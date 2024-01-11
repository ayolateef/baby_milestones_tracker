import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Milestone {
  DateTime date;
  String type;
  String notes;

  Milestone({required this.date, required this.type, required this.notes});

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'type': type,
      'notes': notes,
    };
  }

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      // date: DateTime.parse(map['date']),
      date: DateFormat("yyyy-MM-ddTHH:mm:ss.SSS").parse(map['date']),
      type: map['type'],
      notes: map['notes'],
    );
  }
}

class MilestoneProvider with ChangeNotifier {
  List<Milestone> _milestones = [];

  List<Milestone> get milestones => _milestones;

  Future<void> loadMilestones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedMilestones = prefs.getStringList('milestones');

    if (serializedMilestones != null) {
      _milestones = serializedMilestones
          .map((s) => Milestone.fromMap(json.decode(s)))
          .toList();
      notifyListeners();
    }
  }

  void addMilestone(Milestone milestone) {
    _milestones.add(milestone);
    saveMilestones();
    notifyListeners();
  }

  void editMilestone(int index, Milestone milestone) {
    _milestones[index] = milestone;
    saveMilestones();
    notifyListeners();
  }

  void removeMilestone(int index) {
    _milestones.removeAt(index);
    saveMilestones();
  }

  Future<void> saveMilestones() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> serializedMilestones =
        _milestones.map((m) => m.toMap().toString()).toList();
    await prefs.setStringList('milestones', serializedMilestones);
    notifyListeners();
  }
}
