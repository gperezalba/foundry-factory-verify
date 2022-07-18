// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";

contract Utils is Script {
    function address2String(address addr) public pure returns (string memory) {
        return Strings.toHexString(addr);
    }

    // writeAddress2File("./addresses/", 1, "MyScript.txt", address(this));
    function writeAddress2File(
        string memory root,
        uint chainId,
        string memory fileName,
        address addr
    ) public {
        string memory path = string(abi.encodePacked(root, Strings.toString(chainId), "/", fileName));
        writeAddress2File(path, addr);
    }

    function writeAddress2File(string memory path, address addr) public {
        vm.writeFile(path, Strings.toHexString(addr));
    }

    // readAddressFromFile("./addresses/", 1, "MyScript.txt")
    function readAddressFromFile(string memory path) public returns (address) {
        string memory txt = vm.readLine(path);
        return _toAddress(txt);
    }

    function readAddressFromFile(
        string memory root,
        uint chainId,
        string memory fileName
    ) public returns (address) {
        string memory path = string(abi.encodePacked(root, Strings.toString(chainId), "/", fileName));
        return readAddressFromFile(path);
    }

    function readStringFromFile(string memory path) public returns (string memory) {
        return vm.readLine(path);
    }

    function _toAddress(string memory s) internal pure returns (address) {
        bytes memory _bytes = _hexStringToAddress(s);
        require(_bytes.length >= 1 + 20, "toAddress_outOfBounds");
        address tempAddress;

        assembly {
            tempAddress := div(mload(add(add(_bytes, 0x20), 1)), 0x1000000000000000000000000)
        }

        return tempAddress;
    }

    function _fromHexChar(uint8 c) internal pure returns (uint8) {
        if (bytes1(c) >= bytes1("0") && bytes1(c) <= bytes1("9")) {
            return c - uint8(bytes1("0"));
        }
        if (bytes1(c) >= bytes1("a") && bytes1(c) <= bytes1("f")) {
            return 10 + c - uint8(bytes1("a"));
        }
        if (bytes1(c) >= bytes1("A") && bytes1(c) <= bytes1("F")) {
            return 10 + c - uint8(bytes1("A"));
        }
        return 0;
    }

    function _hexStringToAddress(string memory s) internal pure returns (bytes memory) {
        bytes memory ss = bytes(s);
        require(ss.length % 2 == 0); // length must be even
        bytes memory r = new bytes(ss.length / 2);
        for (uint i = 0; i < ss.length / 2; ++i) {
            r[i] = bytes1(_fromHexChar(uint8(ss[2 * i])) * 16 + _fromHexChar(uint8(ss[2 * i + 1])));
        }

        return r;
    }
}
