import 'package:betweener_app/constants.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/views/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  UserModel user ;
  EditProfileView({Key? key , required this.user}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.user.user!.name!;
    emailController.text = widget.user.user!.email!;
    phoneController.text = "123456";
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
              const CircleAvatar(
                radius: 120,
                backgroundImage: NetworkImage(
                    'https://www.clipartmax.com/png/middle/91-915439_to-the-functionality-and-user-experience-of-our-site-red-person-icon.png'),
              ),
              const SizedBox(height: 20,),
              CustomTextFormField(
                controller: nameController,
                hint: 'Enter username',
                label: 'name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the user name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: emailController,
                hint: 'Enter email',
                label: 'email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextFormField(
                controller: phoneController,
                hint: 'Enter phone number',
                label: 'phone',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () async {
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
