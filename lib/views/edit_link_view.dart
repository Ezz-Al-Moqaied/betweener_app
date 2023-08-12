
import 'package:betweener_app/constants.dart';
import 'package:betweener_app/models/link.dart';
import 'package:betweener_app/provider/link_provider.dart';
import 'package:betweener_app/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLinkView extends StatefulWidget {
  Link link;

  EditLinkView({Key? key, required this.link}) : super(key: key);

  @override
  State<EditLinkView> createState() => _EditLinkViewState();
}

class _EditLinkViewState extends State<EditLinkView> {
  TextEditingController titleLinkController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    titleLinkController.text = widget.link.title!;
    linkController.text = widget.link.link!;
    final linkProvider = Provider.of<LinkProvider>(context);
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
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    widget.link.title = titleLinkController.text;
                    widget.link.link = linkController.text;
                    linkProvider.updateLink(widget.link);
                  }
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
