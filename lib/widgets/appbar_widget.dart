class AppbarWidget extends StatelessWidget {
const AppbarWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
      return AppBar(
        title: Text(AppLocalizations.of(context)!.scanResultTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfopageView()),
              );
            },
          ),
        ],
      ),
  }
}