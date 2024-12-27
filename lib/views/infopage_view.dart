import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:super_simple_scan/widgets/appbar_widget.dart';

// class InfopageView extends StatefulWidget {
//   InfopageView({super.key});

//   @override
//   InfopageViewState createState() => InfopageViewState();
// }

// class InfopageViewState extends State<InfopageView> {
class InfopageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String version = "";
    PackageInfo.fromPlatform().then((value) => {version = value.version});

    Future<String> loadInfoText() async {
      return await DefaultAssetBundle.of(context).loadString(
        "assets/docs/${AppLocalizations.of(context)!.infoPageTextFile}",
      );
    }

    return Scaffold(
        appBar: CustomAppBar(title: AppLocalizations.of(context)!.appName),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                    child: FutureBuilder<String>(
                  future: loadInfoText(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Markdown(data: snapshot.data ?? '');
                    }
                  },
                )),
                Text("Version: $version"),
              ],
            )));
  }
}
