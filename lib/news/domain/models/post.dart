import 'package:conecta_gb/news/domain/models/short_user.dart';

class Post {
  Post._();

  factory Post.fromMap(Map data) => Post._()
    ..user = ShortUser.fromMap(data['user'])
    ..content = data['message']['content']
    ..createdAt = DateTime.parse(data['message']['created_at']).toLocal();

  late String content;
  late DateTime createdAt;
  late ShortUser user;
}
