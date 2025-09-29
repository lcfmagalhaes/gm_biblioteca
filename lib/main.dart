import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String supabaseUrl = const String.fromEnvironment('SUPABASE_URL');
  final String supabaseAnonKey = const String.fromEnvironment('SUPABASE_ANON_KEY');

  bool supabaseReady = false;
  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
    supabaseReady = true;
  }

  runApp(MyApp(supabaseReady: supabaseReady));
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
      home: supabaseReady ? const LoginScreen() : const MissingConfigScreen(),
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color darkRed = Color(0xFF7A1F1F);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'android-chrome-192x192.png',
                          width: 96,
                          height: 96,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Biblioteca Escolar',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: darkRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
        child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email escolar',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Introduza o email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Palavra-passe',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Introduza a palavra-passe';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!(_formKey.currentState?.validate() ?? false)) {
                                return;
                              }
                              final String email = _emailController.text.trim();
                              final String password = _passwordController.text;

                              if (email.toLowerCase() == 'teste' && password == 'teste') {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => const BooksListScreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Credenciais inválidas. Use teste/teste.')),
                                );
                              }
                            },
                            child: const Text('Entrar'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(foregroundColor: darkRed),
                          child: const Text('Criar conta'),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
          ),
        ),
      ),
    );
  }
}

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key});

  Future<List<Map<String, dynamic>>> _loadBooks() async {
    final SupabaseClient client = Supabase.instance.client;
    // Lê de public.livro e, se possível, traz autor (au_nome)
    final List<dynamic> data = await client
        .from('livro')
        .select('li_cod, li_titulo, li_genero, li_autor, autor:autor (au_nome)')
        .limit(100);

    final List<Map<String, dynamic>> result = data
        .map((dynamic e) => e as Map<String, dynamic>)
        .toList();
    result.shuffle();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Livros (aleatório)'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro a carregar livros: ${snapshot.error}'));
          }
          final List<Map<String, dynamic>> books = snapshot.data ?? <Map<String, dynamic>>[];
          if (books.isEmpty) {
            return const Center(child: Text('Sem dados. Verifique configuração do Supabase.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: books.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> book = books[index];
              final String title = (book['li_titulo'] ?? book['title'] ?? '') as String;
              String author = '';
              final Object? autorNested = book['autor'];
              if (autorNested is Map<String, dynamic>) {
                author = (autorNested['au_nome'] ?? '') as String;
              }
              return Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.menu_book_outlined),
                  title: Text(title),
                  subtitle: Text(author),
                  onTap: () {
                    final int liCod = (book['li_cod'] as int);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BookExemplarsScreen(
                          bookId: liCod,
                          bookTitle: title,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookExemplarsScreen extends StatelessWidget {
  const BookExemplarsScreen({super.key, required this.bookId, required this.bookTitle});

  final int bookId;
  final String bookTitle;

  Future<List<Map<String, dynamic>>> _loadExemplars() async {
    final SupabaseClient client = Supabase.instance.client;
    final List<dynamic> data = await client
        .from('livro_exemplar')
        .select('lex_cod, lex_estado, lex_disponivel')
        .eq('lex_li_cod', bookId)
        .order('lex_cod');
    return data.map((dynamic e) => e as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exemplares - $bookTitle')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadExemplars(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro a carregar exemplares: ${snapshot.error}'));
          }
          final List<Map<String, dynamic>> exemplares = snapshot.data ?? <Map<String, dynamic>>[];
          if (exemplares.isEmpty) {
            return const Center(child: Text('Sem exemplares para este livro.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: exemplares.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> ex = exemplares[index];
              final bool disponivel = (ex['lex_disponivel'] == true);
              final String estado = (ex['lex_estado'] ?? '') as String;
              return Card(
                child: ListTile(
                  leading: Icon(
                    disponivel ? Icons.check_circle : Icons.cancel,
                    color: disponivel ? Colors.green : Colors.red,
                  ),
                  title: Text('Exemplar #${ex['lex_cod']}'),
                  subtitle: Text('Estado: $estado'),
                  trailing: Text(disponivel ? 'Disponível' : 'Indisponível'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
