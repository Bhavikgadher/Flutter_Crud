import 'dart:convert';

import 'package:crud_flutter/Model/Model.dart';
import 'package:http/http.dart' as http;

class ApiCode {
  Future<List<Model>> getDetails() async {
    String url = "https://6603b7892393662c31cf7a47.mockapi.io/bookdetails/";
    var res = await http.get(Uri.parse(url));
    List<dynamic> bookList = jsonDecode(res.body);
    List<Model> data = [];
    for (int i = 0; i < bookList.length; i++) {
      Model bookDetails = Model();
      bookDetails.bookName = bookList[i]["Title"];
      bookDetails.bookAuthor = bookList[i]["Author"];
      bookDetails.bookGenre = bookList[i]["Genre"];
      bookDetails.bookAvailableCopies = bookList[i]["AvailableCopies"];
      bookDetails.bookId = bookList[i]["id"];
      data.add(bookDetails);
    }
    return data;
  }

  Future<void> deleteRecord(String id) async {
    await http.delete(Uri.parse(
        "https://6603b7892393662c31cf7a47.mockapi.io/bookdetails/$id"));
  }

  Future<void> insertRecord(Model model) async {
    String url = "https://6603b7892393662c31cf7a47.mockapi.io/bookdetails";
    Map<String, Object?> map = {};
    map["Title"] = model.bookName;
    map["Author"] = model.bookAuthor;
    map["Genre"] = model.bookGenre;
    map["AvailableCopies"] = model.bookAvailableCopies;
    await http.post(Uri.parse(url), body: map);
  }

  Future<void> updateRecord(Model model) async {
    String url = "https://6603b7892393662c31cf7a47.mockapi.io/bookdetails/";
    Map<String, Object?> map = {};
    map["Title"] = model.bookName;
    map["Author"] = model.bookAuthor;
    map["Genre"] = model.bookGenre;
    map["AvailableCopies"] = model.bookAvailableCopies;
    await http.put(Uri.parse(url + model.bookId.toString()), body: map);
  }
}
