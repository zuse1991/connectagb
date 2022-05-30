import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:conecta_gb/news/app/pages/feed/feed_view.dart';
import 'package:conecta_gb/news/data/repositories/posts_repository.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FeedViewController extends Controller {
  FeedViewController() : _presenter = FeedViewPresenter(PostsRepository());

  final FeedViewPresenter _presenter;
  List<InstitutionalMessage>? institutionalPosts;
  List<Post>? feedPosts;

  @override
  void initListeners() {
    _presenter.institutionalNewsOnComplete = institutionalNewsOnComplete;
    _presenter.institutionalNewsOnData = institutionalNewsOnData;
    _presenter.institutionalNewsOnError = institutionalNewsOnError;

    _presenter.fetchPostsOnComplete = fetchPostsOnComplete;
    _presenter.fetchPostsOnData = fetchPostsOnData;
    _presenter.fetchPostsOnError = fetchPostsOnError;

    _presenter.sendPostOnComplete = sendPostOnComplete;
    _presenter.sendPostOnError = sendPostOnError;

    _presenter.listenNewPostsOnComplete = listenNewPostsOnComplete;
    _presenter.listenNewPostsOnData = listenNewPostsOnData;
    _presenter.listenNewPostsOnError = listenNewPostsOnError;

    _presenter.fetchInstitutionalNews();
    _presenter.fetchPosts();
  }

  User? get user => (getState() as FeedViewState).user;

  void displayNewPostField() {}

  void institutionalNewsOnComplete() {}
  void institutionalNewsOnData(List<InstitutionalMessage> data) {
    institutionalPosts = data;
    refreshUI();
  }

  void institutionalNewsOnError(dynamic error) {}

  void fetchPostsOnComplete() {}
  void fetchPostsOnData(List<Post> data) {
    feedPosts = data;
    refreshUI();
  }

  void fetchPostsOnError(dynamic error) {}

  void sendPostOnComplete() {}
  void sendPostOnError(dynamic error) {}

  void listenNewPostsOnComplete() {}
  void listenNewPostsOnData(Post post) {}
  void listenNewPostsOnError(dynamic error) {}

  @override
  void onDisposed() {
    _presenter.dispose();

    super.onDisposed();
  }
}
