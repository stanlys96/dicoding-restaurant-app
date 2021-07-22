import 'package:flutter/material.dart';
import '../data/model/restaurant_detail.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.imageUrl,
    required this.pictureId,
    required this.menu,
  }) : super(key: key);

  final String imageUrl;
  final String pictureId;
  final List<Category> menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: 100.0,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      imageUrl + pictureId,
                      width: 60.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        menu[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Rp 15.000',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: menu.length,
      ),
    );
  }
}
