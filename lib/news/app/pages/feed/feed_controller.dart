import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
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
  Post? editingPost;

  bool newPostFieldIsDisplayed = false;

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

    _presenter.updatePostOnComplete = updatePostOnComplete;
    _presenter.updatePostOnError = updatePostOnError;

    _presenter.deletePostOnComplete = deletePostOnComplete;
    _presenter.deletePostOnError = deletePostOnError;

    _presenter.fetchInstitutionalNews();
    _presenter.fetchPosts();
    _presenter.listenNewPosts();
  }

  User get user => ModalRoute.of(getContext())!.settings.arguments as User;

  void changeNewPostFieldVisibility() {
    newPostFieldIsDisplayed = !newPostFieldIsDisplayed;

    if (!newPostFieldIsDisplayed) {
      editingPost = null;
    }

    refreshUI();
  }

  void createNewPost(String message) {
    if (message.isEmpty) {
      changeNewPostFieldVisibility();
      return;
    }

    if (editingPost == null) {
      _presenter.sendPost(user, message);
    } else {
      _presenter.updatePost(editingPost!, message);
    }
    changeNewPostFieldVisibility();
  }

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

  void refreshPosts() {
    _presenter.fetchPosts();
  }

  void refreshInstitutionalNews() {
    _presenter.fetchInstitutionalNews();
  }

  void fetchPostsOnError(dynamic error) {}

  void sendPostOnComplete() {}

  void sendPostOnError(dynamic error) {}

  void listenNewPostsOnComplete() {}
  void listenNewPostsOnData(Post post) {
    feedPosts!.insert(0, post);
    refreshUI();
  }

  void listenNewPostsOnError(dynamic error) {}

  void deletePostOnError(dynamic e) {}
  void deletePostOnComplete() {
    refreshPosts();
  }

  void updatePostOnError(dynamic e) {}
  void updatePostOnComplete() {
    refreshPosts();
  }

  void onDeletePost(Post post) {
    _presenter.deletePost(post);
  }

  void onEditPost(Post post) {
    editingPost = post;
    changeNewPostFieldVisibility();
  }

  @override
  void onDisposed() {
    _presenter.dispose();

    super.onDisposed();
  }
}
