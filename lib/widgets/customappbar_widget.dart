import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomAppBarState extends State<CustomAppBar> {
  String infoText = "";
  String versionNumber = "";
  Image? appIcon;
  Expanded? aboutAppDescription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadInfoText().then((text) => {
            infoText = text,
          });
      loadVersionNumberText().then((text) => {
            versionNumber = text,
          });
    });
  }

  Future<String> loadInfoText() async {
    return await DefaultAssetBundle.of(context).loadString(
      "assets/docs/${AppLocalizations.of(context)!.infoPageTextFile}",
    );
  }

  Future<String> loadVersionNumberText() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.help_outline),
          onPressed: () {
            showAboutDialog(
                context: context,
                applicationName: AppLocalizations.of(context)!.appName,
                applicationLegalese: AppLocalizations.of(context)!
                    .aboutDialogLegalese(DateTime.now()),
                applicationVersion: versionNumber,
                applicationIcon: Image(
                    image: AssetImage("assets/icons/app_icon.png"),
                    height: IconTheme.of(context).size! * 2),
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Markdown(
                      data: infoText,
                      onTapLink: (String text, String? href, String title) =>
                          {if (href != null) launchUrl(Uri.parse(href))},
                    ),
                  ),
                ]);
          },
        ),
      ],
    );
  }
}
