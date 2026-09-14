import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class BalanceCounterWidget extends StatelessWidget {
  const BalanceCounterWidget({
    super.key,
    required this.value,
    required this.size,
  });
  final double value;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: AnimatedFlipCounter(
        value: value,
        infix: ' \$',
        fractionDigits: 2,
        wholeDigits: 8,
        hideLeadingZeroes: true,
        decimalSeparator: '.',
        thousandSeparator: ',',
        textStyle: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: value < 0 ? AppColors.red : AppColors.primary,
          shadows: [
            BoxShadow(
              color: AppColors.neutral,
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }
}
