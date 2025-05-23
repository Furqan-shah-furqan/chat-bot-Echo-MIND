import 'package:flutter/material.dart';

class CostumBtn extends StatelessWidget {
  const CostumBtn({super.key, this.onPressed, this.height});
  final void Function()? onPressed;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: MaterialButton(
        color: Colors.white.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            topRight: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
        ),
        onPressed: onPressed,
        child: Icon(Icons.send_rounded, color: Colors.white),
      ),
    );
  }
}
