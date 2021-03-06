import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_login/cart/dishproduct.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

FirebaseUser user3;
List numberOfItems = List<int>();

class AllProducts extends StatefulWidget {
  FirebaseUser user;
  AllProducts({this.user});

  @override
  _AllProductsState createState() => _AllProductsState(user1: user);
}

class _AllProductsState extends State<AllProducts> {
  FirebaseUser user1;
  _AllProductsState({this.user1});

  @override
  void initState() {
    user3 = user1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(50.0),
            child: new Text("shop"),
          ),

          //grid view
          Flexible(
            child: MessageStream(
              user4: user1,
            ),
          )
        ],
      ),
    );
  }
}

class MessageStream extends StatefulWidget {
  FirebaseUser user4;
  MessageStream({this.user4});
  @override
  _MessageStreamState createState() => _MessageStreamState(user5: user4);
}

class _MessageStreamState extends State<MessageStream> {
  FirebaseUser user5;
  _MessageStreamState({this.user5});
  // Stream<QuerySnapshot> check() {
  //   if (selectedChoice == "Awesome") {
  //     Stream s = Firestore.instance
  //         .collection("messages")
  //         .where('Review', isEqualTo: "Awesome")
  //         .snapshots();
  //   }
  //   if (selectedChoice == "PhonePay") {
  //     return Firestore.instance
  //         .collection("messages")
  //         .where('Review', isEqualTo: "Awesome")
  //         .snapshots();
  //   }
  //   return Firestore.instance
  //       .collection("messages")
  //       .where('UpiMode', isEqualTo: "PhonePay")
  //       .snapshots();
  //   setState(() {
  //     // selectedChoice = item;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed;
        List<Single_prod> messageWidgets = [];
        int i = 0;
        for (var message in messages) {
          final proName = message.data['prodName'];

          final proPrice = message.data['prodPrice'];
          // final proOldPrice = message.data['quantity'];
          final proImage1 = message.data['prodImage'];
          // final proImage2 = message.data['image2'];
          // final proImage3 = message.data['image3'];
          // // final proSizes = List.from(message.data['sizes']);
          // final proBrand = message.data['brand'];
          // final prodCategory = message.data['category'];
          // final prodVideo = message.data['youtubeVideoUrl'];
          // final prodId = message.data['id'];

          final messageWidget = Single_prod(
            ind: i,
            user6: user5,
            prod_name: proName,
            prod_pricture1: i == 0
                ? "assets/prod1.jpg"
                : i == 1
                    ? "assets/prod2.jpg"
                    : "assets/prod3.jpg",
            // prod_pricture2: proImage2,
            // prod_pricture3: proImage3,
            // prod_old_price: proOldPrice,
            prod_price: proPrice,
            // prod_sizes: proSizes,
            // prod_brand: proBrand,
            // prod_category: prodCategory,
            // prod_video: prodVideo,
            // prod_id: prodId,
          );
          i = i + 1;
          messageWidgets.add(messageWidget);
          numberOfItems.add(1);
        }
        return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (200 / 300),
            crossAxisCount: 2,
            children: messageWidgets);
      },
    );
  }
}

class Single_prod extends StatefulWidget {
  FirebaseUser user6;
  int ind;
  final prod_name;
  final prod_pricture1;
  final prod_pricture2;
  final prod_pricture3;
  final prod_old_price;
  final prod_price;
  final prod_brand;
  // final prod_sizes;
  final prod_category;
  final prod_video;
  final prod_id;

  Single_prod(
      {this.ind,
      this.user6,
      this.prod_name,
      this.prod_pricture1,
      this.prod_pricture2,
      this.prod_pricture3,
      this.prod_old_price,
      this.prod_price,
      // this.prod_sizes,
      this.prod_brand,
      this.prod_category,
      this.prod_video,
      this.prod_id});
  @override
  _Single_prodState createState() => _Single_prodState(
      ind1: ind,
      prod_brand: prod_brand,
      prod_category: prod_category,
      prod_id: prod_id,
      prod_name: prod_name,
      prod_old_price: prod_old_price,
      prod_price: prod_price,
      prod_pricture1: prod_pricture1,
      prod_pricture2: prod_pricture2,
      prod_pricture3: prod_pricture3,
      prod_video: prod_video,
      user6: user6);
}

class _Single_prodState extends State<Single_prod> {
  FirebaseUser user6;
  int ind1;
  final prod_name;
  final prod_pricture1;
  final prod_pricture2;
  final prod_pricture3;
  final prod_old_price;
  final prod_price;
  final prod_brand;
  // final prod_sizes;
  final prod_category;
  final prod_video;
  final prod_id;

  _Single_prodState(
      {this.user6,
      this.ind1,
      this.prod_name,
      this.prod_pricture1,
      this.prod_pricture2,
      this.prod_pricture3,
      this.prod_old_price,
      this.prod_price,
      // this.prod_sizes,
      this.prod_brand,
      this.prod_category,
      this.prod_video,
      this.prod_id});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.yellow[800], width: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
      elevation: 3,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context, //here we are passing the values of  product to proddta
          //   MaterialPageRoute(builder: (context) => DishPage()),
          // );
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow[800], width: 0.9),
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(prod_pricture1),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Flexible(
                child: Text(
                  prod_name,
                  style: TextStyle(fontSize: 11.1),
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Row(
                              children: [
                                Text(
                                  'Rs.${prod_price} ',
                                  style: TextStyle(
                                      color: Colors.green[700], fontSize: 14),
                                ),
                                // Text(
                                //   "\Rs.$prod_old_price",
                                //   style: TextStyle(
                                //       fontSize: 12,
                                //       color: Colors.black,
                                //       fontWeight: FontWeight.w400,
                                //       decoration: TextDecoration.lineThrough),
                                // ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                starIcon(Colors.yellow[700]),
                                starIcon(Colors.yellow[700]),
                                starIcon(Colors.yellow[700]),
                                starIcon(Colors.yellow[700]),
                                starIcon(Colors.grey[200]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // FlutterYoutube.playYoutubeVideoByUrl(
                              //   apiKey: "AIzaSyD31tcLT3yupwANBz7Wa7K6jRRHZTHI",
                              //   videoUrl: prod_video,
                              // );

                              // Navigator.push(
                              //   context, //here we are passing the values of  product to proddta
                              //   MaterialPageRoute(
                              //       builder: (context) => ProductVideo(
                              //             product_details_video: prod_video,
                              //           )),
                              // );
                            },
                            child: Flexible(
                              child: Container(
                                height: 26.0,
                                width: 26.0,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Material(
                                  color: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      size: 19,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                              child: Text(
                            "watch video",
                            style: TextStyle(
                                fontSize: 7, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _decrementButton(ind1),
                        Text(
                          '${numberOfItems[ind1]}',
                          style: TextStyle(fontSize: 10.0),
                        ),
                        _incrementButton(ind1),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    width: 70.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: Colors.yellow[800],
                      borderRadius: BorderRadius.circular(12.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.yellow[800],
                      //     offset: Offset(0.0, 10.0),
                      //     spreadRadius: -5.0,
                      //     blurRadius: 5.0,
                      //   ),
                      // ],
                    ),
                    child: Material(
                      color: Colors.yellow[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          // print(user3.uid);
                          // print("=================");
                          //  Firestore.instance
                          //   .collection('users')
                          //   .document(user6.uid)
                          //   .update(
                          //     {
                          //     "cartUser.quant" : "h3"  ,
                          //     }
                          //   );

                          Firestore.instance
                              .collection('users')
                              .document(user6.uid)
                              .updateData({
                            "cartUser": FieldValue.arrayUnion([
                              {"name": prod_name, "quant": numberOfItems[ind1].toString()}
                            ])
                          });
                          // Navigator.push(
                          //   context, //here we are passing the values of  product to proddta
                          //   MaterialPageRoute(
                          //       builder: (context) => ProductDetails(
                          //             product_details_name: prod_name,
                          //             product_details_new_price: prod_price,
                          //             product_details_old_price: prod_old_price,
                          //             product_details_picture1: prod_pricture1,
                          //             product_details_picture2: prod_pricture2,
                          //             product_details_picture3: prod_pricture3,
                          //             // product_details_sizes: prod_sizes,
                          //             prod_details_brand: prod_brand,
                          //             prod_details_category: prod_category,
                          //             prod_details_video: prod_video,
                          //             prod_details_id: prod_id,
                          //           )),
                          // );
                        },
                        child: Center(
                          child: Text(
                            'Add to Cart',
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _incrementButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          numberOfItems[index]++;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          radius: 19,
          backgroundColor: Colors.grey[400],
          foregroundColor: Colors.green,
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 14,
          ),
        ),
      ),
    );
  }

  Widget _decrementButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          numberOfItems[index]--;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(1),
        child: CircleAvatar(
          
          radius: 19,
          backgroundColor: Colors.grey[400],
          foregroundColor: Colors.green,
          child: Icon(
            Icons.remove,
            color: Colors.black,
            size: 14,
          ),
        ),
      ),
    );
  }

  Icon starIcon(Color color) {
    return Icon(
      Icons.star,
      size: 10.0,
      color: color,
    );
  }
}
