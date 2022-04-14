import 'dart:convert';

class TransactionModel {
  String category;
  String dateTime;
  bool isExpense;
  String quantity;
  String userUid;

  TransactionModel({
    required this.category,
    required this.dateTime,
    required this.isExpense,
    required this.quantity,
    required this.userUid

  });

  TransactionModel copyWith({
    String? category,
    String? dateTime,
    bool? isExpense,
    String? quantity,
    String? userUid,

  }) {
    return TransactionModel(
      category: category ?? this.category,
      dateTime: dateTime ?? this.dateTime,
      isExpense: isExpense ?? this.isExpense,
      quantity: quantity ?? this.quantity,
        userUid : userUid ?? this.userUid,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'dateTime': dateTime,
      'isExpense': isExpense,
      'quantity': quantity,
      'userUid': userUid,

    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      category: map['category'] ?? '',
      dateTime: map['dateTime'] ?? "m",
      isExpense: map['isExpense'] ?? false,
      quantity: map['quantity'] ?? "0",
        userUid : map["userUid"] ?? ""

    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(category: $category, dateTime: $dateTime, isExpense: $isExpense, quantity: $quantity, userUid: $userUid';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.category == category &&
        other.dateTime == dateTime &&
        other.isExpense == isExpense &&
        other.quantity == quantity &&
        other.userUid == userUid;
  }

  @override
  int get hashCode {
    return
      category.hashCode ^
      dateTime.hashCode ^
    isExpense.hashCode ^
    quantity.hashCode^
      userUid.hashCode
    ;
  }
}