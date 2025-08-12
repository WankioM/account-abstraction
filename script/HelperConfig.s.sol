// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script{

    error HelperConfig_InvalidChainId();

    struct NetworkConfig {
        address entrypoint;

    }

    uint256 constant ETH_SEPOLIA_CHAIN_ID =11155111;
    uint256 constant ZKSYNC_SEPOLIA_CHAIN_1D = 300;
    uint256 constant LOCAL_CHAIN_ID = 31337;

    NetworkConfig public localNetworkConfig;

    mapping (uint256 chainId => NetworkConfig) public networkConfigs;


    constructor () {
        networkConfigs(ETH_SEPOLIA_CHAIN_ID) = getEthSepoliaConfig();
    }

    function getConfig() public returns (NetworkConfig memory){
        return getConfigbyChainId (block.chainid );
    }

    function getConfigByChainId (uint256 chainId) public  returns (NetworkConfig memory){
        if (chainId == LOCAL_CHAIN_ID){
            return getOrCreateAnvilEthConfig();
        } else if (networkConfigs[chainId].entryPoint != address(0)) {
            return networkConfigs[chainId];
        } else {
            revert HelperConfig_InvalidChainId();
        }
    }

    function getEthSepoliaConfig ()  public pure returns  (NetworkConfig memory) {
        return NetworkConfig (
            {
                entryPoint: 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789

            }
        )
    }


    function getzkSyncSepoliaConfig ()  public pure returns  (NetworkConfig memory) {
        return NetworkConfig (
            {
                entryPoint: address(0)

            }
        )
    }

    function getOrCreateAnvilEthConfig ()  public pure returns  (NetworkConfig memory) {
        if (localNetworkConfig.entryPoint != address(0)){
            return localNetworkConfig;
        }
        
        //deploy mock entry contract
    }
}