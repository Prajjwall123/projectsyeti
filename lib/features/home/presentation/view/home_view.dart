import 'package:flutter/material.dart';
import 'package:projectsyeti/app/widgets/my_card.dart';
import 'package:projectsyeti/app/widgets/my_tag.dart';
import 'package:projectsyeti/app/widgets/my_voucher.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/round_login.png',
                            height: 40,
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.search, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search Projects',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 30,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            VoucherCard(
                              title: 'Become A Premium Member',
                              description:
                                  'Find better freelancing opportunities',
                              backgroundColor: Color.fromARGB(255, 77, 173, 45),
                            ),
                            VoucherCard(
                              title: 'Referral Awards',
                              description:
                                  'Invite a collegue and get Rs. 500 in credit',
                              backgroundColor:
                                  Color.fromARGB(255, 92, 103, 178),
                            ),
                            VoucherCard(
                              title: 'Optimize Your Profile',
                              description:
                                  'Become more attractive to potential',
                              backgroundColor: Colors.purpleAccent,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Explore Projects',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            MyTag(
                              text: 'Mobile Application',
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'Web Development',
                              backgroundColor: Colors.white,
                              textColor: Colors.blue,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'UI Design',
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'Graphics Design',
                              backgroundColor: Colors.white,
                              textColor: Colors.blue,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'Data Science',
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'Cloud Computing',
                              backgroundColor: Colors.white,
                              textColor: Colors.blue,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'Machine Learning',
                              backgroundColor: Colors.blue,
                              textColor: Colors.white,
                              borderColor: Colors.blue,
                            ),
                            MyTag(
                              text: 'Photography',
                              backgroundColor: Colors.white,
                              textColor: Colors.blue,
                              borderColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Column(
                  children: [
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                    MyCard(),
                    SizedBox(height: 10),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
