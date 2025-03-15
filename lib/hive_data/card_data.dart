import 'package:hive/hive.dart';

part 'card_data.g.dart'; // Adaptör dosyası otomatik oluşturulacak

@HiveType(typeId: 0)
class CardData {
  @HiveField(0)
  String id;

  @HiveField(1)
  int level;

  @HiveField(2)
  String front;

  @HiveField(3)
  String back;

  CardData({
    required this.id,
    required this.level,
    required this.front,
    required this.back,
  });

  // Derin kopyalama fonksiyonu
  CardData copy() {
    return CardData(
      id: id,
      level: level,
      front: front,
      back: back,
    );
  }
}
