import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../feed/feed.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<PetFeedBloc>(
    create: (context) => PetFeedBloc(
      petRepository: context.read<PetRepository>(),
    ),
  ),
];

List<RepositoryProvider> repositoryProviers = [
  RepositoryProvider<PetRepository>(create: (context) => petRepository),
  RepositoryProvider<AuthenticationRepository>(
      create: (context) => AuthenticationRepository()),
];
