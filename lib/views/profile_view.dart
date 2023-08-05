import 'package:betweener_app/controllers/followers_controller.dart';
import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/controllers/user_controller.dart';
import 'package:betweener_app/views/add_link_view.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';


class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<UserModel> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1Tyom2tGGTFNI69YWk3_v4UDPiCclNcxZaKdVKC-N&s',
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${snapshot.data?.user?.name}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                          Text(
                            '${snapshot.data?.user?.email}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const Text(
                            '05955225525222',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                future: getFollowingCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: kSecondaryColor ,
                                      ),
                                      child: Text(
                                          'followers :  ${snapshot.data?.followersCount}',
                                          style: const TextStyle(color: Colors.white)),
                                    );
                                  }
                                  return const Text('loading');
                                },
                              ),
                              const SizedBox(width: 8,),
                              FutureBuilder(
                                future: getFollowingCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: kSecondaryColor ,
                                      ),
                                      child: Text(
                                        'following : ${snapshot.data?.followingCount}',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }
                                  return const Text('loading');
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
              return const Text('loading');
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 80,
                    child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final link = snapshot.data?[index];
                          return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: index%2 == 0 ? kLinksColor : kSecondaryColor,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    link!.title!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    link.link!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16,
                          );
                        },
                        itemCount: snapshot.data!.length),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Text('loading');
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AddLinkView.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(right: 25),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: kPrimaryColor
                  ),
                  alignment: Alignment.centerRight, child: const Icon(Icons.add , color: Colors.white, size: 25),),
              ),
            ],
          ),
          const SizedBox(height: 100,),
        ],
      ),
    );
  }
}
