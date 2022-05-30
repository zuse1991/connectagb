import 'package:conecta_gb/news/app/widgets/news_widget.dart';
import 'package:conecta_gb/news/app/widgets/post_widget.dart';
import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/news/app/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class FeedView extends View {
  FeedView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedViewState();
}

class FeedViewState extends ViewState<View, FeedViewController>
    with SingleTickerProviderStateMixin {
  FeedViewState() : super(FeedViewController());

  List<Widget>? tabs;

  User? user;
  TabController? tabController;

  @override
  Widget get view {
    tabs ??= [
      Tab(
        text: FlutterI18n.translate(context, 'feed.tabs.feed'),
        icon: const Icon(Icons.feed),
      ),
      Tab(
        text: FlutterI18n.translate(context, 'feed.tabs.news'),
        icon: const Icon(Icons.newspaper),
      ),
    ];

    tabController ??= TabController(
      length: tabs!.length,
      vsync: this,
    );
    user ??= ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: I18nText('feed.title'),
      ),
      body: body,
      bottomNavigationBar: TabBar(
        controller: tabController,
        tabs: tabs!,
      ),
    );
  }

  Widget get body => TabBarView(
        controller: tabController,
        children: [feedTab, newsTab],
      );

  Widget get feedTab => Column(
        mainAxisSize: MainAxisSize.max,
        children: [headerRow, postsList],
      );

  Widget get newsTab => Column(
        mainAxisSize: MainAxisSize.max,
        children: [newsList],
      );

  Widget get headerRow => Row(
        children: [
          Text(
            FlutterI18n.translate(
              context,
              'feed.welcome',
              translationParams: {
                'user': user!.name,
              },
            ),
          ),
          Expanded(child: Container()),
          ControlledWidgetBuilder<FeedViewController>(
            builder: (context, controller) => MaterialButton(
              onPressed: controller.displayNewPostField,
              child: Text(FlutterI18n.translate(context, 'feed.new-post')),
            ),
          )
        ],
      );

  Widget get postsList => Expanded(
        child: ControlledWidgetBuilder<FeedViewController>(
          builder: ((context, controller) => controller.feedPosts != null &&
                  controller.feedPosts!.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.feedPosts?.length ?? 0,
                  itemBuilder: ((context, index) {
                    final post = controller.feedPosts!.elementAt(index);
                    return PostWidget(post);
                  }),
                )
              : Center(
                  child: Text(
                    FlutterI18n.translate(context, 'feed.no-posts-to-display'),
                  ),
                )),
        ),
      );

  Widget get newsList => Expanded(
        child: ControlledWidgetBuilder<FeedViewController>(
          builder: ((context, controller) => controller.feedPosts != null &&
                  controller.feedPosts!.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.feedPosts?.length ?? 0,
                  itemBuilder: ((context, index) {
                    final post =
                        controller.institutionalPosts!.elementAt(index);
                    return InstitutionalNewsWidget(post);
                  }),
                )
              : Center(
                  child: Text(
                    FlutterI18n.translate(context, 'feed.no-posts-to-display'),
                  ),
                )),
        ),
      );

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
