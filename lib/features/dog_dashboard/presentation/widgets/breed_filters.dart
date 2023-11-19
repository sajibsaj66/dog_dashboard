import 'package:dog_dashboard/features/dog_dashboard/domain/entities/breed.dart';
import 'package:flutter/material.dart';

class BreedFilters extends StatelessWidget {
  final void Function(String?)? onOptionSelected;
  final void Function(String?)? onBreedSelected;
  final void Function(String?)? onSubBreedSelected;
  final List<Breed> breeds;
  final String? selectedBreed;
  final String? selectedSubBreed;
  final String? selectedOption;

  BreedFilters({
    required this.onOptionSelected,
    required this.onBreedSelected,
    required this.onSubBreedSelected,
    required this.breeds,
    this.selectedBreed,
    this.selectedSubBreed,
    this.selectedOption,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedOption,
              onChanged: onOptionSelected,
              items: <String>[
                'Random image by breed',
                'Images list by breed',
                'Random image by breed and sub breed',
                'Images list by breed and sub breed',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              hint: Text('Select Breed'),
              onChanged: onBreedSelected,
              value: selectedBreed,
              items: breeds.map<DropdownMenuItem<String>>((Breed breed) {
                return DropdownMenuItem<String>(
                  key: ValueKey<String>(breed.name),
                  value: breed.name,
                  child: Text(breed.name),
                );
              }).toList(),
            ),

            if (onSubBreedSelected != null && selectedBreed != null && breeds.isNotEmpty)
              DropdownButton<String>(
                hint: Text('Select Sub Breed'),
                onChanged: onSubBreedSelected,
                value: selectedSubBreed,
                items: (breeds
                    .firstWhere((element) => element.name == selectedBreed)
                    .subBreeds ??
                    [])
                    .map<DropdownMenuItem<String>>((String subBreed) {
                  return DropdownMenuItem<String>(
                    value: subBreed,
                    child: Text(subBreed),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
