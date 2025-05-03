import 'package:flutter/material.dart';
import 'package:foodie_app/utilities/color_palette.dart';

class WhiteBackButton extends StatelessWidget{
  const WhiteBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Image.asset(
        'lib/images/white-back-button.png',
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }
}

class YellowBackButton extends StatelessWidget{
  const YellowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Image.asset(
        'lib/images/yellow-back-button.png',
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.buttonName, this.backgroundColor, required this.onPressed, required this.fontSize});

  final String buttonName;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      elevation: 3,
      backgroundColor: backgroundColor,
      textStyle: TextStyle(fontSize: fontSize),
      minimumSize: const Size(320, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    );

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child:
      ElevatedButton(
        style: style, 
        onPressed: onPressed, 
        child: Padding(
          padding: EdgeInsets.all(16),
          child:
            Text(
              buttonName, 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: c_white,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
          ),
        ),
      ),
    );
  }
}

class NormalButton extends StatelessWidget {
  const NormalButton({super.key, required this.buttonName, this.backgroundColor, required this.fontColor, required this.onPressed, this.outlineColor});

  final String buttonName;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final Color? outlineColor;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      textStyle: TextStyle(fontSize: 12),
      side: BorderSide(color: outlineColor ?? Colors.transparent),
      minimumSize: const Size(320, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child:
      ElevatedButton(
        style: style, 
        onPressed: onPressed, 
        child: Padding(
          padding: EdgeInsets.all(12),
          child:
            Text(
              buttonName, 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: fontColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget  {
  const ProfileButton({super.key, required this.iconColor, required this.onPressed});

  final Color iconColor;
  final Widget Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.account_circle),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => onPressed())
        );
      },
      color: iconColor,
    );
  }
}

class TitleSectionButton extends StatelessWidget{
  const TitleSectionButton({super.key, 
    this.leftmost, 
    this.left, 
    this.right, 
    this.rightmost,
    });

  final Widget? leftmost;
  final Widget? left;
  final Widget? right;
  final Widget? rightmost;
   
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                if (leftmost != null) leftmost!,
                if (left != null) left!,
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                if (right != null) right!,
                if (rightmost != null) rightmost!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}