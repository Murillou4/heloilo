import 'package:flutter/material.dart';
import 'package:heloilo/app/core/cores.dart';

class TextFieldTransparente extends StatefulWidget {
  const TextFieldTransparente({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.isPassword,
  });
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool isPassword;

  @override
  State<TextFieldTransparente> createState() => _TextFieldTransparenteState();
}

class _TextFieldTransparenteState extends State<TextFieldTransparente> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
          constraints: const BoxConstraints(
            maxWidth: 350,
            maxHeight: 50,
          ),
          labelText: widget.label,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.transparent,
              style: BorderStyle.solid,
            ),
          ),
          icon: Icon(
            widget.icon,
            color: Cores.corTextoSobreCardMurillo,
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Cores.corTextoSobreCardMurillo,
                  ),
                )
              : null),
      obscureText: widget.isPassword ? isObscure : false,
      obscuringCharacter: '*',
    );
  }
}
