import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/features/root/model/milestone_model.dart';
import 'core/features/routes.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MilestoneProvider()..loadMilestones(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Baby Milestones',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.onboardingScreen,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}


