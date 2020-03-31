import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final TextEditingController handler;
  final String _hintText;
  final String _labelText;
  Field(this.handler, this._hintText, this._labelText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: handler,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(
            Icons.work,
            color: Colors.orange,
          ),
          hintText: _hintText,
          labelText: _labelText,
          labelStyle: TextStyle(color: Colors.orange),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        ),
        autofocus: true,
        validator: (String value) {
          return value.isEmpty ? "Please enter some text" : null;
        },
      ),
    );
  }
}