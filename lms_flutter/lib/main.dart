import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat'),
      title: "Login to LMS",
      home: Scaffold(
        
        body: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.fromLTRB(24, 50, 24, 24),
            child: Column(

              children: [Text(
                "Welcome",
                style : TextStyle(
                  fontSize: 48,
                  color: Color.fromRGBO(47, 80, 97, 1),
                  fontFamily: "Montserrat"
                ),
                 ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 51, 0, 0),
                  child:  TextFormField(

                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(242, 248, 255, 1),
                      filled: true,
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomLeft: Radius.circular(24)
                          )
                      ),
                      labelText: 'Email',
                      
                      labelStyle: TextStyle(

                        color:  Color.fromRGBO(47, 80, 97, 1),
                      ),


                    ),
                  ),

                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 51, 0, 0),
                  child:  TextFormField(
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                      fillColor: Color.fromRGBO(242, 248, 255, 1),
                      filled: true,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24)
                        )
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(

                        color:  Color.fromRGBO(47, 80, 97, 1),
                      ),


                    ),
                  ),

                ),
              Container(
              width: 343,
                height: 67,
                margin: EdgeInsets.only(
                  top: 51
                ),
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.only(
                         topRight: Radius.circular(24),
                         bottomLeft: Radius.circular(24)
                     )
                   ),
                    primary: Color(0xff0275B1), // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () { },
                  child: Text(
                    'Login',
                    style: TextStyle(
                       fontFamily: 'Montserrat',
                      fontSize: 32
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 51
                ),
                child: Column(
                  children: [
                    Text(
                      "Not having an account yet?"
                    ),
                    Text(
                        "Create one"
                    ),
                  ],
                ),
              ),
                Container(
                  width: 343,
                  height: 67,
                  margin: EdgeInsets.only(
                      top: 51
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(



                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24),
                              bottomLeft: Radius.circular(24)
                          )
                      ),
                      primary: Color(0xff0275B1),
                      side: BorderSide(
                        color: Color(0xff0275B1),
                      )// background

                      // foreground
                    ),
                    onPressed: () { },
                    child: Text(
                      'Go to SignUP',
                      style: TextStyle(
                        color: Color(0xff0275B1),
                          fontSize: 32
                      ),
                    ),
                  ),
                ),],
            ),
          ),
        ),
      ),
    );
  }
}
