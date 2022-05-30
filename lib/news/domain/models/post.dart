import 'package:conecta_gb/access/domain/entities/user.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';

class Post extends InstitutionalMessage {
  factory Post.fromMap(Map data) {
    return InstitutionalMessage.fromMap(data) as Post;
  }

  bool isUserMessage(User compareUser) {
    return compareUser.email == user.email;
  }
}
