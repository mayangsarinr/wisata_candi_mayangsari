import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class SignInscreen extends StatefulWidget {
  SignInscreen({super.key});

  @override
  State<SignInscreen> createState() => _SignInscreenState();
}

class _SignInscreenState extends State<SignInscreen> {
  //TODO: 1. Deklarasikan variabel
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String _errorText = ' ';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
      Future<SharedPreferences> prefs,
      )async {
    final sharedPreferences = await prefs;
    final encryptedUsername = sharedPreferences.getString('username') ?? ' ';
    final encryptedPassword = sharedPreferences.getString('password') ?? ' ';
    final keyString = sharedPreferences.getString('key') ?? ' ';
    final ivString = sharedPreferences.getString('iv') ?? ' ';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decryptedUsername =
    encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword =
    encrypter.decrypt64(encryptedPassword, iv: iv);

    //Mengembalikkan data terdekripsi
    return {'username': decryptedUsername, 'password': decryptedPassword};
  }

  void _signIn() async{
    try {
      final Future<SharedPreferences> prefsFuture =
      SharedPreferences.getInstance();

      final String username = _usernameController.text;
      final String password = _passwordController.text;
      print('Sign in attempt');

      if (username.isNotEmpty && password.isNotEmpty) {
        final SharedPreferences prefs = await prefsFuture;
        final data = await _retrieveAndDecryptDataFromPrefs(prefs);
        if (data.isNotEmpty) {
          final decryptedUsername = data['username'];
          final decryptedPassword = data['password'];

          if (username == decryptedUsername && password == decryptedPassword) {
            _errorText = '';
            _isSignedIn = true;
            //pemanggilan untuk menghapus semua dalam tumpukan navigasi
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            });
            //Sign in berhasil, navigasikan ke layar utama
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/');
            });
            print('Sign in succeeded');
          } else {
            print('Username or password is incorrect');
          }
        } else {
          print('No stored credentials found');
        }
      } else {
        print('Username and password cannot be empty');
        //Tambahkan pesan untuk kasus ketika username atau password kosong
      }
    }catch (e) {
      print('An error occurred: $e');
    }
    }
  //   final SharedPreferences perfs = await SharedPreferences.getInstance();
  //   final String savedUsername = perfs.getString('username') ?? ' ';
  //   final String savedPassword = perfs.getString('password') ?? ' ';
  //   final String enteredUsername = _usernameController.text.trim();
  //   final String enteredPassword = _passwordController.text.trim();
  //
  //   if(enteredUsername.isEmpty || enteredPassword.isEmpty){
  //     setState(() {
  //       _errorText = 'Nama pengguna dan kata sandi harus diisi.';
  //     });
  //     return;
  //   }
  //   if(savedUsername.isEmpty || savedPassword.isEmpty){
  //     setState(() {
  //       _errorText = 'Pengguna belum terdaftar, silahkan daftar terlebih dahulu.';
  //     });
  //     return;
  //   }
  //   if(enteredUsername == savedUsername && enteredPassword == savedPassword){
  //     setState(() {
  //       _errorText= ' ';
  //       _isSignedIn= true;
  //       perfs.setBool('isSignedIn', true);
  //     });
  //     //Pemanggilan untuk menghapus semua halaman dalam tumpukan navigasi
  //     WidgetsBinding.instance.addPostFrameCallback((_){
  //       Navigator.of(context).popUntil((route) => route.isFirst);
  //     });
  //     //Sign in berhasil, navigasikan ke layar utama
  //     WidgetsBinding.instance.addPostFrameCallback((_){
  //       Navigator.pushReplacementNamed(context, '/');
  //     });
  //   }else{
  //     setState(() {
  //       _errorText = 'Nama pengguna atau kata sandi salah.';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: 2. Pasang Appbar
      appBar: AppBar(title: Text('Sign In'),),
      //TODO: 3. Pasang body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                //TODO: 4. Atur mainAxisAligment dan ccrossAxisAligment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //TODO: 5. Pasang TextFormField Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  //TODO: 6. Pasang TextFormField Kata Sandi
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off
                              : Icons.visibility,
                        ),),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  //TODO: 7. Pasang TextFormField Sign In
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('Sign In')),
                  //TODO: 8. Pasang TextButton Sign Up
                  SizedBox(height: 10),
                  // TextButton(
                  //     onPressed: (){},
                  //     child: Text('Belum punya akun? Daftar di sini.')),
                  RichText(
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: TextStyle(fontSize: 16, color:  Colors.deepPurple),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Daftar di sini. ',
                          style: TextStyle(
                              color:  Colors.blue,  //warna untuk teks yang bisa ditekan
                              decoration: TextDecoration.underline,
                              fontSize: 16
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                            Navigator.pushNamed(context, '/signup');
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}


