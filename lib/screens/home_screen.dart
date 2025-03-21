import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokepedia/screens/pokemon_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokepediaAPI = "https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json";
  List pokepedia = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Image.asset('assets/images/pokeball.png', width: 220, fit: BoxFit.fitHeight),
          ),
          Positioned(
            top: 100,
            left: 15,
            child: Text(
              "Pokedex",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 200,
            bottom: 0,
            width: width,
            child: pokepedia.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: pokepedia.length,
                      itemBuilder: (context, index) {
                        var type = pokepedia[index]['type'][0];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>PokeDetails(
                                tag: index, 
                                pokedetails: pokepedia[index], 
                                color:type == 'Grass' ? Colors.greenAccent:
                                       type == 'Fire' ? Colors.redAccent:
                                       type == 'Water' ? Colors.blueAccent:
                                       type == 'Electric' ? Colors.yellowAccent:
                                       type == 'Rock' ? Colors.grey:
                                       type == 'Ground' ? Colors.brown:
                                       type == 'Psychic' ? Colors.indigo:
                                       type == 'Fighting' ? Colors.orange:
                                       type == 'Bug' ? Colors.lightGreen:
                                       type == 'Ghost' ? Colors.deepPurple:
                                       type == 'Normal' ? Colors.black26:
                                       type == 'Poison' ? Colors.deepPurpleAccent:Colors.pink,)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: type == 'Grass' ? Colors.greenAccent:
                                       type == 'Fire' ? Colors.redAccent:
                                       type == 'Water' ? Colors.blueAccent:
                                       type == 'Electric' ? Colors.yellowAccent:
                                       type == 'Rock' ? Colors.grey:
                                       type == 'Ground' ? Colors.brown:
                                       type == 'Psychic' ? Colors.indigo:
                                       type == 'Fighting' ? Colors.orange:
                                       type == 'Bug' ? Colors.lightGreen:
                                       type == 'Ghost' ? Colors.deepPurple:
                                       type == 'Normal' ? Colors.black26:
                                       type == 'Poison' ? Colors.deepPurpleAccent:Colors.pink,
                            
                              ),
                              child: Stack(
                                children:[ Positioned(
                                            bottom: -10,
                                            right: -10,
                                            child: Image.asset('assets/images/pokeball.png', width: 100, fit: BoxFit.fitHeight),
                                          ),
                                Positioned(
                                  top: 10,
                                  left: 10,
                                      child: Text(
                                        pokepedia[index]["name"],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        fontWeight: FontWeight.bold),)
                                    ),
                                Positioned(
                                  top: 35,
                                  left: 6,
                                  child: Container(
                                  height:26,
                                    width:65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white30
                                  ),
                                  child: Center(
                                    child: Text(type.toString(),style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  ),
                                )),
                                Positioned
                                (
                                  bottom: 0,
                                  right: 0,
                                  child: CachedNetworkImage(
                                    imageUrl: pokepedia[index]['img'],
                                    height: 100,
                                    fit: BoxFit.fill,)
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: CircularProgressIndicator()), // Show loader when fetching data
          ),
        ],
      ),
    );
  }

  void fetchData() async {
    var url = Uri.parse(pokepediaAPI);

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodeData = jsonDecode(response.body);
        setState(() {
          pokepedia = decodeData["pokemon"]; // Ensure correct key is used
        });
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
