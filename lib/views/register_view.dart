import 'package:betweener_app/assets.dart';
import 'package:betweener_app/controllers/auth_controller.dart';
import 'package:betweener_app/models/register_user.dart';
import 'package:betweener_app/views/main_app_view.dart';
import 'package:betweener_app/views/widgets/custom_text_form_field.dart';
import 'package:betweener_app/views/widgets/navigate_widget.dart';
import 'package:betweener_app/views/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../views/widgets/google_button_widget.dart';

class RegisterView extends StatefulWidget {
  static String id = '/registerView';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void registerView() {
      if (_formKey.currentState!.validate()) {
        final body = {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'password_confirmation': passwordController.text,
        };

        register(body).then((user) async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', registerUserToJson(user)).then((value){
            navigatePushReplacement(context: context, nextScreen: MainAppView());
          });

        }).catchError((err) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(err.toString()),
            backgroundColor: Colors.red,
          ));
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: Hero(
                          tag: 'authImage',
                          child: SvgPicture.asset(AssetsData.authImage))),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextFormField(
                    controller: nameController,
                    hint: 'John Doe',
                    label: 'Name',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hint: 'example@gmail.com',
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    hint: 'Enter password',
                    label: 'password',
                    password: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SecondaryButtonWidget(
                      onTap: () {
                        registerView();
                      },
                      text: 'REGISTER'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '-  or  -',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GoogleButtonWidget(onTap: () {}),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
