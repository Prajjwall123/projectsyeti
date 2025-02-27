import 'package:flutter/material.dart';
import 'package:projectsyeti/features/auth/presentation/view/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 249, 255, 1),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                buildPage(
                  title: "Find the best freelance projects!",
                  subtitle: "Freelancing made easy",
                  imagePath: "assets/images/welcome.png",
                ),
                buildPage(
                  title: "Network with the best!",
                  subtitle: "Access top experts companies and freelancers",
                  imagePath: "assets/images/new_welcome.png",
                ),
                buildPage(
                  title: "Get Started Today",
                  subtitle: "Sign up and start freelancing now!",
                  imagePath: "assets/images/rafiki.png",
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontSize: 16.0, color: Color(0xFF1976D2)),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 10.0,
                      width: _currentIndex == index ? 12.0 : 8.0,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex < 2) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginView(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16.0),
                  ),
                  child: Text(
                    _currentIndex == 2 ? "Finish" : "Next",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildPage(
    {required String title,
    required String subtitle,
    required String imagePath}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 250.0),
        const SizedBox(height: 40.0),
        Text(
          title,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16.0, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
