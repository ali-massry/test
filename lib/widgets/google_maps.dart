import 'package:capef/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;

class BuildMapDisplay extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Set<Marker> markers;
  final Function(LatLng) ontap;

  const BuildMapDisplay({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.markers,
    required this.ontap,
  }) : super(key: key);

  @override
  State<BuildMapDisplay> createState() => _BuildMapDisplayState();
}

class _BuildMapDisplayState extends State<BuildMapDisplay> {
  late String _mapStyle;
  // ignore: unused_field
  late GoogleMapController _googleMapController;
  BitmapDescriptor? markerIcon;

  void addCustomIcon() async {
    final originalImage = img.decodeImage(await rootBundle
        .load('assets/images/car.png')
        .then((bytes) => bytes.buffer.asUint8List()));
    final resizedImage = img.copyResize(
      originalImage!,
      width: 50,
      height: 80,
    ); // Adjust the width and height as needed

    final byteData = Uint8List.fromList(img.encodePng(resizedImage));

    setState(() {
      markerIcon = BitmapDescriptor.fromBytes(byteData);
    });
  }
  

  @override
  void initState() {
    rootBundle.loadString('assets/mapstyle/map_style.txt').then((mapStyle) {
      _mapStyle = mapStyle;

      // context.read<GetAdsCubit>().getAds(hiveGet('token'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        target: LatLng(widget.latitude, widget.longitude), zoom: 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coordonnées GPS',
          style: GlobalTextStyles.ts12ls1montboldGreen,
        ),
        SizedBox(height: mqh(context, 3)),
        Container(
          width: double.infinity,
          height: mqh(context, 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GoogleMap(
                initialCameraPosition: initialLocation,
                // myLocationEnabled: false,
                // myLocationButtonEnabled: false,
                // zoomControlsEnabled: false,
                // buildingsEnabled: true,
                scrollGesturesEnabled: true,
                // ignore: prefer_collection_literals
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(
                      () => PanGestureRecognizer())),
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                buildingsEnabled: true,
                onMapCreated: (controller) {
                  _googleMapController = controller;
                  controller.setMapStyle(_mapStyle);
                },
                // zoomGesturesEnabled: true,
                // zoomControlsEnabled: true,
                onTap: widget.ontap,
                markers: widget.markers,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
