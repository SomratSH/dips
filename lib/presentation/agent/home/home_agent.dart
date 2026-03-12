import 'package:dips/components/custom_padding.dart';
import 'package:dips/core/routing/route_path.dart';
import 'package:dips/presentation/agent/home/home_agent_provider.dart';
import 'package:dips/presentation/agent/home/widget/recent_activity.dart';
import 'package:dips/presentation/agent/home/widget/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeAgent extends StatelessWidget {
  const HomeAgent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeAgentProvider>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: provider.isLoading ? Center(child: CircularProgressIndicator(),) : Column(
            children: [
              buildHeader(context, provider),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: '🏠 Listings',
                        value: provider.agentDashboardModel.totalPropertyListing!.toString(),
                        percentage: '+13%',
                        iconPath: 'assets/icons/agentHOme.svg',
                        onTap: () {
                          debugPrint('Listings tapped');
                        },
                      ),
                    ),
                    CustomPadding().hPad10,
                    Expanded(
                      child: StatsCard(
                        title: '👁 Views',
                        value: provider.agentDashboardModel.totalPropertyViews.toString(),
                        percentage: '+28%',
                        iconPath: 'assets/icons/eye.svg',
                        onTap: () {
                          debugPrint('Listings tapped');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: '💬 Offers',
                        value: provider.agentDashboardModel.totalOffersReceived.toString(),
                        percentage: '+5%',
                        iconPath: 'assets/icons/offer_icon.svg',
                        onTap: () {
                          debugPrint('Listings tapped');
                        },
                      ),
                    ),
                    CustomPadding().hPad10,
                    Expanded(
                      child: StatsCard(
                        title: '📱 QR Scans',
                        value: provider.agentDashboardModel.totalQrScanned.toString(),
                        percentage: '+42%',
                        iconPath: 'assets/icons/scan_icon.svg',
                        onTap: () {
                          debugPrint('Listings tapped');
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RecentActivityCard(),
              ),
            ],
          ) ,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePath.chatbot);
        },
        shape: CircleBorder(),
        backgroundColor: const Color(0xFF041E41),
        child: SvgPicture.asset("assets/icons/Logo (2).svg"),
      ),
    );
  }
}

Widget buildHeader(BuildContext context, HomeAgentProvider provider) {
  return DecoratedBox(
    decoration: ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0.00, 0.00),
        end: Alignment(1.00, 1.00),
        colors: [
          const Color(0xFFE63946),
          const Color(0xFF752B43),
          const Color(0xFF041E41),
        ],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1.11, color: const Color(0xFFE8E8E8)),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                   provider.agentProfileModel.agentProfile!.brandName!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    'Here\'s what\'s happening with your properties today.',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),

                  CustomPadding().vPad25,
                ],
              ),
              InkWell(
                onTap: () => context.go(RoutePath.notification),
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/icons/notification.svg"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
