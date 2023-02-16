class PayCard {
  final String number;
  final String userName;
  final String date;
  final String rcv;

  const PayCard({
    required this.number,
    required this.userName,
    required this.date,
    required this.rcv,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'userName': userName,
      'date': date,
      'rcv': rcv,
    };
  }

  factory PayCard.fromMap(Map<String, dynamic> map) {
    return PayCard(
      number: map['number'] ?? '',
      userName: map['userName'] ?? '',
      date: map['date'] ?? '',
      rcv: map['rcv'] ?? '',
    );
  }
}
