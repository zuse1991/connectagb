import 'package:conecta_gb/news/app/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FeedView extends View {
  FeedView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedViewState();
}

class FeedViewState extends ViewState<View, FeedViewController> {
  FeedViewState() : super(FeedViewController());

  @override
  Widget get view => Scaffold(
        appBar: AppBar(),
      );
}
