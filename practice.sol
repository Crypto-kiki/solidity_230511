// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract practice {

    struct Student {
        string name;
        uint number;
        uint score;
        string grade;
        string[] classes;
    }

    Student[] students;

    // 학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.
    function check_grade(uint _score) public pure returns(string memory) {
        if(_score >= 90) {
            return "A";
        } else if(_score >=80) {
            return "B";
        } else if(_score >=70) {
            return "C";
        } else if(_score >=60) {
            return "D";
        } else {
            return "F";
        }
    }


    // * 학생 추가 기능 - 특정 학생의 정보를 추가
    function pushStudent(string memory _name, uint _score, string[] memory _classes) public {
        students.push(Student(_name, students.length + 1, _score, check_grade(_score), _classes));
        getName[_name] = Student(_name, students.length, _score, check_grade(_score), _classes);
    }

    // * 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
    function getStudentByNumber(uint _number) public view returns(Student memory) {
        return students[_number - 1];
    }

    // * 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
    mapping(string => Student) getName;
    function getStudentByName(string memory _name) public view returns(Student memory) {
        return getName[_name];
    }

    // * 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
    function getScoreByName(string memory _name) public view returns(uint) {
        return getName[_name].score;
    }

    // * 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
    function getStudentLength() public view returns(uint) {
        return students.length;
    }

    // * 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
    function getAllStudents() public view returns(Student[] memory) {
        return students;
    }

    // * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
    function getAverage() public view returns(uint) {
        uint totalScore;
        for(uint i = 0; i < students.length; i++) {
            totalScore = totalScore + students[i].score;
        }
        return totalScore / students.length;
    }
    // * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
    function teacherEvaluation() public view returns(bool) {
        if(getAverage() >= 70) {
            return true;
        } else {
            return false;
        }
    }

    // * 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환
    function FClass() public view returns(uint, Student[] memory) {
        uint F_class_count = 0;
        Student[] memory F_class = new Student[](students.length);
        for(uint i = 0; i < students.length; i++) {
            if(keccak256(bytes(students[i].grade)) == keccak256(bytes("F"))) {
                F_class[F_class_count] = students[i];
                F_class_count++;
            }
        }
        return (F_class_count, F_class);
    }
    // 위 코드 실행하면 count는 제대로 나오는데 F_class에 빈값이 추가됨. 수정해야됨.



    // * S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정) 
    function SClass() public view returns(Student[4] memory) {
        Student[4] memory S_class_students;
        uint S_class_totalScore;
        // uint S_class_average = S_class_totalScore / S_class_students.length;

        for(uint i = 0; i < S_class_students.length; i++) {
            S_class_totalScore = S_class_totalScore + S_class_students[i].score;
        }

        for(uint i = 0; i < students.length; i++) {
            if(students[i].score * 4 >= S_class_totalScore) {
                uint lowestScore;
                for(uint j = 0; j <= S_class_students.length; j++) {
                    if(S_class_students[j].score < lowestScore) {
                        S_class_students[j] = students[i];
                    }
                }
            }
        }
        return S_class_students;
    }


}