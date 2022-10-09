import 'package:flutter/material.dart';
import 'package:books_app/repositories/book_repo.dart';

class BookProvider with ChangeNotifier {
  List<dynamic> _booksList = [];
  List<dynamic> get getBooksList => _booksList;

  bool _showResults = false;
  bool get ShowResults => _showResults;

  bool _loading = false;
  bool get isLoading => _loading;

  void loading() {
    _loading = !_loading;
    notifyListeners();
  }

  final BookRepo _bookRepo = BookRepo();

  Future<void> getBooks(String query) async {
    loading();
    if (query != '') {
      _booksList = await _bookRepo.getBooks(query);
    }
    _showResults = true;
    loading();
  }
}
