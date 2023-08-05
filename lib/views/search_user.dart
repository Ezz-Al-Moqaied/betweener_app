import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/search_controller.dart';
import 'package:flutter/material.dart';

class SearchUser extends SearchDelegate {
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
                  final link = snapshot.data?[index];
                  return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kLinksColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png'),
                          ),
                          const SizedBox(width: 18,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                link!.name!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                link.name!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(onPressed: (){}, child: const Text("Follow")),
                          const SizedBox(width: 18,),

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
          return const Text('loading');
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: searchUser(''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                padding: const EdgeInsets.all(12),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final link = snapshot.data?[index];
                  return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kLinksColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png'),
                          ),
                          const SizedBox(width: 18,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                link!.name!,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                link.name!,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(onPressed: (){}, child: const Text("Follow")),
                          const SizedBox(width: 18,),

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
          return const Text('loading');
        },
      ),
    );
  }
}
