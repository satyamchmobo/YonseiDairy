import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_user_login/allproducts.dart';
import 'package:firebase_user_login/cart/cart_list.dart';
import 'package:firebase_user_login/cartList.dart';
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
class HomePage extends StatefulWidget {
   FirebaseUser fireUser;

  HomePage({this.fireUser});

  @override
  _HomePageState createState() => _HomePageState(fireUser1: fireUser);
}

class _HomePageState extends State<HomePage> {
  
FirebaseUser fireUser1;

  _HomePageState({this.fireUser1});

  //final MealsListData mealsListData=new MealsListData();
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  final List<Widget> screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    // HomePage(),
    // HomePage()
  ];
  Widget currentScreen = HomePage();

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
      title:  Container(
        height: 40,
        width: 40,
        child: Image.asset("assets/yonsilogo.png",)),
      leading: Icon(
        Icons.short_text,
        size: 30,
        color: Colors.yellow[800],
      ),
      actions: <Widget>[
        Icon(
          Icons.notifications_none,
          size: 30,
          color:Colors.yellow[800],
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
          child: InkWell(onTap: () {
     Navigator.push(
                        context, //here we are passing the values of  product to proddta
                        MaterialPageRoute(
                            builder: (context) => CartList(fireUser: fireUser1,)),
                      );
          },
                      child: Icon(
              Icons.shopping_cart,
              size: 25,
              color: Colors.yellow[800],
            ),
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
        border: Border.all(width: 1,color:Colors.yellow[800],),
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
              child: Icon(Icons.search, color: Color(0xfffec321),)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  Widget _card() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.indigo[400], width: 0.0),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(10.0),
      elevation: 4,
      child: Container(
        height: 200.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: new Carousel(
            boxFit: BoxFit.cover,
            images: [
              AssetImage('assets/welcomeYonDairy.jpg'),
              AssetImage('assets/1caroul.jpg'),
              AssetImage('assets/2caroul.jpg'),
             
              
            ],
            autoplay: false,

//      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
            dotSize: 4.0,
            indicatorBgPadding: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Services", style: TextStyles.title.bold),
              Text(
                "See All",
                style: TextStyles.titleNormal
                    .copyWith(color:Colors.yellow[800]),
              ).p(8).ripple(() {
                 Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DemoPage(
                            //fireUser: user1,
                          )),
                );
              })
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _categoryCard(mealsListData[0],
                  color: LightColor.green, lightColor: LightColor.lightGreen),
              // _categoryCard("Milk Products", "50+ products",
              //     color: LightColor.skyBlue, lightColor: LightColor.lightBlue),
              _categoryCard(mealsListData[1],
                  color: LightColor.orange, lightColor: LightColor.lightOrange)
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(MealsListData mealsListData,
      {Color color, Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return SizedBox(
      width: 160,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: HexColor(mealsListData.endColor).withOpacity(0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
                gradient: LinearGradient(
                  colors: <HexColor>[
                    HexColor(mealsListData.startColor),
                    HexColor(mealsListData.endColor),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(54.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 54, left: 10, right: 0, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      mealsListData.titleTxt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: FitnessAppTheme.white,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mealsListData.meals.join('\n'),
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    mealsListData.kacl != 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                mealsListData.kacl.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  letterSpacing: 0.2,
                                  color: FitnessAppTheme.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 3),
                                child: Text(
                                  'kcal',
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    letterSpacing: 0.2,
                                    color: FitnessAppTheme.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.nearlyWhite,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: FitnessAppTheme.nearlyBlack
                                        .withOpacity(0.4),
                                    offset: Offset(8.0, 8.0),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.add,
                                color: HexColor(mealsListData.endColor),
                                size: 24,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 8,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(mealsListData.imagePath),
            ),
          )
        ],
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
            color: Theme.of(context).primaryColor,
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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                //_header(),
                _searchField(),
                _card(),
                _category(),
                
              ],
            ),
          ),
          _doctorsList(),
     //  MessageStream(),    
          
        ],

      
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        buttonBackgroundColor:Colors.yellow[800],
        color:Colors.yellow[200],
        backgroundColor: Colors.white,
        index: currentTab,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color:Colors.grey[700],
          ),
          Icon(
            Icons.grid_on,
            size: 30,
            color: Colors.grey[700],
          ),
          Icon(Icons.menu, color:Colors.grey[700], size: 30),
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
  @override
  _MessageStreamState createState() => _MessageStreamState();
}


class _MessageStreamState extends State<MessageStream> {
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
      stream: Firestore.instance.collection("category").document().collection("milk").snapshots(),
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
        for (var message in messages) {
          final proName = message.data['nameOfMIlk'];
          
         
          final proPrice = message.data['priceOfMilk'];
          // final proOldPrice = message.data['quantity'];
          // final proImage1 = message.data['image1'];
          // final proImage2 = message.data['image2'];
          // final proImage3 = message.data['image3'];
          // // final proSizes = List.from(message.data['sizes']);
          // final proBrand = message.data['brand'];
          // final prodCategory = message.data['category'];
          // final prodVideo = message.data['youtubeVideoUrl'];
          // final prodId = message.data['id'];

          final messageWidget = Single_prod(
            prod_name: proName,
            prod_pricture1: "assets/slider1.PNG",
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

          messageWidgets.add(messageWidget);
        }
        return SliverGrid(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
  ),
  delegate: SliverChildBuilderDelegate(
    (BuildContext context, int index) {
      return Container(
        child: Text("hghjg"),
      
        color:Colors.blue,
        height: 150.0);
    }
),

        );

          





      },




    );
  }
}
  
class Single_prod extends StatelessWidget {
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
      {this.prod_name,
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
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.indigo[400], width: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
      elevation: 3,
      child: InkWell(
        onTap: () {
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
                  border: Border.all(color: Colors.indigo[400], width: 0.9),
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
                            style: TextStyle(fontSize: 7,fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                width: 120.0,
                height: 27.0,
                decoration: BoxDecoration(
                  color: Colors.indigo[400],
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo[400],
                      offset: Offset(0.0, 10.0),
                      spreadRadius: -5.0,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
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
                        'Details',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
