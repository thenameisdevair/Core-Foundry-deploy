// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/StudentRegistry.sol";

contract DeployStudentRegistry is Script {
    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        StudentRegistry registry = new StudentRegistry();

        console2.log("StudentRegistry deployed at:", address(registry));

        vm.stopBroadcast();
    }
}
