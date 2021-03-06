import 'package:conecta_gb/commom/exceptions/translatable_exception.dart';
import 'package:conecta_gb/news/app/widgets/new_post_field_widget.dart';
import 'package:conecta_gb/news/app/widgets/news_widget.dart';
import 'package:conecta_gb/news/app/widgets/post_widget.dart';
import 'package:conecta_gb/news/app/pages/feed/feed_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(FlutterI18n.translate(context, 'feed.title')),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: body,
      bottomNavigationBar: TabBar(
        controller: tabController,
        tabs: tabs!,
        labelColor: Theme.of(context).primaryColorDark,
        unselectedLabelColor: Theme.of(context).primaryColor,
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

  Widget get headerRow => Column(
        children: [
          ControlledWidgetBuilder<FeedViewController>(
              builder: (context, controller) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: !controller.newPostFieldIsDisplayed
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Text(
                    FlutterI18n.translate(
                      context,
                      'feed.welcome',
                      translationParams: {
                        'user': controller.user.name,
                      },
                    ),
                  ),
                  Expanded(
                      child: Container(
                    height: 60,
                  )),
                  if (!controller.newPostFieldIsDisplayed)
                    MaterialButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: controller.changeNewPostFieldVisibility,
                      child: Text(
                        FlutterI18n.translate(context, 'feed.new-post'),
                      ),
                    ),
                ],
              ),
            );
          }),
          ControlledWidgetBuilder<FeedViewController>(
            builder: ((context, controller) {
              if (!controller.newPostFieldIsDisplayed) {
                return Container();
              }

              return NewPostFieldWidget(
                onCancel: controller.changeNewPostFieldVisibility,
                onSend: controller.createNewPost,
                initialValue: controller.editingPost?.content,
              );
            }),
          )
        ],
      );

  Widget get postsList => Expanded(
        child: ControlledWidgetBuilder<FeedViewController>(
          builder: ((context, controller) => controller.feedPosts != null &&
                  controller.feedPosts!.isNotEmpty
              ? RefreshIndicator(
                  child: ListView.builder(
                    itemCount: controller.feedPosts?.length ?? 0,
                    itemBuilder: ((context, index) {
                      final post = controller.feedPosts!.elementAt(index);
                      return PostWidget(
                        post,
                        enableUserActions: post.isUserPostAuthor(
                          controller.user,
                        ),
                        onDelete: controller.onDeletePost,
                        onEdit: controller.onEditPost,
                      );
                    }),
                  ),
                  onRefresh: () async => controller.refreshPosts(),
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
            builder: ((context, controller) {
          if (controller.institutionalNewsFetchException != null) {
            final exception = controller.institutionalNewsFetchException;
            String translationPath = 'errors.unexpected-error';

            if (exception is TranslatableException) {
              translationPath = exception.translationPath;
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 90,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    FlutterI18n.translate(context, '$translationPath.title'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    FlutterI18n.translate(context, '$translationPath.message'),
                    style: Theme.of(context).textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
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
                    onPressed: controller.refreshInstitutionalNews,
                    child: Text(
                      FlutterI18n.translate(
                        context,
                        'buttons.try-again',
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.apply(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          }

          if (controller.institutionalPosts == null ||
              controller.institutionalPosts!.isEmpty) {
            return Center(
              child: Text(
                FlutterI18n.translate(context, 'feed.no-posts-to-display'),
              ),
            );
          }

          return RefreshIndicator(
            child: ListView.builder(
              itemCount: controller.feedPosts?.length ?? 0,
              itemBuilder: ((context, index) {
                final post = controller.institutionalPosts!.elementAt(index);
                return InstitutionalNewsWidget(post);
              }),
            ),
            onRefresh: () async => controller.refreshInstitutionalNews(),
          );
        })),
      );

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}
