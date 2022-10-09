import 'package:books_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class BookDetails extends StatefulWidget {
  final dynamic book;
  const BookDetails({Key? key, required this.book}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState(book);
}

class _BookDetailsState extends State<BookDetails> {
  final dynamic book;
  bool _extendedDescription = false;

  _BookDetailsState(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Detalles del libro'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.earthAmericas),
                onPressed: () {
                  _launchUrl(Uri.parse("${book["volumeInfo"]["canonicalVolumeLink"]}"));
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.share),
                onPressed: () {
                  Share.share('check out this book  ${book["volumeInfo"]["title"]}\n${book["volumeInfo"]["canonicalVolumeLink"]}');
                },
              )
            ]),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Image.network(
                    book["volumeInfo"].containsKey("imageLinks")
                        ? book["volumeInfo"]["imageLinks"]["thumbnail"]
                        : "https://drupal.nypl.org/sites-drupal/default/files/blogs/J5LVHEL.jpg",
                    fit: BoxFit.fill,
                    height: 250,
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            "${widget.book["volumeInfo"]["title"]}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${book["volumeInfo"].containsKey("publishedDate") ? book["volumeInfo"]["publishedDate"] : "---"}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5, left: 5),
                        child: Text(
                          "Paginas: ${book["volumeInfo"].containsKey("pageCount") ? book["volumeInfo"]["pageCount"] : "---"}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _extendedDescription = !_extendedDescription;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5),
                          child: Text(
                            "${book["volumeInfo"].containsKey("description") ? book["volumeInfo"]["description"] : "No description aviable"}",
                            maxLines: _extendedDescription ? 60 : 5,
                            overflow: _extendedDescription
                                ? null
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
