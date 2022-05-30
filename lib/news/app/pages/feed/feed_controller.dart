import 'package:conecta_gb/news/app/pages/feed/feed_presenter.dart';
import 'package:conecta_gb/news/data/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class FeedViewController extends Controller {
  FeedViewController() : _presenter = FeedViewPresenter(PostsRepository());

  final FeedViewPresenter _presenter;

  @override
  void initListeners() {}

  @override
  void onDisposed() {
    _presenter.dispose();

    super.onDisposed();
  }
}
