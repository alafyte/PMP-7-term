import 'package:flutter/material.dart';
import 'package:lab07/work.dart';
import 'package:lab07/worker_form_page.dart';

import 'database_helper.dart';

class WorkerDetailPage extends StatefulWidget {
  final int id;
  final VoidCallback onDelete;
  final Function(Manager) onEdit;

  const WorkerDetailPage(
      {super.key,
      required this.id,
      required this.onDelete,
      required this.onEdit});

  @override
  WorkerDetailsPageState createState() => WorkerDetailsPageState();
}

class WorkerDetailsPageState extends State<WorkerDetailPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  Manager? worker;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final data = await dbHelper.getWorkerById(widget.id);
    worker = Manager(
      data["id"],
      data["name"],
      data["age"],
      data["department"],
    );
    setState(() {
      worker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(worker?.name ?? ""),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              widget.onDelete();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkerFormPage(
                          onSubmit: (worker) {
                            widget.onEdit(worker);
                            init();
                          },
                          worker: worker)));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Age: ${worker?.age}\nDepartment: ${worker?.department}'),
      ),
    );
  }
}
