// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployMinimal is Script {

    function run() public {}
    function deployMinimalAccount() public returns (HelperConfig.NetworkConfig , MinimalAccount) {
        HelperConfig helperConfig = new HelperConfig();
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        vm.startBroadcast();
        MinimalAccount minimalAccount = new MinimalAccount (config.entryPoint);
        minimalAccount.transferOwnership(msg.sender);
        vm.stopBroadcast();
        return (helperConfig, minimalAccount);
    }

    // USDC Approval
    // msg.sender -> MinimalAccount
    // approve some amount
    // USDC contract
    // come from the entrypoint

    functin testOwnerCanExecuteCommands() public {
        //Arrange
        //Act
        //Assert
    }

}