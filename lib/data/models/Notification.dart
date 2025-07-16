class MyNotification {
  final String title;
  final String text;
  final DateTime date;

  MyNotification({
    required this.title,
    required this.text,
    required this.date,
  });

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