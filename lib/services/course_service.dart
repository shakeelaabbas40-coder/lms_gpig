import '../models/course_model.dart';
import '../models/assignment_model.dart';
import '../models/quiz_model.dart';
import '../models/result_model.dart';

class CourseService {
  static final CourseService _instance = CourseService._internal();
  factory CourseService() => _instance;
  CourseService._internal();

  final List<CourseModel> _courses = [
    CourseModel(
      id: 'cs_101',
      code: 'CS-302',
      title: 'Mobile App Development with Flutter',
      instructor: 'Dr. Zeeshan Haider',
      instructorAvatar: 'ZH',
      category: 'Development',
      rating: 4.9,
      totalReviews: 840,
      studentsEnrolled: 2310,
      duration: '36 Hours',
      totalLessons: 18,
      progress: 0.65,
      isEnrolled: true,
      colorHex: 0xFF2563EB, // Royal Blue
      description:
          'Master cross-platform mobile application development using Flutter & Dart. Learn state management, REST APIs, local databases, and clean architecture with real-world apps.',
      learningOutcomes: [
        'Build production-ready iOS & Android apps with a single codebase',
        'Master Dart programming language and widget lifecycle',
        'State management using Provider, Bloc, and Riverpod',
        'Integrate Firebase, REST APIs, and SQLite',
      ],
      lessons: [
        LessonModel(id: 'l1', title: 'Introduction to Flutter Architecture', duration: '25 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l2', title: 'Dart Fundamentals & OOP Deep Dive', duration: '45 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l3', title: 'Stateless vs Stateful Widgets', duration: '35 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l4', title: 'Responsive UI Design & Layouts', duration: '50 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l5', title: 'Navigation, Routing & Deep Linking', duration: '40 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l6', title: 'REST API Integration & JSON Parsing', duration: '55 mins', isCompleted: false, type: 'video'),
      ],
    ),
    CourseModel(
      id: 'cs_102',
      code: 'CS-401',
      title: 'Advanced Database Management Systems',
      instructor: 'Prof. Ayesha Siddiqui',
      instructorAvatar: 'AS',
      category: 'Database',
      rating: 4.8,
      totalReviews: 620,
      studentsEnrolled: 1840,
      duration: '30 Hours',
      totalLessons: 15,
      progress: 0.40,
      isEnrolled: true,
      colorHex: 0xFF0D9488, // Teal
      description:
          'In-depth study of relational databases, query optimization, indexing, transaction management, ACID properties, NoSQL, and distributed database systems.',
      learningOutcomes: [
        'Design optimized relational schemas and normalize to BCNF',
        'Write complex SQL queries and analyze execution plans',
        'Understand distributed transactions, concurrency control, and 2PC',
        'Hands-on experience with MongoDB and Redis',
      ],
      lessons: [
        LessonModel(id: 'l21', title: 'Relational Model & Normalization', duration: '50 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l22', title: 'Indexing Techniques: B+ Trees & Hashing', duration: '45 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l23', title: 'Query Execution & Optimization Plans', duration: '60 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l24', title: 'ACID Properties & Transaction Schedules', duration: '40 mins', isCompleted: false, type: 'video'),
      ],
    ),
    CourseModel(
      id: 'cs_103',
      code: 'CS-450',
      title: 'Machine Learning & Neural Networks',
      instructor: 'Dr. Tariq Mahmood',
      instructorAvatar: 'TM',
      category: 'AI & Data Science',
      rating: 4.9,
      totalReviews: 1250,
      studentsEnrolled: 3120,
      duration: '42 Hours',
      totalLessons: 20,
      progress: 0.20,
      isEnrolled: true,
      colorHex: 0xFF7C3AED, // Purple
      description:
          'Explore supervised and unsupervised machine learning algorithms, deep learning with TensorFlow, gradient descent, CNNs, RNNs, and transformer models.',
      learningOutcomes: [
        'Implement Linear Regression, SVM, and Random Forests from scratch',
        'Train neural networks using Backpropagation and Gradient Descent',
        'Build image classification models using Convolutional Neural Networks',
        'Deploy trained ML models to cloud endpoints',
      ],
      lessons: [
        LessonModel(id: 'l31', title: 'Math Foundations for Machine Learning', duration: '55 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l32', title: 'Supervised Learning: Regression & Classification', duration: '60 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l33', title: 'Neural Networks Architecture & Activation Functions', duration: '50 mins', isCompleted: false, type: 'video'),
      ],
    ),
    CourseModel(
      id: 'cs_104',
      code: 'CS-205',
      title: 'UI/UX Design Systems & Figma',
      instructor: 'Ms. Fatima Noor',
      instructorAvatar: 'FN',
      category: 'Design',
      rating: 4.7,
      totalReviews: 430,
      studentsEnrolled: 1520,
      duration: '24 Hours',
      totalLessons: 12,
      progress: 0.85,
      isEnrolled: true,
      colorHex: 0xFFEA580C, // Orange
      description:
          'Learn human-centered design principles, wireframing, high-fidelity interactive prototyping, usability testing, and design tokens using Figma.',
      learningOutcomes: [
        'Master Figma components, auto-layout, and interactive variants',
        'Design complete design systems with typography & color scales',
        'Conduct usability tests and user interviews',
        'Design accessible interfaces adhering to WCAG 2.1 guidelines',
      ],
      lessons: [
        LessonModel(id: 'l41', title: 'Design Thinking & User Research', duration: '30 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l42', title: 'Wireframing & Information Architecture', duration: '40 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l43', title: 'Auto-Layout & Components in Figma', duration: '50 mins', isCompleted: true, type: 'video'),
        LessonModel(id: 'l44', title: 'Interactive Micro-interactions & Prototyping', duration: '45 mins', isCompleted: false, type: 'video'),
      ],
    ),
    CourseModel(
      id: 'cs_105',
      code: 'CS-310',
      title: 'Cloud Computing & DevOps Essentials',
      instructor: 'Engr. Bilal Ahmed',
      instructorAvatar: 'BA',
      category: 'Cloud & DevOps',
      rating: 4.8,
      totalReviews: 510,
      studentsEnrolled: 1980,
      duration: '28 Hours',
      totalLessons: 14,
      progress: 0.0,
      isEnrolled: false,
      colorHex: 0xFF059669, // Emerald
      description:
          'Understand cloud architectures on AWS & GCP. Containerize applications with Docker, orchestrate with Kubernetes, and build CI/CD pipelines.',
      learningOutcomes: [
        'Deploy applications to AWS EC2, S3, and RDS',
        'Containerize multi-container web apps using Docker Compose',
        'Configure Kubernetes deployments, services, and ingress',
        'Automate testing and deployment with GitHub Actions',
      ],
      lessons: [
        LessonModel(id: 'l51', title: 'Cloud Computing Concepts & Virtualization', duration: '35 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l52', title: 'Docker Containers & Images', duration: '45 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l53', title: 'Kubernetes Pods, Services & Deployments', duration: '55 mins', isCompleted: false, type: 'video'),
      ],
    ),
    CourseModel(
      id: 'cs_106',
      code: 'CS-330',
      title: 'Cyber Security & Network Defense',
      instructor: 'Dr. Imran Qureshi',
      instructorAvatar: 'IQ',
      category: 'Security',
      rating: 4.9,
      totalReviews: 760,
      studentsEnrolled: 2450,
      duration: '32 Hours',
      totalLessons: 16,
      progress: 0.0,
      isEnrolled: false,
      colorHex: 0xFFDC2626, // Red
      description:
          'Learn ethical hacking methodologies, network vulnerabilities, cryptography, firewalls, and defense against modern cyber threats.',
      learningOutcomes: [
        'Analyze network packets with Wireshark and identify anomalies',
        'Understand symmetric and asymmetric encryption protocols',
        'Perform web security assessments for OWASP Top 10 vulnerabilities',
        'Implement secure firewall rules and IDS/IPS systems',
      ],
      lessons: [
        LessonModel(id: 'l61', title: 'Fundamentals of Network Security', duration: '40 mins', isCompleted: false, type: 'video'),
        LessonModel(id: 'l62', title: 'Applied Cryptography & RSA Algorithm', duration: '50 mins', isCompleted: false, type: 'video'),
      ],
    ),
  ];

  final List<AssignmentModel> _assignments = [
    AssignmentModel(
      id: 'asg_1',
      title: 'Assignment 3: Flutter State Management with Provider',
      courseTitle: 'Mobile App Development with Flutter',
      courseCode: 'CS-302',
      dueDate: 'Tomorrow, 11:59 PM',
      totalPoints: 50,
      status: 'pending',
      description: 'Implement a multi-screen shopping cart app using Provider pattern with clean state separation.',
      instructions:
          '1. Create a ProductList and CartScreen.\n2. Use ChangeNotifierProvider to manage cart state.\n3. Implement add, remove, and quantity update functionality.\n4. Submit a zip archive of lib/ folder along with screenshots.',
    ),
    AssignmentModel(
      id: 'asg_2',
      title: 'Assignment 2: B+ Tree Indexing & Query Plans',
      courseTitle: 'Advanced Database Management Systems',
      courseCode: 'CS-401',
      dueDate: 'Oct 10, 2026',
      totalPoints: 40,
      status: 'pending',
      description: 'Draw step-by-step B+ Tree insertion diagrams and calculate tree height for given dataset.',
      instructions:
          'Submit PDF document with clear step-by-step illustrations of node splits and re-balancing for order p=4.',
    ),
    AssignmentModel(
      id: 'asg_3',
      title: 'Assignment 1: High-Fidelity Prototype in Figma',
      courseTitle: 'UI/UX Design Systems & Figma',
      courseCode: 'CS-205',
      dueDate: 'Submitted on Oct 1, 2026',
      totalPoints: 30,
      obtainedPoints: 28,
      status: 'graded',
      submissionDate: 'Oct 1, 2026, 08:30 PM',
      submissionNote: 'Figma public preview link submitted with full component guide.',
      teacherFeedback: 'Outstanding typography choice and cohesive color palette! Minor spacing issue in navigation bar.',
      description: 'Design mobile and desktop screens for an online food delivery service adhering to WCAG 2.1.',
      instructions: 'Share public Figma link with view permissions enabled.',
    ),
    AssignmentModel(
      id: 'asg_4',
      title: 'Assignment 1: Linear Regression & Gradient Descent',
      courseTitle: 'Machine Learning & Neural Networks',
      courseCode: 'CS-450',
      dueDate: 'Submitted on Sep 28, 2026',
      totalPoints: 50,
      status: 'submitted',
      submissionDate: 'Sep 28, 2026, 04:15 PM',
      submissionNote: 'Jupyter notebook (.ipynb) with loss curve plots uploaded.',
      description: 'Implement batch and stochastic gradient descent in pure Python without scikit-learn.',
      instructions: 'Plot loss vs epochs curve for different learning rates (0.01, 0.001, 0.1).',
    ),
  ];

  final List<QuizModel> _quizzes = [
    QuizModel(
      id: 'qz_1',
      title: 'Midterm Quiz: Flutter Widgets & Lifecycle',
      courseTitle: 'Mobile App Development with Flutter',
      courseCode: 'CS-302',
      totalQuestions: 5,
      durationMinutes: 10,
      totalMarks: 20,
      dueDate: 'Due: Oct 08, 2026',
      questions: [
        QuizQuestion(
          question: 'Which method in State<T> is called only once when the widget enters the tree?',
          options: ['build()', 'initState()', 'didUpdateWidget()', 'dispose()'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'What is the purpose of the const constructor in Flutter widgets?',
          options: [
            'Makes widget rebuild on every tick',
            'Prevents unnecessary widget rebuilds by reusing instances',
            'Converts widget to a stateful widget',
            'Enables animations automatically'
          ],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'Which widget is used to lay out children vertically in Flutter?',
          options: ['Row', 'Column', 'Stack', 'Wrap'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'How do you create an immutable class in Dart?',
          options: ['Mark with @immutable and make all fields final', 'Declare class as sealed', 'Use dynamic types', 'Declare class as static'],
          correctOptionIndex: 0,
        ),
        QuizQuestion(
          question: 'What is the difference between Hot Reload and Hot Restart?',
          options: [
            'Hot Reload is slower than Hot Restart',
            'Hot Reload preserves state while Hot Restart resets app state',
            'Hot Reload recompiles C++ engine',
            'They perform the exact same action'
          ],
          correctOptionIndex: 1,
        ),
      ],
    ),
    QuizModel(
      id: 'qz_2',
      title: 'Quiz 2: Relational Normalization & SQL Queries',
      courseTitle: 'Advanced Database Management Systems',
      courseCode: 'CS-401',
      totalQuestions: 4,
      durationMinutes: 8,
      totalMarks: 15,
      score: 14,
      isCompleted: true,
      dueDate: 'Completed on Sep 29, 2026',
      questions: [
        QuizQuestion(
          question: 'A table is in 3NF if it is in 2NF and has no:',
          options: ['Partial dependency', 'Transitive dependency', 'Primary key', 'Candidate key'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'Which index structure is most widely used for range queries in RDBMS?',
          options: ['Hash Index', 'B+ Tree Index', 'Bitmap Index', 'Inverted Index'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'What does the "I" in ACID stand for?',
          options: ['Integrity', 'Isolation', 'Inheritance', 'Index'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'Which SQL clause is used to filter records after aggregation (GROUP BY)?',
          options: ['WHERE', 'HAVING', 'ORDER BY', 'LIMIT'],
          correctOptionIndex: 1,
        ),
      ],
    ),
    QuizModel(
      id: 'qz_3',
      title: 'Quiz 1: User Research & Figma Fundamentals',
      courseTitle: 'UI/UX Design Systems & Figma',
      courseCode: 'CS-205',
      totalQuestions: 3,
      durationMinutes: 6,
      totalMarks: 10,
      score: 10,
      isCompleted: true,
      dueDate: 'Completed on Sep 22, 2026',
      questions: [
        QuizQuestion(
          question: 'What feature in Figma allows responsive design inside frames?',
          options: ['Auto-Layout', 'Vector Network', 'Pen Tool', 'Smart Animate'],
          correctOptionIndex: 0,
        ),
        QuizQuestion(
          question: 'Which contrast ratio is required for normal text under WCAG AA standards?',
          options: ['3:1', '4.5:1', '7:1', '10:1'],
          correctOptionIndex: 1,
        ),
        QuizQuestion(
          question: 'What is a low-fidelity prototype primarily used for?',
          options: ['Final user testing', 'Rapid concept exploration and layout testing', 'Production release', 'Marketing banners'],
          correctOptionIndex: 1,
        ),
      ],
    ),
  ];

  final List<ResultModel> _results = [
    ResultModel(
      courseCode: 'CS-302',
      courseTitle: 'Mobile App Development',
      creditHours: 4,
      totalMarks: 100,
      obtainedMarks: 94,
      grade: 'A',
      gradePoint: 4.00,
      remarks: 'Excellent performance in hands-on lab and semester project.',
    ),
    ResultModel(
      courseCode: 'CS-401',
      courseTitle: 'Advanced Database Systems',
      creditHours: 3,
      totalMarks: 100,
      obtainedMarks: 86,
      grade: 'A-',
      gradePoint: 3.70,
      remarks: 'Strong theoretical grasp of query optimization.',
    ),
    ResultModel(
      courseCode: 'CS-205',
      courseTitle: 'UI/UX Design Systems',
      creditHours: 3,
      totalMarks: 100,
      obtainedMarks: 96,
      grade: 'A+',
      gradePoint: 4.00,
      remarks: 'Creative prototype designs and great presentation.',
    ),
    ResultModel(
      courseCode: 'CS-450',
      courseTitle: 'Machine Learning',
      creditHours: 4,
      totalMarks: 100,
      obtainedMarks: 82,
      grade: 'B+',
      gradePoint: 3.30,
      remarks: 'Good progress in neural network models and training.',
    ),
    ResultModel(
      courseCode: 'HU-101',
      courseTitle: 'Technical Communication & Ethics',
      creditHours: 2,
      totalMarks: 100,
      obtainedMarks: 90,
      grade: 'A',
      gradePoint: 4.00,
      remarks: 'Active participant in seminar presentations.',
    ),
  ];

  List<CourseModel> getAllCourses() => _courses;
  List<CourseModel> getEnrolledCourses() => _courses.where((c) => c.isEnrolled).toList();

  void toggleEnrollment(String courseId) {
    final index = _courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      final current = _courses[index];
      _courses[index] = current.copyWith(
        isEnrolled: !current.isEnrolled,
        progress: !current.isEnrolled ? 0.05 : 0.0,
      );
    }
  }

  void updateLessonCompletion(String courseId, String lessonId, bool isCompleted) {
    final courseIndex = _courses.indexWhere((c) => c.id == courseId);
    if (courseIndex != -1) {
      final course = _courses[courseIndex];
      final lessonIndex = course.lessons.indexWhere((l) => l.id == lessonId);
      if (lessonIndex != -1) {
        course.lessons[lessonIndex] = LessonModel(
          id: course.lessons[lessonIndex].id,
          title: course.lessons[lessonIndex].title,
          duration: course.lessons[lessonIndex].duration,
          isCompleted: isCompleted,
          type: course.lessons[lessonIndex].type,
        );

        final completedCount = course.lessons.where((l) => l.isCompleted).length;
        final newProgress = course.lessons.isEmpty ? 0.0 : completedCount / course.lessons.length;
        _courses[courseIndex] = course.copyWith(progress: newProgress);
      }
    }
  }

  List<AssignmentModel> getAssignments() => _assignments;

  void submitAssignment(String assignmentId, String submissionNote) {
    final index = _assignments.indexWhere((a) => a.id == assignmentId);
    if (index != -1) {
      _assignments[index] = _assignments[index].copyWith(
        status: 'submitted',
        submissionDate: 'Just now',
        submissionNote: submissionNote,
      );
    }
  }

  List<QuizModel> getQuizzes() => _quizzes;

  void submitQuiz(String quizId, int calculatedScore) {
    final index = _quizzes.indexWhere((q) => q.id == quizId);
    if (index != -1) {
      _quizzes[index] = _quizzes[index].copyWith(
        isCompleted: true,
        score: calculatedScore,
      );
    }
  }

  List<ResultModel> getResults() => _results;
}
