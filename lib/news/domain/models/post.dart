import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/news/domain/models/short_user.dart';

class Post {
  Post._();

  factory Post.fromMap(Map data) => Post._()
    ..id = data['id']
    ..user = ShortUser.fromMap(data['user'])
    ..content = data['message']['content']
    ..createdAt = DateTime.parse(data['message']['created_at']).toLocal();

  late int id;
  late String content;
  late DateTime createdAt;
  late ShortUser user;

  bool isUserPostAuthor(User user) => user.email == this.user.email;
}
