// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Map {
    
    mapping(uint => uint) uintToUint;
    mapping(string => uint) stringToUint;
    
    struct Wallet {
        string name;
        uint number;
        address account;
    }

    mapping(string => Wallet) strToWallet;

    Wallet[] wallets;

    function setWallet(string memory _name, uint _number, address _account) public {
        wallets.push(Wallet(_name, _number, _account));
    }

    // 특정 n번째 wallet을 받아오기

    function getWallet(uint _n) public view returns(Wallet memory) {
        return wallets[_n - 1];
    }

    function getAccount(uint _n) public view returns(address) {
        return wallets[_n - 1].account;
    }

    function allWallet() public view returns(Wallet[] memory) {
        return wallets;
    }
}

contract quiz2 {

    uint[10] a;
    uint[] b;

    function setA(uint _n, uint _a) public {
        a[_n - 1] = _a;
    }

    function setB(uint _b) public {
        b.push(_b);
    }

    uint count;
    function setA2(uint _a) public {
        a[count++] = _a;
    }

    function changeB(uint _n, uint _b) public {
        b[_n - 1] = _b;
    }

    function sumA() public view returns(uint) {
        uint result;
        for (uint i = 0; i < a.length; i++) {
            result = result + a[i];
        }

        return count;
    }

    

}