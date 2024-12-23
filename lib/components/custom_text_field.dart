import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum TextFieldType { normal, password }

class CustomTextField extends StatefulWidget {
  final String name;
  final String label;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final int maxLength;
  final TextFieldType type;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const CustomTextField({
    super.key,
    required this.name,
    required this.label,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.maxLength,
   this.maxLines =1,
    this.validator,
    this.type = TextFieldType.normal,
    this.initialValue,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;
  @override
  void initState() {
    isObscure = widget.type == TextFieldType.password;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style:const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
           const Gap(8),
          FormBuilderTextField (
            name: widget.name,
            keyboardType: TextInputType.text,
            maxLength: widget.maxLength,
            maxLines:widget.maxLines,
            cursorColor: Colors.indigo,
            obscureText: isObscure,
            validator:widget.validator,
            initialValue:widget.initialValue ,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: const Color.fromARGB(255, 243, 239, 239),
              filled: true,
              prefixIcon: Icon(widget.prefixIcon),
              suffixIcon: widget.type == TextFieldType.password
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                        isObscure? Icons.visibility : Icons.visibility_off))
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.yellow, width: 3),
              ),
              labelText: widget.labelText,
              floatingLabelAlignment: FloatingLabelAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}