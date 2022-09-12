// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ming/common/ui/editable_textfield.dart';

class UiSamplePage extends StatelessWidget {
  const UiSamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // PreEditable Text default
        Text("PreEditableTextField"),
        PreEditableTextField(
          title: "닉네임",
          content: "컨텐츠",
          onEdit: () {},
        ),
        Divider(),
        // PreEditable Text grayed
        Text("PreEditableTextField, grayed: true"),
        PreEditableTextField(
          title: "닉네임",
          content: "컨텐츠",
          grayed: true,
          onEdit: () {},
        ),
        Divider(),
        // PostEditablePlainTextField
        Text("PostEditableTestField"),
        PostEditablePlainTextField(
          title: "닉네임",
          desc: "불리고 싶은 이름을 입력해주세요.",
          fieldTitle: "닉네임",
        ),
        Divider(),
      ],
    );
  }
}
