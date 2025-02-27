import 'dart:io';
import 'package:bloc_quiz/bloc/profile/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../bloc/profile/profile_state.dart';
import '../../data/repositories/storage_repo.dart';

class Profile extends StatelessWidget {
  static final String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileBloc(repository: StorageRepo())..add(DataRequested()),
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('Мой профиль'),
          //   backgroundColor: Theme.of(context).colorScheme.onPrimary,
          // ),
          body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateState) {
                BlocProvider.of<AuthBloc>(context)
                    .add(ProfileImageChangeRequested(state.url));
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
              if (state is Success) {
                // will also execute for child classes: ProfileUpdateState
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state.user.photoURL != null
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          shape: CircleBorder(), // Добавляем круглую форму кнопки
                          padding: EdgeInsets.all(0), // Убираем внутренние отступы
                        ),
                        child: ClipOval(
                          child: Image.network(
                            "${state.user.photoURL}",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover, // Устанавливаем обрезку для корректного отображения
                          ),
                        ),
                        onPressed: () {},
                      )
                          : Container(),

                      const SizedBox(height: 16),
                      state.user.displayName != null
                          ? Text("${state.user.displayName}",
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
                          : Container(),
                      const SizedBox(height: 16),
                      Text(
                        '${state.user.email}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        child: const Text('Выйти из аккаунта'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        ),
                        onPressed: () {
                          // Signing out the user
                          context.read<AuthBloc>().add(SignOutRequested());
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Обновить фото профиля'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                        ),
                        onPressed: () {
                          showUpdateProfileImageAlertDialog(context);
                        },
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Загрузка...', style: TextStyle(fontSize: 40),));
            }),
          ),
        ));
  }

  showUpdateProfileImageAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cameraButton = ElevatedButton(
      child: const Text("Камера"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      ),
      onPressed: () async {
        XFile? imageFile = await ImagePicker().pickImage(
            source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
        debugPrint('path: ${imageFile!.path}');
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfileImageUpdateEvent(File(imageFile.path)));
        Navigator.of(context).pop();
      },
    );
    Widget galleryButton = ElevatedButton(
      child: const Text("Галерея"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
    ),
      onPressed: () async {
        XFile? imageFile = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
        debugPrint('path: ${imageFile!.path}');
        BlocProvider.of<ProfileBloc>(context)
            .add(ProfileImageUpdateEvent(File(imageFile.path)));
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Выберите ресурс:"),
      actions: [
        cameraButton,
        galleryButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
