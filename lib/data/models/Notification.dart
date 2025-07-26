class MyNotification {
  final String title;
  final String text;
  final DateTime date;

  MyNotification({
    required this.title,
    required this.text,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  // Setter
  set title(String value) {
    title = value;
  }

  set text(String value) {
    text = value;
  }

  set date(DateTime value) {
    date = value;
  }


}