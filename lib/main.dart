import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:social_media/core/theme/app_theme.dart';
import 'package:social_media/features/create_post/bloc/create_post_bloc.dart';
import 'package:social_media/features/create_post/data/hive_model/post_hive_model.dart';
import 'package:social_media/features/create_post/data/hive_model/post_media_hive.dart';
import 'package:social_media/features/feed/bloc/feed_bloc.dart';
import 'package:social_media/features/feed/presentation/feed.dart';
import 'package:social_media/features/shorts/bloc/shorts_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(PostMediaHiveAdapter());
  Hive.registerAdapter(PostHiveModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => FeedBloc()), BlocProvider(create: (_) => CreatePostBloc()), BlocProvider(create: (_) => ShortsBloc())],
      child: MaterialApp(debugShowCheckedModeBanner: false, title: 'Flutter Demo', theme: AppTheme.darkTheme, home: Feed()),
    );
  }
}
