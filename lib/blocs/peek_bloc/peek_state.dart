// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/peek/Peek.dart';

enum PeekStatus {
  Loading,
  Loaded,
  Error
}

class PeekState {

  final List<Peek> Peeks;
  final String Title;
  final PeekStatus Status;
  final int? DisplayType;

  PeekState ({ this.Peeks = const[], this.Title = '', this.Status = PeekStatus.Loading, this.DisplayType = 1 });

  PeekState CopyWith(
      {
        List<Peek>? peeks,
        String? title,
        PeekStatus? status,
        int? displayType
      }) {
    return PeekState(
      Peeks: peeks ?? this.Peeks,
      Title: title ?? this.Title,
      Status: status ?? this.Status,
      DisplayType: displayType ?? this.DisplayType
    );
  }
}