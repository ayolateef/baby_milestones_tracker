import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes.dart';
import '../model/milestone_model.dart';
import 'MilestoneForm.dart';

class MilestoneScreen extends StatelessWidget {
  const MilestoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Milestones'),
      ),
      body: Consumer<MilestoneProvider>(
        builder: (context, milestoneProvider, child) {
          List<Milestone> milestones = milestoneProvider.milestones;

          return ListView.builder(
            itemCount: milestones.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(milestones[index].type),
                subtitle: Text('Date: ${milestones[index].date.toString()}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MilestoneForm(
                          milestone: milestones[index], index: index),
                    ),
                  );
                },
                onLongPress: () {
                  milestoneProvider.removeMilestone(index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, Routes.milestoneForm);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Milestone'),
      ),
    );
  }
}
