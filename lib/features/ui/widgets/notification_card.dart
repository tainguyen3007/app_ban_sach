import 'package:flutter/material.dart';
import 'package:app_ban_sach/core/constants/style.dart';
import 'package:app_ban_sach/data/models/Notification.dart';

class NotificationCard extends StatefulWidget {
  final MyNotification notifi;

  const NotificationCard({
    required this.notifi,
    super.key,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2, // shadow
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔔 Tiêu đề
            Text(
              widget.notifi.title,
              style: TextStyle(
                fontSize: MyTextStyle.size_13,
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
              ),
            ),
            const SizedBox(height: 5),

            /// 📄 Nội dung
            Text(
              widget.notifi.text,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: MyTextStyle.size_13,
                fontWeight: MyTextStyle.medium,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),

            /// 📅 Ngày
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _formatDate(widget.notifi.date),
                style: TextStyle(
                  fontSize: MyTextStyle.size_13,
                  color: MyColors.darkGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🧠 Hàm định dạng ngày
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
           "${date.month.toString().padLeft(2, '0')}/"
           "${date.year}";
  }
}
