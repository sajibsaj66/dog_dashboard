import 'package:dog_dashboard/core/network/api.dart';
import 'package:dog_dashboard/features/dog_dashboard/domain/entities/breed.dart';

class DogRepository {
  final Api api = Api(); // Create an instance of the Api class

  // Fetch a list of dog breeds from the API
  Future<List<Breed>> fetchBreeds() async {
    final response = await api.get("breeds/list/all");

    if (response['status'] == "success") {
      final Map<String, dynamic> message = Map<String, dynamic>.from(response['message']);

      List<Breed> breeds = [];
      message.forEach((breed, subBreeds) {
        if (subBreeds is List<dynamic>) {
          breeds.add(Breed(name: breed, subBreeds: subBreeds.cast<String>()));
        } else {
          breeds.add(Breed(name: breed, subBreeds: []));
        }
      });

      return breeds;
    } else {
      throw Exception('Failed to load breeds');
    }
  }

  // Fetch a random image by breed
  Future<List<String>> fetchRandomImageByBreed(String breed) async {
    final response = await api.get("breed/$breed/images/random");

    if (response['status'] == "success") {
      if (response['message'] is String) {
        // If 'message' is a single string, wrap it in a list
        return [response['message']];
      } else if (response['message'] is List) {
        // If 'message' is already a list, cast it to a list of strings
        return List<String>.from(response['message']);
      } else {
        throw Exception('Invalid format for images in the response');
      }
    } else {
      throw Exception('Failed to load images by breed');
    }
  }

  // Fetch a list of images by breed
  Future<List<String>> fetchImageListByBreed(String breed) async {
    final response = await api.get("breed/$breed/images");

    if (response['status'] == "success") {
      List<String> images = List<String>.from(response['message']);
      return images;
    } else {
      throw Exception('Failed to load images by breed');
    }
  }

  // Fetch a random image by breed and sub-breed
  Future<List<String>> fetchRandomImageByBreedAndSubBreed(String breed, String subBreed) async {
    final response = await api.get("breed/$breed/$subBreed/images/random");

    if (response['status'] == "success") {
      if (response['message'] is String) {
        // If 'message' is a single string, wrap it in a list
        return [response['message']];
      } else if (response['message'] is List) {
        // If 'message' is already a list, cast it to a list of strings
        return List<String>.from(response['message']);
      } else {
        throw Exception('Invalid format for images in the response');
      }
    } else {
      throw Exception('Failed to load images by breed');
    }
  }

  // Fetch a list of images by breed and sub-breed
  Future<List<String>> fetchImageListByBreedAndSubBreed(String breed, String subBreed) async {
    final response = await api.get("breed/$breed/$subBreed/images");

    if (response['status'] == "success") {
      List<String> images = List<String>.from(response['message']);
      return images;
    } else {
      throw Exception('Failed to load images by breed and sub-breed');
    }
  }
}
