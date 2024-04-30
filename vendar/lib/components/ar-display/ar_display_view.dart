import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class ARDisplay extends StatefulWidget {
  const ARDisplay({super.key});
  @override
  ARDisplayState createState() => ARDisplayState();
}

class ARDisplayState extends State<ARDisplay> {
  ArCoreController? arCoreController;
  ArCoreReferenceNode? modelNode;
  Vector3? lastPosition = Vector3.zero();
  Vector4? lastRotation = Vector4.zero();

  String? objectSelected;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AR Display Mode'),
        ),
        body: GestureDetector(
          onPanUpdate: (details) {
            if (modelNode != null) {
              modelNode?.position?.value += Vector3(
                details.delta.dx / 100,
                details.delta.dy / 100,
                0,
              );
            }
          },
          onPanEnd: (_) {
            if (modelNode != null) {
              lastPosition = modelNode?.position?.value;
            }

          },

          onScaleUpdate: (details) {
            if (modelNode != null) {
              modelNode?.rotation?.value = lastRotation! + Vector4(0, details.rotation, 0, 0);
            }
          },

          child: ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
          ),
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController?.onNodeTap = (name) => onTapHandler(name);
    arCoreController?.onPlaneTap = _handleOnPlaneTap;
  }

  void _addNode(ArCoreHitTestResult plane) {

    if (modelNode != null) {
      arCoreController?.removeNode(nodeName: "Model");
    }

    modelNode = ArCoreReferenceNode(
        name: "Model",
        objectUrl:
            "https://raw.githubusercontent.com/vendAR-project/vendAR/main/vendar/models/Barrel/Barrel.glb",
        position: plane.pose.translation,
        rotation: plane.pose.rotation);

    arCoreController?.addArCoreNodeWithAnchor(modelNode as ArCoreNode);
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addNode(hit);
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: const Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController?.removeNode(nodeName: name);
                  modelNode = null;
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
