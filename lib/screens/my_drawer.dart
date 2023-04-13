
import 'package:firebasetodoapps/screens/login_screen.dart';
import 'package:firebasetodoapps/screens/recycle_bin.dart';
import 'package:firebasetodoapps/screens/tabs_screens.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../bloc/bloc_export.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              color: Colors.grey,
              child: Text('Task Drawer', style: Theme
                  .of(context)
                  .textTheme
                  .headlineSmall,),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(
                          TabsScreen.id),
                  child: ListTile(
                    leading: const Icon(Icons.folder_special,),
                    title: const Text('My Tasks'),
                    trailing: Text('${state.pendingTasks.length} | ${state.completedTasks.length}'),
                  ),
                );
              },
            ),
            const Divider(),

            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed(RecycleBin.id),
                  child: ListTile(
                    leading: const Icon(Icons.delete,),
                    title: const Text('Bin'),
                    trailing: Text('${state.removedTasks.length}'),
                  ),
                );
              },
            ),
            ListTile(
              onTap: (){
                GetStorage().remove('token');
                Navigator.pushReplacementNamed(context, LoginScreen.id);

              },
              leading: Icon(Icons.logout),
              title: Text('Logout'),
            ),
            const Divider(),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Switch(
                  value: state.switchValue, onChanged: (value) {
                value? context.read<SwitchBloc>().add(SwitchOnEvent())
                    :context.read<SwitchBloc>().add(SwitchOffEvent());
                },);
              },
            )
          ],
        ),
      ),
    );
  }
}
