// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Token} from "./Token.sol";

contract TokenFactory {
    function createToken() external returns (address) {
        return _createToken();
    }

    function _createToken() private returns (address) {
        return address(new Token());
    }
}
