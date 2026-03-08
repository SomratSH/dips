import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final String iconPath;
  final Color valueColor;
  final Color percentageColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.iconPath,
    this.valueColor = const Color(0xFFE63946),
    this.percentageColor = const Color(0xFF00A63E),
    this.backgroundColor = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.13,
              color: Colors.black.withOpacity(0.10),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF495565),
                      fontSize: 12.28,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SvgPicture.asset(iconPath, height: 20),
                ],
              ),

              const SizedBox(height: 16),

              /// Main value
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 24,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              /// Percentage
              Row(
                children: [
                  Text(
                    percentage,
                    style: TextStyle(
                      color: percentageColor,
                      fontSize: 12.28,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
