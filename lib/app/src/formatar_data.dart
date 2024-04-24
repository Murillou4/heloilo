//adicionar 0 antes do número se ele for menor que 10 e deixar a data no formato dia/mes/ano;

String formatarData(DateTime data) {
  String dia = data.day.toString();
  String mes = data.month.toString();
  String ano = data.year.toString();
  if (dia.length == 1) {
    dia = '0$dia';
  }
  if (mes.length == 1) {
    mes = '0$mes';
  }
  return '$dia/$mes/$ano';
}
