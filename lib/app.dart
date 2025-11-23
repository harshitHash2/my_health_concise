import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_health_concise/features/health/presentation/providers/theme_provider.dart';

import 'core/theme/app_theme.dart';
import 'features/health/presentation/screens/health_dashboard_screen.dart';
import 'features/health/presentation/screens/metric_detail_screen.dart';
import 'features/health/domain/entities/health_metric.dart';

class PersonalHealthInsightsApp extends ConsumerWidget {
  const PersonalHealthInsightsApp({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'PersonalHealthInsightsApp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: HealthDashboardScreen.routeName,
      routes: {
        HealthDashboardScreen.routeName: (_) => const HealthDashboardScreen(),
        MetricDetailScreen.routeName: (ctx) {
          final metric = ModalRoute.of(ctx)!.settings.arguments as HealthMetric;
          //print();
          return MetricDetailScreen(metric: metric);
        },
      },
    );
  }
}
