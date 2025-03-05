import 'package:projectsyeti/features/certification/domain/entity/certification_entity.dart';
import 'package:projectsyeti/features/experience/domain/entity/experience_entity.dart';
import 'package:projectsyeti/features/freelancer/domain/entity/freelancer_entity.dart';
import 'package:projectsyeti/features/skill/domain/entity/skill_entity.dart';

final DateTime testDate = DateTime(2025, 3, 3, 13, 45, 55, 4);

final FreelancerEntity freelancer = FreelancerEntity(
  id: '679e5d8f4e658cfacb72a07d',
  userId: '679e4f5ad588a2d01a28724f',
  skills: const [
    SkillEntity(skillId: '679b4fbb7dbeac15d47c7cdb', name: 'Flutter'),
    SkillEntity(skillId: '679b4fdc7dbeac15d47c7cde', name: 'React'),
  ],
  experienceYears: 5,
  freelancerName: 'Prajwal Pokhrel',
  availability: 'part time',
  portfolio: 'https://prajwal10.com.np',
  profileImage: '',
  projectsCompleted: 0,
  createdAt: testDate,
  updatedAt: testDate,
  certifications: const [
    CertificationEntity(name: 'CCNP', organization: 'CISCO'),
    CertificationEntity(name: 'Certification 2', organization: 'My startup'),
  ],
  experience: const [
    ExperienceEntity(
      title: 'web developer',
      description: 'I did some work in Web API development.',
      company: 'technergy global',
      from: 2025,
      to: 2025,
    ),
    ExperienceEntity(
      title: 'Mobile App Developer',
      description: 'I did some flutter mobile app development',
      company: 'Stable Cluster Pvt. Ltd.',
      from: 2024,
      to: 2025,
    ),
  ],
  languages: const ['nepali', 'english', 'hindi'],
  profession: 'software developer',
  location: 'kathmandu',
  aboutMe: 'I like to go swimming',
  workAt: 'freelancer',
);
