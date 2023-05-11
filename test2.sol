// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
/*
여러분은 선생님입니다. 학생들의 정보를 관리하려고 합니다. 
학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들이 포함되어야 합니다.

번호는 1번부터 시작하여 정보를 기입하는 순으로 순차적으로 증가합니다.

학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.

필요한 기능들은 아래와 같습니다.

* 학생 추가 기능 - 특정 학생의 정보를 추가
* 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
* 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
* 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
* 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
* 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
* 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
* 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
* 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환
-------------------------------------------------------------------------------
* S반 조회 기능 - 가장 점수가 높은 학생 4명을 S반으로 설정하는데, 이 학생들의 전체 정보를 반환하는 기능 (S반은 4명으로 한정)

기입할 학생들의 정보는 아래와 같습니다.

Alice, 1, 85
Bob,2, 75
Charlie,3,60
Dwayne, 4, 90
Ellen,5,65
Fitz,6,50
Garret,7,80
Hubert,8,90
Isabel,9,100
Jane,10,70
*/
contract test {
    struct Student {
        string name;
        uint number;
        uint score;
        string grade;
        string[] classes;
    }

    Student[] students;

    mapping(string => Student[]) grade;

    function setGrade(uint _score) public {
        for(uint i = 0; i < Student.length; i++) {
            if(students[i].score > 90) {
                students[i].grade = "A";
            }
        }
    }



    // 학생 추가 기능
    function setStudent(string memory _name, uint _number, uint _score, string memory _grade, string[] memory _classes) public {
        students.push(Student(_name, _number, _score, _grade, _classes));
    }

    // 학생 조회 기능(1) 번호로 - 전체정보 반환. 
    function getStudent(uint _number) public view returns(Student memory) {
        return students[_number - 1];
    }

    // 학생 조회 기능(2) 이름으로 - 전체정보 반환. 
    function getStudent(string memory _name) public view returns(Student memory) {
        return students[_name];
    }

    // // 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
    // function getScore(string memory _name) public view returns(uint) {
    //     return getStudentScore[_name].score;
    // }

    // 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
    function getTotalStudents() public view returns(uint) {
        return students.length;
    }

    //  학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
    function getTotalStudent() public view returns(Student[] memory) {
        return students;
    }

    // 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
    uint totalCount;
    function average() public {
        for(uint i = 0; i < students.length; i++) {
            totalCount = totalCount + students[i].score;
            totalCount = totalCount / students.length;
        }
    }

    // 학생 score에 따른 grade 값 부여하기
    // function setStudentGrade(string memory _name) public {
    //     if(students[_name].score >= 90) {
    //         return A;
    //     }
    // }

    // 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
    function teacher_value() public view returns(bool) {
        if(totalCount >= 70) {
            return true;
        }
        return false;
    }
}