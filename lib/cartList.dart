import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_user_login/allproducts.dart';
import 'package:firebase_user_login/country.dart';
import 'package:flutter/material.dart';
import 'package:firebase_user_login/fintness_app_theme.dart';
import 'package:firebase_user_login/meal_list_data.dart';

import 'package:firebase_user_login/theme/extention.dart';
import 'package:firebase_user_login/theme/light_color.dart';
import 'package:firebase_user_login/theme/text_styles.dart';
import 'package:firebase_user_login/theme/theme.dart';
import 'package:firebase_user_login/models/doctor_model.dart';
import 'package:firebase_user_login/models/data.dart';
import 'package:firebase_user_login/detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_login/newFurn.dart';

dynamic cartUserArrayList;

class CartList extends StatefulWidget {
  FirebaseUser fireUser;

  CartList({this.fireUser});

  @override
  _CartListState createState() => _CartListState(fireUser1: fireUser);
}

class _CartListState extends State<CartList> {
  FirebaseUser fireUser1;

  _CartListState({this.fireUser1});

  //final MealsListData mealsListData=new MealsListData();
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  final List<Widget> screens = [
    CartList(),
    CartList(),
    CartList(),
    // HomePage(),
    // HomePage()
  ];
  Widget currentScreen = CartList();

  List<DoctorModel> doctorDataList;
  @override
  void initState() {
    doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Container(
          height: 40,
          width: 40,
          child: Image.asset(
            "assets/yonsilogo.png",
          )),
      leading: Icon(
        Icons.short_text,
        size: 30,
        color: Colors.yellow[800],
      ),
      actions: <Widget>[
        Icon(
          Icons.notifications_none,
          size: 30,
          color: Colors.yellow[800],
        ),
        // ClipRRect(
        //   borderRadius: BorderRadius.all(Radius.circular(13)),
        //   child: Container(
        //     // height: 40,
        //     // width: 40,
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).backgroundColor,
        //     ),
        //     child: Image.asset("assets/user.png", fit: BoxFit.fill),
        //   ),
        // ).p(8),
        Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 6, 0),
          child: Icon(
            Icons.shopping_cart,
            size: 25,
            color: Colors.yellow[800],
          ),
        ),
      ],
    );
  }

  int currentTab = 0;

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text("Peter Parker", style: TextStyles.h1Style),
      ],
    ).p16;
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        border: Border.all(
          width: 1,
          color: Colors.yellow[800],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xfffec321).withOpacity(.2),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Find Your Product",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(
                Icons.search,
                color: Color(0xfffec321),
              )
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  Widget _doctorsList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Top Products", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Colors.yellow[800],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllProducts(
                                user: fireUser1,
                                //fireUser: user1,
                              )),
                    );
                  })
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          getdoctorWidgetList()
        ],
      ),
    );
  }

  Widget getdoctorWidgetList() {
    return Column(
        children: doctorDataList.map((x) {
      return _doctorTile(x);
    }).toList());
  }

  Widget _doctorTile(DoctorModel model) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.asset(
                "assets/card2.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text("milk", style: TextStyles.title.bold),
          subtitle: Text(
            "milk Products",
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Colors.yellow[800],
          ),
        ),
      ).ripple(() {
        // Navigator.pushNamed(context, "/DetailPage", arguments: model);
        //        Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>DetailPage(model: model))
        // );
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Your Cart", style: TextStyles.title.bold),
              IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Colors.yellow[800],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllProducts(
                                user: fireUser1,
                                //fireUser: user1,
                              )),
                    );
                  })
              // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
            ],
          ).hP16,
          MessageStream(
            user: fireUser1,
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        buttonBackgroundColor: Colors.yellow[800],
        color: Colors.yellow[200],
        backgroundColor: Colors.white,
        index: currentTab,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.grey[700],
          ),
          Icon(
            Icons.grid_on,
            size: 30,
            color: Colors.grey[700],
          ),
          Icon(Icons.menu, color: Colors.grey[700], size: 30),
          // Icon(Icons.done_outline, color: Colors.white,size: 30),
          // Icon(Icons.ac_unit_outlined,color: Colors.white, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            currentTab = index;
            currentScreen = screens[index];
          });
        },
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class MessageStream extends StatefulWidget {
  FirebaseUser user;
  MessageStream({this.user});
  @override
  _MessageStreamState createState() => _MessageStreamState(user: user);
}

class _MessageStreamState extends State<MessageStream> {
  FirebaseUser user;
  _MessageStreamState({this.user});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection("users").document(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        var userDocument = snapshot.data;
        dynamic arrayOfMapsOfcartProduserDocument = userDocument["cartUser"];
        // return new Text(userDocument["name"]);
        cartUserArrayList = arrayOfMapsOfcartProduserDocument;
        print(arrayOfMapsOfcartProduserDocument);
        //final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageWidgets = [];
        int i = 0;
        for (var message in arrayOfMapsOfcartProduserDocument) {
          final name = message['name'];
          final quant = message['quant'];

          final messageWidget = MessageBubble(
            user: user,
            ind: i,
            prodName: name,
            prodQuant: quant,
          );

          messageWidgets.add(messageWidget);
          i++;
        }
        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  FirebaseUser user;
  final String prodName;
  final String prodQuant;
  final int ind;

  MessageBubble({
    this.user,
    this.ind,
    this.prodName,
    this.prodQuant,
  });
  Color randomColor() {
    var random = Random();
    final colorList = [
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  @override
  Widget build(BuildContext context) {
    //IconData myFeedback = FontAwesomeIcons.sadTear;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(),
              ),
              child: Image.asset(
                "assets/card2.png",
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(prodName, style: TextStyles.title.bold),
          subtitle: Text(
            "Quantity : ${prodQuant}",
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: InkWell(
            onTap: () async {
              // List<Map<String, Object>> f;
              // f.add({"name": "f");

              // Map<String, Object> updates;
              // updates.putIfAbsent("cartUser", () => FieldValue.delete());
              // Firestore.instance
              //     .collection('users')
              //     .document(user6.uid)
              //     .updateData({
              //   "cartUser": FieldValue.arrayUnion([
              //     {"name": prod_name, "quant": numberOfItems[ind1].toString()}
              //   ])
              // });
              print("==================");
               await Firestore.instance
            .collection('users')
            .document(user.uid)
            .updateData({
          "cartUser": FieldValue.arrayRemove([
            {"name": prodName, "quant": prodQuant}
          ])
        });
            },
            child: Icon(
              Icons.delete,
              size: 25,
              color: Colors.yellow[800],
            ),
          ),
        ),
      ) 
    );
  }
}
