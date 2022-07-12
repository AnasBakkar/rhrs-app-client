import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhrs_app/providers/facilities.dart';
import 'package:rhrs_app/widgets/facility_item2.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedFacilities = Provider.of<Facilities>(context, listen: false);
    return FutureBuilder(
        future: Provider.of<Facilities>(context, listen: false)
            .fetchSavedFacilities(),
        builder: ((ctx, resultSnapShot) =>
            resultSnapShot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (context, index) =>
                        FacilityItem2(savedFacilities.savedFacilities[index]),
                    itemCount: savedFacilities.savedFacilities.length,
                  )));
  }
}
