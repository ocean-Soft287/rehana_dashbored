import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/utils/responsive/responsive_builder.dart';
import '../../manger/collections_cubit.dart';
import '../widgets/mobile_collections_screen.dart';
import '../widgets/tablet_collections_screen.dart';

class ResponsiveCollectionsScreen extends StatefulWidget {
  const ResponsiveCollectionsScreen({super.key});

  @override
  State<ResponsiveCollectionsScreen> createState() =>
      _ResponsiveCollectionsScreenState();
}

class _ResponsiveCollectionsScreenState
    extends State<ResponsiveCollectionsScreen> {
  late CollectionsCubit _collectionsCubit;

  @override
  void initState() {
    super.initState();
    _collectionsCubit = GetIt.instance<CollectionsCubit>();
    _collectionsCubit.loadVillas();
  }

  @override
  void dispose() {
    _collectionsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _collectionsCubit,
      child: ResponsiveBuilder(
        builder: (context, isMobile) {
          if (isMobile) {
            return const MobileCollectionsScreen();
          } else {
            return const TabletCollectionsScreen();
          }
        },
      ),
    );
  }
}
