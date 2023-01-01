
enum LoadingPageStatus {
  Initialized,
  Ready,
  TextChanged
}

class LoadingPageState {

  final String Message;
  final LoadingPageStatus Status;

  LoadingPageState ({
    this.Message = '',
    this.Status = LoadingPageStatus.Initialized
  });

  LoadingPageState CopyWith(
      {
        String? message,
        LoadingPageStatus? status
      }) {
    return LoadingPageState(
        Message: message ?? this.Message,
        Status: status ?? this.Status
    );
  }
}