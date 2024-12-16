import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  final String message;
  final Function(String) onTextCompleted;
  const SearchComponent(
      {super.key, required this.message, required this.onTextCompleted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onTextCompleted,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white70,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(color: Colors.white60),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
        suffixIcon: const Icon(Icons.search),
        hintText: message,
        hintStyle: regular14.copyWith(color: Colors.grey[500]),
        counterStyle: regular14,
      ),
    );
  }
}
