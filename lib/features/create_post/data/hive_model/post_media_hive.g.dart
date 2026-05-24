// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_media_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostMediaHiveAdapter extends TypeAdapter<PostMediaHive> {
  @override
  final int typeId = 1;

  @override
  PostMediaHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostMediaHive(
      path: fields[0] as String,
      mediaType: fields[1] as String,
      thumbnailPath: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PostMediaHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.mediaType)
      ..writeByte(2)
      ..write(obj.thumbnailPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostMediaHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
