import 'package:flutter/material.dart';
import 'package:leitor_codigo_de_barras/views/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Imagem ou ícone
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/logo.png'),
                ),
                //Nome do local
                const Text(
                  'Bem vindo!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                //Nome do App
                const Text(
                  'Leitor de Código de Barras',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                //Login
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Login'),
                      ),
                    ),
                  ),
                ),
                //Espaço
                SizedBox(height: 10),
                //Senha
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Senha'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                //Botão entrar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new HomePage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Entrar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                    ),
                  ),
                ),
                //Não consegue entrar?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' Acione o ramal 1775',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ))),
    );
  }
}
