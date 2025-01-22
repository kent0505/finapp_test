class Cash {
  Cash({
    required this.id,
    required this.title,
    required this.amount,
  });

  int id;
  String title;
  int amount;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
    };
  }

  factory Cash.fromMap(Map<String, dynamic> map) {
    return Cash(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
    );
  }
}
