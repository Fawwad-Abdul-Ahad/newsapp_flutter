import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController fullNameController = TextEditingController();
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // scrollDirection: ,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 90),
              Image.asset('asset/image/logo.png'),
              SizedBox(height: 50),
        
              SizedBox(
                height: 12,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        'Full Name',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 25, top: 0, left: 18, right: 18),
                    child: TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                          hintText: "Full Name",
                          fillColor: Color.fromARGB(22, 210, 210, 210),
                          filled: true,
                          // prefixIcon: Icon(Icons.email_sharp),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 18.0,
                      right: 18,
                      left: 22,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        'Email',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 18, right: 18, left: 18),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          fillColor: Color.fromARGB(22, 210, 210, 210),
                          filled: true,
                          // prefixIcon: Icon(Icons.email_sharp),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 22, left: 22),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        'Password',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 0.0, right: 22, left: 20),
                    child: TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: Color.fromARGB(22, 210, 210, 210),
                          filled: true,
                          // prefixIcon: Icon(Icons.lock_open_sharp),
                          suffixIcon: Icon(Icons.visibility_off_outlined),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              InkWell(
                onTap: () {
                  // signin();
                  
                },
                child: Container(
                  width: 340,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const SignUpScreen()),
                        // );
                      },
                      child: Text(
                        " SignUp",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}