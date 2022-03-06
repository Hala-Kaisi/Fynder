import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class cardContentStartup extends StatefulWidget {
  const cardContentStartup({
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
  final String asset;
  final String description;
  final String websiteLink;
  final String videoLink;
  final String location;
  final String investmentType;
  final String marketSegment;
  final String targetFunds;

  @override
  _CardContent createState() => _CardContent();
}

class _CardContent extends State<cardContentStartup> {

  late String _name;
  late String _asset;
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
    _asset = widget.asset;
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
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
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
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget infoSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumn(color, Icons.location_on_sharp, '$_location'),
        _buildColumn(color, Image.asset('investmentType.png') as IconData, '$_investmentType'),
        _buildColumn(color, Icons.business, '$_marketSegment'),
      ],
    );
    Widget infoSection2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildColumn(color, Icons.attach_money, '$_targetFunds'),
        _buildButtonColumn(color, Icons.videocam, 'Personal Video', _videoLink),
        _buildButtonColumn(color, Image.asset('website.png') as IconData, 'Website', _websiteLink),
      ],
    );

    Widget textSection = Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        '$_description',
        softWrap: true,
      ),
    );

    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            Image(
              image: NetworkImage(_asset),
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            infoSection,
            infoSection2,
            textSection,
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildButtonColumn(Color color, IconData icon, String label, String link) {
    return
      ElevatedButton(
          onPressed: openLink(link),
          child: Column(
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
          ),
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