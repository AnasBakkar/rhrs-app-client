import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhrs_app/providers/facilities.dart';
import 'package:rhrs_app/screens/search_screen.dart';
import 'package:rhrs_app/widgets/facility_item2.dart';
import '../constants.dart';
import '../widgets/travel_card.dart';
import 'package:rhrs_app/models/facility.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //here i'm going to add a list of image url that I collected from the internet
  //you can use the image that you want, just copy and paste their Urls here inside the list
  List<String> urls = [
    "https://resofrance.eu/wp-content/uploads/2018/09/hotel-luxe-mandarin-oriental-paris.jpg",
    "https://lh3.googleusercontent.com/proxy/wTkD1USQGpbVXzZFNLCZBDCL1OQS1bFzSgPa44cHwiheaY9DpoqMdNjBgEJcCIZSQeSkCO-2q5gfuhtnuz4cDhtpansOcWos093YsGvogdQqWnpWlA",
    "https://images.squarespace-cdn.com/content/v1/57d5245815d5db80eadeef3b/1558864684068-1CX3SZ0SFYZA1DFJSCYD/ke17ZwdGBToddI8pDm48kIpXjvpiLxnd0TWe793Q1fcUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKcZwk0euuUA52dtKj-h3u7rSTnusqQy-ueHttlzqk_avnQ5Fuy2HU38XIezBtUAeHK/Marataba+Safari+lodge",
    "https://lh3.googleusercontent.com/proxy/ovCSxeucYYoir_rZdSYq8FfCHPeot49lbYqlk7nXs7sXjqAfbZ2uw_1E9iivLT85LwIZiGSnXuqkdbQ_xKFhd91M7Y05G94d",
    "https://q-xx.bstatic.com/xdata/images/hotel/max500/216968639.jpg?k=a65c7ca7141416ffec244cbc1175bf3bae188d1b4919d5fb294fab5ec8ee2fd2&o=",
    "https://hubinstitute.com/sites/default/files/styles/1200x500_crop/public/2018-06/photo-1439130490301-25e322d88054.jpeg?h=f720410d&itok=HI5-oD_g",
    "https://cdn.contexttravel.com/image/upload/c_fill,q_60,w_2600/v1549318570/production/city/hero_image_2_1549318566.jpg",
    "https://www.shieldsgazette.com/images-i.jpimedia.uk/imagefetch/https://jpgreatcontent.co.uk/wp-content/uploads/2020/04/spain.jpg",
    "https://www.telegraph.co.uk/content/dam/Travel/2017/November/tunisia-sidi-bou-GettyImages-575664325.jpg",
    "https://lp-cms-production.imgix.net/features/2018/06/byrsa-hill-carthage-tunis-tunisia-2d96efe7b9bf.jpg"
  ];

  //sometime we can face some http request erreur if the owner of the picture delted it or the url is not available
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Let's start by adding the text
          Text(
            "Welcome to Bookify",
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Pick your destination",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          //Now let's add some elevation to our text field
          //to do this we need to wrap it in a Material widget
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchScreen.routeName);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'search for Hostels, Resorts...',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          /*Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Color(0x55434343),
                child: TextField(
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Search for Hotel, Flight...",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),*/
          SizedBox(height: 30.0),
          //Now let's Add a Tabulation bar
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      //Color(0xFFFE8C68),
                      unselectedLabelColor: Color(0xFF555555),
                      labelColor: Theme.of(context).primaryColor,
                      //Color(0xFFFE8C68),
                      labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      tabs: [
                        Tab(
                          text: "Resorts",
                        ),
                        Tab(
                          text: "Hostels",
                        ),
                        Tab(
                          text: "Chalets",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 300.0,
                      child: TabBarView(
                        children: [
                          //Now let's create our first tab page
                          Container(
                            child: FutureBuilder(
                                future: Provider.of<Facilities>(context,
                                        listen: false)
                                    .fetchTop5('farmer'),
                                builder: ((ctx, resultSnapShot) =>
                                    resultSnapShot.connectionState ==
                                            ConnectionState.waiting
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : Consumer<Facilities>(
                                            builder: (ctx, fetchedFacilities,
                                                    child) =>
                                                ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return travelCard(
                                                      /*localApi +*/
                                                      fetchedFacilities
                                                          .top5Resort[index]
                                                          .facilityImages[0]
                                                          .photoPath,
                                                      fetchedFacilities
                                                          .top5Resort[index]
                                                          .name,
                                                      fetchedFacilities
                                                          .top5Resort[index]
                                                          .location,
                                                      fetchedFacilities
                                                          .top5Resort[index]
                                                          .rate,
                                                      fetchedFacilities
                                                          .top5Resort[index]
                                                          .id,
                                                      context
                                                    );
                                                  },
                                                  itemCount: fetchedFacilities
                                                      .top5Resort.length,
                                                )))),
                          ),
                          Container(
                            child: FutureBuilder(
                              future: Provider.of<Facilities>(context,
                                      listen: false)
                                  .fetchTop5('hostel'),
                              builder: ((ctx, resultSnapShot) => resultSnapShot
                                          .connectionState ==
                                      ConnectionState.waiting
                                  ? Center(child: CircularProgressIndicator())
                                  : Consumer<Facilities>(
                                      builder:
                                          (ctx, fetchedFacilities, child) =>
                                              ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return travelCard(
                                            /*localApi +*/
                                            fetchedFacilities.top5Hostels[index]
                                                .facilityImages[0].photoPath,
                                            fetchedFacilities
                                                .top5Hostels[index].name,
                                            fetchedFacilities
                                                .top5Hostels[index].location,
                                            fetchedFacilities
                                                .top5Hostels[index].rate,
                                            fetchedFacilities
                                                .top5Hostels[index].id,
                                            context
                                          );
                                        },
                                        itemCount: fetchedFacilities
                                            .top5Hostels.length,
                                      ),
                                    )),
                            ),
                            /*ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                //Here you can add what ever you want
                                travelCard(urls[6], "Visit Rome", "Italy", 4),
                                travelCard(urls[8], "Visit Sidi bou Said",
                                    "Tunsia", 4),
                              ],
                            ),*/
                          ),
                          Container(
                            child: FutureBuilder(
                              future: Provider.of<Facilities>(context,
                                      listen: false)
                                  .fetchTop5('chalet'),
                              builder: ((ctx, resultSnapShot) => resultSnapShot
                                          .connectionState ==
                                      ConnectionState.waiting
                                  ? Center(child: CircularProgressIndicator())
                                  : Consumer<Facilities>(
                                      builder:
                                          (ctx, fetchedFacilities, child) =>
                                              ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return travelCard(
                                            /*localApi +*/
                                            fetchedFacilities.top5Chalet[index]
                                                .facilityImages[0].photoPath,
                                            fetchedFacilities
                                                .top5Chalet[index].name,
                                            fetchedFacilities
                                                .top5Chalet[index].location,
                                            fetchedFacilities
                                                .top5Chalet[index].rate,
                                            fetchedFacilities
                                                .top5Chalet[index].id,
                                            context
                                          );
                                        },
                                        itemCount:
                                            fetchedFacilities.top5Chalet.length,
                                      ),
                                    )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
