import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/book.dart';

class BooksRepository {
  BooksRepository(this._client);

  final SupabaseClient _client;

  Future<List<Book>> fetchBooksRandom({int limit = 50}) async {
    final List<dynamic> data = await _client
        .from('books')
        .select()
        .limit(limit);

    final List<Book> books = data
        .map((dynamic e) => Book.fromMap(e as Map<String, dynamic>))
        .toList();
    books.shuffle();
    return books;
  }
}


