import 'package:flutter/material.dart';

ThemeData themeApp() {
  return ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,

    /// COLOR DE FONDO DE LA APLICACIÓN
    scaffoldBackgroundColor: Colors.transparent,

    /// COLOR DEL APP BAR DE LA APLICACION
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    /// COLORES DE LOS TEXTOS DE LA APLICACIÓN
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),

    /// COLORES DE LOS INPUTS DE LOS FORMULARIOS
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      hintStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      prefixStyle: const TextStyle(
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      errorStyle: const TextStyle(
        color: Colors.white,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 3.0,
        ),
      ),
      fillColor: Colors.white,
    ),

    /// COLORES DE LOS BOTONES DE LA APLICACIÓN
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 14.0,
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      surfaceTintColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      elevation: 16,
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(
        color: Colors.blue,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      insetPadding: const EdgeInsets.all(20.0),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
    ),
  );
}
