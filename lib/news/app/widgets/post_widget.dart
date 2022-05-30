import 'package:cached_network_image/cached_network_image.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(this._post, {Key? key}) : super(key: key);

  final Post _post;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _post.content,
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                height: 32,
                width: 32,
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: _post.user.picture,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                _post.user.name,
              ),
            ],
          )
        ],
      );
}
