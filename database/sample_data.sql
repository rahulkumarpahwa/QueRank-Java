-- Sample Data for Online Quiz System
-- Clear existing data (in reverse order due to foreign keys)
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM Results;
DELETE FROM Questions;
DELETE FROM Companies;
DELETE FROM Users;
SET FOREIGN_KEY_CHECKS = 1;
-- Insert sample companies (specifying IDs explicitly)
INSERT INTO Companies (company_id, company_name)
VALUES (1, 'TCS'),
    (2, 'Infosys'),
    (3, 'Wipro'),
    (4, 'Google'),
    (5, 'Microsoft'),
    (6, 'Amazon'),
    (7, 'Accenture'),
    (8, 'Cognizant');
-- Insert sample questions for TCS (company_id = 1)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is the time complexity of binary search?',
        'O(n)',
        'O(log n)',
        'O(n^2)',
        'O(1)',
        'B',
        10,
        1
    ),
    (
        'Which data structure uses LIFO?',
        'Queue',
        'Stack',
        'Array',
        'Tree',
        'B',
        9,
        1
    ),
    (
        'What does SQL stand for?',
        'Structured Query Language',
        'Simple Query Language',
        'Standard Query Language',
        'Sequential Query Language',
        'A',
        8,
        1
    ),
    (
        'In Java, which keyword is used for inheritance?',
        'implements',
        'extends',
        'inherits',
        'super',
        'B',
        7,
        1
    ),
    (
        'What is the default value of boolean in Java?',
        'true',
        'false',
        'null',
        '0',
        'B',
        6,
        1
    );
-- Insert sample questions for Infosys (company_id = 2)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'Which sorting algorithm has best average case?',
        'Bubble Sort',
        'Merge Sort',
        'Selection Sort',
        'Insertion Sort',
        'B',
        10,
        2
    ),
    (
        'What is encapsulation in OOP?',
        'Data hiding',
        'Inheritance',
        'Polymorphism',
        'Abstraction',
        'A',
        9,
        2
    ),
    (
        'Which protocol is used for secure web browsing?',
        'HTTP',
        'FTP',
        'HTTPS',
        'SMTP',
        'C',
        8,
        2
    ),
    (
        'What is the size of int in Java?',
        '2 bytes',
        '4 bytes',
        '8 bytes',
        '16 bytes',
        'B',
        7,
        2
    ),
    (
        'Which collection allows duplicate elements?',
        'Set',
        'Map',
        'List',
        'None',
        'C',
        6,
        2
    );
-- Insert sample questions for Wipro (company_id = 3)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is the use of StringBuilder in Java?',
        'Immutable strings',
        'Mutable strings',
        'Thread-safe strings',
        'Final strings',
        'B',
        10,
        3
    ),
    (
        'Which keyword is used to prevent method overriding?',
        'static',
        'final',
        'private',
        'abstract',
        'B',
        9,
        3
    ),
    (
        'What is the default value of a reference variable?',
        '0',
        'null',
        'undefined',
        'false',
        'B',
        8,
        3
    ),
    (
        'Which is NOT a access modifier in Java?',
        'public',
        'private',
        'protected',
        'secured',
        'D',
        7,
        3
    ),
    (
        'What does JVM stand for?',
        'Java Virtual Machine',
        'Java Visual Machine',
        'Java Variable Machine',
        'Java Verified Machine',
        'A',
        6,
        3
    );
-- Insert sample questions for Google (company_id = 4)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is a hash collision?',
        'Two keys hash to same index',
        'Hash function returns null',
        'Hash table is full',
        'Invalid key',
        'A',
        10,
        4
    ),
    (
        'Which is NOT a principle of OOP?',
        'Encapsulation',
        'Compilation',
        'Inheritance',
        'Polymorphism',
        'B',
        9,
        4
    ),
    (
        'What is Big O of quicksort worst case?',
        'O(n log n)',
        'O(n^2)',
        'O(log n)',
        'O(n)',
        'B',
        8,
        4
    ),
    (
        'Which pattern is used in JDBC?',
        'Singleton',
        'Factory',
        'DAO',
        'MVC',
        'C',
        7,
        4
    ),
    (
        'What does REST stand for?',
        'Representational State Transfer',
        'Remote State Transfer',
        'Reliable State Transfer',
        'Resource State Transfer',
        'A',
        6,
        4
    );
-- Insert sample questions for Microsoft (company_id = 5)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is polymorphism?',
        'Many forms',
        'Single form',
        'No form',
        'Abstract form',
        'A',
        10,
        5
    ),
    (
        'Which is a NoSQL database?',
        'MySQL',
        'PostgreSQL',
        'MongoDB',
        'Oracle',
        'C',
        9,
        5
    ),
    (
        'What is a deadlock?',
        'Thread waiting forever',
        'Thread execution',
        'Thread completion',
        'Thread creation',
        'A',
        8,
        5
    ),
    (
        'Which HTTP method is idempotent?',
        'POST',
        'GET',
        'PATCH',
        'None',
        'B',
        7,
        5
    ),
    (
        'What is the purpose of finally block?',
        'Handle exceptions',
        'Execute always',
        'Throw exceptions',
        'Catch exceptions',
        'B',
        6,
        5
    );
-- Insert sample questions for Amazon (company_id = 6)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is dynamic programming?',
        'Breaking problems into subproblems',
        'Using dynamic variables',
        'Runtime compilation',
        'Dynamic typing',
        'A',
        10,
        6
    ),
    (
        'Which is faster: ArrayList or LinkedList for random access?',
        'ArrayList',
        'LinkedList',
        'Both same',
        'Depends on size',
        'A',
        9,
        6
    ),
    (
        'What is CAP theorem?',
        'Consistency, Availability, Partition tolerance',
        'Cache, API, Performance',
        'Code, Algorithm, Program',
        'None',
        'A',
        8,
        6
    ),
    (
        'Which design pattern ensures single instance?',
        'Factory',
        'Singleton',
        'Observer',
        'Adapter',
        'B',
        7,
        6
    ),
    (
        'What is normalization in DBMS?',
        'Reducing redundancy',
        'Increasing redundancy',
        'Data encryption',
        'Data compression',
        'A',
        6,
        6
    );
-- Insert sample questions for Accenture (company_id = 7)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is the purpose of interface in Java?',
        'Multiple inheritance',
        'Single inheritance',
        'No inheritance',
        'Private inheritance',
        'A',
        10,
        7
    ),
    (
        'Which keyword is used for exception handling?',
        'throw',
        'throws',
        'try',
        'All of above',
        'D',
        9,
        7
    ),
    (
        'What is the root class in Java?',
        'Object',
        'Class',
        'System',
        'Main',
        'A',
        8,
        7
    ),
    (
        'Which collection maintains insertion order?',
        'HashSet',
        'TreeSet',
        'LinkedHashSet',
        'None',
        'C',
        7,
        7
    ),
    (
        'What is the size of long in Java?',
        '2 bytes',
        '4 bytes',
        '8 bytes',
        '16 bytes',
        'C',
        6,
        7
    );
-- Insert sample questions for Cognizant (company_id = 8)
INSERT INTO Questions (
        question_text,
        option_a,
        option_b,
        option_c,
        option_d,
        correct_answer,
        question_rank,
        company_id
    )
VALUES (
        'What is constructor in Java?',
        'Method to initialize object',
        'Method to destroy object',
        'Method to copy object',
        'Method to compare object',
        'A',
        10,
        8
    ),
    (
        'Which loop is guaranteed to execute at least once?',
        'for',
        'while',
        'do-while',
        'None',
        'C',
        9,
        8
    ),
    (
        'What is method overloading?',
        'Same name, different parameters',
        'Different name, same parameters',
        'Same name, same parameters',
        'Different name, different parameters',
        'A',
        8,
        8
    ),
    (
        'Which is a wrapper class for int?',
        'Int',
        'Integer',
        'Number',
        'Primitive',
        'B',
        7,
        8
    ),
    (
        'What does API stand for?',
        'Application Programming Interface',
        'Advanced Programming Interface',
        'Application Process Interface',
        'Advanced Process Interface',
        'A',
        6,
        8
    );
-- Insert a sample user for testing
INSERT INTO Users (name, roll_number, email)
VALUES ('Test User', 'TEST001', 'test@example.com');