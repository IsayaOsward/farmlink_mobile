import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/utility/location_provider.dart';

class CustomDropdownField extends StatefulWidget {
  final String label;
  final String? hint;
  final List<Map<String, String>>
      items; // List of { "text": "label", "value": "actual_value" }
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String?>? onChanged;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.hint,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Selector<LocationProvider, String?>(
        selector: (p0, p1) => p1.selectedValue,
        builder: (context, selectedValue, child) {
          return DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem(
                      value: item["value"],
                      child: Text(item["text"] ?? ""),
                    ))
                .toList(),
            onChanged: (value) {
              if (selectedValue != value) {
                selectedValue = value;
              }
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            validator: widget.validator,
          );
        });
  }
}
