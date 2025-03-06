import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:confetti/confetti.dart';
import 'package:projectsyeti/features/notification/domain/entity/notification_entity.dart';
import 'package:projectsyeti/features/notification/presentation/view_model/notification_bloc.dart';

class NotificationView extends StatefulWidget {
  final String freelancerId;

  const NotificationView({super.key, required this.freelancerId});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 2));
    context.read<NotificationBloc>().add(
          GetNotificationByFreelancerIdEvent(widget.freelancerId),
        );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: Stack(
        children: [
          SafeArea(
            child: BlocConsumer<NotificationBloc, NotificationState>(
              listener: (context, state) {
                if (state is NotificationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
                if (state is NotificationSeenSuccess) {
                  context.read<NotificationBloc>().add(
                        GetNotificationByFreelancerIdEvent(widget.freelancerId),
                      );
                }

                if (state is NotificationLoaded) {
                  final hasUnreadAwardedNotification = state.notifications.any(
                    (notification) =>
                        !notification.isRead &&
                        notification.message.contains(
                            "Congratulations! You have been awarded the project"),
                  );
                  if (hasUnreadAwardedNotification) {
                    _confettiController.play();
                  }
                }
              },
              builder: (context, state) {
                if (state is NotificationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NotificationError) {
                  return Center(child: Text(state.message));
                } else if (state is NotificationLoaded) {
                  final notifications = state.notifications;
                  if (notifications.isEmpty) {
                    return const Center(child: Text("No notifications found"));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      final bool isRead = notification.isRead;
                      final bool isAwarded = notification.message.contains(
                          "Congratulations! You have been awarded the project");

                      return GestureDetector(
                        onTap: () {
                          if (!isRead) {
                            context.read<NotificationBloc>().add(
                                SeenNotificationEvent(
                                    notification.notificationId));
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isRead
                                ? Colors.grey[300]
                                : (isAwarded
                                    ? Colors.green[100]
                                    : Colors.blue[100]),
                            boxShadow: isAwarded && !isRead
                                ? [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification.message,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: isRead
                                        ? Colors.grey[600]
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Received: ${notification.createdAt.toLocal().toString().split(' ')[0]}",
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                                const SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Icon(
                                    isRead
                                        ? Icons.check_circle
                                        : Icons.mark_email_unread,
                                    color: isRead ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text("No notifications available"));
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.yellow,
                Colors.blue,
                Colors.red
              ],
              numberOfParticles: 20,
              gravity: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
