import 'package:cached_network_image/cached_network_image.dart';
import 'package:conecta_gb/news/domain/models/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  PostWidget(this._post,
      {Key? key, this.enableUserActions = false, this.onDelete, this.onEdit})
      : super(key: key) {
    assert(
      !enableUserActions || (onDelete != null && onEdit != null),
      'Need set onDelete and onEdit callback if enableUserActions is true',
    );
  }

  final Post _post;
  final bool enableUserActions;

  final Function(Post)? onEdit;
  final Function(Post)? onDelete;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            color: Colors.white,
            child: Column(
              children: [
                Container(
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
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
                      ),
                    ],
                  ),
                ),
                if (enableUserActions)
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 20,
                          color: Colors.red,
                          onPressed: () => onDelete?.call(_post),
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                        IconButton(
                          iconSize: 20,
                          color: Theme.of(context).primaryColor,
                          onPressed: () => onEdit?.call(_post),
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            )),
      );
}
