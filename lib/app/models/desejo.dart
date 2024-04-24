import 'dart:convert';

import 'package:heloilo/app/models/comentario.dart';

class Desejo {
  String? id;
  String? data;
  String titulo;
  String pessoa;
  String? link;
  String? imageBinary;
  int nivelDesejo = 1;
  List<Comentario>? comentarios;

  Desejo({
    this.id,
    this.data,
    required this.titulo,
    required this.pessoa,
    this.link,
    this.imageBinary,
    required this.nivelDesejo,
    this.comentarios,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titulo': titulo,
      'pessoa': pessoa,
      'link': link,
      'image_binary': imageBinary,
      'nivel_de_desejo': nivelDesejo,
      'comentarios': comentarios?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory Desejo.fromMap(Map<String, dynamic> map) {
    return Desejo(
      id: map['id']?.toString(),
      data: map['data']?.toString(),
      titulo: map['titulo'] as String,
      pessoa: map['pessoa'] as String,
      link: map['link'] != null ? map['link'] as String : null,
      imageBinary: map['image_binary']?.toString(),
      nivelDesejo: map['nivel_de_desejo'] as int,
      comentarios: map['comentarios'] != null
          ? Comentario.snapshotToList(map['comentarios'])
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Desejo.fromJson(String source) =>
      Desejo.fromMap(json.decode(source) as Map<String, dynamic>);
}
