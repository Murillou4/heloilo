// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Comentario {
  String id;
  String comentario;
  String data;
  String pessoa;

  Comentario({
    required this.id,
    required this.comentario,
    required this.data,
    required this.pessoa,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'comentario': comentario,
      'data': data,
      'pessoa': pessoa,
    };
  }

  factory Comentario.fromMap(Map<String, dynamic> map) {
    return Comentario(
      id: map['id'] as String,
      comentario: map['comentario'] as String,
      data: map['data'] as String,
      pessoa: map['pessoa'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comentario.fromJson(String source) =>
      Comentario.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<Comentario> snapshotToList(List<dynamic> snapshot) {
    if (snapshot.isNotEmpty) {
      List<Comentario> list =
          snapshot.map((e) => Comentario.fromMap(e)).toList();
      return list;
    }
    return [];
  }
}
