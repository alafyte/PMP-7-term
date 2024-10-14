import 'package:flutter/material.dart';
import 'package:lab07/work.dart';
import 'package:lab07/worker_details_page.dart';
import 'package:lab07/worker_form_page.dart';

import 'database_helper.dart';
import 'file_system_page.dart';

class WorkerListPage extends StatefulWidget {
  const WorkerListPage({super.key});

  @override
  WorkerListPageState createState() => WorkerListPageState();
}

class WorkerListPageState extends State<WorkerListPage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<Manager> workers = [];

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  Future<void> _loadWorkers() async {
    final data = await dbHelper.getWorkers();
    setState(() {
      workers = data
          .map((workerData) => Manager(workerData['id'], workerData['name'],
              workerData['age'], workerData['department']))
          .toList();
    });
  }

  Future<void> _addWorker(Manager worker) async {
    await dbHelper.insertWorker(worker);
    _loadWorkers();
  }

  Future<void> _editWorker(int id, Manager worker) async {
    await dbHelper.updateWorker(worker, id);
    _loadWorkers();
  }

  Future<void> _deleteWorker(int id) async {
    await dbHelper.deleteWorker(id);
    _loadWorkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkerFormPage(
                    onSubmit: _addWorker,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FileSystemPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          final worker = workers[index];
          return ListTile(
            title: Text(worker.name),
            subtitle: Text('Age: ${worker.age}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkerDetailPage(
                    id: worker.id,
                    onDelete: () => _deleteWorker(worker.id),
                    onEdit: (editedWorker) =>
                        _editWorker(worker.id, editedWorker),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
