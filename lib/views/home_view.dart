import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/views/search_user.dart';
import 'package:betweener_app/views/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants.dart';
import '../models/link.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<Link>> links;

  @override
  void initState() {
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(SharedPreferencesHelper.user.user!.id!);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: const Icon(
              Icons.search,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.document_scanner_rounded,
              size: 35,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            const Text(
              "Hello , Ezz !",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: QrImageView(
                data: SharedPreferencesHelper.user.user!.id!.toString(),
                version: QrVersions.auto,
                size: 350.0,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromRGBO(247, 247, 250, 100),
              ),
              height: 150,
              child: Row(
                children: [
                  Expanded(
                      child: FutureBuilder(
                    future: links,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 120,
                          child: ListView.separated(
                              padding: const EdgeInsets.all(12),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final link = snapshot.data?[index];
                                return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? kLinksColor
                                            : kSecondaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          link!.title!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        Text(
                                          link.link!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ));
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  width: 16,
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
                  )),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      child: const Column(
                        children:  [
                          Icon(Icons.add),
                          Text("Add Link"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
