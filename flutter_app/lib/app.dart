import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router.dart';
import 'theme/app_theme.dart';

class VulgusApp extends ConsumerWidget {
  const VulgusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstLaunch = ref.watch(firstLaunchProvider);
    return firstLaunch.when(
      data: (isFirst) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'VULGUS',
        theme: buildAppTheme(),
        routerConfig: buildRouter(isFirst),
      ),
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
