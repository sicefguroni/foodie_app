import 'package:flutter/material.dart';

class ScalableGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scalable Grid')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          crossAxisSpacing: 8, // Spacing between columns
          mainAxisSpacing: 8, // Spacing between rows
          childAspectRatio: 1, // Adjust this for aspect ratio of each card
        ),
        itemCount: 10, // Number of grid items
        itemBuilder: (context, index) {
          return ScalableCard(index: index);
        },
      ),
    );
  }
}

class ScalableCard extends StatelessWidget {
  final int index;

  ScalableCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The available width for each card
        double cardWidth = constraints.maxWidth;

        // Dynamically scale image size
        double imageSize = cardWidth * 0.6; // 60% of card width
        double fontSizeTitle = cardWidth * 0.07; // 7% of card width for title text
        double fontSizeSubtitle = cardWidth * 0.05; // 5% of card width for subtitle text

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: imageSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/food.png'), // Replace with your image
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
              // Text
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Food Item $index', 
                      style: TextStyle(fontSize: fontSizeTitle, fontWeight: FontWeight.bold),
                    ),
                    // Subtitle
                    SizedBox(height: 4),
                    Text(
                      'Delicious food description $index is so yummy yummy yummy',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: fontSizeSubtitle, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ScalableGridView(),
  ));
}
