// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // Provider for AI Service
// final aiCareerServiceProvider = Provider<AICareerService>((ref) {
//   return AICareerService();
// });

// class AICareerService {
//   late final GenerativeModel _model;

//   AICareerService() {
//     // Get API key from environment or Supabase Edge Function
//     const apiKey = String.fromEnvironment('GEMINI_API_KEY');
//     _model = GenerativeModel(
//       model: 'gemini-pro',
//       apiKey: apiKey,
//     );
//   }

//   /// Generate career path recommendations based on user profile
//   Future<CareerRecommendation> getCareerRecommendations({
//     required List<String> skills,
//     required List<String> interests,
//     required List<String> careerInterests,
//     required List<String> goals,
//     required String experienceLevel,
//     String? currentRole,
//   }) async {
//     final prompt = _buildCareerPrompt(
//       skills: skills,
//       interests: interests,
//       careerInterests: careerInterests,
//       goals: goals,
//       experienceLevel: experienceLevel,
//       currentRole: currentRole,
//     );

//     try {
//       final response = await _model.generateContent([Content.text(prompt)]);
//       final text = response.text ?? '';
      
//       return _parseCareerRecommendation(text);
//     } catch (e) {
//       throw Exception('Failed to get career recommendations: $e');
//     }
//   }

//   /// Find matching mentors based on student profile
//   Future<List<String>> findMatchingMentors({
//     required List<String> studentSkills,
//     required List<String> studentInterests,
//     required List<String> careerGoals,
//     required List<Map<String, dynamic>> availableMentors,
//   }) async {
//     final prompt = '''
// You are an AI mentor matching system. Based on the student's profile, rank the following mentors by compatibility (most compatible first).

// Student Profile:
// - Skills: ${studentSkills.join(', ')}
// - Interests: ${studentInterests.join(', ')}
// - Career Goals: ${careerGoals.join(', ')}

// Available Mentors:
// ${availableMentors.map((m) => '''
// ID: ${m['id']}
// Skills: ${(m['skills'] as List).join(', ')}
// Interests: ${(m['interests'] as List).join(', ')}
// Position: ${m['current_position']}
// Company: ${m['company']}
// Experience: ${m['years_of_experience']} years
// ''').join('\n---\n')}

// Return ONLY a JSON array of mentor IDs in order of compatibility, like: ["id1", "id2", "id3"]
// ''';

//     try {
//       final response = await _model.generateContent([Content.text(prompt)]);
//       final text = response.text ?? '';
      
//       // Extract JSON array from response
//       final jsonMatch = RegExp(r'\[.*?\]').firstMatch(text);
//       if (jsonMatch != null) {
//         final jsonStr = jsonMatch.group(0)!;
//         final List<dynamic> ids = jsonDecode(jsonStr);
//         return ids.cast<String>();
//       }
      
//       return [];
//     } catch (e) {
//       throw Exception('Failed to match mentors: $e');
//     }
//   }

//   /// Generate personalized learning roadmap
//   Future<LearningRoadmap> generateLearningRoadmap({
//     required String targetCareer,
//     required List<String> currentSkills,
//     required String experienceLevel,
//   }) async {
//     final prompt = '''
// Create a detailed learning roadmap for someone who wants to become a $targetCareer.

// Current Profile:
// - Current Skills: ${currentSkills.join(', ')}
// - Experience Level: $experienceLevel

// Provide:
// 1. Skills Gap Analysis (what skills are missing)
// 2. Learning Path (step-by-step phases)
// 3. Recommended Resources (courses, books, projects)
// 4. Estimated Timeline
// 5. Milestones to track progress

// Format the response as JSON:
// {
//   "skillsGap": ["skill1", "skill2"],
//   "phases": [
//     {
//       "phase": "Phase 1: Foundations",
//       "duration": "2-3 months",
//       "skills": ["skill1", "skill2"],
//       "resources": ["resource1", "resource2"],
//       "projects": ["project1"]
//     }
//   ],
//   "estimatedTimeline": "6-12 months",
//   "milestones": ["milestone1", "milestone2"]
// }
// ''';

//     try {
//       final response = await _model.generateContent([Content.text(prompt)]);
//       final text = response.text ?? '';
      
//       // Extract JSON from response
//       final jsonMatch = RegExp(r'\{.*\}', dotAll: true).firstMatch(text);
//       if (jsonMatch != null) {
//         final jsonStr = jsonMatch.group(0)!;
//         final Map<String, dynamic> data = jsonDecode(jsonStr);
//         return LearningRoadmap.fromJson(data);
//       }
      
//       throw Exception('Failed to parse roadmap');
//     } catch (e) {
//       throw Exception('Failed to generate roadmap: $e');
//     }
//   }

//   String _buildCareerPrompt({
//     required List<String> skills,
//     required List<String> interests,
//     required List<String> careerInterests,
//     required List<String> goals,
//     required String experienceLevel,
//     String? currentRole,
//   }) {
//     return '''
// You are an AI career advisor. Based on the following profile, suggest 3-5 relevant career paths with explanations.

// Profile:
// - Skills: ${skills.join(', ')}
// - Interests: ${interests.join(', ')}
// - Career Interests: ${careerInterests.join(', ')}
// - Goals: ${goals.join(', ')}
// - Experience Level: $experienceLevel
// ${currentRole != null ? '- Current Role: $currentRole' : ''}

// For each career path, provide:
// 1. Career Title
// 2. Why it's a good fit (2-3 sentences)
// 3. Required skills they already have
// 4. Skills they need to develop
// 5. Potential salary range
// 6. Growth prospects

// Format as JSON:
// {
//   "recommendations": [
//     {
//       "title": "Career Title",
//       "fitReason": "Why it's a good fit",
//       "matchingSkills": ["skill1", "skill2"],
//       "skillsToLearn": ["skill1", "skill2"],
//       "salaryRange": "Range",
//       "growthProspects": "High/Medium/Low"
//     }
//   ]
// }
// ''';
//   }

//   CareerRecommendation _parseCareerRecommendation(String text) {
//     try {
//       // Extract JSON from response
//       final jsonMatch = RegExp(r'\{.*\}', dotAll: true).firstMatch(text);
//       if (jsonMatch != null) {
//         final jsonStr = jsonMatch.group(0)!;
//         final Map<String, dynamic> data = jsonDecode(jsonStr);
//         return CareerRecommendation.fromJson(data);
//       }
//     } catch (e) {
//       // Fallback: parse text manually if JSON parsing fails
//     }
    
//     return CareerRecommendation(recommendations: []);
//   }
// }

// // Models
// class CareerRecommendation {
//   final List<CareerPath> recommendations;

//   CareerRecommendation({required this.recommendations});

//   factory CareerRecommendation.fromJson(Map<String, dynamic> json) {
//     return CareerRecommendation(
//       recommendations: (json['recommendations'] as List)
//           .map((item) => CareerPath.fromJson(item))
//           .toList(),
//     );
//   }
// }

// class CareerPath {
//   final String title;
//   final String fitReason;
//   final List<String> matchingSkills;
//   final List<String> skillsToLearn;
//   final String salaryRange;
//   final String growthProspects;

//   CareerPath({
//     required this.title,
//     required this.fitReason,
//     required this.matchingSkills,
//     required this.skillsToLearn,
//     required this.salaryRange,
//     required this.growthProspects,
//   });

//   factory CareerPath.fromJson(Map<String, dynamic> json) {
//     return CareerPath(
//       title: json['title'],
//       fitReason: json['fitReason'],
//       matchingSkills: List<String>.from(json['matchingSkills'] ?? []),
//       skillsToLearn: List<String>.from(json['skillsToLearn'] ?? []),
//       salaryRange: json['salaryRange'],
//       growthProspects: json['growthProspects'],
//     );
//   }
// }

// class LearningRoadmap {
//   final List<String> skillsGap;
//   final List<LearningPhase> phases;
//   final String estimatedTimeline;
//   final List<String> milestones;

//   LearningRoadmap({
//     required this.skillsGap,
//     required this.phases,
//     required this.estimatedTimeline,
//     required this.milestones,
//   });

//   factory LearningRoadmap.fromJson(Map<String, dynamic> json) {
//     return LearningRoadmap(
//       skillsGap: List<String>.from(json['skillsGap'] ?? []),
//       phases: (json['phases'] as List)
//           .map((item) => LearningPhase.fromJson(item))
//           .toList(),
//       estimatedTimeline: json['estimatedTimeline'],
//       milestones: List<String>.from(json['milestones'] ?? []),
//     );
//   }
// }

// class LearningPhase {
//   final String phase;
//   final String duration;
//   final List<String> skills;
//   final List<String> resources;
//   final List<String> projects;

//   LearningPhase({
//     required this.phase,
//     required this.duration,
//     required this.skills,
//     required this.resources,
//     required this.projects,
//   });

//   factory LearningPhase.fromJson(Map<String, dynamic> json) {
//     return LearningPhase(
//       phase: json['phase'],
//       duration: json['duration'],
//       skills: List<String>.from(json['skills'] ?? []),
//       resources: List<String>.from(json['resources'] ?? []),
//       projects: List<String>.from(json['projects'] ?? []),
//     );
//   }
// }