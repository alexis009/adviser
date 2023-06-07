import 'package:adviser/application/core/services/theme_service.dart';
import 'package:adviser/application/pages/advice/cubit/adviser_cubit.dart';
import 'package:adviser/application/pages/advice/widgets/advice_field.dart';
import 'package:adviser/application/pages/advice/widgets/custom_button.dart';
import 'package:adviser/application/pages/advice/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdviserCubit>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
              value: Provider.of<ThemeService>(context).isDarkModeOn,
              onChanged: (_) {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviserCubit, AdviserCubitState>(
                  builder: (context, state) {
                    if (state is AdviserInitial) {
                      return Text(
                        'Your Advice is waiting for you!',
                        style: themeData.textTheme.bodyLarge,
                      );
                    } else if (state is AdviserStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdviserStateLoaded) {
                      return AdviceFiled(advice: state.advice);
                    } else if (state is AdviserStateError) {
                      return ErrorMessage(message: state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const SizedBox(height: 200, child: Center(child: CustomButton())),
          ],
        ),
      ),
    );
  }
}
