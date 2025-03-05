import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectsyeti/features/project/domain/entity/project_entity.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:projectsyeti/app/widgets/my_card.dart';
import 'package:projectsyeti/app/widgets/my_tag.dart';
import 'package:projectsyeti/core/app_theme/theme_provider.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_cubit.dart';
import 'package:projectsyeti/features/home/presentation/view_model/home_state.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<StreamSubscription<dynamic>> _streamSubscriptions = [];
  bool _isLoggingOut = false;
  bool _isNear = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchProjects();
    context.read<HomeCubit>().fetchSkills();
    context.read<HomeCubit>().fetchFreelancerProfile();

    _listenToAccelerometer();
    _listenToProximitySensor();

    // Listen to changes in the search bar to trigger rebuilds
    _searchController.addListener(() {
      setState(() {}); // Rebuild the UI when the search query changes
    });
  }

  /// **🔹 Shake to Logout**
  void _listenToAccelerometer() {
    const double shakeThreshold = 15.0;
    _streamSubscriptions.add(
      accelerometerEventStream().listen((event) {
        double acceleration =
            sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
        if (acceleration > shakeThreshold) {
          _handleShakeLogout();
        }
      }),
    );
  }

  void _handleShakeLogout() {
    if (!_isLoggingOut) {
      _isLoggingOut = true;
      context.read<HomeCubit>().logout(context);
    }
  }

  void _listenToProximitySensor() {
    _streamSubscriptions.add(
      ProximitySensor.events.listen(
        (int event) {
          setState(() {
            _isNear = event == 1;
            if (_isNear) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            }
          });
        },
        onError: (e) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text("Sensor Not Found"),
                content:
                    Text("Your device may not support a proximity sensor."),
              );
            },
          );
        },
        cancelOnError: true,
      ),
    );
  }

  @override
  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                      /// **🔹 Search & Profile Row**
                      _buildSearchBar(state),

                      /// **🔹 Info Cards (Promotions)**
                      const SizedBox(height: 20),
                      _buildPromoCards(
                          context), // Pass context for responsive sizing

                      /// **🔹 Explore Projects Section**
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

                      /// **🔹 Skill Tags**
                      _buildSkillTags(state),

                      /// **🔹 Project List**
                      const SizedBox(height: 10),
                      _buildProjectList(state),
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

  /// **🔹 Search Bar + Theme & Logout Menu**
  Widget _buildSearchBar(HomeState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/round_login.png', height: 40),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search Projects',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                    },
                  ),
              ],
            ),
          ),
        ),
        Builder(
          builder: (context) {
            return PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  context.read<HomeCubit>().logout(context);
                } else if (value == 'theme') {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                }
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<String>(
                  value: 'theme',
                  child: Row(
                    children: [
                      Icon(Icons.brightness_6, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Change Theme'),
                    ],
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Logout'),
                    ],
                  ),
                ),
              ],
              child: CircleAvatar(
                radius: 20,
                backgroundImage: state.freelancer?.profileImage != null
                    ? NetworkImage(
                        'http://192.168.1.70:3000/${state.freelancer!.profileImage}')
                    : const AssetImage('assets/images/default_avatar.png')
                        as ImageProvider,
              ),
            );
          },
        ),
      ],
    );
  }

  /// **🔹 Promo Cards (Carousel)**
  Widget _buildPromoCards(BuildContext context) {
    // Get the screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate a responsive height based on screen width
    final carouselHeight = screenWidth > 600
        ? screenHeight * 0.15 // For tablets, use 15% of screen height
        : screenHeight * 0.2; // For phones, use 20% of screen height

    final List<Widget> promoCards = [
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            image: AssetImage('assets/images/1.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            image: AssetImage('assets/images/2.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            image: AssetImage('assets/images/3.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ];

    return SizedBox(
      height: carouselHeight,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.easeInOut,
          enlargeCenterPage: true,
          viewportFraction: 0.85,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: true,
          padEnds: true,
        ),
        items: promoCards,
      ),
    );
  }

  /// **🔹 Skill Tags**
  Widget _buildSkillTags(HomeState state) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Add an "All" tag to clear the filter
          GestureDetector(
            onTap: () {
              context.read<HomeCubit>().setSelectedSkill(null);
            },
            child: MyTag(
              skill: const SkillEntity(name: "All"),
              backgroundColor: state.selectedSkill == null
                  ? Colors.blue
                  : const Color(0xFF001F3F),
              textColor: Colors.white,
              borderColor: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          ...state.skills.map((skill) {
            return GestureDetector(
              onTap: () {
                context.read<HomeCubit>().setSelectedSkill(skill.name);
              },
              child: MyTag(
                skill: skill,
                backgroundColor: state.selectedSkill == skill.name
                    ? Colors.blue
                    : const Color(0xFF001F3F),
                textColor: Colors.white,
                borderColor: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }

  /// **🔹 Projects List**
  Widget _buildProjectList(HomeState state) {
    List<ProjectEntity> filteredProjects = state.projects;

    if (state.selectedSkill != null) {
      filteredProjects = filteredProjects
          .where((project) => project.category
              .map((cat) => cat.toLowerCase())
              .contains(state.selectedSkill!.toLowerCase()))
          .toList();
    }

    final String searchQuery = _searchController.text.trim().toLowerCase();
    if (searchQuery.isNotEmpty) {
      filteredProjects = filteredProjects.where((project) {
        return project.title.toLowerCase().contains(searchQuery) ||
            project.description.toLowerCase().contains(searchQuery) ||
            project.companyName.toLowerCase().contains(searchQuery);
      }).toList();
    }

    if (filteredProjects.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'No projects found.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: filteredProjects.map((project) {
        return Column(
          children: [
            MyCard(project: project),
            const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}
