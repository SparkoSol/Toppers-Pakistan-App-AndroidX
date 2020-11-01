import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundDropDownButton<T> extends StatelessWidget {
  final T value;
  final Widget hint;
  final Function(T value) onChanged;
  final List<DropdownMenuItem<T>> items;

  RoundDropDownButton({
    this.hint,
    this.value,
    this.onChanged,
    this.items
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4)
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: DropdownButton(
          hint: this.hint,
          items: this.items,
          value: this.value,
          onChanged: this.onChanged,

          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }
}
