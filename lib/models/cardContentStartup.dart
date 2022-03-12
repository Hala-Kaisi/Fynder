import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class cardContentStartup extends StatefulWidget {
  cardContentStartup({
    required this.name,
    required this.asset,
    required this.description,
    required this.websiteLink,
    required this.videoLink,
    required this.location,
    required this.investmentType,
    required this.marketSegment,
    required this.targetFunds
  });

  final String name;
  var asset;
  final String description;
  final String websiteLink;
  final String videoLink;
  final String location;
  final String investmentType;
  final String marketSegment;
  final String targetFunds;

  String getName(){
    return name;
  }


  @override
  _CardContent createState() => _CardContent();
}

class _CardContent extends State<cardContentStartup> {

  late String _name;
  late var _asset;
  late String _description;
  late String _websiteLink;
  late String _videoLink;
  late String _location;
  late String _investmentType;
  late String _marketSegment;
  late String _targetFunds;

  @override
  void initState() {
    _name = widget.name;
    _asset = widget.asset.toString();
    _description = widget.description;
    _websiteLink = widget.websiteLink;
    _videoLink = widget.videoLink;
    _location = widget.location;
    _investmentType = widget.investmentType;
    _marketSegment = widget.marketSegment;
    _targetFunds = widget.targetFunds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
              //crossAxisAlignment: CrossAxisAlignment.start,
                Container(
                  //padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    _name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget infoSection = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumn(color, Icons.location_on_sharp, _location),
        _buildColumn(color, Icons.money, _investmentType),
        _buildColumn(color, Icons.business, _marketSegment),
      ],
    );
    Widget infoSection2 = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumn(color, Icons.attach_money, _targetFunds),
        _buildButtonColumn(color, Icons.videocam, 'Personal Video', _websiteLink),
        _buildButtonColumn(color, Icons.web, 'Website', _videoLink),
      ],
    );
    Widget textSection = SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Text(
            _description,
            softWrap: true,
          ),
        ),
    );

    return
        Card(
          shadowColor: Colors.black,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child:ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                child: Image.network('$_asset'),
                width: 380,
                height: 100,
              ),
              titleSection,
              SizedBox(height: 5),
              infoSection,
              SizedBox(height: 20),
              infoSection2,
              SizedBox(height: 10),
              textSection,
            ],
          ),
        );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label, String link) {
    return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: (){openLink(link);},
                icon: Icon(icon, color: color)
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ],
          );
  }

  openLink(String link) async {
    if (await canLaunch(link)) {
    await launch(link);
    } else {
    throw 'Unable to open link.';
    }
  }

  Column _buildColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}