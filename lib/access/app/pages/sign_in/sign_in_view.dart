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
        backgroundColor: Theme.of(context).primaryColor,
        key: globalKey,
        body: body,
        bottomNavigationBar: newAccountSession,
      );

  Widget get body {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 75),
            Container(
              height: 150,
              width: 150,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 30),
            Text(
              FlutterI18n.translate(
                context,
                'sign-in.title',
              ),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.apply(color: Colors.white),
            ),
            const SizedBox(height: 15),
            signInFields,
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget get signInFields => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              FlutterI18n.translate(
                context,
                'sign-in.sign-in-subtitle',
              ),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 15),
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
                            controller:
                                controller.passwordTextEditingController,
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
            const SizedBox(height: 10),
            ControlledWidgetBuilder<SignInViewController>(
              builder: (context, controller) => MaterialButton(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                splashColor: Theme.of(context).primaryColorDark,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                onPressed: controller.signInButtonTap,
                child: Text(
                  FlutterI18n.translate(
                    context,
                    'sign-in.sign-in-button',
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.apply(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );

  Widget get newAccountSession => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              FlutterI18n.translate(
                context,
                'sign-in.new-account-subtitle',
              ),
            ),
            const SizedBox(height: 10),
            ControlledWidgetBuilder<SignInViewController>(
              builder: (context, controller) => MaterialButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                splashColor: Theme.of(context).primaryColorLight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
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
