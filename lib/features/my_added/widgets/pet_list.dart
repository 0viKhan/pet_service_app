import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/features/my_added/widgets/petcard.dart';

class PetList extends StatelessWidget {
  const PetList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: const [
        PetCard(
          image: "assets/images/doctor_girl.jpg",
          name: "Bella",
        ),
        PetCard(
          image: "assets/images/dog.png",
          name: "Roudy",
        ),
        PetCard(
          image: "assets/images/dog_child.png",
          name: "Luna",
        ),
      ],
    );
  }
}