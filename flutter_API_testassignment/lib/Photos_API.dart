import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosAPI extends StatefulWidget {
  const PhotosAPI({super.key});

  @override
  State<PhotosAPI> createState() => _PhotosAPIState();
}

class _PhotosAPIState extends State<PhotosAPI> {
  List photos = [];

  Future fetchPhotos() async {
    final response = await http.get(
      Uri.parse("https://picsum.photos/v2/list"),
    );

    if (response.statusCode == 200) {
      setState(() {
        photos = jsonDecode(response.body);
      });
    } else {
      throw Exception("Failed to load photos");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Photo Gallery"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: photos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: photos.length > 30 ? 30 : photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            final imageUrl = photo['download_url'] ?? '';
            final author = photo['author'] ?? 'Unknown';

            return Card(
              color: Colors.grey[900],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image,
                            size: 50, color: Colors.grey),
                      )
                          : const Icon(Icons.image_not_supported,
                          size: 50, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      author,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
