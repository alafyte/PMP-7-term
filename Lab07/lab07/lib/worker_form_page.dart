import 'package:flutter/material.dart';
import 'package:lab07/work.dart';

class WorkerFormPage extends StatefulWidget {
  final Function(Manager) onSubmit;
  final Manager? worker;

  const WorkerFormPage({super.key, required this.onSubmit, this.worker});

  @override
  WorkerFormPageState createState() => WorkerFormPageState();
}

class WorkerFormPageState extends State<WorkerFormPage> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _departmentController;

  String? _nameError;
  String? _ageError;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.worker?.name ?? '');
    _ageController =
        TextEditingController(text: widget.worker?.age.toString() ?? '');
    _departmentController = TextEditingController(
        text: widget.worker is Manager ? (widget.worker as Manager).department : '');
  }

  void _validateInputs() {
    setState(() {
      _nameError = null;
      _ageError = null;

      if (_nameController.text.isEmpty) {
        _nameError = 'Name cannot be empty';
      } else if (_nameController.text.length > 50) {
        _nameError = 'Name is too long (max 50 characters)';
      }

      if (_ageController.text.isEmpty) {
        _ageError = 'Age cannot be empty';
      } else {
        final age = int.tryParse(_ageController.text);
        if (age == null || age < 0 || age > 100) {
          _ageError = 'Please enter a valid age';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.worker == null ? 'Add Worker' : 'Edit Worker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                errorText: _nameError,
              ),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age',
                errorText: _ageError,
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _departmentController,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            ElevatedButton(
              onPressed: () {
                _validateInputs();

                if (_nameError == null && _ageError == null) {
                  final worker = Manager(
                    0,
                    _nameController.text,
                    int.parse(_ageController.text),
                    _departmentController.text,
                  );
                  widget.onSubmit(worker);
                  Navigator.pop(context);
                }
              },
              child: Text(widget.worker == null ? 'Add' : 'Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
