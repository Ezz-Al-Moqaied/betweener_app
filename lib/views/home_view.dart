import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/views/add_link_view.dart';
import 'package:betweener_app/views/search_user.dart';
import 'package:betweener_app/views/widgets/navigate_widget.dart';
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
                data: '20',
                version: QrVersions.auto,
                size: 350.0,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FutureBuilder(
                    future: links,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 120,
                          child: ListView.separated(
                              padding: const EdgeInsets.all(12),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final link = snapshot.data?[index];
                                return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: kLinksColor,
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
                  ),
                  GestureDetector(
                    onTap: () {
                      navigatePush(context: context, nextScreen: const AddLinkView());
                    },
                    child: Container(
                      height: 98,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 30,
                          ),
                          Text(
                            "Add Link",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
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
//
