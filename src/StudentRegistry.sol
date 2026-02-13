// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// StudentRegistry
///  Simple contract to track students and their attendance on Core Testnet
contract StudentRegistry {
    struct Student {
        string name;
        uint8 age;
        bool present;
    }

    
    Student[] private _students;

    event StudentAdded(
        uint256 indexed studentId,
        string name,
        uint8 age,
        bool present
    );

    event AttendanceUpdated(
        uint256 indexed studentId,
        bool present
    );


    function addStudent(
        string calldata name,
        uint8 age,
        bool present
    ) external returns (uint256 studentId) {
        require(bytes(name).length > 0, "Name required");
        require(age > 0, "Age must be > 0");

        studentId = _students.length;

        _students.push(
            Student({
                name: name,
                age: age,
                present: present
            })
        );

        emit StudentAdded(studentId, name, age, present);
    }

    function updateAttendance(
        uint256 studentId,
        bool present
    ) external {
        require(studentId < _students.length, "Invalid studentId");

        _students[studentId].present = present;

        emit AttendanceUpdated(studentId, present);
    }

    ///  Get a single student's data
    function getStudent(
        uint256 studentId
    )
        external
        view
        returns (string memory name, uint8 age, bool present)
    {
        require(studentId < _students.length, "Invalid studentId");
        Student memory s = _students[studentId];
        return (s.name, s.age, s.present);
    }

    /// Total number of students stored
    function getStudentCount() external view returns (uint256) {
        return _students.length;
    }
}
