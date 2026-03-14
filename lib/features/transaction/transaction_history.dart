import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            Text(
              "Transaction History",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  color: Color(0xFFF0F0F0),
                ),
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEAF6F5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_outward,
                            color: Color(0xFF0F766E),
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                tx.date,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$${tx.amount}",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F766E),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String name;
  final String date;
  final int amount;

  Transaction({
    required this.name,
    required this.date,
    required this.amount,
  });
}

final List<Transaction> transactions = [
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
  Transaction(name: "Grooming Service", date: "12/05/2025", amount: 21),
];