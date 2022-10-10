import 'package:books/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_provider.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  String txt = '';
  HomePage({
    Key? key,
    required this.txt,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();
  bool busqueda = false;

  @override
  void dispose() {
    widget.txt = widget.txt;

    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Librería free to play'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                            onTap: () {
                              widget.txt = '';
                              busqueda = true;
                              setState(() {});

                              Provider.of<BookProvider>(context, listen: false)
                                  .searchBook(controller.text);
                            },
                            child: Icon(Icons.search)),
                        border: OutlineInputBorder(),
                        labelText: 'Ingresa Título')),
              ),
              Text('${widget.txt}'),
              Consumer<BookProvider>(builder: (context, value, child) {
                return Expanded(
                  child: value.searchResults.isEmpty && busqueda
                      ? value.termina
                          ? Text('No se encontraron resultados')
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return ProfilePageShimmer(
                                  hasCustomColors: true,
                                  colors: [
                                    Colors.yellow,
                                    Color.fromARGB(255, 147, 232, 150),
                                    Color.fromARGB(255, 198, 71, 220),                  
                                  ],
                                );
                              })
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                          ),
                          itemCount:
                              Provider.of<BookProvider>(context, listen: false)
                                  .searchResults
                                  .length,
                          itemBuilder: (BuildContext context, int index) {
                            String title = '';
                            String description = '';
                            String release = '';
                            String pages = '';
                            String cover = '';
                            if (Provider.of<BookProvider>(context,
                                        listen: false)
                                    .searchResults
                                    .length ==
                                0) {
                              description = '';
                              release = '';
                              pages = '';
                              cover = '';
                              title = '';
                            } else {
                              title =
                                  '${value.searchResults[index]['volumeInfo']['title']}';
                              description =
                                  '${value.searchResults[index]['volumeInfo']['description']}';
                              release =
                                  '${value.searchResults[index]['volumeInfo']['publishedDate']}';
                              pages =
                                  '${value.searchResults[index]['volumeInfo']['pageCount'].toString()}';
                              cover = Provider.of<BookProvider>(context,
                                                  listen: false)
                                              .searchResults[index]
                                          ['volumeInfo']['imageLinks'] ==
                                      null
                                  ? 'assets/not_found.png'
                                  : '${value.searchResults[index]['volumeInfo']['imageLinks']['thumbnail']}';
                            }
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                    description: description,
                                    title: title,
                                    cover: cover,
                                    release: release,
                                    pages: pages,
                                  ),
                                ));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Provider.of<BookProvider>(
                                                                context,
                                                                listen: false)
                                                            .searchResults[
                                                        index]['volumeInfo']
                                                    ['imageLinks'] ==
                                                null
                                            ? Image.asset(
                                                'assets/not_found.png')
                                            : Image.network(
                                                '${value.searchResults[index]['volumeInfo']['imageLinks']['thumbnail']}')),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        '${value.searchResults[index]['volumeInfo']['title']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                );
              })
            ],
          )),
    );
  }
}
