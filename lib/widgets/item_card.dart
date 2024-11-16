import 'package:flutter/material.dart';

import '../models/candi.dart';

class ItemCard extends StatelessWidget {
  //TODO: 1. Delarasikan variabel yang dibutuhkan dan pasang pada konstruktor
  final Candi candi;
  const ItemCard({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    return Card(
      //TODO: 2. Tetapkan parameter shape, margin, dan elevation dari Cari
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      margin: EdgeInsets.all(4),
      elevation: 1,
      child: Column(
        children: [
          //TODO: 3. Buat Image sebagai anak dari Column
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15) ,
              child: Image.asset(candi.imageAsset,
                  width: double.infinity,
                  fit: BoxFit.cover
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              top: 8,
            ),
            child: Text(
              candi.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16, bottom: 8),
            child: Text(
              candi.type,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          //TODO: 4. Buat Text sebagai anak dari Column
          //TODO: 5. Buat Text sebagai anak dari Column

        ],
      ),
    );
  }
}
