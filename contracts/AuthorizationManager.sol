// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract AuthorizationManager {
    using ECDSA for bytes32;

    mapping(bytes32 => bool) public consumedAuthorizations;
    address public immutable owner;

    constructor() {
        owner = msg.sender; // The person who deploys is the "signer"
    }

    function verifyAuthorization(
        address vault,
        address recipient,
        uint256 amount,
        bytes32 nonce,
        bytes calldata signature
    ) external returns (bool) {
        // Create a unique ID for this specific withdrawal
        bytes32 authHash = keccak256(abi.encodePacked(block.chainid, vault, recipient, amount, nonce));

        require(!consumedAuthorizations[authHash], "Already used");
        
        bytes32 ethSignedHash = MessageHashUtils.toEthSignedMessageHash(authHash);
        require(ethSignedHash.recover(signature) == owner, "Invalid signature");

        consumedAuthorizations[authHash] = true; // Mark as used (Replay protection)
        return true;
    }
}