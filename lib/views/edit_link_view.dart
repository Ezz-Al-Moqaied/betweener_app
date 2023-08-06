import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditLinkView extends StatefulWidget {
  String linkTitle;

  String link;

  EditLinkView({Key? key, required this.linkTitle, required this.link})
      : super(key: key);

  @override
  State<EditLinkView> createState() => _EditLinkViewState();
}

class _EditLinkViewState extends State<EditLinkView> {
  TextEditingController titleLinkController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void AddLink() {
    if (_formKey.currentState!.validate()) {
      final bodyData = {
        'title': titleLinkController.text,
        'link': linkController.text
      };

      updateLink(bodyData).then((value) async {
        print(value.link!.title);
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    titleLinkController.text = widget.linkTitle;
    linkController.text = widget.link;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLinksColor.withOpacity(0.6),
        title: const Text("Edit"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              CustomTextFormField(
                controller: titleLinkController,
                hint: 'Enter title Link',
                label: 'title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the title link';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: linkController,
                hint: 'Enter Link',
                label: 'link',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the link';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () async {
                  AddLink();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  decoration: const BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Text(
                    "SAVA",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}