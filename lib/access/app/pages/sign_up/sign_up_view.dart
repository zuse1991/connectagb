import 'package:conecta_gb/access/app/pages/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SignUpView extends View {
  SignUpView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignUpViewState();
}

class SignUpViewState extends ViewState<SignUpView, SignUpViewController> {
  SignUpViewState() : super(SignUpViewController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            FlutterI18n.translate(context, 'sign-up.title'),
          ),
        ),
        body: body,
      );

  Widget get body => SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ControlledWidgetBuilder<SignUpViewController>(
            builder: (context, controller) => Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(FlutterI18n.translate(context, 'sign-up.description')),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: controller.nameTextEditingController,
                    keyboardType: TextInputType.name,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: FlutterI18n.translate(
                        context,
                        'sign-up.name-field',
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: controller.validateName,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: FlutterI18n.translate(
                        context,
                        'sign-up.email-field',
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: controller.validateEmail,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.passwordTextEditingController,
                    decoration: InputDecoration(
                      labelText: FlutterI18n.translate(
                        context,
                        'sign-up.password-field',
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: controller.validatePassword,
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    splashColor: Theme.of(context).primaryColorDark,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    onPressed: controller.sendUser,
                    child: Text(
                      FlutterI18n.translate(
                        context,
                        'buttons.ok',
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.apply(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
}
