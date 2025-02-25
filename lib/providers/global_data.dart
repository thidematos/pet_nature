import 'package:uuid/uuid.dart';

final kUuid = Uuid();

final Map<String, String> kProdutosCategories = {
  'alimentos-umidos': 'Alimentos úmidos (latas e sachês)',
  'camas-almofadas': 'Camas e almofadas',
  'coleiras-guias': 'Coleiras e guias',
  'escovas-pentes': 'Escovas e pentes',
  'racao': 'Ração',
  'shampoo-cond': 'Shampoo e condicionadores',
};

enum appRoles { leitor, estoquista, admin }

String kFormatTimestamp(timestamp) {
  final DateTime date = DateTime.fromMillisecondsSinceEpoch(
    int.parse(timestamp),
  );

  String toStringAndPadLeft(value) {
    return value.toString().padLeft(2, '0');
  }

  return '${toStringAndPadLeft(date.day)}/${toStringAndPadLeft(date.month)}/${date.year}';
}
