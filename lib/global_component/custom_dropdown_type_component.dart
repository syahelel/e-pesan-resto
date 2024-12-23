import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownTypeComponent extends StatefulWidget {
  final Function(String, int) callback;
  const CustomDropdownTypeComponent({super.key, required this.callback});

  @override
  State<CustomDropdownTypeComponent> createState() =>
      _CustomDropdownTypeComponentState();
}

class _CustomDropdownTypeComponentState
    extends State<CustomDropdownTypeComponent> {
  String? _selectedProduct;
  int? _selectedIndex;

  final List<String> _productOptions = ['Food', 'Drink'];
  final Map<String, Color> _productColors = {
    'Food': Colors.grey.shade300,
    'Drink': Colors.grey.shade300,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _selectedProduct != null
            ? _productColors[_selectedProduct]
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: _selectedProduct,
        hint: Text(
          'Pilih tipe produk',
          style: regular14,
        ),
        underline: const SizedBox(),
        isExpanded: true,
        items: _productOptions.asMap().entries.map((entry) {
          String value = entry.value;
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: regular14,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedProduct = value;
            _selectedIndex = _productOptions.indexOf(value!);
            widget.callback(_selectedProduct!, _selectedIndex! + 1);
          });
        },
      ),
    );
  }
}
