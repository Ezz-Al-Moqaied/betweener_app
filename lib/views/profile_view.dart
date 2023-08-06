import 'package:betweener_app/controllers/followers_controller.dart';
import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/controllers/user_controller.dart';
import 'package:betweener_app/views/add_link_view.dart';
import 'package:betweener_app/views/edit_link_view.dart';
import 'package:betweener_app/views/edit_profile_view.dart';
import 'package:betweener_app/views/widgets/navigate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    void deleteLinkView(String id) {
      deleteLink(id).then((value) {
        setState(() {
          links = getLinks(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Link has been removed"),
            backgroundColor: Colors.red,
          ));
        });
      });
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(
                                'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${snapshot.data?.user?.name}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '${snapshot.data?.user?.email}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Text(
                            '05955225525222',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                child: FutureBuilder(
                                  future: getFollowingCount(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: kSecondaryColor,
                                        ),
                                        child: Text(
                                            'followers :  ${snapshot.data?.followersCount}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                                onTap: () {

                                },
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              FutureBuilder(
                                future: getFollowingCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: kSecondaryColor,
                                      ),
                                      child: Text(
                                        'following : ${snapshot.data?.followingCount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                navigatePush(
                                    context: context,
                                    nextScreen:
                                        EditProfileView(user: snapshot.data!));
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 30,
                                color: Colors.white,
                              ))
                        ],
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: FutureBuilder(
              future: links,
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
                              color: index % 2 == 0
                                  ? kDangerColor.withOpacity(0.3)
                                  : kSecondaryColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    deleteLinkView(
                                        snapshot.data![index].id.toString());
                                  },
                                  backgroundColor: kRedColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    navigatePush(
                                        context: context,
                                        nextScreen: EditLinkView(
                                            link: snapshot.data![index]));
                                  },
                                  backgroundColor: kSecondaryColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    link!.title!,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    link.link!,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.4),
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
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
                      color: kPrimaryColor),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.add, color: Colors.white, size: 25),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
