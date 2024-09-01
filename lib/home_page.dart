// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:post_app/post.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // Variable to call and store future list of posts
//   Future<List<Post>> postsFuture = getData();

//   // Function to fetch data from API and return future list of posts
//   static Future<List<Post>> getData() async {
//     var url =
//         Uri.parse("https://api.airtable.com/v0/app7TDeHagnJEtYlz/Details");
//     final response = await http.get(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//         "Authorization":
//             "Bearer pat703vpKB5Wlg35B.20b7f83d25dcae00c8fb81f71c5c932c1a00a9c32138dc83c206f5e09f82f135", // Include your token here
//       },
//     );

//     if (response.statusCode == 200) {
//       final body = json.decode(response.body);
//       print(body);
//       List records = body['records'];
//       return records.map((e) => Post.fromJson(e['fields'])).toList();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Indesh"),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//       ),
//       body: Center(
//         child: FutureBuilder<List<Post>>(
//           future: postsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               // Until data is fetched, show loader
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               // Once data is fetched, display it on screen (call buildPosts())
//               final posts = snapshot.data!;
//               return buildPosts(posts);
//             } else if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             } else {
//               return const Text("No data available");
//             }
//           },
//         ),
//       ),
//     );
//   }

//   // Function to display fetched data on screen
//   Widget buildPosts(List<Post> posts) {
//     return ListView.builder(
//       itemCount: posts.length,
//       itemBuilder: (context, index) {
//         final post = posts[index];
//         return Container(
//           color: Color.fromARGB(255, 240, 238, 238),
//           margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 8.0, left: 8.0),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           ' ${post.firstName} ${post.lastName}',
//                           style: const TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           ' ${post.designation}',
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.w300),
//                         ),
//                         Text(
//                           'Github Link: ${post.githubLink}',
//                           style: const TextStyle(fontSize: 10),
//                         ),

//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'Contact',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text('Email: ${post.email}'),
//                         Text('DOB: ${post.dob != null ? post.dob! : 'N/A'}'),
//                         Text('Address: ${post.address}'),
//                         Text('Phone: ${post.phone}'),

//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'Education',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         // Text(
//                         //     ' ${post.education != null ? post.education!.join(', ') : 'N/A'}'),
//                         Text(' ${post.collegeName}'),
//                         Text(' ${post.degreeName}'),
//                         Text(' ${post.educationCity}'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'Experience',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(' ${post.jobtitle}'),
//                         Text(' ${post.jobDescription}'),
//                         Text(' ${post.organization}'),
//                         Text(' ${post.jobCity}'),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Summary',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(' ${post.summary}'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'Hobbies',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Text(' ${post.hobbies}'),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           'Languages',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: post.languages != null
//                               ? List.generate(post.languages!.length, (index) {
//                                   return Text(
//                                     '${index + 1}. ${post.languages![index]}',
//                                     style: const TextStyle(fontSize: 14),
//                                   );
//                                 })
//                               : [
//                                   const Text('N/A',
//                                       style: TextStyle(fontSize: 14))
//                                 ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future to fetch the posts from the API
  Future<List<Post>> postsFuture = getData();

  static Future<List<Post>> getData() async {
    var url =
        Uri.parse("https://api.airtable.com/v0/app7TDeHagnJEtYlz/Details");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer pat703vpKB5Wlg35B.20b7f83d25dcae00c8fb81f71c5c932c1a00a9c32138dc83c206f5e09f82f135",
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      List records = body['records'];
      return records.map((e) => Post.fromJson(e['fields'])).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildPosts(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          color: const Color.fromARGB(255, 240, 238, 238),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 40,
                            width: 40,
                            child: ClipOval(
                                child: Image.network(
                              ' ${post.photoUrl}',
                              fit: BoxFit.cover,
                            ))),
                        Text(
                          ' ${post.firstName} ${post.lastName}',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' ${post.designation}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          'Github Link: ${post.githubLink}',
                          style: const TextStyle(fontSize: 10),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Contact',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Email: ${post.email}'),
                        Text('DOB: ${post.dob}'),
                        // Text('DOB: ${post.dob != null ? post.dob! : 'N/A'}'),
                        Text('Address: ${post.address}'),
                        Text('Phone: ${post.phone}'),

                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Education',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //     ' ${post.education != null ? post.education!.join(', ') : 'N/A'}'),
                        Text(' ${post.collegeName}'),
                        Text(' ${post.degreeName}'),
                        Text(' ${post.educationCity}'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Experience',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(' ${post.jobtitle}'),
                        Text(' ${post.jobDescription}'),
                        Text(' ${post.organization}'),
                        Text(' ${post.jobCity}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Summary',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ${post.summary}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Hobbies',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ${post.hobbies}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Languages',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        // Text(
                        //   ' ${post.languages}',
                        //   style: const TextStyle(fontSize: 11),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: post.languages != null
                              ? List.generate(post.languages!.length, (index) {
                                  return Text(
                                    '${index + 1}. ${post.languages![index]}',
                                    style: const TextStyle(fontSize: 11),
                                  );
                                })
                              : [
                                  const Text('N/A',
                                      style: TextStyle(fontSize: 14))
                                ],
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
