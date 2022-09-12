import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class PreEditableTextField extends StatelessWidget {
  final String title;
  final String content;
  final bool grayed;
  final void Function()? onEdit;

  const PreEditableTextField({
    Key? key,
    this.onEdit,
    required this.title,
    required this.content,
    this.grayed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: theme.textTheme.bodyText2?.copyWith(
                color: grayed ? Colors.grey : null,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: onEdit,
              child: Text(
                S.of(context).edit,
                style: theme.textTheme.bodyText2?.copyWith(
                  decoration: TextDecoration.underline,
                  color: grayed ? Colors.grey : null,
                ),
              ),
            ),
          ],
        ),
        Text(
          content,
          style: theme.textTheme.caption?.copyWith(
            color: grayed ? Colors.grey : null,
          ),
        ),
      ],
    );
  }
}

class PostEditablePlainTextField extends StatefulWidget {
  final String title;
  final String desc;
  final String fieldTitle;
  final void Function()? onCancel;

  const PostEditablePlainTextField({
    Key? key,
    required this.title,
    required this.desc,
    required this.fieldTitle,
    this.onCancel,
  }) : super(key: key);

  @override
  State<PostEditablePlainTextField> createState() =>
      _PostEditablePlainTextFieldState();
}

class _PostEditablePlainTextFieldState
    extends State<PostEditablePlainTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: theme.textTheme.bodyText2,
            ),
            const Spacer(),
            TextButton(
              onPressed: widget.onCancel,
              child: Text(
                S.of(context).cancel,
                style: theme.textTheme.bodyText2?.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.fieldTitle,
                  style: theme.textTheme.caption,
                ),
                TextFormField(
                  style: theme.textTheme.bodyText2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
