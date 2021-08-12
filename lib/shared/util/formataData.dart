import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Data {
  data(String data) {
    initializeDateFormatting("pt_BR");
    var formatandoData = DateFormat.yMEd("pt_BR");
    DateTime dataConvertida = DateTime.parse(data);
    String dataFormatado = formatandoData.format(dataConvertida);
    return dataFormatado;
  }
}
