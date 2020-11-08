import 'package:firebase_user_login/cart/dish_object.dart';
import 'package:flutter/material.dart';

class CartList1 {
  List<Dish> currentCartList=[];
  CartList1({this.currentCartList});

  List<Dish> fun() {
    return currentCartList;
  }
}
