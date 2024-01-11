import 'package:baby_milestones_tracker/core/features/root/model/milestone_model.dart';
import 'package:baby_milestones_tracker/core/features/root/widgets/MilestoneForm.dart';
import 'package:baby_milestones_tracker/core/features/root/widgets/dashboard_screen.dart';
import 'package:baby_milestones_tracker/core/features/root/widgets/milestone_screen.dart';
import 'package:baby_milestones_tracker/core/features/root/widgets/onboading_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String onboardingScreen = '/onboarding_screen';
  static const String dashboardScreen = '/dashboard_screen';
  static const String milestoneScreen = '/milestoneScreen';
  static const String milestoneForm = '/milestoneForm';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case dashboardScreen:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case milestoneScreen:
        return MaterialPageRoute(builder: (_) => const MilestoneScreen());
      case milestoneForm:
        var args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MilestoneForm(milestone: args as Milestone?));
        ;
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
