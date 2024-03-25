import 'package:flutter/material.dart';

import 'db_HelperClass.dart';

class InsertAndUpdateDialog extends StatefulWidget {
  const InsertAndUpdateDialog({super.key, this.map});

  final Map? map;

  @override
  State<InsertAndUpdateDialog> createState() => _InsertAndUpdateDialogState();
}

class _InsertAndUpdateDialogState extends State<InsertAndUpdateDialog> {
  DbHelperClass db = DbHelperClass();
  TextEditingController bookNameTextController = TextEditingController();
  TextEditingController bookAuthorTextController = TextEditingController();
  TextEditingController bookGenreTextController = TextEditingController();
  TextEditingController bookAvailableCopiesTextController =
      TextEditingController();

  void showInsertUpdateDialog(
      BuildContext context, TextEditingController controller, String hintText) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hintText),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            onTap: () {
              showInsertUpdateDialog(
                context,
                bookNameTextController,
                "Enter Book Name",
              );
            },
            controller: bookNameTextController,
            decoration: const InputDecoration(hintText: "BookName"),
          ),
          TextFormField(
            onTap: () {
              showInsertUpdateDialog(
                context,
                bookAuthorTextController,
                "Enter Book AuthorName",
              );
            },
            controller: bookAuthorTextController,
            decoration: const InputDecoration(hintText: "Book AuthorName"),
          ),
          TextFormField(
            onTap: () {
              showInsertUpdateDialog(
                context,
                bookGenreTextController,
                "Enter BookGenre",
              );
            },
            controller: bookGenreTextController,
            decoration: const InputDecoration(hintText: "BookGenre"),
          ),
          TextFormField(
            onTap: () {
              showInsertUpdateDialog(
                context,
                bookAvailableCopiesTextController,
                "Enter AvailableBookCopies",
              );
            },
            controller: bookAvailableCopiesTextController,
            decoration: const InputDecoration(hintText: "AvailableBookCopies"),
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.map == null) {
                db.insertBook(
                  bookName: bookNameTextController.text,
                  bookAuthor: bookAuthorTextController.text,
                  bookGenre: bookGenreTextController.text,
                  bookAvailableCopies: bookAvailableCopiesTextController.text,
                );
              } else {
                db
                    .updateBook(
                      bookId: widget.map!['BookId'],
                      bookName: bookNameTextController.text,
                      bookAuthor: bookAuthorTextController.text,
                      bookGenre: bookGenreTextController.text,
                      bookAvailableCopies:
                          bookAvailableCopiesTextController.text,
                    )
                    .then((value) => Navigator.pop(context));
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
