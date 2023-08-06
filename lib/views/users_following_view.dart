import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/followers_controller.dart';
import 'package:flutter/material.dart';

class UsersFollowingView extends StatefulWidget {
  int number ;
  UsersFollowingView({Key? key , required this.number}) : super(key: key);

  @override
  State<UsersFollowingView> createState() => _UsersFollowingViewState();
}

class _UsersFollowingViewState extends State<UsersFollowingView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            child: ListView.separated(
                itemBuilder: (context, index) {

                }, separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                }, itemCount: widget.number,
            ),
          );
        }
        return Container();
      },
    );
  }
}

/*
Text(
                'followers :  ${snapshot.data?.followersCount}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black))
 */