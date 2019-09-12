// import 'package:flutter/material.dart';

// class CustomSearchDeleagte extends SearchDelegate<String>{
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     close(context, query);
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     return Container();
//   }
  
// }