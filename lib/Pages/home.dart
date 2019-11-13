import 'package:embee/Pages/aboutus.dart';
import 'package:embee/Pages/alreadybooked.dart';
import 'package:embee/Pages/cart.dart';
import 'package:embee/Pages/contactus.dart';
import 'package:embee/model/fooditems.dart';
import 'package:embee/theme/customtheme.dart';
import 'package:embee/theme/mythemes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference ref,myref;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<FoodItem> foodItems;
  List<String> keyvalue;
  List<int> value;
  List<int> quantity;
  List<String> imageUrl;
  FoodItem foodItem;
 
   int id=0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
 String uid,currentUserEmail;


  getUid() async {
    print("Inside Home init");
   final id=await FirebaseAuth.instance.currentUser();
     uid=id.uid; 
     currentUserEmail=id.email;
     print(uid);
     print(currentUserEmail);
   }

  @override
  void initState() {

    // TODO: implement initState

    
    super.initState();
    getUid();
    foodItems=new List();
    keyvalue=List();
    value=List();
    imageUrl=List();
    quantity=List();
    foodItem=FoodItem(hotel: "", imgUrl: "null", title: "null", price: 0, id: 0, quantity: 0);
    ref= _database.reference().child("FoodItems");
    myref=_database.reference().child("Order");
  
    ref.onChildAdded.listen(_onEntryChanged);
    ref.onChildChanged.listen(_onEntryChanged);
  }
  _onEntryChanged(Event event) {
      myref.child(uid).once().then((DataSnapshot snapshot) async {
        if(snapshot.value==null){
          print("TRUE");
        }
        else{
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context){
                return AlreadyBooked();
              }
            ),
          );
        }
    });
    setState(() {
      foodItems.add(FoodItem.fromSnapshot(event.snapshot));
    });
  }

Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ?? false;
  }

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }




  @override
  Widget build(BuildContext context) {

    final drawerHeader=UserAccountsDrawerHeader(
        accountName: Text("Embee Food "),
        currentAccountPicture: CircleAvatar(
          child: FlutterLogo(size: 42.0,),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        accountEmail: null,
    
    );
    final drawer=ListView(
        children: <Widget>[
          drawerHeader,
          ListTile(title: new Text("About Us"),onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                 );
          },),
          Divider(),
          ListTile(title: new Text("Contact Us"),onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUs()),
              );
          },),
          Divider(),
          ListTile(title: new Text("Sign-Out"),onTap: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamed('/login');
                       //and
          },),
          Divider(),
          ListTile(
            title: Text("Day Mode"),
            onTap: (){
              _changeTheme(context, MyThemeKeys.LIGHT);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Night Mode"),
            onTap: (){
              _changeTheme(context, MyThemeKeys.DARK);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Dark Mode"),
            onTap: (){
              _changeTheme(context, MyThemeKeys.DARKER);
            },
          ),
        ],
    );

    for(int i=0;i<foodItems.length;i++){
      quantity.add(0);
    }

    return WillPopScope(
       onWillPop: _onWillPop,
       child: Scaffold(
       resizeToAvoidBottomPadding: false,
        body:  Column(
        children: <Widget>[
          title(),
          Flexible(
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return items(
                  foodItems[index].title,
                  foodItems[index].price.toString(),
                  foodItems[index].imgUrl,
                  quantity[index],
                  index
                );
              },
            ),
          ),
          InkWell(
            onTap: (){},
            child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
              decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                              Colors.green[900],
                              Colors.green[600]
                            ]),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              if(checkEmpty()){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context){
                                        return CartIndex(
                                          foodItems: foodItems,
                                          quantity: quantity,
                                        );
                                      }
                                  ),
                                );
                              }
                              else{
                                Fluttertoast.showToast(
                                    msg: "Empty List cannot be added to cart",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                            },
                            child: Center(
                              child: Text("Move To Cart",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
        ],
      ),
      drawer: Drawer(
        child: drawer,
      ),
      ),
    );
  }
  Widget title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Embee",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          Text(
            "Foods",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:75.0),
            child: Text("Click on any item to add it to cart"),
          )
        ],
      ),

    
    ],
  );
}

  Widget items(String title,String price,String imageurl,int count,int index){
    print(title+"::"+price+":::"+imageurl);
      return GestureDetector(
        onTap: (){
        // Fluttertoast.showToast(
        //   msg: "Item added to Cart",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIos: 1,
        //   backgroundColor: Colors.grey,
        //   textColor: Colors.white,
        //   fontSize: 16.0
        // );
        //   keyvalue.add(title);
        //   value.add(int.parse(price));
        //   imageUrl.add(imageurl);
        },
        child: Card(
          borderOnForeground: true,
          semanticContainer: true,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                    Container(
                      width: 800.0,
                      height: 250.0,
                      child: (imageurl!=null|| imageurl.length==0)?Image.network(imageurl,fit: BoxFit.fill,):Text("No Image Found")
                    ),
                    Positioned(
                      top: 200.0,
                      left:220.0,
                      right: 0.0,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                                Icons.arrow_drop_up,
                                color: Colors.red,
                                size: 35.0,
                              ),
                              onPressed: (){
                                  setState(() {
                                    count=count+1;
                                    quantity[index]=count;
                                  });
                              },
                            ),
                          Text(count.toString(),style: TextStyle(color: Colors.red,fontSize: 35.0),),
                          IconButton(
                            icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                                size: 35.0,
                              ),
                              onPressed: (){
                                  setState(() {
                                    count=count-1;
                                    quantity[index]=count;
                                  });
                              },
                            ),
                        ],
                      ),
                    ),
                ],
              ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Item:$title",style: TextStyle(color: Colors.green,fontSize: 20.0,fontWeight: FontWeight.bold)),
                    Text("Price: $price /Kg",style: TextStyle(color: Colors.red,fontSize: 20.0,)),
                  ],
                ),
               
            ],
          ),

          // child: Column(
          //   children: <Widget>[
          //     Image.network(imageurl),
          //     Stack(
          //       children: <Widget>[
          //         Positioned(
          //           right: 40.0,
          //           top: 40.0,
          //           child: Text(
          //             "Rs $price/Kg",
          //             style: TextStyle(color: Colors.red,fontSize: 25.0,fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ],
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         Text(
          //           title,
          //           style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold),
          //         ), 
          //       ],
          //     ),
          //   ],
          // ),
        ),
      );
  }

  bool checkEmpty() {
    for(var i=0;i<quantity.length;i++){
      if(quantity[i]>0){
        return true;
      }
    }
    return false;
  }


}