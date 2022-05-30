import 'package:conecta_gb/access/app/pages/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SignInView extends View {
  SignInView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SignInViewState();
}

class SignInViewState extends ViewState<SignInView, SignInViewController> {
  SignInViewState() : super(SignInViewController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: body,
      );

  Widget get body {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            FlutterI18n.translate(
              context,
              'sign-in.title',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            FlutterI18n.translate(
              context,
              'sign-in.sign-in-subtitle',
            ),
          ),
          ControlledWidgetBuilder<SignInViewController>(
            builder: ((context, controller) => Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: FlutterI18n.translate(
                            context,
                            'sign-in.email',
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: controller.validateEmail,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                          controller: controller.passwordTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: FlutterI18n.translate(
                              context,
                              'sign-in.password',
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          validator: controller.validatePassword),
                    ],
                  ),
                )),
          ),
          ControlledWidgetBuilder<SignInViewController>(
            builder: (context, controller) => MaterialButton(
              onPressed: controller.signInButtonTap,
              child: Text(
                FlutterI18n.translate(
                  context,
                  'sign-in.sign-in-button',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          const Divider(),
          Text(
            FlutterI18n.translate(
              context,
              'sign-in.new-account-subtitle',
            ),
          ),
          ControlledWidgetBuilder<SignInViewController>(
            builder: (context, controller) => MaterialButton(
              onPressed: controller.newAccountButtonTap,
              child: Text(
                FlutterI18n.translate(
                  context,
                  'sign-in.create-account-button',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
