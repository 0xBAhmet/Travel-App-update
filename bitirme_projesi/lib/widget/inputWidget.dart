import 'package:bitirme_projesi/model/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class InputWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool obscureText;
  final bool showImage;
  final TextEditingController textEdit;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const InputWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.obscureText = false,
    required this.showImage,
    required this.textEdit,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _gorunurluk = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade700.withOpacity(0.2),
      ),
      alignment: Alignment.center,
      child: TextField(
        inputFormatters: widget.inputFormatters,
        controller: widget.textEdit,
        onChanged: widget.onChanged,
        cursorColor: screenColor.grey,
        obscureText: widget.obscureText && !_gorunurluk,
        decoration: InputDecoration(
          fillColor: screenColor.transparent,
          hoverColor: screenColor.transparent,
          icon: Icon(
            widget.icon,
            color: screenColor.loginIcon,
          ),
          hintText: widget.text,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: widget.obscureText
              ? _gorunurluk
                  ? InkWell(
                      splashColor: screenColor.transparent,
                      onTap: () {
                        setState(() {
                          _gorunurluk = false;
                        });
                      },
                      child: Icon(
                        Iconsax.eye,
                        color: screenColor.loginIcon,
                      ),
                    )
                  : InkWell(
                      splashColor: screenColor.transparent,
                      onTap: () {
                        setState(() {
                          _gorunurluk = true;
                        });
                      },
                      child: Icon(
                        Iconsax.eye_slash,
                        color: screenColor.loginIcon,
                      ),
                    )
              : null,
        ),
      ),
    );
  }
}
