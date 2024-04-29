class CustomModelController {
  void addModel(Map<String, dynamic> formData, List<dynamic>? pickedFiles,
      dynamic pickedGlbFile) {
    print('Form Data:');
    formData.forEach((key, value) {
      print('$key: $value');
    });

    print('Picked Images:');
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (var file in pickedFiles) {
        print('File name: ${file.name}');
      }
    } else {
      print('No images selected.');
    }

    if (pickedGlbFile != null) {
      print('Picked GLB File: ${pickedGlbFile.name}');
    } else {
      print('No GLB file selected.');
    }
  }
}
