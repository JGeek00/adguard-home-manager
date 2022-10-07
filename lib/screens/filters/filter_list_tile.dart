import 'package:flutter/material.dart';

class FilterListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  final bool? bold;

  const FilterListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color,
    this.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 26,
            color: Colors.grey,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: MediaQuery.of(context).size.width-86,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: color ?? Colors.grey,
                    fontWeight: bold == true ? FontWeight.bold : null
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}