// import 'package:flutter/material.dart';

// class SearchableDropdown extends StatefulWidget {
//   final List<String> items;

//   const SearchableDropdown({super.key, required this.items});

//   @override
//   _SearchableDropdownState createState() => _SearchableDropdownState();
// }

// class _SearchableDropdownState extends State<SearchableDropdown> {
//   List<String> filteredItems = [];
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     filteredItems = widget.items;
//   }

//   void filterSearchResults(String query) {
//     List<String> dummySearchList = [];
//     dummySearchList.addAll(widget.items);
//     if (query.isNotEmpty) {
//       List<String> dummyListData = [];
//       for (var item in dummySearchList) {
//         if (item.toLowerCase().contains(query.toLowerCase())) {
//           dummyListData.add(item);
//         }
//       }
//       setState(() {
//         filteredItems.clear();
//         filteredItems.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         filteredItems.clear();
//         filteredItems.addAll(widget.items);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: _controller,
//           decoration: const InputDecoration(
//             labelText: 'Search',
//             prefixIcon: Icon(Icons.search),
//           ),
//           onChanged: (value) {
//             filterSearchResults(value);
//           },
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 200, // Set the height as needed
//           child: ListView.builder(
//             itemCount: filteredItems.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(filteredItems[index]),
//                 onTap: () {
//                   // Handle the selection here
//                   _controller.text = filteredItems[index];
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
