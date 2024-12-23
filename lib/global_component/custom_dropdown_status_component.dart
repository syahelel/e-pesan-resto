import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';

class CustomDropdownStatusComponent extends StatefulWidget {
  final Function(String, int) callbackDropdown;
  const CustomDropdownStatusComponent(
      {super.key, required this.callbackDropdown});

  @override
  State<CustomDropdownStatusComponent> createState() =>
      _CustomDropdownStatusComponentState();
}

class _CustomDropdownStatusComponentState
    extends State<CustomDropdownStatusComponent> {
  String? _selectedStatus;

  int? _selectedIndex;

  final List<String> _statusOptions = ['Pending', 'Process', 'Complete'];

  final Map<String, Color> _statusColors = {
    'Process': Colors.blue,
    'Complete': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _selectedStatus != null
            ? _statusColors[_selectedStatus]
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: _selectedStatus,
        hint: Text(
          'Select Status',
          style: regular14,
        ),
        underline: const SizedBox(),
        isExpanded: true,
        items: ['Process', 'Complete'].map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: bold14.copyWith(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedStatus = value;
            _selectedIndex = _statusOptions.indexOf(value!);
            widget.callbackDropdown(_selectedStatus!, _selectedIndex!);
          });
        },
      ),
    );
  }
}
