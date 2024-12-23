import 'package:flutter/material.dart';
import 'package:super_simple_scan/widgets/sharebutton_widget.dart';
import 'package:super_simple_scan/widgets/textfield_widget.dart';

class FileNameFormWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController fileNameFieldController;
  final void Function() onSubmitted;
  final String defaultFileName;

  FileNameFormWidget(
      {super.key,
      required GlobalKey<FormState> formKey,
      required this.fileNameFieldController,
      required this.onSubmitted,
      required this.defaultFileName})
      : _formKey = formKey {
    fileNameFieldController.text = defaultFileName;
    fileNameFieldController.selection = TextSelection(
        baseOffset: 0, extentOffset: fileNameFieldController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            FileNameInputTextField(controller: fileNameFieldController),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ShareButton(
                  onPressed: onSubmitted,
                ))
          ],
        ));
  }
}
