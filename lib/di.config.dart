// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'features/auth/data/data_sources/remote/auth_remote_ds.dart' as _i981;
import 'features/auth/data/data_sources/remote/auth_remote_ds_impl.dart'
    as _i393;
import 'features/auth/data/repositories/auth_repo_impl.dart' as _i426;
import 'features/auth/domain/repositories/auth_repo.dart' as _i416;
import 'features/auth/domain/use_cases/signUp_usecase.dart' as _i286;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i981.AuthRemoteDataSource>(() => _i393.AuthRemoteDsImpl());
    gh.factory<_i416.AuthRepository>(
      () => _i426.AuthRepositoryImpl(
        authRemoteDataSource: gh<_i981.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i286.SignUpUseCase>(
      () => _i286.SignUpUseCase(authRepository: gh<_i416.AuthRepository>()),
    );
    gh.factory<_i363.AuthBloc>(() => _i363.AuthBloc(gh<_i286.SignUpUseCase>()));
    return this;
  }
}
