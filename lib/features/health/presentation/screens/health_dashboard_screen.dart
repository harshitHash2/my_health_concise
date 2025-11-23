import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_health_concise/features/health/presentation/providers/theme_provider.dart';

import '../providers/health_providers.dart';
import '../widgets/metrics_list.dart';

class HealthDashboardScreen extends ConsumerWidget {
  static const routeName = '/';

  const HealthDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(healthDataProvider);
    final metrics = ref.watch(filteredMetricsProvider);
    final filter = ref.watch(statusFilterProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: asyncData.when(
          data: (data) => Text('Hi, ${data.user}'),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Health Insights'),
        ),
        actions: [
    Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeModeProvider);

        return IconButton(
          // icon: new Icon(Icons.medical_information),
          icon: Icon(
            themeMode == ThemeMode.dark
                ? Icons.light_mode  
                : Icons.dark_mode,   
          ),
          onPressed: () {
            final notifier = ref.read(themeModeProvider.notifier);

            notifier.state =
                themeMode == ThemeMode.light
                    ? ThemeMode.dark     
                    : ThemeMode.light;   
          },
        );
      },
    ),
  ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              asyncData.when(
                data: (data) => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Last updated: '
                    '${DateTime.now().toLocal().toString().split(' ').first}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 12),
              
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search metrics...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  isDense: true,
                ),
                onChanged: (val) =>
                    ref.read(searchQueryProvider.notifier).state = val,
              ),
              const SizedBox(height: 12),
              
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: filter == HealthStatusFilter.all,
                      onTap: () => ref
                          .read(statusFilterProvider.notifier)
                          .state = HealthStatusFilter.all,
                    ),
                    _FilterChip(
                      label: 'Normal',
                      selected: filter == HealthStatusFilter.normal,
                      onTap: () => ref
                          .read(statusFilterProvider.notifier)
                          .state = HealthStatusFilter.normal,
                    ),
                    _FilterChip(
                      label: 'High',
                      selected: filter == HealthStatusFilter.high,
                      onTap: () => ref
                          .read(statusFilterProvider.notifier)
                          .state = HealthStatusFilter.high,
                    ),
                    _FilterChip(
                      label: 'Low',
                      selected: filter == HealthStatusFilter.low,
                      onTap: () => ref
                          .read(statusFilterProvider.notifier)
                          .state = HealthStatusFilter.low,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: asyncData.when(
                  data: (_) => MetricsList(metrics: metrics),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) => Center(
                    child: Text('Error: $err'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
