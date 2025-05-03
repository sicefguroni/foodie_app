import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      )
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.title, required this.color});

  final String title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Text(title, style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: 48
        ),
      )
    );
  }
}
 
class Heading2_Text extends StatelessWidget {
  const Heading2_Text({super.key, required this.text, required this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(text, style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontSize: 32
        ),
      )
    );
  }
}

class Heading3_Text extends StatelessWidget {
  const Heading3_Text({super.key, required this.text, required this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(text, style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontSize: 24
        ),
      )
    );
  }
}

class Heading4_Text extends StatelessWidget {
  const Heading4_Text({super.key, required this.text, required this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Text(text, style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontSize: 16
        ),
      )
    );
  }
}

class bodyText extends StatelessWidget {
  const bodyText({super.key, required this.text, required this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Text(text, style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontSize: 12
        ),
      )
    );
  }
}
