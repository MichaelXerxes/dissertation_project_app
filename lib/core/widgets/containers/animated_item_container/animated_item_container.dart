import 'package:flutter/material.dart';

class AnimatedItemContainer extends StatelessWidget {
  final int minDuration;
  final int maxDuration;
  final IconData icon;
  final Alignment alignment;
  final bool toggleButton;
  final double size;
  final Function onTap;

  const AnimatedItemContainer({
    Key? key,
    required this.minDuration,
    required this.maxDuration,
    required this.icon,
    required this.alignment,
    required this.toggleButton,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: toggleButton
          ? Duration(milliseconds: minDuration)
          : Duration(milliseconds: maxDuration),
      alignment: alignment,
      curve: toggleButton ? Curves.easeIn : Curves.elasticOut,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(microseconds: 300),
          curve: toggleButton ? Curves.easeIn : Curves.easeOut,
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
