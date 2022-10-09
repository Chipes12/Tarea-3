import 'package:books_app/items/book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libreria free to play'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Ingresa un titulo"),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    context.read<BookProvider>().getBooks(titleController.text);
                  },
                ),
              ),
            ),
          ),
          !context.watch<BookProvider>().ShowResults
              ? initialWidget()
              : context.watch<BookProvider>().isLoading
                  ? loadingWidget()
                  : context.watch<BookProvider>().getBooksList.length == 0
                      ? notFoundWidget()
                      : BooksWidget()
        ],
      ),
    );
  }
}

class initialWidget extends StatelessWidget {
  const initialWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.50,
        margin: EdgeInsets.all(14),
        child: Center(child: Text("Ingrese palabra para buscar libro")),
      ),
    );
  }
}

class loadingWidget extends StatelessWidget {
  const loadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [YoutubeShimmer(), YoutubeShimmer(), YoutubeShimmer(), YoutubeShimmer()],
    ));
  }
}

class BooksWidget extends StatelessWidget {
  const BooksWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 30),
            children: List.generate(
                context.watch<BookProvider>().getBooksList.length, (index) {
              return BookItem(
                  book: context.watch<BookProvider>().getBooksList[index]);
            })));
  }
}

class notFoundWidget extends StatelessWidget {
  const notFoundWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.50,
        margin: EdgeInsets.all(14),
        child:
            Center(child: Text("No se encontraron libros con ese titulo :(")),
      ),
    );
  }
}
