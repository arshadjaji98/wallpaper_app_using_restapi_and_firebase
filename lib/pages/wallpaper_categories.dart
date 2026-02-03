import 'package:flutter/material.dart';
import 'package:wallify/pages/categoroy_wallpaper.dart';

class WallpaperCategories extends StatefulWidget {
  const WallpaperCategories({super.key});

  @override
  State<WallpaperCategories> createState() => _WallpaperCategoriesState();
}

class _WallpaperCategoriesState extends State<WallpaperCategories>
    with AutomaticKeepAliveClientMixin {
  final List<Map<String, String>> categories = [
    {"label": "Wildlife", "image": "assets/animals.jpg"},
    {"label": "Nature", "image": "assets/nature.jpg"},
    {"label": "Mountains", "image": "assets/mountains.jpg"},
    {"label": "City", "image": "assets/city.jpg"},
    {"label": "Cars", "image": "assets/cars.jpg"},
    {"label": "Technology", "image": "assets/technology.jpg"},
    {"label": "Space", "image": "assets/space.jpg"},
    {"label": "Minimal", "image": "assets/minimal.jpg"},
    {"label": "Abstract", "image": "assets/abstract.jpg"},
    {"label": "Dark", "image": "assets/dark.jpg"},
    {"label": "Sports", "image": "assets/sports.jpg"},
    {"label": "Food", "image": "assets/foods.jpg"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final cat in categories) {
        final imagePath = cat['image'];
        if (imagePath != null) {
          precacheImage(AssetImage(imagePath), context);
        }
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final width = MediaQuery.of(context).size.width;
    final isWeb = width >= 700;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: isWeb ? _webGrid(context) : _mobileList(context),
    );
  }

  // 📱 Mobile layout
  Widget _mobileList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final cat = categories[index];
        return _categoryItem(context, cat, height: 200);
      },
    );
  }

  // 🖥 Web layout
  Widget _webGrid(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 16 / 9,
          ),
          itemBuilder: (context, index) {
            final cat = categories[index];
            return _categoryItem(context, cat, height: 220);
          },
        ),
      ),
    );
  }

  Widget _categoryItem(
    BuildContext context,
    Map<String, String> cat, {
    required double height,
  }) {
    final label = cat['label'];
    final image = cat['image'];

    if (label == null || image == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryWallpapers(category: label),
          ),
        );
      },
      child: _buildCategoryContainer(context, image, label, height),
    );
  }
}

Widget _buildCategoryContainer(
  BuildContext context,
  String imagePath,
  String label,
  double height,
) {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width >= 700 ? 0 : 20,
    ),
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Container(
            color: Colors.black38,
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
