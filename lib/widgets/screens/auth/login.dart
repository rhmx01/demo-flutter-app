import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:washaacustomer/providers/data_provider.dart';
import 'package:washaacustomer/widgets/screens/auth/forgot_password.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
        final dataProvider = Provider.of<DataProvider>(context);
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    // const Image(
                    //   image: AssetImage('assets/images/authentication.png'),
                    //   fit: BoxFit.fill,
                    // ),

                    const Icon(
                      Icons.perm_identity,
                      size: 150,
                      color: Colors.grey,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Connectez-vous !',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade100))),
                                child: TextField(
                                  controller: dataProvider.usernameController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      border: InputBorder.none,
                                      hintText: "E-mail ou Téléphone",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: dataProvider.passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      border: InputBorder.none,
                                      hintText: "Mot de passe",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                         Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPassword()),
                              );
                            },
                            child: Text(
                              "Mot de passe oublié?",
                              style: TextStyle(
                                color: Color.fromRGBO(31, 54, 199, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // `showNotification`();
                            final username = dataProvider.usernameController.text;
                            final password = dataProvider.passwordController.text;
                            dataProvider.login(username, password);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(31, 54, 199, 1),
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            minimumSize: Size(double.infinity, 60.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: dataProvider.state == LoginScreenState.loading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Se connecter",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        const SizedBox(height: 10.0,),
                        if (dataProvider.state == LoginScreenState.error)
                          Text(
                            dataProvider.errorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),

                    // login btn
                    // forget pswd
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
