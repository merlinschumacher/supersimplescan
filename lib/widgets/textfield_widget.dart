import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FileNameInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const FileNameInputTextField({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.enterFileNamePrompt,
        suffixText: '.pdf',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.fileNameIsRequired;
        }
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(245),
      ],
    );
  }
}
