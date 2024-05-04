    pragma solidity ^0.8.22;
    
    contract Utils {
        function addressToBytes32(address _addr) external pure returns (bytes32) {
            return bytes32(uint256(uint160(_addr)));
        }
        function bytes32ToAddress(bytes32 _bytes) external pure returns (address) {
            return address(uint160(uint256(_bytes)));
        }
    }
