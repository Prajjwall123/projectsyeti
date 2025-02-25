import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/app/widgets/my_card.dart';
import 'package:projectsyeti/app/widgets/my_tag.dart';
import 'package:projectsyeti/app/widgets/my_voucher.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchProjects();
    context.read<HomeCubit>().fetchSkills();
    context.read<HomeCubit>().fetchFreelancerProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            } else {
              return SingleChildScrollView(
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
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
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: state
                                              .freelancer?.profileImage !=
                                          null
                                      ? NetworkImage(
                                          'http://192.168.1.70:3000/${state.freelancer!.profileImage}')
                                      : const AssetImage(
                                              'assets/images/default_avatar.png')
                                          as ImageProvider,
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
                                    backgroundColor:
                                        Color.fromARGB(255, 77, 173, 45),
                                  ),
                                  VoucherCard(
                                    title: 'Referral Awards',
                                    description:
                                        'Invite a colleague and get Rs. 500 in credit',
                                    backgroundColor:
                                        Color.fromARGB(255, 92, 103, 178),
                                  ),
                                  VoucherCard(
                                    title: 'Optimize Your Profile',
                                    description:
                                        'Become more attractive to potential clients',
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
                                children: state.skills.map((skill) {
                                  return MyTag(
                                    skill: skill,
                                    backgroundColor: const Color(0xFF001F3F),
                                    textColor: Colors.white,
                                    borderColor: Colors.white,
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: state.projects
                            .map(
                              (project) => Column(
                                children: [
                                  MyCard(project: project),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
