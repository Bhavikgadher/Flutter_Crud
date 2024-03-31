import 'package:crud_flutter/Api/Apicode.dart';
import 'package:flutter/material.dart';

import '../Model/Model.dart';

class AddEditDialog extends StatefulWidget {
  AddEditDialog({super.key, this.model});

  Model? model;

  @override
  State<AddEditDialog> createState() => _AddEditDialogState();
}

class _AddEditDialogState extends State<AddEditDialog> {
  ApiCode api = ApiCode();
  TextEditingController bookName = TextEditingController();
  TextEditingController bookAuthor = TextEditingController();
  TextEditingController bookGenre = TextEditingController();
  TextEditingController bookAvailableCopies = TextEditingController();

  final _fKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bookName.text = widget.model?.bookName ?? '';
    bookAuthor.text = widget.model?.bookAuthor ?? '';
    bookGenre.text = widget.model?.bookGenre ?? '';
    bookAvailableCopies.text = widget.model?.bookAvailableCopies ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          key: _fKey,
          children: [
            TextFormField(
              controller: bookName,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                  labelText: 'Enter The BookName',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: bookAuthor,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter The BookAuthorName',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: bookGenre,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter The BookGenre',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: bookAvailableCopies,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Enter The BookAvailableCopies',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                print('Submit button pressed');
                Model amb = Model();
                amb.bookName = bookName.text;
                amb.bookAuthor = bookAuthor.text;
                amb.bookGenre = bookGenre.text;
                amb.bookAvailableCopies = bookAvailableCopies.text;

                if (widget.model != null) {
                  amb.bookId = widget.model?.bookId ?? '0';
                  api.updateRecord(amb).then(
                    (value) {
                      print('Record updated successfully');
                      Navigator.pop(context);
                    },
                  );
                } else {
                  api.insertRecord(amb).then(
                    (value) {
                      print('Record inserted successfully');
                      Navigator.pop(context);
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  elevation: 3,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.all(16)),
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.black,
    );
  }
}
