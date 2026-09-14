enum ExpenseCategory { home, food, transit, shop, bills, more }

class ExpenseModel {
  double value;
  ExpenseCategory type;
  String? note;
  String image;
  int id;
  bool isIncome;
  DateTime createdAt;
  ExpenseModel({
    required this.value,
    required this.type,
    this.note,
    required this.image,
    required this.id,
    required this.isIncome,
    required this.createdAt,
  });
  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      value: (json['value'] as num).toDouble(),
      type: ExpenseCategory.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ExpenseCategory.more,
      ),
      note: json['note'],
      image: json['image'],
      id: json['id'] as int,
      isIncome: json['isIncome'] == 1,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() => {
    "id": id,
    "value": value,
    "type": type.name,
    "note": note,
    "image": image,
    "isIncome": isIncome ? 1 : 0,
    "createdAt": createdAt.toIso8601String(),
  };
}
