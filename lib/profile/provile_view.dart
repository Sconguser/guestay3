import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestay/profile/profile_bloc.dart';
import 'package:guestay/profile/profile_event.dart';
import 'package:guestay/profile/profile_state.dart';
import 'package:guestay/shared/appbar.dart';
import 'package:guestay/shared/constants/background.dart';

import '../auth/auth_cubit.dart';
import '../session_cubit.dart';
import '../shared/constants/colours.dart';
import '../shared/divider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    return BlocProvider(
        create: (context) => ProfileBloc(
            user: sessionCubit.selectedUser ?? sessionCubit.currentUser,
            isCurrentUser: sessionCubit.isCurrentUserSelected,
            sessionCubit: sessionCubit),
        child: Scaffold(
            // backgroundColor: Colors.blue,
            // appBar: _appBar(),
            body: Container(
          decoration: backgroundDecoration,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              // containerAppBar(context, 'Profile', false),
              _appBar(),
              textFieldDivider,
              _profilePage(),
            ],
          ),
        )));
  }

  PreferredSize _appBar() {
    final appBarHeight = AppBar().preferredSize.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        return Row(
          children: [
            if (state.isCurrentUser)
              IconButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(SignOut());
                  },
                  icon: Icon(Icons.logout)),
            Text('Your profile')
          ],
        );
      }),
    );
  }

  Widget _profilePage() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              _avatar(),
              if (state.isCurrentUser) _changeAvatarButton(),
              SizedBox(height: 30),
              _usernameTile(),
              _emailTile(),
              _descriptionTile(),
              if (state.isCurrentUser) _saveProfileChangesButton()
            ],
          ),
        ),
      );
    });
  }

  Widget _avatar() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return CircleAvatar(
        radius: 50,
        child: Icon(Icons.person),
      );
    });
  }

  Widget _changeAvatarButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return TextButton(
        onPressed: () {},
        child: Text('Change avatar'),
      );
    });
  }

  Widget _usernameTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.person),
        title: Text(state.username != null
            ? state.username!
            : 'Cannot display username'),
      );
    });
  }

  Widget _emailTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
        tileColor: Colors.white,
        leading: Icon(Icons.email),
        title:
            Text(state.email != null ? state.email! : 'Cannot display email'),
      );
    });
  }

  Widget _descriptionTile() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ListTile(
          tileColor: Colors.white,
          leading: Icon(Icons.edit),
          title: TextFormField(
            initialValue: state.userDescription != null
                ? state.userDescription!
                : 'No description provided',
            decoration: InputDecoration.collapsed(
              hintText: state.isCurrentUser
                  ? 'Say something about yourself'
                  : 'This user hasn\'t updated their description',
            ),
            maxLines: null,
            readOnly: !state.isCurrentUser,
            toolbarOptions: ToolbarOptions(
                copy: state.isCurrentUser,
                cut: state.isCurrentUser,
                paste: state.isCurrentUser,
                selectAll: state.isCurrentUser),
            onChanged: (value) => context
                .read<ProfileBloc>()
                .add(ProfileDescriptionChanged(userDescription: value)),
          ));
    });
  }

  Widget _saveProfileChangesButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(primary: primaryColor, elevation: 0),
          onPressed: () {},
          child: Text(
            'Save profile changes',
            style: TextStyle(color: Colors.black),
          ));
    });
  }
}
