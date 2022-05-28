import 'package:conecta_gb/access/domain/entities/user.dart';

class Post {
  Post(this.user, this.message);

  final User user;
  final String message;
}
