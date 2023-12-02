import 'package:NeedZIndia/Screen/ProductList.dart';
import 'package:NeedZIndia/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class SearchBar extends StatefulWidget {
  final List searchQuery;
  SearchBar({Key key, this.searchQuery}) : super(key: key);
  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  TextEditingController _textController = TextEditingController();
  List<String> searchData = [];
  @override
  void initState(){
    print(widget.searchQuery);
    super.initState();
  }

  _onChanged(String value) {
    if(mounted){
      setState(() {
        searchData =widget.searchQuery
            .where((string) => string.toLowerCase().contains(value.toLowerCase()))
            .toList();
        print(searchData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: new TextField(
            controller: _textController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search here.',
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.blueGrey),
            ),
            style: const TextStyle(color: Colors.blueGrey, fontSize: 16.0),
            onChanged: _onChanged,
            textInputAction: TextInputAction.search,
            onSubmitted: (data) {
             if(data.isEmpty==false){
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductList(search:data)));
             }
            },
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon:Icon(Icons.search,color: Colors.black,),
              onPressed: () {
                if(_textController.text.isEmpty == false){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductList(search:_textController.text)));
                }
              },
            ),
          ],
        ),
      body: Column(
        children: <Widget>[
          searchData != null && searchData.length != 0
              ? Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: searchData.map((data) {
                return ListTile(
                  tileColor: Colors.white,
                    title: Text(data),
                onTap: (){
                     if(mounted){
                       setState(() {
                         _textController.text = data;
                       });
                     }
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductList(search:data)));
                },
                );
              }).toList(),
            ),
          )
              : SizedBox(),
        ],
      )
    );
  }
}
