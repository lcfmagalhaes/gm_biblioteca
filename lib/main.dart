import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String supabaseUrl = const String.fromEnvironment('SUPABASE_URL');
  final String supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');

  bool supabaseReady = false;
  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    supabaseReady = true;
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MyApp(supabaseReady: supabaseReady),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.supabaseReady});
  final bool supabaseReady;

  @override
  Widget build(BuildContext context) {
    const Color darkRed = Color(0xFF7A1F1F);
    const Color darkRedAccent = Color(0xFF5A1414);
    return MaterialApp(
      title: 'GM Biblioteca',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkRed,
          brightness: Brightness.light,
        ),
        primaryColor: darkRed,
        scaffoldBackgroundColor: const Color(0xFFFAF7F7),
        appBarTheme: const AppBarTheme(
          backgroundColor: darkRed,
          foregroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: darkRedAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: darkRed, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkRed,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: supabaseReady ? const AuthWrapper() : const MissingConfigScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MissingConfigScreen extends StatelessWidget {
  const MissingConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Configuração do Supabase em falta.\n\nInicie a app por uma configuração de execução que inclua --dart-define para SUPABASE_URL e SUPABASE_ANON_KEY.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        // Mostrar splash screen enquanto carrega
        if (authProvider.isLoading) {
          return const SplashScreen();
        }
        
        // Se o usuário está logado, mostrar home screen
        if (authProvider.isLoggedIn) {
          return const HomeScreen();
        }
        
        // Se não está logado, mostrar login screen
        return const LoginScreen();
      },
    );
  }
}

