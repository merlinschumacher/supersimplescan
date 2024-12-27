import 'package:package_info_plus/package_info_plus.dart';

class InfopageView extends StatelessWidget {
const InfopageView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return Scaffold(
      appBar: AppbarWidget(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.infoPageText,
            ),
            Text(
              "Version: " + version
            ),
          ],
      )
    )

  }
}