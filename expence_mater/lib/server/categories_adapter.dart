import 'package:hive/hive.dart';
import 'package:expence_mater_yt/models/expenseModel.dart';

class CategoriesAdapter extends TypeAdapter<Categorys> {
  @override
  final int typeId = 2;

  @override
  Categorys read(BinaryReader reader) {
    return Categorys.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, Categorys obj) {
    writer.writeByte(obj.index);
  }
}
