import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.hint = "",
    this.controller,
    this.onChange,
    this.focusNode,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final Function(String?)? onChange;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 3),
      height: 50,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(.05),
            spreadRadius: .5,
            blurRadius: .5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        key: const Key('searchField'),
        autofocus: false,
        onChanged: onChange,
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.grey, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
        ),
      ),
    );
  }
}
