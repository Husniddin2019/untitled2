import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:untitled2/pages/add_new.dart';

import 'package:untitled2/service/http.dart';

import '../model/post.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<Post> items =[];
  bool isLoading=false;
  void _apiPost() async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    setState(() {
      if (response != null) {
        items = Network.parsePost(response);
      } else {
        items = [];
      }
      isLoading = false;
    });
  }

  void _apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    setState(() {
      if (response != null) {
        _apiPost();
      }
      isLoading = false;
    });
  }

  _updete(){}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pdp"),
      ),
      body: Stack(

        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx,index){

            return itemofPost(items[index]);
          },
          ),
          isLoading ? Center(child: CircularProgressIndicator(),):SizedBox.shrink(),

        ],
      ),
      floatingActionButton:  FloatingActionButton
        (onPressed: (){ Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const add()),
      );},child: Icon(Icons.add), ),
    );
  }
  Widget itemofPost(Post post){
    return Slidable(


          child: Container(
             padding: EdgeInsets.only(left: 20,right: 20,top: 20),
           child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title!.toUpperCase(),
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5,),
          Text(post.body!)
        ],
      ),
    ), startActionPane: ActionPane(
      // A motion is a widget used to control how the pane animates.
      motion:  ScrollMotion(),


      children:  [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: _updete(),
          backgroundColor: Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),

      ],
    ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane:  ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context){_apiPostDelete(post);},
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),



    );


  }
}
