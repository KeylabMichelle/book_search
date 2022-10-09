import 'package:books/home_page.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// ignore: must_be_immutable
class BookDetail extends StatefulWidget {
  String cover = '';
  String title = '';
  String description = '';
  String release = '';
  String pages = '';

  BookDetail({
    Key? key,
    required this.cover,
    required this.title,
    required this.description,
    required this.release,
    required this.pages,
  }) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  int wrap = 5;

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Detalles del libro'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.public)),
              IconButton(onPressed: () {
                Share.share('Libro: <${widget.title}> con un número de páginas de ${widget.pages}', subject: 'Libro');
              }, icon: Icon(Icons.share))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: widget.cover == ''
                        ? Image.asset('assets/not_found.png',width: 200, height: 300, fit: BoxFit.cover)
                        : Image.network('${widget.cover}',
                            width: 200, height: 300, fit: BoxFit.cover),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        '${widget.title}',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                      )),
                  Text(
                    'Date ${widget.release == 'null' ? 'No date' : widget.release}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Pages: ${widget.pages == 'null' ? 'Unknown' : widget.pages}'),
                  GestureDetector(
                    onTap: () {
                     
                      setState(() {
                         wrap = wrap == 5 ? 100 : 5;
                      });
                      
                    },
                    
                    child: Text(
                      '${widget.description == 'null' ? 'No description' : widget.description}',
                      maxLines: wrap,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),


                ],
              ),
            ),
          )),
    );
  }
}
