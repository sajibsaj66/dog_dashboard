import 'package:dog_dashboard/features/dog_dashboard/data/dog_repository.dart';
import 'package:dog_dashboard/features/dog_dashboard/domain/entities/breed.dart';
import 'package:dog_dashboard/features/dog_dashboard/presentation/widgets/breed_filters.dart';
import 'package:dog_dashboard/features/dog_dashboard/presentation/widgets/image_list.dart';
import 'package:flutter/material.dart';

class DogDashboardPage extends StatefulWidget {
  @override
  _DogDashboardPageState createState() => _DogDashboardPageState();
}

class _DogDashboardPageState extends State<DogDashboardPage> {
  final DogRepository dogRepository = DogRepository();
  String selectedOption = 'Random image by breed';
  String selectedBreed = '';
  String selectedSubBreed = '';
  List<String> images = [];
  List<Breed> breeds = [];
  bool isLoading = true;
  bool isLoadingImg = true;

  @override
  void initState() {
    super.initState();
    fetchBreeds();
  }

  Future<void> fetchBreeds() async {
    try {
      breeds.clear();
      final fetchedBreeds = await dogRepository.fetchBreeds();
      setState(() {
        breeds = fetchedBreeds;
        isLoading = false;
        isLoadingImg = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        isLoading = false;
        isLoadingImg = false;
      });
    }
  }

  void handleOptionSelected(String? option) {
    setState(() {
      selectedOption = option!;
    });
  }

  void handleBreedSelected(String? breed) {
    setState(() {
      selectedBreed = breed!;
    });
  }

  void handleSubBreedSelected(String? subBreed) {
    setState(() {
      selectedSubBreed = subBreed!;
    });
  }

  void showResults() async {
    setState(() {
      isLoadingImg = true;
    });
    // Implement logic to show results based on selected options
    List<String> newImages = [];

    if (selectedOption == 'Random image by breed') {
      if (selectedBreed.isNotEmpty) {
        newImages = await dogRepository.fetchRandomImageByBreed(selectedBreed);
        print(newImages.length);
      } else {
        showSnackBar('Incomplete Info');
      }
    } else if (selectedOption == 'Images list by breed') {
      if (selectedBreed.isNotEmpty) {
        newImages = await dogRepository.fetchImageListByBreed(selectedBreed);
        print(newImages.length);
      } else {
        showSnackBar('Incomplete Info');
      }
    } else if (selectedOption == 'Random image by breed and sub breed') {
      if (selectedBreed.isNotEmpty && selectedSubBreed.isNotEmpty) {
        newImages = await dogRepository.fetchRandomImageByBreedAndSubBreed(
            selectedBreed, selectedSubBreed);
        print(newImages.length);
      } else {
        showSnackBar('Incomplete Info');
      }
    } else if (selectedOption == 'Images list by breed and sub breed') {
      if (selectedBreed.isNotEmpty && selectedSubBreed.isNotEmpty) {
        newImages = await dogRepository.fetchImageListByBreedAndSubBreed(
            selectedBreed, selectedSubBreed);
        print(newImages.length);
      } else {
        showSnackBar('Incomplete Info');
      }
    }

    setState(() {
      isLoadingImg = false;
      images.clear();
      images = newImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dog Dashboard'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : breeds.isNotEmpty
              ? Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 1.2,
                      child: BreedFilters(
                        onOptionSelected: handleOptionSelected,
                        onBreedSelected: handleBreedSelected,
                        onSubBreedSelected: handleSubBreedSelected,
                        breeds: breeds,
                        selectedBreed: selectedBreed.isNotEmpty
                            ? selectedBreed
                            : breeds.isNotEmpty
                                ? breeds[0].name
                                : null,
                        selectedSubBreed: selectedSubBreed.isNotEmpty
                            ? selectedSubBreed
                            : breeds.isNotEmpty &&
                                    breeds[0].subBreeds.isNotEmpty
                                ? breeds[0].subBreeds.first
                                : null,
                        selectedOption: selectedOption,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: showResults,
                      child: Text('Show Results'),
                    ),
                    if (isLoadingImg)
                      CircularProgressIndicator()
                    else if (images.isNotEmpty)
                      Expanded(
                        child: ImageList(
                          images: images,
                          title: selectedOption,
                        ),
                      ),
                  ],
                )
              : Center(
                  child: Text('No breeds available.'),
                ),
    );
  }

  showSnackBar(String msg) {
    isLoadingImg = false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
