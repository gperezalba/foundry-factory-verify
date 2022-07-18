// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";

import {TokenFactory} from "../src/TokenFactory.sol";
import {Token} from "../src/Token.sol";
import {Utils} from "./Utils.s.sol";

string constant ROOT_PATH = "./addresses/";

contract Create is Script, Test, Utils {
    uint public chainId;
    TokenFactory public tokenFactory;
    function setUp() public {
        chainId = _getChainID();
        _customSetUp();
    }

    function run() external {
        vm.startBroadcast();

        Token token = Token(tokenFactory.createToken());

        console.log("TPToken", address(token));

        vm.stopBroadcast();
    }

    function _customSetUp() internal {
        tokenFactory = TokenFactory(readAddressFromFile(ROOT_PATH, chainId, "TPTokenFactory.txt"));
    }

    function _getChainID() internal view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }
}
