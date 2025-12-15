import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rehana_dashboared/core/utils/firebase/firebase_conumer_impl.dart';
import 'package:rehana_dashboared/feature/Account_Management/data/repo/accountmangmentrepoimp.dart';
import 'package:rehana_dashboared/feature/Home/data/repo/invitation_repo_imp.dart';
import 'package:rehana_dashboared/feature/add_users/data/repo/adduserrepoimp.dart';
import '../../../feature/Account_Management/data/repo/accountmangmentrepo.dart';
import '../../../feature/Account_Management/presentation/manger/person_cubit.dart';
import '../../../feature/Auth/data/repo/auth_repo.dart';
import '../../../feature/Auth/data/repo/auth_repo_imp.dart';
import '../../../feature/Auth/presentation/manger/auth_cubit.dart';
import '../../../feature/Home/data/repo/invitation_repo.dart';
import '../../../feature/Home/presentation/manger/homeinvitation_cubit.dart';
import '../../../feature/UserManagement/data/usermangmentrepo.dart';
import '../../../feature/UserManagement/data/usermangmentrepoimp.dart';
import '../../../feature/UserManagement/presentation/manger/user_cubit.dart';
import '../../../feature/add_users/data/repo/adduserrepo.dart';
import '../../../feature/add_users/presentaion/manger/adduser_cubit.dart';
import '../../../feature/create_invite/data/repo/invitationsecurity_repo.dart';
import '../../../feature/create_invite/data/repo/invitationsecurity_repo_imp.dart';
import '../../../feature/create_invite/presentation/manger/securityonetime_cubit.dart';
import '../../../feature/security_view/data/repo/security_repo.dart';
import '../../../feature/security_view/data/repo/security_repo_imp.dart';
import '../../../feature/security_view/presentation/manger/security_cubit.dart';
import '../api/endpoint.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../../../feature/Chat/data/datasource/chat_datasource.dart';
import '../../../feature/Chat/data/repo/chat_repo.dart';
import '../../../feature/Chat/data/repo/chat_repo_impl.dart';
import '../../../feature/Chat/presentation/manager/chat_contacts_cubit.dart';
import '../firebase/firebase_consumer.dart';

final sl = GetIt.instance;
void setup() {
  // Dio instance registration
  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: EndPoint.baseUrl))
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
        ),
      ),
  );
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Register Firebase Consumer
  sl.registerLazySingleton<FirebaseConsumer>(
    () => BaseFirebaseConsumer(firestore: sl<FirebaseFirestore>()),
  );

  /// Register DioConsumer
  sl.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: sl<Dio>()));
  sl.registerLazySingleton<ApiConsumer>(() => sl<DioConsumer>());

  /// Registering login
  sl.registerLazySingleton<LoginRepo>(
    () => Loginrepoimp(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<LoginRepo>()));

  /// invitation
  sl.registerLazySingleton<Invitationrepo>(
    () => Invitationrepoimp(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<HomeinvitationCubit>(
    () => HomeinvitationCubit(sl<Invitationrepo>()),
  );

  //

  sl.registerLazySingleton<InvitationsecurityRepo>(
    () => Invitatiosecuritynrepoimp(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<SecurityonetimeCubit>(
    () => SecurityonetimeCubit(sl<InvitationsecurityRepo>()),
  );
  //adduser
  sl.registerLazySingleton<Adduserrepo>(
    () => AddUserRepoImpl(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<AdduserCubit>(() => AdduserCubit(sl<Adduserrepo>()));

  //security
  sl.registerLazySingleton<Securityrepo>(
    () => SecurityRepoImp(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<SecurityCubit>(() => SecurityCubit(sl<Securityrepo>()));
  //person
  sl.registerLazySingleton<AccountMangmentrepo>(
    () => AccountMangmentrepoimp(dioConsumer: sl<DioConsumer>()),
  );

  // ثم نسجل الكيوبت
  sl.registerFactory<PersonCubit>(() => PersonCubit(sl<AccountMangmentrepo>()));

  sl.registerLazySingleton<UserMangmentRepo>(
    () => Usermangmentrepoimp(dioConsumer: sl<DioConsumer>()),
  );
  sl.registerFactory<UserCubit>(() => UserCubit(sl<UserMangmentRepo>()));

  /// Chat Feature
  sl.registerLazySingleton<ChatDataSource>(
    () => ChatDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl<ChatDataSource>()),
  );
  sl.registerFactory<ChatContactsCubit>(
    () => ChatContactsCubit(sl<ChatRepository>()),
  );
}
