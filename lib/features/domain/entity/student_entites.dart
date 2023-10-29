class StudentEntity {
  final String? password; // Unique identifier for the student
  final String? fullName; // Full name of the student
  final int? age; // Age of the student
  final String? email; // Email address of the student
  final String? profileImageUrl; // URL to the student's profile image
  final String? rollNumber; // Roll number of the student
  final String? course; // Course in which the student is enrolled

  StudentEntity({
     this.password,
     this.fullName,
     this.age,
    this.email,
     this.profileImageUrl,
     this.rollNumber,
     this.course,
  });
}