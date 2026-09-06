import 'package:capsule_toast/capsule_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final toastNotifierProvider =
    NotifierProvider<ToastNotifier, CapsuleToastData?>(
      ToastNotifier.new,
      name: 'toastNotifierProvider',
    );

class ToastNotifier extends Notifier<CapsuleToastData?> {
  @override
  CapsuleToastData? build() => null;

  void showSuccess({
    required String title,
    required String message,
  }) {
    state = CapsuleToastData.success(
      title: title,
      message: message,
      initialMode: CapsuleToastMode.expanded,
    );
  }

  void showWarning({
    required String title,
    required String message,
  }) {
    state = CapsuleToastData.warning(
      title: title,
      message: message,
      initialMode: CapsuleToastMode.expanded,
    );
  }

  void showError({
    required String title,
    required String message,
  }) {
    state = CapsuleToastData.error(
      title: title,
      message: message,
      initialMode: CapsuleToastMode.expanded,
    );
  }

  void showInfo({
    required String title,
    required String message,
  }) {
    state = CapsuleToastData.information(
      title: title,
      message: message,
      initialMode: CapsuleToastMode.expanded,
    );
  }
}
