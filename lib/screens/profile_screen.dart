import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhrs_app/models/profile.dart';
import '../widgets/profile_item_card.dart';
import '../widgets/profile_stack_container.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context).myProfile;
    return Scaffold(
      body: FutureBuilder(
        future: profile.fetchProfileInfo(),
        builder: ((ctx, resultSnapShot) =>
            resultSnapShot.connectionState == ConnectionState.waiting
                ? Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        StackContainer(
                          userName: profile.userName,
                          userImage: profile.profilePhoto,
                        ),
                        ListView(
                          children: [
                            CardItem(
                                icon: Icons.email,
                                fieldName: 'Email',
                                fieldValue: profile.email),
                            CardItem(
                                icon: Icons.person,
                                fieldName: 'Name',
                                fieldValue: profile.userName),
                            CardItem(
                              icon: Icons.phone,
                              fieldName: 'PhoneNumber',
                              fieldValue: '+963937925594',
                            ),
                            CardItem(
                              icon: Icons.person_outline,
                              fieldName: 'Gender',
                              fieldValue: 'male',
                            ),
                            CardItem(
                              icon: Icons.hourglass_bottom,
                              fieldName: 'Age',
                              fieldValue: '21',
                            ),
                          ],
                          //CardItem(),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )
                      ],
                    ),
                  )),
      ),
    );
  }
}
