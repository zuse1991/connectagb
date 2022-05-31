import 'package:cached_network_image/cached_network_image.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(this._post, {Key? key}) : super(key: key);

  final Post _post;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _post.content,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      height: 32,
                      width: 32,
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        cacheKey: _post.user.picture,
                        fit: BoxFit.cover,
                        imageUrl: _post.user.picture,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _post.user.name,
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${DateFormat.yMd('pt_BR').format(_post.createdAt)} ${DateFormat.Hm('pt_BR').format(_post.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
