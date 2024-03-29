import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NGOHelpScreen extends StatelessWidget {
  const NGOHelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Help'),
          backgroundColor: Get.theme.colorScheme.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Authentication ',
    <Entry>[
      Entry(
        'In order to use the application, the user needs to create his/her account in the app. On registration form for security purpose whenever we register for first time you need to fill OTP i.e One Time Password which is autogenerated if you have same number sim with you otherwise you need to fill manually within 2 min . You can resend it if time limit ends from Bottom Resend option. You need to go through same  process for both Donor and NGO side. Both restaurant and users who have the food must register using registration form. During registration, some information about the users is saved to the real-time database such as address, name and gender under the unique user id. So, each user profile information is saved into the database and next time user can directly jump to there profile and edit the information. ',
      ),
    ],
  ),
  Entry('About donations', <Entry>[
    Entry(
      'On the dashboard, you will be able to see the available donations, on getting details of that donation, you can confirm the donation and get the location of the particular donation also you can accept another donation and decline the accepted donation.',
    ),
  ]),
  Entry('Map', <Entry>[
    Entry(
      'Once you confirm the donation then you can get the location of particular donation by clicking on get location button, firstly you have to enable the permission and then you can get the desired location.',
    ),
  ]),
  Entry('History', <Entry>[
    Entry(
      'Once you donate your food and it is completed successfully then it will be shown on your dashboard as well as History tab so you can hold your history.',
    ),
  ]),
  Entry('List of suppliers', <Entry>[
    Entry(
      'On Supplier tab you will be showing all list of Suppliers who are restaurant owner registered in the application. On tapping on more button, you will be able to see the details of the particular Supplier.',
    ),
  ]),
  Entry('Profile', <Entry>[
    Entry(
      'On the profile tab, you will be able to see your profile, if you wish you can update your profile.',
    ),
  ]),
];

class EntryItem extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
