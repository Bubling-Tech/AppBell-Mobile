import 'package:flutter/material.dart';
import 'package:to_com_bell_app/core/theme/app_colors.dart';
import 'package:to_com_bell_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );

    final colorScheme = baseScheme.copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.accentGreen,
      background: AppColors.background,
      surface: AppColors.surface,
      onBackground: AppColors.textStrong,
      onSurface: AppColors.textStrong,
      outlineVariant: AppColors.border,
    );

    final textTheme = ThemeData.light().textTheme.apply(
          bodyColor: AppColors.textStrong,
          displayColor: AppColors.textStrong,
        );

    return MaterialApp(
      title: 'Tô com Bell!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: textTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textStrong,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textStrong,
          ),
        ),
        cardTheme: const CardTheme(
          color: AppColors.surface,
          surfaceTintColor: Colors.transparent,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
      initialRoute: AppRoutes.feed,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
