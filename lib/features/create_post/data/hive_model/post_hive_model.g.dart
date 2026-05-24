// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveModelAdapter extends TypeAdapter<PostHiveModel> {
  @override
  final int typeId = 0;

  @override
  PostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveModel(
      id: fields[0] as String,
      medias: (fields[1] as List).cast<PostMediaHive>(),
      caption: fields[2] as String?,
      visibility: fields[3] as String,
      createdAt: fields[4] as DateTime,
      isLike: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PostHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medias)
      ..writeByte(2)
      ..write(obj.caption)
      ..writeByte(3)
      ..write(obj.visibility)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.isLike);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
