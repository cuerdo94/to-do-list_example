import 'package:flutter/material.dart';

class TaskModalWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function() onPressed;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TaskModalWidget({
    Key? key,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  String? _validateTaskDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese una descripción válida';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 33,
        vertical: 23,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Nueva Tarea',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Descripción de la tarea',
                ),
                validator: _validateTaskDescription,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                onPressed();
              }
            },
            child: const SizedBox(
              width: double.maxFinite,
              height: 50,
              child: Center(child: Text('Guardar')),
            ),
          ),
        ],
      ),
    );
  }
}
