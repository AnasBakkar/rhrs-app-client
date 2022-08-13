import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhrs_app/providers/bookings.dart';
import 'package:rhrs_app/widgets/booking_item.dart';

class BookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Bookings>(context, listen: false).fetchMyBookings(),
        builder: ((ctx, resultSnapShot) =>
            resultSnapShot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator() /*spinKit*/)
                : Consumer<Bookings>(
                    builder: (ctx, fetchedBookings, child) => ListView.builder(
                      itemBuilder: (context, index) {
                        return BookingCard(fetchedBookings.bookings[index]);
                      },
                      itemCount: fetchedBookings.bookings.length,
                    ),
                  )),
      );
  }
}
