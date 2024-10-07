import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/models/x_profile.dart';
import '../hosamAddition/HttpReqstats/Loaders/SingleWidget.dart';
import '../hosamAddition/HttpReqstats/httpStats.dart';
import '../main.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
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
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final XProfile profile;

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
  final XProfile profile;

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
  final XProfile profile;

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
  final XProfile profile;

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
  final XProfile profile;

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