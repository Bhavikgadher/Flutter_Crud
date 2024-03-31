// class UserForm extends StatefulWidget {
//   Map<String, dynamic>? map;
//
//   UserForm({Map<String, dynamic>? map}) {
//     this.map = map;
//   }
//
//   @override
//   State<UserForm> createState() => _UserFormState();
// }
//
// class _UserFormState extends State<UserForm> {
//   var usernameController = TextEditingController();
//   var passwordController = TextEditingController();
//   var firstnameController = TextEditingController();
//   String text = "Hello";
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (widget.map != null) {
//       usernameController.text = widget.map!["UserName"].toString();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         Container(
//           color: Colors.blue,
//           width: MediaQuery.of(context).size.width,
//           child: Row(
//             children: [
//               InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Icon(Icons.arrow_back_rounded)),
//               Container(
//                 height: 50,
//                 child: Text("App Bar"),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Container(
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter username';
//                       }
//
//                       return null;
//                     },
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue)),
//                       labelText: "Enter User Name",
//                       hintText: "abc",
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter username';
//                       }
//
//                       return null;
//                     },
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue)),
//                       labelText: "Enter Password",
//                       hintText: "abc",
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: TextFormField(
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter username';
//                       }
//
//                       return null;
//                     },
//                     controller: firstnameController,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue)),
//                       labelText: "Enter First Name",
//                       hintText: "abc",
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 ElevatedButton(
//                     onPressed: () async {
//                       if (_formKey.currentState!.validate()) {
//                         await insertRecord().then((value) {
//                           Navigator.of(context).pop(true);
//                         });
//                       }
//                     },
//                     child: Text("Submit")),
//                 Text(text)
//               ],
//             ),
//           ),
//         ),
//       ],
//     ));
//   }
//
//   Future<void> insertRecord() async {
//     Map<String, dynamic> map = {};
//     // map["Username"] = usernameController.text;
//     // map["Password"] = passwordController.text;
//     // map["FirstName"] = firstnameController.text;
//
//     UserModelDemo user = UserModelDemo();
//     user.userName = usernameController.text;
//     user.password = passwordController.text;
//     user.firstname = firstnameController.text;
//     await APICode().insertRecord(user.toMap());
//   }
//
// // Future<void> updateRecord() async {
// //   Map<String,dynamic> map = {};
// //   map["UserID"] = widget.map!["UserID"];
// //   map["UserName"] = usernameController.text.toString();
// //   int update = await  MyDatabase().updateRecord(map);
// //
// //
// // }
// }

//========================================================================================
//
// import 'package:crud_flutter/Api/Apicode.dart';
// import 'package:flutter/material.dart';
//
// import 'ApiDialogBox.dart';
//
// class ApiHomePage extends StatefulWidget {
//   const ApiHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<ApiHomePage> createState() => _ApiHomePageState();
// }
//
// class _ApiHomePageState extends State<ApiHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Api Home"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) {
//                   return Justtry();
//                 },
//               )).then((value) {
//                 setState(() {});
//               });
//             },
//             icon: const Icon(Icons.add),
//           )
//         ],
//       ),
//       body: FutureBuilder(
//         future: ApiCode().getDetails(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemBuilder: (context, index) {
//                 final record = snapshot.data![index];
//                 return Row(
//                   children: [
//                     Text(record["title"] as String? ?? 'Unknown Title'),
//                     IconButton(
//                       onPressed: () {
//                         ApiCode()
//                             .deleteRecord(record["id"] as String)
//                             .then((value) => setState(() {}));
//                       },
//                       icon: const Icon(Icons.delete),
//                     )
//                   ],
//                 );
//               },
//               itemCount: snapshot.data!.length,
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text("Error: ${snapshot.error}"),
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//==============================================================================================================//

// import 'package:crud_flutter/Api/Apicode.dart';
// import 'package:crud_flutter/Model/Model.dart';
// import 'package:flutter/material.dart';
//
// class Justtry extends StatefulWidget {
//   Justtry({super.key, this.map});
//   Map<String, dynamic>? map;
//   @override
//   State<Justtry> createState() => _JusttryState();
// }
//
// class _JusttryState extends State<Justtry> {
//   var bookNameController = TextEditingController();
//   var bookAuthorController = TextEditingController();
//   var bookGenreController = TextEditingController();
//   var bookAvailableCopiesController = TextEditingController();
//
//   final _fKey = GlobalKey<FormState>();
//
//   void initState() {
//     super.initState();
//     if (widget.map != null) {
//       bookNameController.text = widget.map!["Title"].toString();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//           children: [
//             Container(
//               color: Colors.blue,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 children: [
//                   InkWell(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: const Icon(Icons.arrow_back_rounded)),
//                   const SizedBox(
//                     height: 50,
//                     child: Text("App Bar"),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Form(
//                 key: _fKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter username';
//                         }
//
//                         return null;
//                       },
//                       controller: bookNameController,
//                       decoration: const InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         labelText: "Enter BookName",
//                         hintText: "abc",
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter bookName';
//                         }
//
//                         return null;
//                       },
//                       controller: bookAuthorController,
//                       decoration: const InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         labelText: "Enter BookAuthorName",
//                         hintText: "abc",
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter BookAuthorName';
//                         }
//
//                         return null;
//                       },
//                       controller: bookGenreController,
//                       decoration: const InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         labelText: "Enter BookGenre",
//                         hintText: "abc",
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter Genre';
//                         }
//
//                         return null;
//                       },
//                       controller: bookAvailableCopiesController,
//                       decoration: const InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.blue)),
//                         labelText: "Enter BookCopy",
//                         hintText: "abc",
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_fKey.currentState!.validate()) {
//                           await insertRecord().then((value) {
//                             Navigator.of(context).pop(true);
//                           });
//                         }
//                       },
//                       child: const Text("Submit"),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Future<void> insertRecord() async {
//     Model user = Model();
//     user.bookName = bookNameController.text;
//     user.bookAuthor = bookAuthorController.text;
//     user.bookGenre = bookGenreController.text;
//     user.bookAvailableCopies = bookAvailableCopiesController.text;
//     await ApiCode().insertRecord(user.toMap());
//   }
// }
