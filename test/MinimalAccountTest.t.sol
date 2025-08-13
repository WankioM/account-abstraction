// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;
import {Test} from "forge-std/Test.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";
import {DeployMinimal} from "script/DeployMinimal.s.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20.sol"; 

contract MinimalAccountTest is Test{

    HelperConfig helperConfig;
    MinimalAccount minimalAccount;
    ERC20Mock usdc;

    function setUp() public {
        DeployMinimal deployMinimal = new DeployMinimal();
        
        (helperConfig, minimalAccount)= deployMinimal.deployMinimalAccount();
        usdc= new ERC20Mock();
    }

}