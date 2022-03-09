// ignore_for_file: non_constant_identifier_names
import 'package:mobi_reads/entities/peek/Peek.dart';

enum PeekListStatus {
  Constructed,
  PeeksLoading,
  PeeksLoaded,
  Loaded,
  Error
}

class PeekListState {

  final List<Peek> Peeks;
  final String Title;
  final PeekListStatus Status;
  final int? DisplayType;

  PeekListState ({ this.Peeks = const[], this.Title = '', this.Status = PeekListStatus.Constructed, this.DisplayType = 1 });

  PeekListState CopyWith(
      {
        List<Peek>? peeks,
        String? title,
        PeekListStatus? status,
        int? displayType
      }) {
    return PeekListState(
      Peeks: peeks ?? this.Peeks,
      Title: title ?? this.Title,
      Status: status ?? this.Status,
      DisplayType: displayType ?? this.DisplayType
    );
  }
}