import 'package:flutter/material.dart';

import '../model/post.dart';
import '../service/http.dart';
class add extends StatefulWidget {
  const add({Key? key}) : super(key: key);


  @override
  State<add> createState() => _addState();
}



class _addState extends State<add> {


Post data= Post();
  TextEditingController title1 = TextEditingController();
  TextEditingController title2 = TextEditingController();
  bool isLoading = false;




  void _apipostlist(){
    Network.GET(Network.API_LIST, Network.paramsEmpty()).then((response) => {
      print(response),
      _showResponse(response!),

    });
  }

  void _apiPostCreate(Post post){

    Network.POST(Network.API_CREATE, Network.paramsCreate(post)).then((response) => {
      print(response),
      _showResponse(response!),
    });
  }

  void _showResponse(String response){
    setState(() {
      data = response as Post;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apipostlist();

  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
               child: TextField(
                 controller: title1,
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
                         borderSide: BorderSide(color: Colors.grey),

                       ),
                       hintText: ("Insert title"),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
                         borderSide: BorderSide(color: Colors.blue),
                       )
                   )
                )
             ),
            SizedBox(height: 20,),
            Container(
              //height: 80,
                padding: EdgeInsets.only(left: 10,right: 10),
                child: TextField(
                  maxLines: 5,

                  controller: title2,

                    decoration: InputDecoration(

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: ("Insert body"),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        )
                    )
                )
            ),
            SizedBox(height: 20,),


          ],
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){_apiPostCreate(Post(title: title1.text,body: title2.text));},
        child: Icon(Icons.add),
      ),
    );
  }
}
