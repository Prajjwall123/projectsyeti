import 'package:equatable/equatable.dart';

class CertificationEntity extends Equatable {
  final String name;
  final String organization;

  const CertificationEntity({
    required this.name,
    required this.organization,
  });

  @override
  List<Object> get props => [name, organization];

  CertificationEntity copyWith({
    String? name,
    String? organization,
  }) {
    return CertificationEntity(
      name: name ?? this.name,
      organization: organization ?? this.organization,
    );
  }
}
