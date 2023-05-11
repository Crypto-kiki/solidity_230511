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

contract quiz1 {
    // 학생의 정보는 이름, 번호, 점수, 학점 그리고 듣는 수업들
    struct Student {
        string name;
        uint number;
        uint score;
        string credit;
        string[] classes;
    }

    

    Student[] students;

    // 학점은 점수에 따라 자동으로 계산되어 기입하게 합니다. 90점 이상 A, 80점 이상 B, 70점 이상 C, 60점 이상 D, 나머지는 F 입니다.
    function setCredit(uint _score) public pure returns(string memory) {
        if(_score >= 90) {
            return "A";
        } else if(_score >= 80) {
            return "B";
        } else if(_score >= 70) {
            return "C";
        } else if(_score >= 60) {
            return "D";
        } else {
            return "F";
        }
    }

    // * 학생 추가 기능 - 특정 학생의 정보를 추가
    // 번호는 1번부터 시작하여 정보를 기입하는 순으로 순차적으로 증가합니다. (지속적으로 참고할 수 있도록)
    /*uint count = 1; */
    function pushStudent(string memory _name, uint _score, string[] memory _classes) public {
        students.push(Student(_name, students.length + 1/*count++*/, _score, setCredit(_score) ,_classes));  // count++ 은 1연산하고 증가, ++count는 1이 증가된 2부터 연산
        name_Student[_name] = Student(_name, students.length, _score, setCredit(_score), _classes);  // 여기서는 students.length +1하면 안됨!!
    }

    // * 학생 전체 숫자 조회 기능 - 현재 등록된 학생들의 숫자를 반환
    function getStudentsNumber() public view returns(uint) {
        return students.length;
    }

    // * 학생 전체 정보 조회 기능 - 현재 등록된 모든 학생들의 정보를 반환
    function getAllStudents() public view returns(Student[] memory) {
        return students;
    }

    // * 학생 조회 기능(1) - 특정 학생의 번호를 입력하면 그 학생 전체 정보를 반환
    function getStudentByNumber(uint _number) public view returns(Student memory) {
        return students[_number - 1];
    }

    // * 학생 조회 기능(2) - 특정 학생의 이름을 입력하면 그 학생 전체 정보를 반환
    mapping(string => Student) name_Student;
    function getStudentByName(string memory _name) public view returns(Student memory) {
        return name_Student[_name];
    }

    // * 학생 점수 조회 기능 - 특정 학생의 이름을 입력하면 그 학생의 점수를 반환
    function getStudentScore(string memory _name) public view returns(uint) {
        return name_Student[_name].score;
    }

    // * 학생들의 전체 평균 점수 계산 기능 - 학생들의 전체 평균 점수를 반환
    function getAverageScore() public view returns(uint) {
        uint totalScore;
        for(uint i = 0; i < students.length; i++) {
            totalScore += students[i].score;  // totalScore = totalScore + students[i].score;
        }
        return totalScore / students.length;  // totalScore / getStudentsNumber()로도 되는지 확인하기
    }

    // * 선생 지도 자격 자가 평가 시스템 - 학생들의 평균 점수가 70점 이상이면 true, 아니면 false를 반환
    function selfEva() public view returns(bool) {
        if(getAverageScore() >= 70) {
            return true;
        } else {
            return false;
        } 
    }

    // * 보충반 조회 기능 - F 학점을 받은 학생들의 숫자와 그 전체 정보를 반환 (정리시작)
    function FClass() public view returns(Student[] memory) {

        uint num; // 4. 그래서 F 학점 학생수를 구해보자

        // Student[num] memory F_students;  // 5. num 만큼의 array. 해도 오류가 발생함.
        Student[] memory F_students = new Student[](num);  // 6. new 키워드를 사용해야 함.
        /*  new는 언제쓰나? 동적이야! 변할수가있어. 그런데 동적으로 선언을 못해!(예를들어 지역변수, 또는 배열길이가 정해져있거나 변할거야!)
        그럴때 사용~
        */
        // 1. 지역변수지만 무거우니까 memory를 써줘야 함. Student[] memory F_students; 지역변수는 사이즈를 안정한 상태에서 push를 하려고하면 에러 발생함.
        // 2. 사이즈 정해줘야 됨. Student[10] memory F_students; 그런데 사이즈를 정해도 오류남. 왜냐하면 push가 배열의 길이를 늘리는 것이기 때문.
        /* 아래 참고
            function bytesToString4(string memory _a, uint _n) public pure returns(string memory) {
            bytes memory _b = new bytes(1);
            _b[0] = bytes(_a)[_n-1]; [나중에] 조건문 배운 후에 다시 돌아오기, 글자 수에 맞게
            return string(_b);
        */
        
       // num이 몇명인지 확인하기
        for(uint i = 0; i < students.length; i++) {
            if(keccak256(bytes(students[i].credit)) == keccak256(bytes("F"))) {
                num++;
                // 7. F_students[num] = students[i];   몇명인지를 세보자~
                // 3. F_students[_n] = students[i]; 해보자.그런데 Student가 몇명일줄알고?
            }
        }

        uint _num;
        for(uint i = 0; i < students.length; i++) {
            if(keccak256(bytes(students[i].credit)) == keccak256(bytes("F"))) {
                F_students[_num] = students[i];
                _num++;
            }
        }

    }



}

// 보충반 조회 가능에서 문자열 비교가 필요함. 알아보자.
contract STRING_Compare {

    function compare1(string memory s1, string memory s2) public pure returns(bool) {
        return keccak256(bytes(s1)) == keccak256(bytes(s2));
    }

    function compare2(string memory s1) public pure returns(bytes memory, bytes memory) {
        return (abi.encodePacked(s1), bytes(s1));
    }

    /* 그럼 스트링을 바이트로 바꿔서 비교하면 안되나?
    function compare(string memory s1, string memory s2) public pure returns(bool) {
        return bytes(s1) == bytes(s2);
    }
    TypeError: Built-in binary operator == cannot be applied to types bytes memory and bytes memory.
   --> Answer.sol:132:16:
    |
132 |         return bytes(s1) == bytes(s2);
    |                ^^^^^^^^^^^^^^^^^^^^^^

    동적, 정적 비교할 수 없는 것과 같음.
    */

    /* abi.encodePacked 말고 아래처럼 할 수도 있음
    keccak1, 2 함수 둘다 같은 문자 주고 출력해서 같이나오는지 확인하기
    abi : application binary interface. ABI에서 비교해보면 조금 알 수 있을듯?
    */
    function keccak2(string memory s1) public pure returns(bytes32) {
        return keccak256(bytes(s1));
    }

    function keccak1(string memory s1) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(s1));
    }  // 값 출력해보기
    
    /* 인코딩 방법 에러가 발생함. (인풋값이 string인데 bytes32로 결과값 낼건데 그건 정적임.)
    function compare1(string memory s1) public pure returns(bytes32) {
        return keccak256(s1);
    }

    TypeError: Invalid type for argument in function call. Invalid implicit conversion from string memory to bytes memory requested. This function requires a single bytes argument. Use abi.encodePacked(...) to obtain the pre-0.5.0 behaviour or abi.encode(...) to use ABI encoding.
   --> Answer.sol:131:26:
    |
131 |         return keccak256(s1);
    |                          ^^


    */
    

    /* 이렇게하면 에러메세지 2개 나옴. 에러 두번째는 bytes32로 나올거라고 경고함. 따라서 더 수정해야 됨.나머지 하나 경고는 위에 있음
    function compare1(string memory s1) public pure returns(bytes memory) {
        return keccak256(s1);
    }
    */



    /*
    function compare(string memory s1, string memory s2) public pure returns(bool) {
        return s1 == s2;  오류발생함. 
    }
    */
}