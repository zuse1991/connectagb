import 'package:cached_network_image/cached_network_image.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstitutionalNewsWidget extends StatelessWidget {
  const InstitutionalNewsWidget(this._message, {Key? key}) : super(key: key);

  final InstitutionalMessage _message;

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
                  _message.content,
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
                        cacheKey: _message.user.picture,
                        fit: BoxFit.cover,
                        imageUrl: _message.user.picture,
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
                      _message.user.name,
                    ),
                    Expanded(child: Container()),
                    Text(
                      '${DateFormat.yMd('pt_BR').format(_message.createdAt)} ${DateFormat.Hm('pt_BR').format(_message.createdAt)}',
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
