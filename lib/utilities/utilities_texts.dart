import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.obscureText = false,
    this.isPassword = false,
  });

  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isPassword;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: c_sec_yellow,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: c_pri_yellow),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: c_pri_yellow),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: c_pri_yellow, width: 2),
          ),
          suffixIcon: widget.isPassword ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: c_pri_yellow,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ) : null,
        ),
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        cursorColor: c_pri_yellow,
      ),
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
