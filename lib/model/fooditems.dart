import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
  
final databaseReference = FirebaseDatabase.instance.reference();
 


FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
    id: 1,
    title: "Baygan",
    hotel: "",
    price: 50,
    imgUrl:
        "https://image.shutterstock.com/image-photo/fresh-eggplant-vegetable-stem-isolated-260nw-1037478487.jpg",
  ),
  FoodItem(
    id: 2,
    title: "Chota Baygan",
    hotel: "",
    price: 50,
    imgUrl:
        "https://image.shutterstock.com/image-photo/fresh-eggplant-vegetable-stem-isolated-260nw-1037478487.jpg",
  ),
  FoodItem(
    id: 3,
    title: "patta gobhi",
    hotel: "",
    price: 50,
    imgUrl: "",
  ),
  FoodItem(
    id: 4,
    title: "gajar",
    hotel: "",
    price: 50,
    imgUrl: "https://befreshcorp.net/wp-content/uploads/2017/06/product-packshot-Carrot-558x600.jpg",
  ),
  FoodItem(
    id: 5,
    title: "shimla mirach",
    hotel: "",
    price: 50,
    imgUrl: "",
  ),
  FoodItem(
    id: 6,
    title: "phool gobhi",
    hotel: "",
    price:50,
    imgUrl:
        "",
  ),
  FoodItem(
    id: 6,
    title: "Adrak",
    hotel: "",
    price: 50,
    imgUrl:
        "",
  ),
    FoodItem(
    id: 6,
    title: "Mirch",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),
    FoodItem(
    id: 6,
    title: "Loki",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),
    FoodItem(
    id: 6,
    title: "Nimbu",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),
    FoodItem(
    id: 6,
    title: "Pyaaz",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),
    FoodItem(
    id: 6,
    title: "Aalu",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),
    FoodItem(
    id: 6,
    title: "Tamater",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),
    FoodItem(
    id: 6,
    title: "Sita-fal",
    hotel: "",
    price: 50,
    imgUrl:"",
  ),

]);

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});


  
}

class FoodItem {
  int id;
  String title;
  String hotel;
  int price;
  String imgUrl;
  int quantity;

  

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.hotel,
    @required this.price,
    @required this.imgUrl,
    @required this.quantity,
  });

  
FoodItem.fromSnapshot(DataSnapshot snapshot)
  :title=snapshot.value['title'],
   price=snapshot.value['price'],
   imgUrl=snapshot.value['imageurl'],
   quantity=snapshot.value['quantity'];


  
  
  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}
