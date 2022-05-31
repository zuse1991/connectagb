import 'package:flutter/material.dart';

class NewPostFieldWidget extends StatelessWidget {
  NewPostFieldWidget({
    Key? key,
    required this.onSend,
    required this.onCancel,
    String? initialValue,
  })  : _textController = TextEditingController(text: initialValue),
        super(key: key);

  final Function(String message) onSend;
  final Function() onCancel;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            maxLines: null,
            maxLength: 280,
            keyboardType: TextInputType.text,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                onPressed: onCancel,
              ),
              TextButton(
                onPressed: () => onSend(_textController.text),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.blue)),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
