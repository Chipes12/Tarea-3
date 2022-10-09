import 'package:books_app/pages/book_page.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final dynamic book;
  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetails(
                        book: book,
                      )),
            );
          },
          child: Image.network(
            book["volumeInfo"].containsKey("imageLinks")
                ? book["volumeInfo"]["imageLinks"]["thumbnail"]
                : "https://drupal.nypl.org/sites-drupal/default/files/blogs/J5LVHEL.jpg",
            width: 150,
            height: 160,
          ),
        ),
        Text(
          "${book["volumeInfo"]["title"]}",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          softWrap: false,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
