import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    required this.isLoading,
  });
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onTap!,
      duration: 10,
      height: 70,
      width: 340,
      enabled: true,
      shadowDegree: ShadowDegree.dark,
      disabledColor: Colors.grey,
      borderRadius: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLoading
            ? <Widget>[
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              ]
            : [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                  color: Colors.white,
                ),
              ],
      ),
    );
  }
}
