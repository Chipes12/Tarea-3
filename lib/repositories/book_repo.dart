import 'dart:convert';
import 'package:http/http.dart' as http;

class BookRepo {
  final String url = "https://www.googleapis.com/books/v1/volumes";
  static final BookRepo bookRepo = BookRepo._internal();
  factory BookRepo() => bookRepo;

  BookRepo._internal();

  Future<dynamic> getBooks(String? queryParam) async {
    var bookUrl = Uri.parse("${url}?q=${queryParam}");
    dynamic response;
    try {
      response = await http.get(bookUrl);
      response = jsonDecode(response.body);
      if (response["totalItems"] == 0) return [];
      return response["items"];
    } catch (error) {
      throw error;
    }
  }
}
