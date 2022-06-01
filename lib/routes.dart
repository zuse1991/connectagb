import 'package:conecta_gb/access/app/pages/sign_in/sign_in_view.dart';
import 'package:conecta_gb/access/app/pages/sign_up/sign_up_view.dart';
import 'package:conecta_gb/news/app/pages/feed/feed_view.dart';
import 'package:flutter/material.dart';

var appRoutes = <String, WidgetBuilder>{
  '/sign-in': (context) => SignInView(),
  '/sign-up': (context) => SignUpView(),
  '/feed': (context) => FeedView(),
};
