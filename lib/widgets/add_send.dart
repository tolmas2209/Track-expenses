import 'package:flutter/material.dart';
import 'package:track_expenses/const/colors/app_colors.dart';

class AddSend extends StatefulWidget {
  final String onAddFunds;
  final String onSend;
  final ValueChanged<int>? onChanged;
  final int initialIndex;
  const AddSend({
    super.key,
    required this.onAddFunds,
    required this.onSend,
    this.onChanged,
    this.initialIndex = 0,
  });
  @override
  State<AddSend> createState() => _AddSendState();
}

class _AddSendState extends State<AddSend> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(covariant AddSend oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _selectedIndex = widget.initialIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
            if (widget.onChanged != null) widget.onChanged!(0);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _selectedIndex == 0
                  ? AppColors.primary
                  : AppColors.secondary,
              borderRadius: BorderRadius.circular(24),
              border: _selectedIndex == 0
                  ? null
                  : Border.all(color: AppColors.neutral, width: 1),
            ),
            child: Text(
              widget.onAddFunds,
              style: TextStyle(
                color: _selectedIndex == 0
                    ? AppColors.white
                    : AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
            if (widget.onChanged != null) widget.onChanged!(1);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _selectedIndex == 1
                  ? AppColors.primary
                  : AppColors.secondary,
              borderRadius: BorderRadius.circular(24),
              border: _selectedIndex == 1
                  ? null
                  : Border.all(color: AppColors.neutral, width: 1),
            ),
            child: Text(
              widget.onSend,
              style: TextStyle(
                color: _selectedIndex == 1
                    ? AppColors.white
                    : AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
