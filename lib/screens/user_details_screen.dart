import 'package:flutter/material.dart';
import 'package:flutter_github_api/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_github_api/screens/repo_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  //const UserDetailsScreen({Key? key}) : super(key: key);
  String username='';
  UserDetailsScreen({required this.username});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var _init=true;
  var _isLoading=false;
  @override

  void didChangeDependencies(){
    super.didChangeDependencies();

    if(_init){
      setState(() {
        _isLoading=true;

      });

      Provider.of<UserProvider>(context).getUserProfile(widget.username).then((_){
        setState(() {
          _isLoading=false;
        });
      });
    }
    _init = false;


  }


  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final size = MediaQuery.of(context).size;
    var textStyle = TextStyle(fontFamily: 'Lato', fontSize: 18);
    final f = new DateFormat.yMMMMd("en_US");
    //print('User: ${user.user}');
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.username, style: TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.indigo[900],
        ),
        body: _isLoading ? Center(
          child: CircularProgressIndicator(),
        ) :
        ListView(
          children: [
            ListTile(
              title: Text('Username: ${user.user.username}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: user.user.imageUrl.isNotEmpty ?
              CircleAvatar(
                radius: size.width * 0.30,
                backgroundImage: NetworkImage(user.user.imageUrl),
              ) :
              Container(),
            ),
            ListTile(
              title: Text('Followers: ${user.user.followers}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Text('Following: ${user.user.followings}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Text('Public Repositories: ${user.user.public_repo}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: Text('Joined on: ${f.format(DateTime.parse(user.user.joined_data))}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> RepoScreen(user.user.username)));},
                child: Text('Check Repositories')
            ),
          ],
        )
    );
  }
}
