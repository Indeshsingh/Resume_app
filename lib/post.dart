// class Post {
//   int? albumId;
//   int? id;
//   String? title;
//   String? url;
//   String? thumbnailUrl;

//   Post({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

//   Post.fromJson(Map<String, dynamic> json) {
//     albumId = json['albumId'];
//     id = json['id'];
//     title = json['title'];
//     url = json['url'];
//     thumbnailUrl = json['thumbnailUrl'];
//   }
// }

// class Post {
//   String? designation;
//   String? firstName;
//   String? middleName;
//   String? lastName;
//   String? dob;
//   String? phone;
//   String? email;
//   String? address;
//   String? summary;
//   String? githubLink;
//   List<String>? education;
//   String? collegeName;
//   String? degreeName;
//   String? educationCity;
//   String? jobtitle;
//   String? organization;
//   String? jobCity;
//   String? jobDescription;
//   String? hobbies;
//   List<String>? languages;

//   Post(
//       {this.firstName,
//       this.middleName,
//       this.lastName,
//       this.dob,
//       this.address,
//       this.education,
//       this.designation,
//       this.phone,
//       this.email,
//       this.summary,
//       this.githubLink,
//       this.collegeName,
//       this.degreeName,
//       this.educationCity,
//       this.jobtitle,
//       this.organization,
//       this.jobCity,
//       this.jobDescription,
//       this.hobbies,
//       this.languages});

//   Post.fromJson(Map<String, dynamic> json) {
//     designation = json["Designation"];
//     firstName = json['First Name'];
//     middleName = json["Middle Name"];
//     lastName = json['Last Name'];
//     dob = json['DOB'];
//     phone = json["Phone"];
//     email = json["Email"];
//     address = json["Address"];
//     githubLink = json["Github Link"];
//     summary = json["Summary"];
//     education =
//         json['Education'] != null ? List<String>.from(json['Education']) : null;

//     print('Parsed DOB: $dob');
//     collegeName = json["College Name"];
//     degreeName = json["Degree Name"];
//     educationCity = json["Education City"];
//     jobtitle = json["Job Title"];
//     organization = json["Organization"];
//     jobCity = json["Job City"];
//     jobDescription = json["Job Description"];
//     hobbies = json["Hobbies"];
//     languages =
//         json["Languages"] != null ? List<String>.from(json['Languages']) : null;
//   }
// }

class Post {
  final String firstName;
  final String middleName;
  final String lastName;
  final String? designation;
  final String? githubLink;
  final String? email;
  final String? dob;
  final String? address;
  final String? phone;
  final String? collegeName;
  final String? degreeName;
  final String? educationCity;
  final String? jobtitle;
  final String? jobDescription;
  final String? organization;
  final String? jobCity;
  final String? summary;
  final String? hobbies;
  final List<String>? languages;
  final String? photoUrl;

  Post({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    this.designation,
    this.githubLink,
    this.email,
    this.dob,
    this.address,
    this.phone,
    this.collegeName,
    this.degreeName,
    this.educationCity,
    this.jobtitle,
    this.jobDescription,
    this.organization,
    this.jobCity,
    this.summary,
    this.hobbies,
    this.languages,
    this.photoUrl,
  });

  // Factory constructor to create a Post object from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      firstName: json['First Name'] ?? '',
      middleName: json['Middle Name'] ?? '',
      lastName: json['Last Name'] ?? '',
      designation: json['Designation'],
      githubLink: json['Github Link'],
      email: json['Email'],
      dob: json['DOB'],
      address: json['Address'],
      phone: json['Phone'],
      collegeName: json['College Name'],
      degreeName: json['Degree Name'],
      educationCity: json['Education City'],
      jobtitle: json['Job Title'],
      jobDescription: json['Job Description'],
      organization: json['Organization'],
      jobCity: json['Job City'],
      summary: json['Summary'],
      hobbies: json['Hobbies'],
      languages: json['Languages'] != null
          ? List<String>.from(json['Languages'])
          : null,
      photoUrl: json['PhotoUrl'],
    );
  }

  // Method to convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      "fields": {
        'First Name': firstName,
        'Middle Name': middleName,
        'Last Name': lastName,
        'Designation': designation,
        'Github Link': githubLink,
        'Email': email,
        'DOB': dob,
        'Address': address,
        'Phone': phone,
        'College Name': collegeName,
        'Degree Name': degreeName,
        'Education City': educationCity,
        'Job Title': jobtitle,
        'Job Description': jobDescription,
        'Organization': organization,
        'Job City': jobCity,
        'Summary': summary,
        'Hobbies': hobbies,
        'Languages': languages,
        'PhotoUrl': photoUrl,
      }
    };
  }
}
