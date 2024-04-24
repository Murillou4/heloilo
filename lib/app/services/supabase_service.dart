import 'dart:convert';

import 'package:heloilo/app/models/comentario.dart';
import 'package:heloilo/app/models/desejo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final instance = SupabaseService();
  static final supabase = Supabase.instance.client;
  final String imagePath = 'desejos-images';
  Future<Supabase> init() async {
    return await Supabase.initialize(
      url: 'https://uiyqnpzbxegylzglasxg.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVpeXFucHpieGVneWx6Z2xhc3hnIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwNDIzMzA2NCwiZXhwIjoyMDE5ODA5MDY0fQ.Kaa9elugOwPX3NbzBnWxKWMDIh85O5A80n37l6MkQ78',
    );
  }

  Future<void> addDesejo(Desejo desejo) async {
    try {
      await supabase.from('desejos').insert(desejo.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDesejo(Desejo desejo) async {
    try {
      await supabase.from('desejos').update({
        'titulo': desejo.titulo,
        'link': desejo.link,
        'image_binary': desejo.imageBinary,
        'nivel_de_desejo': desejo.nivelDesejo,
      }).eq('id', desejo.id!);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeDesejo(String id) async {
    try {
      await supabase.from('desejos').delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List?> getDesejoComentarios(Desejo desejo) async {
    var listaComentarios = await supabase
        .from('desejos')
        .select('comentarios')
        .eq('id', desejo.id!);

    return listaComentarios.first['comentarios'];
  }

  Future<void> addComentario(Desejo desejo, Comentario comentario) async {
    try {
      var listaComentarios = await getDesejoComentarios(desejo);
      if (listaComentarios == null) {
        await supabase.from('desejos').update({
          'comentarios': [comentario.toMap()],
        }).eq('id', desejo.id!);
      } else {
        listaComentarios.add(comentario.toMap());
        await supabase.from('desejos').update({
          'comentarios': listaComentarios,
        }).eq('id', desejo.id!);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeComentario(Desejo desejo, Comentario comentario) async {
    try {
      var listaComentarios = await getDesejoComentarios(desejo);
      if (listaComentarios == null) {
        return;
      } else {
        listaComentarios
            .removeWhere((element) => element['id'] == comentario.id);
        await supabase.from('desejos').update({
          'comentarios': listaComentarios,
        }).eq('id', desejo.id!);
      }
    } catch (e) {
      rethrow;
    }
  }
}
