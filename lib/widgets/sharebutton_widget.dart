import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShareButton extends StatelessWidget {
  final void Function() onPressed;

  const ShareButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        padding: EdgeInsets.symmetric(horizontal: 34, vertical: 16),
      ),
      onPressed: onPressed,
      label: Text(AppLocalizations.of(context)!.shareButton),
      icon: Icon(Icons.share, size: 16),
    );
  }
}
