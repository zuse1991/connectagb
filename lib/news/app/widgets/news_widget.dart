import 'package:cached_network_image/cached_network_image.dart';
import 'package:conecta_gb/news/domain/models/institutional_message.dart';
import 'package:flutter/material.dart';

class InstitutionalNewsWidget extends StatelessWidget {
  const InstitutionalNewsWidget(this._message, {Key? key}) : super(key: key);

  final InstitutionalMessage _message;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _message.content,
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                height: 32,
                width: 32,
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: _message.user.picture,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Text(
                _message.user.name,
              ),
            ],
          )
        ],
      );
}
