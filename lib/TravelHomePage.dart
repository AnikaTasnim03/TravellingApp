import 'package:flutter/material.dart';

void main() {
  runApp(TravelHomePageApp());
}

class TravelHomePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelLovers',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        primaryColor: Colors.amber.withOpacity(0.95), // Increased opacity
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.amber.withOpacity(0.95),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: Text('Welcome back! Explore new adventures today.'),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleCategoryTap(String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You tapped on $label booking')),
    );
  }

  Widget buildCategoryRow() {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.flight, 'label': 'Flights', 'color': Colors.blue},
      {'icon': Icons.hotel, 'label': 'Hotels', 'color': Colors.green},
      {'icon': Icons.restaurant, 'label': 'Food', 'color': Colors.red},
      {'icon': Icons.directions_bike, 'label': 'Adventure', 'color': Colors.orange},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories.map((cat) {
          return GestureDetector(
            onTap: () => _handleCategoryTap(cat['label'] as String),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: (cat['color'] as Color).withOpacity(0.2),
                  child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 28),
                ),
                SizedBox(height: 6),
                Text(cat['label'] as String, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildImageSection(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                width: 160,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(item['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      item['name']!,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildOffersSection() {
    final List<Map<String, dynamic>> offers = [
      {
        'icon': Icons.discount,
        'title': '10% Discount on First Booking',
        'color': Colors.orange
      },
      {
        'icon': Icons.breakfast_dining,
        'title': 'Free Breakfast in Select Hotels',
        'color': Colors.pink
      },
      {
        'icon': Icons.card_giftcard,
        'title': 'Loyalty Rewards Program',
        'color': Colors.purple
      },
      {
        'icon': Icons.airplanemode_active,
        'title': 'Zero Booking Fees',
        'color': Colors.teal
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Exclusive Offers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Container(
                width: 250,
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: (offer['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: offer['color'] as Color, width: 1),
                ),
                child: ListTile(
                  leading: Icon(offer['icon'] as IconData, color: offer['color'] as Color, size: 32),
                  title: Text(offer['title'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Limited Time Only'),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${offer['title']} selected')),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildWhyChooseUs() {
    final List<Map<String, dynamic>> reasons = [
      {'icon': Icons.support_agent, 'text': '24/7 Customer Support', 'color': Colors.green},
      {'icon': Icons.lock, 'text': 'Secure Payments', 'color': Colors.blue},
      {'icon': Icons.price_check, 'text': 'Best Price Guarantee', 'color': Colors.orange},
      {'icon': Icons.group, 'text': 'Trusted by Thousands of Travelers', 'color': Colors.purple},
      {'icon': Icons.card_travel, 'text': 'Tailored Travel Packages', 'color': Colors.teal},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Why Choose TravelLovers?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reasons.length,
            itemBuilder: (context, index) {
              final reason = reasons[index];
              return Container(
                width: 240,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: (reason['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: reason['color'] as Color, width: 1),
                ),
                child: ListTile(
                  leading: Icon(reason['icon'] as IconData, color: reason['color'] as Color, size: 36),
                  title: Text(reason['text'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildBookingProcedure() {
    final List<Map<String, String>> steps = [
      {'step': '1', 'title': 'Search Destinations'},
      {'step': '2', 'title': 'Select Packages'},
      {'step': '3', 'title': 'Make Payment'},
      {'step': '4', 'title': 'Receive Confirmation'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Booking Procedure',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...steps.map((s) => Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Text(s['step']!, style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                Text(s['title']!, style: TextStyle(fontSize: 16)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recentPictures = [
      {'image': 'assets/picture6.jpg', 'name': 'Dubai'},
      {'image': 'assets/picture10.jpg', 'name': 'Singapore'},
      {'image': 'assets/picture11.jpg', 'name': 'Egypt'},
      {'image': 'assets/picture12.jpg', 'name': 'Bhutan'},
    ];

    final hotelPictures = [
      {'image': 'assets/picture13.jpg', 'name': 'Luxury Inn'},
      {'image': 'assets/picture14.jpg', 'name': 'Palm Resort'},
      {'image': 'assets/picture21.jpg', 'name': 'Sea View Hotel'},
      {'image': 'assets/picture24.jpg', 'name': 'Mountain Stay'},
    ];

    final bangladeshDestinations = [
      {'image': 'assets/picture17.jpg', 'name': 'Cox Bazar'},
      {'image': 'assets/picture18.jpg', 'name': 'Sitakundo'},
      {'image': 'assets/picture19.jpg', 'name': 'Khagrachori'},
      {'image': 'assets/picture23.jpg', 'name': 'Sonargaon'},
    ];

    final recommendedPlaces = [
      {'image': 'assets/picture27.jpeg', 'name': 'Switzerland'},
      {'image': 'assets/picture7.jpg', 'name': 'Norway'},
      {'image': 'assets/picture30.jpg', 'name': 'Canada'},
      {'image': 'assets/picture31.jpg', 'name': 'Iceland'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Home Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildCategoryRow(),
            buildImageSection('Recent Trips', recentPictures),
            buildImageSection('Hotel ', hotelPictures),
            buildImageSection('Bangladesh Destinations', bangladeshDestinations),
            buildImageSection('RecommendedPlaces', recommendedPlaces),
            buildOffersSection(),
            buildWhyChooseUs(),
            buildBookingProcedure(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber[700],
        unselectedItemColor: Colors.amber,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
