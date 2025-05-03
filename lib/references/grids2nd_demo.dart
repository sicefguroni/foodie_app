GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.7, // Adjust based on your design
  ),
  itemCount: 10,
  itemBuilder: (context, index) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Make the image stretch to full width
        children: [
          Expanded(
            child: Image.asset(
              'assets/food_image.png',
              fit: BoxFit.cover, // Make the image cover the available Expanded space
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Food Item $index',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Delicious and crunchy!',
                  style: TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
)
