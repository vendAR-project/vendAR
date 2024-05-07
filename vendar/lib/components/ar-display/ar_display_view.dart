import 'package:ar_flutter_plugin_flutterflow/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin_flutterflow/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_flutterflow/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_node.dart';
import 'package:ar_flutter_plugin_flutterflow/models/ar_hittest_result.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:developer' as developer;

class ObjectsOnPlanesWidget extends StatefulWidget {
  final String url;

  ObjectsOnPlanesWidget({Key? key, required this.url}) : super(key: key);

  @override
  _ObjectsOnPlanesWidgetState createState() => _ObjectsOnPlanesWidgetState();
}

class _ObjectsOnPlanesWidgetState extends State<ObjectsOnPlanesWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];
  bool isLoading = false; // New variable to track loading state

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AR Display Mode"),
        ),
        body: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: isLoading ? null : onRemoveEverything, // Disable button when loading
                      child: Text("Remove Everything")),
                ]),
          ),
          if (isLoading) // Show loading indicator when an asset is loading
            Center(
              child: CircularProgressIndicator(),
            ),
        ]));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
      handlePans: true,
      handleRotation: true,
    );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = isLoading ? (_) {} : onPlaneOrPointTapped; // Prevent taps when loading
    this.arObjectManager!.onPanStart = onPanStarted;
    this.arObjectManager!.onPanChange = onPanChanged;
    this.arObjectManager!.onPanEnd = onPanEnded;
    this.arObjectManager!.onRotationStart = onRotationStarted;
    this.arObjectManager!.onRotationChange = onRotationChanged;
    this.arObjectManager!.onRotationEnd = onRotationEnded;
  }

  Future<void> onRemoveEverything() async {
    setState(() {
      isLoading = true;
    });
    anchors.forEach((anchor) {
      arAnchorManager!.removeAnchor(anchor);
    });
    anchors = [];
    nodes = [];

    setState(() {
      isLoading = false;
      arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    });
  }

  Future<void> onPlaneOrPointTapped(List<ARHitTestResult> hitTestResults) async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor = ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor!) {
        anchors.add(newAnchor);

        var newNode = ARNode(
          type: NodeType.webGLB,
          uri: widget.url,
          scale: Vector3(1, 1, 1),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0),
        );
        bool? didAddNodeToAnchor = await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor!) {
          nodes.add(newNode);
          arSessionManager!.onPlaneOrPointTap = (_) {};
        } else {
          arSessionManager!.onError!("Adding Node to Anchor failed");
        }
      } else {
        arSessionManager!.onError!("Adding Anchor failed");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  onPanStarted(String nodeName) {
    developer.log('Started panning node $nodeName');
  }

  onPanChanged(String nodeName) {
    developer.log('Continued panning node $nodeName');
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    developer.log('Ended panning $nodeName');
    final pannedNode = nodes.firstWhere((element) => element.name == nodeName);
    pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    developer.log('Started rotating node $nodeName');
  }

  onRotationChanged(String nodeName) {
    developer.log('Continued rotating node $nodeName');
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    developer.log('Ended rotating $nodeName');
    final rotatedNode = nodes.firstWhere((element) => element.name == nodeName);
    rotatedNode.transform = newTransform;
  }
}
