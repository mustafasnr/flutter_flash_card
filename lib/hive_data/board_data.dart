import 'package:hive/hive.dart';
import 'card_data.dart'; // CardData sınıfını içe aktar

part 'board_data.g.dart'; // Adaptör dosyası otomatik oluşturulacak

@HiveType(typeId: 1)
class BoardData {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<CardData> cards;

  @HiveField(3)
  bool isFavorite;

  BoardData({
    required this.id,
    required this.name,
    required this.cards,
    required this.isFavorite,
  });

  // Derin kopya fonksiyonu
  BoardData copy() {
    return BoardData(
      id: id,
      name: name,
      cards: cards.map((card) => card.copy()).toList(), // Derin kopyalama
      isFavorite: isFavorite,
    );
  }
}