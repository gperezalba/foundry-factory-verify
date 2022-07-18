// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";

import {TokenFactory} from "../src/TokenFactory.sol";
import {Token} from "../src/Token.sol";

contract CreateToken is Script, Test {
    TokenFactory public tokenFactory;

    function setUp() public {
        tokenFactory = TokenFactory(address());
    }

    function run() external {
        vm.startBroadcast();

        Token token = Token(tokenFactory.createToken());

        console.log("Token", address(token));

        vm.stopBroadcast();
    }
}
