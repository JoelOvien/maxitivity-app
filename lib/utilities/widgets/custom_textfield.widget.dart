import 'package:ambeego_test/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefix,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      constraints: const BoxConstraints(minHeight: 40),
      decoration: BoxDecoration(
        color: const Color(0xffF6F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefix,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.familjenGrotesk(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.textLight.withOpacity(0.50),
          ),
        ),
      ),
    );
  }
}
