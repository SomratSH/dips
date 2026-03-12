import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:dips/presentation/agent/notification/widget/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => context.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF041E41),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: ()async{
            await provider.getNotification();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
            
            
              provider.isLoading ? Center(child: CircularProgressIndicator(),) : provider.notificationList.isEmpty ? Center(
                child: Text("No notification available"),
              )  :
              
               Column(
                  children: List.generate(provider.notificationList.length, (index) => Column(
                    children: [
                      NotificationCard(
                        index: index,
                        markasread: provider.notificationList[index].isRead!,
                      id:provider.notificationList[index].id! ,
                      bgColor: Color(0xFFE3EFFF),
                      iconBg: Color(0xFFD2B7FF),
                      icon: Icons.currency_pound,
                      title:provider.notificationList[index].title!,
                      subtitle:
                        provider.notificationList[index].body!,
                                      ),
                                      SizedBox(height: 10,)
                    ],
                  ),),
                )
                /// Notifications
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
