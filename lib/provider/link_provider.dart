import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/models/link.dart';
import 'package:betweener_app/views/widgets/flutterToastWidget.dart';
import 'package:flutter/material.dart';

class LinkProvider with ChangeNotifier {
  final LinkHelper _linkHelper = LinkHelper.instance;
  List<Link> links = [];

  Future<void> getLinks() async {
    await _linkHelper.links().then((value) {
      for (var element in value) {
        links.add(element);
      }
    });
  }

  Future<void> deleteLink(String id) async {
    await _linkHelper.deleteLink(id).then((value) {
      links.remove(value.link);
      flutterToastWidget(
          msg: "Link has been removed", colors: Colors.redAccent);
    });
    notifyListeners();
  }

  Future<void> updateLink(Link link) async {
    await _linkHelper.updateLink(link).then((value) {
      links.remove(value.link);
      flutterToastWidget(
          msg: "Link has been removed", colors: Colors.redAccent);
    });
    notifyListeners();
  }
}
