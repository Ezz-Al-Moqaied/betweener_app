import 'package:betweener_app/constants.dart';
import 'package:betweener_app/controllers/link_controller.dart';
import 'package:betweener_app/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddLinkView extends StatefulWidget {
  static String id = '/addLinkView';

  const AddLinkView({Key? key}) : super(key: key);

  @override
  State<AddLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<AddLinkView> {
  TextEditingController titleLinkController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void addLinkView() {
    if (_formKey.currentState!.validate()) {
      final bodyData = {
        'title': titleLinkController.text,
        'link': linkController.text
      };

      addLink(bodyData).then((value) async {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("The link has been added successfully"),
          backgroundColor: kLinksColor,
        ));
        titleLinkController.clear();
        linkController.clear();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kLinksColor.withOpacity(0.6),
        title: const Text("Add Link"),
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
                  addLinkView();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  decoration: const BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: const Text(
                    "ADD",
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
