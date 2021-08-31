class Filter {
  final DateTime startDate;
  DateTime endDate;
  final double price;
  final String category;
  final String inputText;
  double radius = 50000.0;

  Filter(this.startDate, this.endDate, this.price, this.category, this.radius,
      this.inputText);
}
