import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isLoading = false;
  bool _obscureCvv = true;

  // Card type detect
  String _cardType = '';

  void _detectCardType(String number) {
    final cleaned = number.replaceAll(' ', '');
    setState(() {
      if (cleaned.startsWith('4')) {
        _cardType = 'Visa';
      } else if (cleaned.startsWith('5')) {
        _cardType = 'Mastercard';
      } else if (cleaned.startsWith('3')) {
        _cardType = 'Amex';
      } else {
        _cardType = '';
      }
    });
  }

  // Card number formatter (XXXX XXXX XXXX XXXX)
  String _formatCardNumber(String value) {
    final cleaned = value.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }

  // Expiry formatter (MM/YY)
  String _formatExpiry(String value) {
    final cleaned = value.replaceAll('/', '');
    if (cleaned.length >= 2) {
      return '${cleaned.substring(0, 2)}/${cleaned.substring(2)}';
    }
    return cleaned;
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      // Step 1: Backend থেকে PaymentIntent নিন
      final amount = (double.parse(_amountController.text) * 100).toInt();
      final paymentIntent = await _createPaymentIntent(amount);

      // Step 2: Payment Sheet initialize করুন
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Your App Name',
          style: ThemeMode.light,
        ),
      );

      // Step 3: Payment Sheet দেখান
      await Stripe.instance.presentPaymentSheet();

      setState(() => _isLoading = false);

      // Success dialog দেখান
      _showSuccessDialog();

    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }

// Stripe PaymentIntent create করুন
  Future<Map<String, dynamic>> _createPaymentIntent(int amount) async {
    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer sk_test_আপনার_secret_key',  // ⚠️ production এ backend এ রাখবেন
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'amount': amount.toString(),
        'currency': 'usd',
      },
    );
    return json.decode(response.body);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70, height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF2D6A4F), shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            const Text('Payment Successful!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('\$${_amountController.text}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
                    color: Color(0xFF2D6A4F))),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D6A4F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Done', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Card Preview ──
              _buildCardPreview(),

              const SizedBox(height: 24),

              // ── Amount ──
              const Text(
                'Amount',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  hint: '0.00',
                  prefix: const Text(
                    '\$  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Amount দিন';
                  if (double.tryParse(v) == null) return 'Valid amount দিন';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Card Number ──
              const Text(
                'Card Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                maxLength: 19,
                decoration: _inputDecoration(
                  hint: '0000 0000 0000 0000',
                  suffix: _cardType.isNotEmpty
                      ? Text(
                    _cardType,
                    style: const TextStyle(
                      color: Color(0xFF2D6A4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                      : const Icon(
                    Icons.credit_card,
                    color: Colors.grey,
                  ),
                  counter: const SizedBox.shrink(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final formatted = _formatCardNumber(newValue.text);
                    return TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  }),
                ],
                onChanged: _detectCardType,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Card number দিন';
                  if (v.replaceAll(' ', '').length < 16) {
                    return 'Valid card number দিন';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Card Holder ──
              const Text(
                'Card Holder Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cardHolderController,
                textCapitalization: TextCapitalization.words,
                decoration: _inputDecoration(
                  hint: 'John Doe',
                  suffix: const Icon(Icons.person_outline, color: Colors.grey),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Card holder name দিন';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // ── Expiry & CVV ──
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expiry Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration(
                            hint: 'MM/YY',
                            suffix: const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.grey,
                              size: 18,
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            TextInputFormatter.withFunction((old, newVal) {
                              final formatted = _formatExpiry(newVal.text);
                              return TextEditingValue(
                                text: formatted,
                                selection: TextSelection.collapsed(
                                  offset: formatted.length,
                                ),
                              );
                            }),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Expiry দিন';
                            if (v.length < 5) return 'MM/YY format এ দিন';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'CVV',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          obscureText: _obscureCvv,
                          decoration: _inputDecoration(
                            hint: '•••',
                            suffix: GestureDetector(
                              onTap: () => setState(
                                    () => _obscureCvv = !_obscureCvv,
                              ),
                              child: Icon(
                                _obscureCvv
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                                size: 18,
                              ),
                            ),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(3),
                          ],
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'CVV দিন';
                            if (v.length < 3) return '3 digit দিন';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ── Pay Button ──
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _processPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D6A4F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    _amountController.text.isNotEmpty
                        ? 'Pay \$${_amountController.text}'
                        : 'Pay Now',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── Secure Badge ──
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 14,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Secured by Stripe',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Card Preview Widget ──
  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      height: 190,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D6A4F), Color(0xFF40916C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D6A4F).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DEBIT CARD',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
              Text(
                _cardType.isNotEmpty ? _cardType.toUpperCase() : 'CARD',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          // Card number display
          Text(
            _cardNumberController.text.isNotEmpty
                ? _cardNumberController.text.padRight(19, '•')
                : '•••• •••• •••• ••••',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),

          // Bottom row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CARD HOLDER',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                  Text(
                    _cardHolderController.text.isNotEmpty
                        ? _cardHolderController.text.toUpperCase()
                        : 'YOUR NAME',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'EXPIRES',
                    style: TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                  Text(
                    _expiryController.text.isNotEmpty
                        ? _expiryController.text
                        : 'MM/YY',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Input Decoration ──
  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffix,
    Widget? prefix,
    Widget? counter,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffix != null ? Padding(
        padding: const EdgeInsets.only(right: 12),
        child: suffix,
      ) : null,
      prefixIcon: prefix != null ? Padding(
        padding: const EdgeInsets.only(left: 12),
        child: prefix,
      ) : null,
      suffixIconConstraints: const BoxConstraints(),
      prefixIconConstraints: const BoxConstraints(),
      counter: counter,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF2D6A4F)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}