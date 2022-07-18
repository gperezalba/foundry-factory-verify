// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
import {TokenFactory} from "../src/TokenFactory.sol";
import {Utils} from "./Utils.s.sol";

string constant ROOT_PATH = "./addresses/";

contract Deploy is Script, Test, Utils {
    uint public chainId;

    function setUp() public {
        chainId = _getChainID();
    }

    function run() external {
        vm.startBroadcast();

        TokenFactory tokenFactory = new TokenFactory();

        writeAddress2File(ROOT_PATH, chainId, "TPTokenFactory.txt", address(tokenFactory));

        console.log("TPTokenFactory", address(tokenFactory));

        vm.stopBroadcast();
    }

    function _getChainID() internal view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }
}
