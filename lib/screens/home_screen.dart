import 'package:flutter/material.dart';
import 'package:flutter_github_api/screens/user_details_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text.trim();
      if (username.isNotEmpty) {
        var response = await http.get(Uri.parse('https://api.github.com/users/$username'));

        if (response.statusCode == 200) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => UserDetailsScreen(username: username),
          ));
        } else if (response.statusCode == 404) {
          // User not found
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("User not found"),
                content: Text("The GitHub username '$username' does not exist."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other status codes
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("An error occurred while fetching the user data."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("GitHub username cannot be empty."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: MediaQuery.of(context).size.height * 0.2),
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
                    Text(
                      'Fetch your Repositories',
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter a valid username';
                          }
                        },
                        onFieldSubmitted: (ctx) {
                          submit();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        print('Pressed');
                        submit();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Text(
                        'Check',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
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
