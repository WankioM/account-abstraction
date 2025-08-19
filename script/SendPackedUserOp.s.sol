// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MinimalAccount} from "src/MinimalAccount.sol";
import {PackedUserOperation} from "account-abstraction/interfaces/PackedUserOperation.sol";

contract SendPackedUserOp is Script {

    function run() public {}
    function generateSignedUserOperation(bytes memory callData, address sender) public return (PackedUserOperation memory){
        returns (PackedUserOperation memory){

        }

    //Generate the unsigned data

    uint256 nonce = vm.getNonce(sender);
    PackedUserOperation unsignedUserOp = _generateUnsignedUserOperation( calldata, sender , nonce);

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