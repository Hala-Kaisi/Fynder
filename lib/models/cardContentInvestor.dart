import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class cardContentInvestor extends StatefulWidget {
  const cardContentInvestor({
    required this.name,
    required this.asset,
    required this.description,
    required this.websiteLink,
    required this.videoLink,
    required this.location,
  });

  final String name;
  final String asset;
  final String description;
  final String websiteLink;
  final String videoLink;
  final String location;

  String getName(){
    return name;
  }

  @override
  _CardContent createState() => _CardContent();
}

class _CardContent extends State<cardContentInvestor> {

  late String _name;
  late String _asset;
  late String _description;
  late String _websiteLink;
  late String _videoLink;
  late String _location;

  @override
  void initState() {
    _name = widget.name;
    _asset = widget.asset.toString();
    _description = widget.description;
    _websiteLink = widget.websiteLink;
    _videoLink = widget.videoLink;
    _location = widget.location;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '$_name',
              style: TextStyle(
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
        _buildColumn(color, Icons.location_on_sharp, '$_location'),
        _buildButtonColumn(color, Icons.videocam, 'Personal Video', _websiteLink),
        _buildButtonColumn(color, Icons.web, 'Website', _videoLink),
      ],
    );

    Widget textSection = SizedBox (
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          '$_description',
          softWrap: true,
        ),
      ),
    );

    return  Card(
        shadowColor: Colors.black,
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child:ListView(
          shrinkWrap: true,
        children: [
          /*Image(
            image: NetworkImage('http://$_asset'),
            width: 380,
            height: 100,
            fit: BoxFit.fitWidth,
          ),*/
          titleSection,
          SizedBox(height: 5),
          infoSection,
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