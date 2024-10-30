import 'dart:math';

class QuizzModel {
  final String question;
  final List<String> options;
  final String answer;
  final int score;

  QuizzModel({
    required this.score,
    required this.question,
    required this.options,
    required this.answer,
  });

  static List<QuizzModel> get() {
    List<QuizzModel> questions = [
      QuizzModel(
        score: 25, // Medium
        question: "WHEN WAS CURIOSITY LAUNCHED?",
        options: [
          "June 6, 2012",
          "January 12, 2014",
          "November 26, 2011",
        ],
        answer: "November 26, 2011",
      ),
      QuizzModel(
        score: 25, // Medium
        question: "CURIOSITY LANDED ON MARS ON:",
        options: [
          "April 24, 2014",
          "August 6, 2012",
          "November 26, 2011",
        ],
        answer: "August 6, 2012",
      ),
      QuizzModel(
        score: 25, // Hard
        question: "CURIOSITY IS POWERED BY A:",
        options: [
          "Wind turbine",
          "Radioisotope generator",
          "Solar Panel",
        ],
        answer: "Radioisotope generator",
      ),
      QuizzModel(
        score: 25, // Easy
        question: "Which of those is a valid IP address:",
        options: [
          "192.168.2",
          "190.49.223.14",
          "55.3.134.122",
        ],
        answer: "190.49.223.14",
      ),
      QuizzModel(
        score: 25, // Easy
        question: "What is the primary function of HTML in website creation?",
        options: [
          "Making the website dynamic",
          "Structure website's content",
          "Website accessibility",
        ],
        answer: "Structure website's content",
      ),
      QuizzModel(
        score: 25, // Medium
        question:
            "What is the highlighted part of this URL called? https://www.youtube.com/watch?v=dQw4w9WgXcQ",
        options: [
          "Query string",
          "Top-level domain",
          "Subdomain",
        ],
        answer: "Query string",
      ),
      QuizzModel(
        score: 25, // Easy
        question: "What are website cookies?",
        options: [
          "Trackers on website",
          "Small data pieces stored",
          "Temporary website files",
        ],
        answer: "Small data pieces stored",
      ),
      QuizzModel(
        score: 25, // Medium
        question: "What is the main purpose of a server with websites?",
        options: [
          "Display webpages",
          "Translate domain names to IP addresses",
          "Add Smment",
        ],
        answer: "Translate domain names to IP addresses",
      ),
      QuizzModel(
        score: 25, // Medium
        question: "What is the role of Javascript in web development?",
        options: [
          "Structure the webpage's content",
          "Styling the webpage's content",
          "Making webpages dynamic",
        ],
        answer: "Making webpages dynamic",
      ),
      QuizzModel(
        score: 25, // Easy
        question: "Why do we use a Domain Name instead of using IP addresses?",
        options: [
          "Reduce loading time",
          "Domain names are easier to remember",
          "Domains help balancing traffic across multiple servers",
        ],
        answer: "Domain names are easier to remember",
      ),
      QuizzModel(
        score: 25, // Medium
        question: "WHERE ON MARS DID CURIOSITY LAND?",
        options: [
          "Meridiani Planum",
          "Gale Crater",
          "Chryse Planitia",
        ],
        answer: "Gale Crater",
      ),
      QuizzModel(
        score: 25, // Medium
        question: "HOW MANY CAMERAS DOES CURIOSITY HAVE?",
        options: [
          "1 Camera",
          "17 Cameras",
          "13 Cameras",
        ],
        answer: "17 Cameras",
      ),
      QuizzModel(
        score: 25, // Hard
        question: "CURIOSITY TRAVELS AT AN AVERAGE SPEED OF:",
        options: [
          "30 km/h (18 mph)",
          "60 km/h (37 mph)",
          "30 m/h (98 ft/h)",
        ],
        answer: "30 m/h (98 ft/h)",
      ),
      QuizzModel(
        score: 25, // Hard
        question: "HOW MUCH DID IT COST TO SEND CURIOSITY TO MARS?",
        options: [
          "10 Million",
          "2.5 Billion",
        ],
        answer: "2.5 Billion",
      ),
    ];
    List<QuizzModel> randomQuestions = getRandomSubArray(questions, 4);
    return randomQuestions;
  }
}

List<QuizzModel> getRandomSubArray(List<QuizzModel> originalArray, int size) {
  // Check if the requested size is valid
  if (size <= 0 || size > originalArray.length) {
    throw Exception("Invalid size for the random array");
  }

  // Create a random number generator
  Random random = Random();

  // Create a set to hold unique indices
  Set<int> indices = <int>{};

  // Get unique random indices
  while (indices.length < size) {
    indices.add(random.nextInt(originalArray.length));
  }

  // Map the indices to get the corresponding values from the original array
  List<QuizzModel> randomSubArray =
      indices.map((index) => originalArray[index]).toList();

  return randomSubArray;
}
