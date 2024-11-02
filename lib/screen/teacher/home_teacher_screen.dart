import 'dart:convert';
import 'dart:typed_data';

import 'package:biblioteca/widgets/drawer_teacher.dart';
import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/book.dart';

class HomeTeacherScreen extends StatefulWidget {
  const HomeTeacherScreen({super.key});

  @override
  State<HomeTeacherScreen> createState() => _HomeTeacherScreenState();
}

class _HomeTeacherScreenState extends State<HomeTeacherScreen> {
  TextEditingController searchController = TextEditingController();
  List<Book> booksSearch = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    searchBook();
  }

  void searchBook() async {
    setState(() {
      isLoaded = true;
    });
    List<Book> libros = await Provider.of<BookProvider>(context, listen: false)
        .searchBook(searchController.text);

    setState(() {
      booksSearch = libros;
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BIBLIOTECARIO'),
      ),
      drawer: drawerTeacher(context),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  searchBook();
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar libro',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: isLoaded
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : booksSearch.isEmpty
                      ? const Center(
                          child: Text(
                            'NO HAY LIBROS DISPONIBLES',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: booksSearch.length,
                          itemBuilder: (context, index) {
                            var book = booksSearch[index];
                            Uint8List bytes = base64Decode(book.portada);

                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  context.go(
                                      '/home-teacher-screen/book-details-librarian',
                                      extra: book);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        CachedMemoryImage(
                                          uniqueKey: 'app://image/${book.id}',
                                          errorWidget: const Text('Error'),
                                          bytes: bytes,
                                          placeholder:
                                              const CircularProgressIndicator(),
                                        ),
                                        Text(
                                          book.nombre,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          book.autor,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          book.fechaPublicacion,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
