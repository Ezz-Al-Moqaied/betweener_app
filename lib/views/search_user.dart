import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/followers_controller.dart';
import 'package:betweener_app/controllers/search_controller.dart';
import 'package:flutter/material.dart';

class SearchUser extends SearchDelegate {
  void addFollowView(var body, BuildContext context) {
    addFollow(body).then((value) async {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("The person has been followed"),
        backgroundColor: kLinksColor,
      ));
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You are following the person"),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: searchUser(query.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                padding: const EdgeInsets.all(12),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final users = snapshot.data?[index];
                  return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kLinksColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png'),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users!.name!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                              onPressed: () {
                                final body = {
                                  'followee_id': users.id.toString(),
                                };
                                addFollowView(body, context);
                              },
                              child: const Text("Follow")),
                          const SizedBox(
                            width: 18,
                          ),
                        ],
                      ));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: snapshot.data!.length);
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
