import 'package:flutter/material.dart';
import 'package:foodie_app/Utilities/color_palette.dart';

class FAButton extends StatelessWidget {
  const FAButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      onPressed: onPressed,
      elevation: 2,
      backgroundColor: c_pri_yellow,
      foregroundColor: c_white,
      child: Icon(Icons.add),
    );
  }
}

class AddRemoveButton extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;

  const AddRemoveButton({super.key, this.initialValue = 1, required this.onChanged});

  @override
  State<AddRemoveButton> createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
  }

  void _increment() {
    setState(() => _quantity++);
    widget.onChanged(_quantity);
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
      widget.onChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconButtonSize = screenWidth * 0.04;
    double quantityBoxSize = screenWidth * 0.07;
    double subtitleFontSize = screenWidth * 0.04;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Remove Button
        SizedBox(
          width: quantityBoxSize,
          height: quantityBoxSize,
          child: IconButton.filled(
            onPressed: _decrement,
            icon: const Icon(Icons.remove),
            iconSize: iconButtonSize,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(c_pri_yellow),
              foregroundColor: MaterialStateProperty.all(c_white),
            ),
          ),
        ),

        // Quantity Display Box
        Container(
          width: quantityBoxSize,
          height: quantityBoxSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: c_pri_yellow),
          ),
          child: Text(
            '$_quantity',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: subtitleFontSize),
          ),
        ),

        // Add Button
        SizedBox(
          width: quantityBoxSize,
          height: quantityBoxSize,
          child: IconButton.filled(
            onPressed: _increment,
            icon: const Icon(Icons.add),
            iconSize: iconButtonSize,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(c_pri_yellow),
              foregroundColor: MaterialStateProperty.all(c_white),
            ),
          ),
        ),
      ],
    );
  }
}

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
  const ActionButton({super.key, required this.buttonName, this.backgroundColor, required this.onPressed});

  final String buttonName;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      elevation: 3,
      backgroundColor: backgroundColor,
      textStyle: TextStyle(fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    );

    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: style, 
        onPressed: onPressed, 
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            buttonName, 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: c_white,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );

    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: style, 
        onPressed: onPressed, 
        child:
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
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