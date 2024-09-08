import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Profile {
  final String name;
  final String major;
  final String department;
  final int currentSemester;
  final int enrolledCourses;
  final int completedCourses;
  final int coursesInProgress;
  final List<Skill> skills;
  final List<Experience> experiences;
  final List<Certificate> certificates;

  Profile({
    required this.name,
    required this.major,
    required this.department,
    required this.currentSemester,
    required this.enrolledCourses,
    required this.completedCourses,
    required this.coursesInProgress,
    required this.skills,
    required this.experiences,
    required this.certificates,
  });
}

class Skill {
  final String name;
  final int score;

  Skill({required this.name, required this.score});
}

class Experience {
  final String title;
  final String company;
  final String location;
  final String period;

  Experience({
    required this.title,
    required this.company,
    required this.location,
    required this.period,
  });
}

class Certificate {
  final String title;
  final String issuer;
  final String date;
  final String credentialId;

  Certificate({
    required this.title,
    required this.issuer,
    required this.date,
    required this.credentialId,
  });
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Profile(
      name: 'Sara Mohamed Ayman',
      major: 'Mechanical Engineering',
      department: 'Applied Sciences and Engineering',
      currentSemester: 4,
      enrolledCourses: 15,
      completedCourses: 8,
      coursesInProgress: 6,
      skills: [
        Skill(name: 'Leadership and Coordination', score: 92),
        Skill(name: 'Data Gathering and Interpretation', score: 88),
        Skill(name: 'Capacity to Learn', score: 85),
      ],
      experiences: [
        Experience(
          title: 'Industrial Designer',
          company: 'Fabcube Srl',
          location: 'Vittorio Veneto, Italy',
          period: 'Apr 2021 - Jul 2021',
        ),
        Experience(
          title: 'Industrial Designer',
          company: 'NilePreneurs',
          location: 'Giza, Egypt',
          period: 'Mar 2020 - May 2020',
        ),
      ],
      certificates: [
        Certificate(
          title: 'Foundations of Project Management',
          issuer: 'Coursera',
          date: 'May 2023',
          credentialId: 'MLZSH99VJK9K',
        ),
        Certificate(
          title: 'Google UX Design Certificate',
          issuer: 'Coursera',
          date: 'Mar 2022',
          credentialId: '',
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(profile: profile),
            const SizedBox(height: 20),
            StudentStatusSection(profile: profile),
            const SizedBox(height: 20),
            SkillsSection(profile: profile),
            const SizedBox(height: 20),
            ExperienceSection(profile: profile),
            const SizedBox(height: 20),
            CertificateSection(profile: profile),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final Profile profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              'https://www.example.com/profile_image.jpg'), // Replace with profile image URL
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              profile.major,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              profile.department,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

// Student Status Section with CircularProgressIndicator
class StudentStatusSection extends StatelessWidget {
  final Profile profile;

  const StudentStatusSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Student Status',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircularProgressBar(
              label: 'Enrolled Courses',
              value: profile.enrolledCourses / 20, // Assuming a max of 20 courses
              number: profile.enrolledCourses,
            ),
            CircularProgressBar(
              label: 'Completed Courses',
              value: profile.completedCourses / profile.enrolledCourses,
              number: profile.completedCourses,
            ),
            CircularProgressBar(
              label: 'Courses In Progress',
              value: profile.coursesInProgress / profile.enrolledCourses,
              number: profile.coursesInProgress,
            ),
          ],
        ),
      ],
    );
  }
}

// Skills Section with CircularProgressIndicator
class SkillsSection extends StatelessWidget {
  final Profile profile;

  const SkillsSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Top Skills',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: profile.skills.map((skill) {
            return CircularProgressBar(
              label: skill.name,
              value: skill.score / 100,
              number: skill.score,
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Custom widget to create a circular progress bar with label and percentage
class CircularProgressBar extends StatelessWidget {
  final String label;
  final double value;
  final int number;

  const CircularProgressBar({
    super.key,
    required this.label,
    required this.value,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 6,
                backgroundColor: Colors.grey.shade300, // Background color for the circular bar
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF007ac3)), // Primary color #007ac3
              ),
            ),
            Text(
              '$number',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 80,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class ExperienceSection extends StatelessWidget {
  final Profile profile;

  const ExperienceSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Work Experience',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...profile.experiences.map((experience) {
          return ListTile(
            leading: const Icon(Icons.work),
            title: Text(experience.title),
            subtitle: Text('${experience.company} - ${experience.location}'),
            trailing: Text(experience.period),
          );
        }).toList(),
      ],
    );
  }
}

class CertificateSection extends StatelessWidget {
  final Profile profile;

  const CertificateSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Certificates and Licenses',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...profile.certificates.map((certificate) {
          return ListTile(
            leading: const Icon(Icons.school),
            title: Text(certificate.title),
            subtitle: Text('${certificate.issuer} - ${certificate.date}'),
            trailing: ElevatedButton(
              onPressed: () {},
              child: const Text('Show credential'),
            ),
          );
        }).toList(),
      ],
    );
  }
}