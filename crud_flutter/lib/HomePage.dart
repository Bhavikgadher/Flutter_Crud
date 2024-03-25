import 'package:flutter/material.dart';

import 'db_HelperClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelperClass db = DbHelperClass();

  void showInsertAndUpdateDialog(BuildContext context, Map? map) async {
    TextEditingController bookNameTextController = TextEditingController();
    TextEditingController bookAuthorTextController = TextEditingController();
    TextEditingController bookGenreTextController = TextEditingController();
    TextEditingController bookAvailableCopiesTextController =
        TextEditingController();

    if (map != null) {
      bookNameTextController.text = map['BookName'] ?? '';
      bookAuthorTextController.text = map['BookAuthor'] ?? '';
      bookGenreTextController.text = map['BookGenre'] ?? '';
      bookAvailableCopiesTextController.text =
          map['BookAvailableCopies']?.toString() ?? '';
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: bookNameTextController,
              decoration: const InputDecoration(
                  hintText: "BookName",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            TextFormField(
              controller: bookAuthorTextController,
              decoration: const InputDecoration(
                  hintText: "Book AuthorName",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            TextFormField(
              controller: bookGenreTextController,
              decoration: const InputDecoration(
                  hintText: "BookGenre",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            TextFormField(
              controller: bookAvailableCopiesTextController,
              decoration: const InputDecoration(
                  hintText: "AvailableBookCopies",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (map == null) {
                  await db.insertBook(
                    bookName: bookNameTextController.text,
                    bookAuthor: bookAuthorTextController.text,
                    bookGenre: bookGenreTextController.text,
                    bookAvailableCopies:
                        int.tryParse(bookAvailableCopiesTextController.text) ??
                            0,
                  );
                } else {
                  await db.updateBook(
                    bookId: map['BookId'],
                    bookName: bookNameTextController.text,
                    bookAuthor: bookAuthorTextController.text,
                    bookGenre: bookGenreTextController.text,
                    bookAvailableCopies:
                        int.tryParse(bookAvailableCopiesTextController.text) ??
                            0,
                  );
                }
                Navigator.pop(context);
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                elevation: 3, // Elevation
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.black,
              ),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Library Catalog",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: db.getDataFromLibrary(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Data Is Not Found"));
          } else {
            return ListView.builder(
              key: UniqueKey(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, bottom: 10.0, top: 10.0),
                  child: ListTile(
                    tileColor: Colors.black,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "BookID: ${snapshot.data![index]["BookId"]}. ",
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                            Expanded(
                              child: Text(
                                snapshot.data![index]["BookName"].toString(),
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "BookAuthor: ${snapshot.data![index]["BookAuthor"]}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          "BookGenre: ${snapshot.data![index]["BookGenre"]}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          "BookAvailableCopies: ${snapshot.data![index]["BookAvailableCopies"]}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showInsertAndUpdateDialog(
                                context, snapshot.data![index]);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await db.deleteBook(int.parse(
                                snapshot.data![index]['BookId'].toString()));
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showInsertAndUpdateDialog(context, null);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
