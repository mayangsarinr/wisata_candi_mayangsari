import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // TODO: deklasrasikan variabel yang diberikan
  bool isSignedIn = false;
  String fullName = ' ';
  int favoriteCandiCount =0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
              //   TODO: 2. buat bagian ProfileScreen yang berisi gambar profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200-50),
                    child:
                    Stack(
                      alignment:Alignment.topCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage("images/placeholder_image.png"),
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.camera_alt, color: Colors.deepPurple[50],),),
                      ],
                    ),
                  ),
                ),
              //   TODO: 3. buat bagian ProfileInfo yang beriosi info profil
              //   TODO: 4. buat ProfileActions yang berisi TextButton sign in/out
              ],
            ),
          ),
        ],
      ),
    );
  }
}
