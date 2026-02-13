// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/StudentRegistry.sol";

contract StudentRegistryTest is Test {
    StudentRegistry private registry;

    // Re-declare event signature so expectEmit can match it
    event StudentAdded(
        uint256 indexed studentId,
        string name,
        uint8 age,
        bool present
    );

    function setUp() public {
        registry = new StudentRegistry();
    }

    function testAddStudentStoresData() public {
        uint256 id = registry.addStudent("Alice", 20, false);

        (string memory name, uint8 age, bool present) = registry.getStudent(id);

        assertEq(name, "Alice");
        assertEq(age, 20);
        assertEq(present, false);
        assertEq(registry.getStudentCount(), 1);
    }

    function testUpdateAttendance() public {
        uint256 id = registry.addStudent("Bob", 22, false);

        registry.updateAttendance(id, true);

        (, , bool present) = registry.getStudent(id);
        assertTrue(present);
    }

    function testRevertOnInvalidStudentId() public {
        // No students yet, so id 0 should revert
        vm.expectRevert(bytes("Invalid studentId"));
        registry.updateAttendance(0, true);
    }

    function testStudentAddedEventEmitted() public {
        vm.expectEmit(true, false, false, true);
        emit StudentAdded(0, "Alice", 20, false);

        registry.addStudent("Alice", 20, false);
    }
}
