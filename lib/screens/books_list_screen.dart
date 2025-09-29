import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
