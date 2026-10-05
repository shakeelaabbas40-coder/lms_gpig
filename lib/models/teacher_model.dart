/// Model representing a teacher/faculty member in the LMS.
///
/// All fields except [id] and [name] are optional so you can add
/// as much or as little detail as needed when populating the list later.
class TeacherModel {
  final String id;
  final String name;
  final String subject;       // Primary subject / course they teach
  final String department;    // e.g. "Computer Science"
  final String teacherId;     // e.g. "TCH-001"
  final String email;         // optional contact email
  final String qualification; // e.g. "PhD, M.Sc"
  final String imageInitials; // override auto-derived initials

  const TeacherModel({
    required this.id,
    required this.name,
    this.subject = '',
    this.department = '',
    this.teacherId = '',
    this.email = '',
    this.qualification = '',
    this.imageInitials = '',
  });

  /// Returns initials for the avatar circle.
  /// Uses [imageInitials] if provided, otherwise derives from [name].
  String get avatarInitials {
    if (imageInitials.isNotEmpty) return imageInitials;
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}
