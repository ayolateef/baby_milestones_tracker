import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/milestone_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MilestoneForm extends StatefulWidget {
  final Milestone? milestone;
  final int? index;

  const MilestoneForm({Key? key, this.milestone, this.index}) : super(key: key);

  @override
  _MilestoneFormState createState() => _MilestoneFormState();
}

class _MilestoneFormState extends State<MilestoneForm> {
  late TextEditingController dateController;
  late TextEditingController typeController;
  late TextEditingController notesController;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    loadStoredData();

    if (widget.milestone != null) {
      selectedDate = widget.milestone!.date;
      dateController =
          TextEditingController(text: formatDate(widget.milestone!.date));
      typeController = TextEditingController(text: widget.milestone!.type);
      notesController = TextEditingController(text: widget.milestone!.notes);
    } else {
      dateController = TextEditingController();
      typeController = TextEditingController();
      notesController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.milestone == null ? 'Add Milestone' : 'Edit Milestone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveMilestone();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = formatDate(selectedDate!);
      });
    }
  }

  Future<void> loadStoredData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedDate = prefs.getString('dateTime') != null
          ? DateFormat('dd/MM/yyyy HH:mm').parse(prefs.getString('dateTime')!)
          : null;
      dateController =
          TextEditingController(text: prefs.getString('dateTime') ?? '');
      typeController =
          TextEditingController(text: prefs.getString('type') ?? '');
      notesController =
          TextEditingController(text: prefs.getString('notes') ?? '');
    });
  }

  void saveMilestone() async {
    DateTime date = selectedDate ?? DateTime.now();
    String type = typeController.text;
    String notes = notesController.text;

    Milestone newMilestone = Milestone(date: date, type: type, notes: notes);

// Save the data using shared_preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('date', formatDate(date));
    prefs.setString('type', type);
    prefs.setString('notes', notes);

    if (widget.index != null) {
      Provider.of<MilestoneProvider>(context, listen: false)
          .editMilestone(widget.index!, newMilestone);
    } else {
      Provider.of<MilestoneProvider>(context, listen: false)
          .addMilestone(newMilestone);
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
