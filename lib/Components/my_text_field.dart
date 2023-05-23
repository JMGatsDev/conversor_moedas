import 'package:flutter/material.dart';

 myTextField(
    {required String coin,
    required String prefix,
    required BuildContext context,
    required TextEditingController controller,
    required Function function}) {
  return TextField(
    keyboardType: TextInputType.number,
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(color: Colors.green),
      labelText: coin,
      prefixText: prefix,
    ),
    style: const TextStyle(color: Colors.green, fontSize: 25),
    onChanged: (value){
      function(value);
    },
  );
}
