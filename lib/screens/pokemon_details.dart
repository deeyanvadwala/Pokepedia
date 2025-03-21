
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokeDetails extends StatefulWidget {
  final tag;
  final pokedetails;
  final Color color;
  const PokeDetails({super.key,required this.tag,required this.pokedetails, required this.color});

  @override
  State<PokeDetails> createState() => _PokeDetailsState();
}

class _PokeDetailsState extends State<PokeDetails> {
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: widget.color,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: height * 0.18,
            right: -30,
            child: Image.asset('assets/images/pokeball.png', width: 200, fit: BoxFit.fitHeight),
          ),
          Positioned(
            top: 20,
            left: 0,
            child: IconButton(
              onPressed: (){
                  Navigator.pop(context);
              }, 
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,))),
          Positioned(
            top: 60,
              left: 30,
            child: Text(widget.pokedetails['name'],
            style: TextStyle(
              color:Colors.white,
              fontSize:  30, 
              fontWeight: FontWeight.bold),)
              ),
              Positioned(
                                  top: 105,
                                  left: 30,
                                  child: Container(
                                  height:26,
                                    width:65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white30
                                  ),
                                  child: Center(
                                    child: Text(widget.pokedetails['type'][0],
                                    style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  ),
                                )),
               Positioned
                    (
                      top: 120,
                      left: (width/2) -100 ,
                      child: CachedNetworkImage(
                             imageUrl: widget.pokedetails['img'],
                            height: 200,
                             fit: BoxFit.fill,)
                     ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  height: height*0.6,
                  
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                         
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                child: Text('Name',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),),
                              ),
                              Container(
                                child: Text(widget.pokedetails['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                child: Text('Height',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),),
                              ),
                              Container(
                                child: Text(widget.pokedetails['height'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                child: Text('Weight',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),),
                              ),
                              Container(
                                child: Text(widget.pokedetails['weight'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                child: Text('Spawn Time',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),),
                              ),
                              Container(
                                child: Text(widget.pokedetails['spawn_time'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                child: Text('Weakness',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),),
                              ),
                              Container(
                                child: Text(widget.pokedetails['weaknesses'].join(', '),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.3,
                                child: Text('Evolution',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 20,
                                ),),
                              ),
                              widget.pokedetails['next_evolution'] != null
                              ?
                              SizedBox(
                                height: 30,
                                width: width*0.5,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: widget.pokedetails['next_evolution'].length,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        widget.pokedetails['next_evolution'][index]['name'],
                                        style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.bold
                                                                      ),),
                                    );
                                  },),
                              )
                              :Text('Maxed Out',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),)
                            ]
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ))
      
        ],
      ),
    );
  }
}