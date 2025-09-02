// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;


import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";
import {PackedUserOperation} from "account-abstraction/interfaces/PackedUserOperation.sol";
import {NetworkConfig} from "script/HelperConfig.s.sol";
import {IEntryPoint} from "account-abstraction/contracts/interfaces/IEntryPoint.sol";
import {MessageHashUtils} from "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract SendPackedUserOp is Script {

    using MessageHashUtils for bytes32;

    function run() public {}

    function generateSignedUserOperation(bytes memory callData,  HelperConfig.NetworkConfig memory config) public return (PackedUserOperation memory){
        returns (PackedUserOperation memory){
            uint256 nonce=vm.getNonce(config.account);
            PackedUserOperation memory userOp= _generateUnisgnedUserOperation (callData, config.account, nonce);

            // Get the userOp hash
            bytes32 userOpHash = IEntryPoint(config.entryPoint).getUserOpHash(unsignedUserOp);
            bytes32 digest = userOpHash.toEthSignedMessageHash();

            // Sign it and return it
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(config.account,digest);
            userOp.signature = abi.encodePacked(r,s,v);
            return userOp;
        }

    //Generate the unsigned data

    uint256 nonce = vm.getNonce(config.account);
    PackedUserOperation memory unsignedUserOp = _generateUnsignedUserOperation( calldata, config.account , nonce);

    //Sign it and return it
}

    function _generateUnsignedUserOperation( bytes memory callData, address sender) internal pure returns (PackedUserOperation memory){
        uint128 verificationGasLImit = 167777216;
        uint128 callGasLimit =verificationGasLimit;
        uint128 maxPriorityFeeperGas =256;
        uint maxFeeperGas= maxPriorityFeePerGas;

        return PackedUseroperation ({
            sender: sender,
            nonce: nonce,
            initCode: hex""
            calldata: callData,
            accountGasLimits: bytes32 (uint256(verificationGasLimit) << 128 |callGasLimit),
            preVerificationGas: verificationGasLimit,
            gasFees: bytes32 (uint256(maxPriorityFeePerGas ) << 128 | maxFeePerGas ),
            paymasterAndData : hex"",
            signature: hex""
        })
    }
}