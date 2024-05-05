import 'package:vendar/model/template.dart';

class SelectTemplateController {
  final List<Template> templates = const [
    Template(
        name: 'Computer',
        modelSrc:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Duck/glTF-Binary/Duck.glb',
        imageSrc:
            'https://thumbs.dreamstime.com/b/desktop-computer-2240018.jpg'),
    Template(
        name: 'Table ',
        modelSrc:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Duck/glTF-Binary/Duck.glb',
        imageSrc:
            'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGYtczYyLXBvbS0wNzM5LXRlZGR5LWpvZHMucG5n.png'),
    Template(
        name: 'Bed',
        modelSrc:
            'https://github.com/KhronosGroup/glTF-Sample-Models/raw/main/2.0/Duck/glTF-Binary/Duck.glb',
        imageSrc: 'https://pngimg.com/uploads/bed/bed_PNG17404.png'),
  ];

  List<Template> getFilteredTemplates(String query) {
    if (query.isEmpty) {
      return templates;
    } else {
      return templates.where((template) {
        return template.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
