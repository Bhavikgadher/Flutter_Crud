import 'package:crud_flutter/Api/AddEditRecord.dart';
import 'package:crud_flutter/Api/Apicode.dart';
import 'package:flutter/material.dart';

class ApiHomePage extends StatefulWidget {
  const ApiHomePage({Key? key}) : super(key: key);

  @override
  State<ApiHomePage> createState() => _ApiHomePageState();
}

class _ApiHomePageState extends State<ApiHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Page"),
      ),
      body: FutureBuilder(
        future: ApiCode().getDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("Data Is Not Found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                  child: ListTile(
                    tileColor: Colors.blue,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "BookName: ${snapshot.data![index].bookName.toString()}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "BookAuthor: ${snapshot.data![index].bookAuthor.toString()}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "BookGenre: ${snapshot.data![index].bookGenre.toString()}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        Text(
                          "BookAvailableCopies: ${snapshot.data![index].bookAvailableCopies.toString()}",
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
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AddEditDialog(
                                    model: snapshot.data![index],
                                  );
                                },
                              ).then(
                                (value) {
                                  setState(() {});
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                        IconButton(
                          onPressed: () => ApiCode()
                              .deleteRecord(
                                  snapshot.data![index].bookId.toString())
                              .then((value) => setState(() {})),
                          icon: const Icon(
                            color: Colors.white,
                            Icons.deblur_outlined,
                          ),
                        ),
                      ],
                    ),
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddEditDialog();
              }).then(
            (value) {
              setState(() {});
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
