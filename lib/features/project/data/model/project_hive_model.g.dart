// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectHiveModelAdapter extends TypeAdapter<ProjectHiveModel> {
  @override
  final int typeId = 1;

  @override
  ProjectHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectHiveModel(
      id: fields[0] as String?,
      companyId: fields[1] as String,
      companyName: fields[2] as String,
      companyLogo: fields[3] as String,
      headquarters: fields[4] as String?,
      title: fields[5] as String,
      category: (fields[6] as List).cast<String>(),
      requirements: fields[7] as String,
      description: fields[8] as String,
      duration: fields[9] as String,
      postedDate: fields[10] as DateTime,
      status: fields[11] as String,
      bidCount: fields[12] as int,
      awardedTo: fields[13] as String?,
      feedbackRequestedMessage: fields[14] as String?,
      link: fields[15] as String?,
      feedbackRespondMessage: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectHiveModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyId)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.companyLogo)
      ..writeByte(4)
      ..write(obj.headquarters)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.requirements)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.duration)
      ..writeByte(10)
      ..write(obj.postedDate)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.bidCount)
      ..writeByte(13)
      ..write(obj.awardedTo)
      ..writeByte(14)
      ..write(obj.feedbackRequestedMessage)
      ..writeByte(15)
      ..write(obj.link)
      ..writeByte(16)
      ..write(obj.feedbackRespondMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
