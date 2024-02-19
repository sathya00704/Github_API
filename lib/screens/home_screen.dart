import 'package:flutter/material.dart';
import 'package:flutter_github_api/screens/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void submit(){
    if(_formKey.currentState?.validate() ?? false){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> UserDetailsScreen(username: _usernameController.text)));
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left:10,right:10,bottom:10,top:MediaQuery.of(context).size.height*0.2),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Image.asset('assets/githublogo.png'),
                    ),
                    SizedBox(height: 30),
                    Text('Fetch your Repositories', style: TextStyle(
                        color: Colors.black,
                        fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: TextFormField(
                        controller: _usernameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter your GitHub Username",
                          hintStyle: TextStyle(color: Colors.grey[800]), // Set the color to dark grey
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding
                        ),
                        validator: (val){
                          if (val==null || val.isEmpty) {
                            return 'Please enter a valid username';
                          }
                        },
                        onFieldSubmitted: (ctx){
                          submit();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {print('Pressed');submit();},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white
                        ),
                        child: Text('Check', style: TextStyle(color: Colors.black, fontSize: 20),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
