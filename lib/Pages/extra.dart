


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData.dark(),
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> {
//   List<Item> items = List();
//   Item item;
//   DatabaseReference itemRef;

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     item = Item("", "");
//     final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.  
//     itemRef = database.reference().child('items');
//     itemRef.onChildAdded.listen(_onEntryAdded);
//     itemRef.onChildChanged.listen(_onEntryChanged);
//   }

//   _onEntryAdded(Event event) {
//     setState(() {
//       items.add(Item.fromSnapshot(event.snapshot));
//     });
//   }

//   _onEntryChanged(Event event) {
//     var old = items.singleWhere((entry) {
//       return entry.key == event.snapshot.key;
//     });
//     setState(() {
//       items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
//     });
//   }

//   void handleSubmit() {
//     final FormState form = formKey.currentState;

//     if (form.validate()) {
//       form.save();
//       form.reset();
//       itemRef.push().set(item.toJson());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FB example'),
//       ),
//       resizeToAvoidBottomPadding: false,
//       body: Column(
//         children: <Widget>[
//           Flexible(
//             flex: 0,
//             child: Center(
//               child: Form(
//                 key: formKey,
//                 child: Flex(
//                   direction: Axis.vertical,
//                   children: <Widget>[
//                     ListTile(
//                       leading: Icon(Icons.info),
//                       title: TextFormField(
//                         initialValue: "",
//                         onSaved: (val) => item.title = val,
//                         validator: (val) => val == "" ? val : null,
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.info),
//                       title: TextFormField(
//                         initialValue: '',
//                         onSaved: (val) => item.body = val,
//                         validator: (val) => val == "" ? val : null,
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send),
//                       onPressed: () {
//                         handleSubmit();
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Flexible(
//             child: FirebaseAnimatedList(
//               query: itemRef,
//               itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                   Animation<double> animation, int index) {
//                 return new ListTile(
//                   leading: Icon(Icons.message),
//                   title: Text(items[index].title),
//                   subtitle: Text(items[index].body),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Item {
//   String key;
//   String title;
//   String body;

//   Item(this.title, this.body);

//   Item.fromSnapshot(DataSnapshot snapshot)
//       : key = snapshot.key,
//         title = snapshot.value["title"],
//         body = snapshot.value["body"];

//   toJson() {
//     return {
//       "title": title,
//       "body": body,
//     };
//   }
// }


// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:math' as Math;

// // import 'package:async/async.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:foodzzz_restaurent2/models/restaurentDetails.dart';
// // import 'package:foodzzz_restaurent2/pages/Order.dart';
// // import 'package:foodzzz_restaurent2/services/authentication.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:foodzzz_restaurent2/models/todo.dart';
// // import 'dart:async';
// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:image_picker/image_picker.dart';
// // import 'package:path/path.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:image/image.dart' as Img;
// // import 'package:firebase_database/ui/firebase_animated_list.dart';

// // class HomePage extends StatefulWidget {
// //   HomePage({Key key, this.auth, this.userId, this.onSignedOut})
// //       : super(key: key);

// //   final BaseAuth auth;
// //   final VoidCallback onSignedOut;
// //   final String userId;

// //   @override
// //   State<StatefulWidget> createState() => new _HomePageState();
// // }

// // String name;
// // class _HomePageState extends State<HomePage> {
// //   List<Todo> _todoList;
// //   String userId="";
// //   List<Order> myorder;

// //   final FirebaseDatabase _database = FirebaseDatabase.instance;
// //   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
// //   DatabaseReference ref3;

// //   final _textEditingController = TextEditingController();
// //   StreamSubscription<Event> _onTodoAddedSubscription;
// //   StreamSubscription<Event> _onTodoChangedSubscription;

// //  // Query _todoQuery;

// //   bool _isEmailVerified = false;

// //   void inputData() async {
// //     final FirebaseAuth auth=FirebaseAuth.instance;
// //     final FirebaseUser user = await auth.currentUser();
// //     final uid = user.uid;
// //     userId=user.uid;
// //     print("Input data called");
// //     // here you write the codes to input the data into firestore
// //   }
// //   _onEntryChanged(Event event) {
// //     setState(() {
// //       myorder.add(Order.fromSnapshot(event.snapshot));
// //     });
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     inputData();
// //     print("Inside init");
// //     print("UID is"+userId);
// //     _checkEmailVerification();
// //     myorder=new List();
// //     ref3= _database.reference().child("Order");
// //     ref3.onChildAdded.listen(_onEntryChanged);

// //     _todoList = new List();
// // //    _todoQuery = _database
// // //        .reference()
// // //        .child("todo")
// // //        .orderByChild("userId")
// // //        .equalTo(widget.userId);
// // //    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(_onEntryAdded);
// // //    _onTodoChangedSubscription = _todoQuery.onChildChanged.listen(_onEntryChanged);
// //   }

// //   void _checkEmailVerification() async {
// //     _isEmailVerified = await widget.auth.isEmailVerified();
// //     if (!_isEmailVerified) {
// //       _showVerifyEmailDialog();
// //     }
// //   }

// //   void _resentVerifyEmail(){
// //     widget.auth.sendEmailVerification();
// //     _showVerifyEmailSentDialog();
// //   }

// //   void _showVerifyEmailDialog() {
// //     showDialog(
// //       builder: (BuildContext context) {
// //         // return object of type Dialog
// //         return AlertDialog(
// //           title: new Text("Verify your account"),
// //           content: new Text("Please verify account in the link sent to email"),
// //           actions: <Widget>[
// //             new FlatButton(
// //               child: new Text("Resent link"),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //                 _resentVerifyEmail();
// //               },
// //             ),
// //             new FlatButton(
// //               child: new Text("Dismiss"),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   void _showVerifyEmailSentDialog() {
// //     showDialog(
// //       builder: (BuildContext context) {
// //         // return object of type Dialog
// //         return AlertDialog(
// //           title: new Text("Verify your account"),
// //           content: new Text("Link to verify account has been sent to your email"),
// //           actions: <Widget>[
// //             new FlatButton(
// //               child: new Text("Dismiss"),
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _onTodoAddedSubscription.cancel();
// //     _onTodoChangedSubscription.cancel();
// //     super.dispose();
// //   }



// //   _signOut() async {
// //     try {
// //       await widget.auth.signOut();
// //       widget.onSignedOut();
// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   List<String> name=new List();




// //   TextEditingController Name=new TextEditingController();
// //   TextEditingController Mobile=new TextEditingController();
// //   TextEditingController Address=new TextEditingController();
// //   TextEditingController Gstn=new TextEditingController();
// //   TextEditingController PAN=new TextEditingController();

// //   TextEditingController Food=new TextEditingController();
// //   TextEditingController Price=new TextEditingController();
// //   File _image;
// //   Future getImageGallery() async{
// //     var imageFile=await ImagePicker.pickImage(source: ImageSource.gallery);

// //     final tempDir=await getTemporaryDirectory();
// //     final path=tempDir.path;

// //     final id=await FirebaseAuth.instance.currentUser();
// //     String uid=id.uid;
// //     int rand=Math.Random().nextInt(100000);

// //     Img.Image image=Img.decodeImage(imageFile.readAsBytesSync());
// //     Img.Image smallerImage=Img.copyResize(image, 500);
// //     var compressImg=File("$path/image_$uid.jpg")
// //     ..writeAsBytesSync(Img.encodeJpg(smallerImage,quality: 85));


// //     setState(() {
// //       _image=imageFile;
// //     });
// //   }
// //   Future getImageCamera() async{
// //     var imageFile=await ImagePicker.pickImage(source: ImageSource.camera);
// //     final tempDir=await getTemporaryDirectory();
// //     final path=tempDir.path;

// //     final id=await FirebaseAuth.instance.currentUser();
// //     String uid=id.uid;

// //     Img.Image image=Img.decodeImage(imageFile.readAsBytesSync());
// //     Img.Image smallerImage=Img.copyResize(image, 500);
// //     var compressImg=File("$path/image_$uid.jpg")
// //       ..writeAsBytesSync(Img.encodeJpg(smallerImage,quality: 85));


// //     setState(() {
// //       _image=imageFile;
// //     });
// //   }

// //   Future upload(File imageFile,String UserId) async{
// //     var steam=http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
// //     var length=await imageFile.length();
// //     var uri=Uri.parse("https://commerceguru.000webhostapp.com/setFoodDetails.php");
// //     var request=http.MultipartRequest("POST",uri);
// //     request.fields['uid']=UserId;
// //     request.fields['foodname']=Food.text;
// //     request.fields['foodprice']=Price.text;
// //     var multipartFile=http.MultipartFile("image",steam,length,filename: basename(imageFile.path));
// //     request.files.add(multipartFile);
// //     var response=await request.send();
// //     if(response.statusCode==200){
// //       print("DATA UPLOADED");
// //     }
// //     else{
// //       print("FAILED");
// //     }
// //   }
// //   addFood(BuildContext context) async {

// //     await showDialog<String>(
// //       context: context,
// //       builder: (BuildContext context){
// //         return AlertDialog(
// //           content: Column(
// //             children: <Widget>[
// //               Expanded(
// //                 child:TextField(controller:Food,decoration: InputDecoration(hintText: "Enter Food Name",labelText: "Enter Food Name"),),
// //               ),
// //               Expanded(
// //                 child:TextField(controller:Price,decoration: InputDecoration(hintText: "Enter Food Price",labelText: "Enter Food Price"),),
// //               ),
// //              Expanded(
// //                child: _image==null?Text("No Image Selected"):Image.file(_image),
// //              ),

// //              Row(
// //                children: <Widget>[
// //                  MaterialButton(
// //                    child:Text("Gallery"),
// //                    onPressed: getImageGallery,
// //                  ),
// //                  MaterialButton(
// //                    child:Text("Camera"),
// //                    onPressed: getImageCamera,
// //                  ),

// //                ],
// //              ),

// //             ],
// //           ),
// //           actions: <Widget>[
// //             FutureBuilder(
// //               future: FirebaseAuth.instance.currentUser(),
// //               builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
// //                 if(snapshot.hasData){
// //                   return  FlatButton(
// //                     child: Text("Continue"),
// //                     onPressed: (){
// //                       upload(_image,snapshot.data.uid);

// //                     },
// //                   );
// //                 }
// //                 else{
// //                   return Text('Loading...');

// //                 }
// //               },

// //             ),

// //             FlatButton(
// //               child: Text("Cancel"),
// //               onPressed: ()=>Navigator.of(context).pop(),
// //             ),
// //           ],
// //         );

// //       }
// //     );

// //   }

// //   Future<List> getData(String id) async{

// //     final response=await http.get("https://commerceguru.000webhostapp.com/getFoodDetails.php?q="+id);
// //     print(response.body);
// //     return json.decode(response.body);

// //   }
// //   Future<List> getRestData(String id) async{

// //     final response=await http.get("https://commerceguru.000webhostapp.com/getrestaurentdetails.php?q="+id);
// //     print(response.body);
// //     return json.decode(response.body);

// //   }

// //   Widget foodDetails(){
// //     return FutureBuilder(
// //       future: FirebaseAuth.instance.currentUser(),
// //       builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
// //         if(snapshot.hasData){
// //           getData(snapshot.data.uid);
// //           return FutureBuilder(
// //             future: getData(snapshot.data.uid),
// //             builder: (context,i){
// //               if(i.hasData){
// //                 return ItemList(list: i.data,);
// //               }
// //               else{
// //                 return Center(child: Text("Please wait...."),);
// //               }
// //             },
// //           );
// //         }
// //         else{
// //           return Center(child: Text("Error 2"),);

// //         }
// //       },
// //     );
// //   }
// // //  Widget restdetails(){
// // //    return FutureBuilder(
// // //      future: FirebaseAuth.instance.currentUser(),
// // //      builder: (context,AsyncSnapshot<FirebaseUser> snapshot){
// // //        if(snapshot.hasData){
// // //          getRestData(snapshot.data.uid);
// // //          return FutureBuilder(
// // //            future: getData(snapshot.data.uid),
// // //            builder: (context,i){
// // //              if(i.hasData){
// // //                return ItemList1(list: i.data,);
// // //              }
// // //              else{
// // //                return Center(child: Text("Please wait...."),);
// // //              }
// // //            },
// // //          );
// // //        }
// // //        else{
// // //          return Center(child: Text("Error 2"),);
// // //
// // //        }
// // //      },
// // //    );
// // //  }



// //   Widget orders(){


// //     return Column(
// //       children: <Widget>[
// //         Flexible(
// //           child: FirebaseAnimatedList(
// //             query: ref3,
// //             itemBuilder: (BuildContext context, DataSnapshot snapshot,
// //                 Animation<double> animation, int index) {
// //                 return new ListTile(
// //                   title: Text(myorder[index].CustomerName+"\n"+myorder[index].CustomerMobile),
// //                   subtitle: Text(myorder[index].FoodName+"\n"+myorder[index].FoodPrice),

// //                 );


// //             },
// //           ),
// //         ),
// //       ],
// //     );



// //   }

// //   Widget RestaurentProfile(){

// //     return FutureBuilder(
// //       future: FirebaseAuth.instance.currentUser(),
// //       builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
// //         if (snapshot.hasData) {
// //           return
// //           ListView(
// //             children: <Widget>[
// //               Padding(padding: EdgeInsets.all(25.0),),
// //               TextField(controller:Name,decoration: InputDecoration(labelText: "Enter Restaurent Name",hintText: "Enter Restaurent Name"),),
// //               TextField(controller:Mobile,decoration: InputDecoration(labelText: "Enter Restaurent Mobile Number",hintText: "Enter Restaurent Mobile Number"),),
// //               TextField(controller:Address,decoration: InputDecoration(labelText: "Enter Address with Pincode",hintText: "Enter Address With Pincode"),),
// //               TextField(controller:Gstn,decoration: InputDecoration(labelText: "Enter Adhaar Number",hintText: "Enter Adhaar Number"),),
// //               TextField(controller:PAN,decoration: InputDecoration(labelText: "Enter PAN Number",hintText: "Enter PAN Number"),),
// //               MaterialButton(
// //                 color: Colors.blue,
// //                 child: Text("UPDATE"),
// //                 onPressed: (){
// //                   var url="https://commerceguru.000webhostapp.com/setRestaurentDetails.php";

// //                   http.post(url,body: {
// //                     'uid':snapshot.data.uid,
// //                     'name':Name.text,
// //                     'address':Address.text,
// //                     'mobile':Mobile.text,
// //                     'gstnumber':Gstn.text,
// //                     'pannumber':PAN.text,
// //                   });
// //                   print("DATA UPLOADED");
// // //                final FirebaseDatabase _database = FirebaseDatabase.instance;
// // //                DocumentReference ref=Firestore.instance.collection("RestaurentDetail").document(snapshot.data.uid);
// // //                String name=Name.text;
// // //                String mobile=Mobile.text;
// // //                String address=Address.text;
// // //                String gstn=Gstn.text;
// // //                String pan=PAN.text;
// // //                Map<String,String> res_data=<String,String>{
// // //                  "name":name,
// // //                  "mobile":mobile,
// // //                  "address":address,
// // //                  "gstn":gstn,
// // //                  "pan":pan,
// // //
// // //                };
// // ////                FirebaseUser user=FirebaseAuth.instance.currentUser();
// // //                Res obj=new Res(name,mobile,address,gstn,pan);
// // //                _database
// // //                    .reference()
// // //                    .child("RestaurentDetails")
// // //                    .child(snapshot.data.uid)
// // //                    .set(obj.toJson());
// // //
// // //                ref.setData(res_data).whenComplete((){
// // //                  print("Data uploaded");
// // //                }).catchError((e)=>print(e));
// // //
// // //
// // //


// //               },
// //               ),

// //             ],

// //           );
// //         }
// //         else {
// //           return Text('Loading...');
// //         }
// //       },
// //     );



// //   }

// //   int id=0;
// //   @override
// //   Widget build(BuildContext context) {



// //     final tabpages=<Widget>[
// //       foodDetails(),
// //       orders(),
// //       RestaurentProfile(),
// //     ];
// //     return new Scaffold(
// //         appBar: new AppBar(
// //           title: new Text('Restaurent HomePage'),
// //           actions: <Widget>[
// //             new FlatButton(
// //                 child: new Text('Logout',
// //                     style: new TextStyle(fontSize: 17.0, color: Colors.white)),
// //                 onPressed: _signOut)
// //           ],
// //         ),
// //         body:tabpages[id],
// //         floatingActionButton: FloatingActionButton(
// //           onPressed: () {
// //             addFood(context);
// //           },
// //           tooltip: 'Add Food',
// //           child: Icon(Icons.add),
// //         ),
// //       bottomNavigationBar: CurvedNavigationBar(
// //         items: <Widget>[
// //           Icon(Icons.home,color: Colors.white,),
// //           Icon(Icons.email,color: Colors.white,),
// //           Icon(Icons.person,color: Colors.white,),
// //         ],
// //         color: Colors.blue,
// //         buttonBackgroundColor: Colors.blue,
// //         animationCurve: Curves.easeIn,
// //         animationDuration: Duration(milliseconds: 600),
// //         onTap: (int index){
// //           setState(() {
// //             id=index;
// //           });
// //         },
// //       ),
// //     );
// //   }
// // }
// // class ItemList extends StatelessWidget {
// //   final List list;

// //   ItemList({this.list});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //         itemCount: list==null?0:list.length,
// //         itemBuilder: (context,i){
// //           return ListTile(
// //             leading: Container(
// //               height: 100.0,
// //               width: 100.0,
// //               child: Image.network("https://commerceguru.000webhostapp.com/uploads/"+list[i]['image']),
// //             ),
// //             title: Text(list[i]['FoodName']),
// //             subtitle: Text(list[i]['FoodPrice']),
// //             onTap: (){},
// //           );
// //         }
// //     );
// //   }
// // }

// // //class ItemList1 extends StatelessWidget {
// // //  final List list;
// // //
// // //  ItemList1({this.list});
// // //
// // //  @override
// // //  Widget build(BuildContext context) {
// // //    return ListView.builder(
// // //        itemCount: list==null?0:list.length,
// // //        itemBuilder: (context,i){
// // //          name=list[i]['name'];
// // //
// // //        }
// // //    );
// // //  }
// // //}