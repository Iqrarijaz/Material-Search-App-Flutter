import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search App"),
        centerTitle: true,
        actions:<Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            }, icon: Icon(Icons.search)),
          )
        ],
      ),
      drawer: Drawer(),
    );
  }
}
class DataSearch extends SearchDelegate<String>
{
  final fruits=["apples",
"oranges",
"carrots",
"mango"
 "brocoli",
 "chillipowder",
 "onions"];
  final recentSearchList=["oranges",
    "carrots",];
  @override
  List<Widget>? buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton( icon: const Icon(Icons.clear),
        onPressed: (){
          query="";
        },)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   //leading icons
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress:transitionAnimation ),
        onPressed: (){
          close(context,"");});
  }


  @override
  Widget buildResults(BuildContext context) {
    // show result
    return Center(child: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Text(query,style: TextStyle(
        fontSize: 28
      ),),
    )) ;
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    //query is the word user is typing
    final suggestionList=query.isEmpty?recentSearchList:fruits.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context,index)=>ListTile(
        onTap: (){
          showResults(context);
        },
      leading: const Icon(Icons.location_city),
      title: RichText(text: TextSpan(text: suggestionList[index].substring(0,query.length),
      style: const TextStyle(color:Colors.black,
      fontWeight: FontWeight.bold),children:[TextSpan(text:suggestionList[index].substring(query.length),
              style: const TextStyle(color:Colors.grey,
                  ))] )),),
    itemCount: suggestionList.length,);
  }

}