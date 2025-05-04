import 'package:flutter/material.dart';
import 'utilities_texts.dart';
import 'utilities_cards.dart';
import 'package:foodie_app/utilities/color_palette.dart';

class TitlewithImage extends StatelessWidget {
  final String title;
  final String image;

  const TitlewithImage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.50,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: 25,
            child: TitleText(title: title, color: c_pri_yellow),
          ),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(image, width: double.infinity, height: 300, fit: BoxFit.cover);
  }
}


class CustomerAvatar extends StatelessWidget {
  const CustomerAvatar({super.key, required this.assetName, required this.radius});

  final String assetName;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: AssetImage(assetName),
      radius: radius,
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SizedBox(
          height: 40,
          child: SearchBar(
            elevation: MaterialStateProperty.all(0.5),
            controller: controller,
            backgroundColor: MaterialStateProperty.all(c_white),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 8)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            onTap: () {
              controller.openView();
            },
            trailing: [
              Icon(Icons.search, color: c_pri_yellow),
            ],
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return [
          ListTile(
            title: Text('Suggestion 1'),
            onTap: () {
              controller.closeView('Suggestion 1');
            },
          ),
          ListTile(
            title: Text('Suggestion 2'),
            onTap: () {
              controller.closeView('Suggestion 2');
            },
          ),
        ];
      },
    );
  }
}

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            isScrollable: true,
            indicatorColor: c_pri_yellow,
            tabAlignment: TabAlignment.start,
            splashBorderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            tabs: [
              Text('Pending', style: TextStyle(fontSize: 12)),
              Text('Accepted', style: TextStyle(fontSize: 12)),
              Text('Preparing', style: TextStyle(fontSize: 12)),
              Text('To Deliver', style: TextStyle(fontSize: 12)),
              Text('Completed', style: TextStyle(fontSize: 12)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                CheckoutCards(),
                CheckoutCards(),
                CheckoutCards(),
                CheckoutCards(),
                CheckoutCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
