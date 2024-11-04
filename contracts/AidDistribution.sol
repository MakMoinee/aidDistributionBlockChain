// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract AidDistribution {
    struct AidRecord {
        uint256 aidID;
        string recipient;
        uint256 amount;
        string purpose;
        uint256 timestamp;
    }

    AidRecord[] public aidRecords;
    mapping(uint256 => uint256) private aidFunds; // Maps aidID to total funds received
    string private constant AUTH_UUID = "d8cf7845-403b-40fb-a7cd-0bdbdda43b69";

    event AidRecordAdded(
        uint256 aidID,
        string recipient,
        uint256 amount,
        string purpose,
        uint256 timestamp
    );
    event DonationReceived(uint256 aidID, address sender, uint256 amount);
    event FundsReceived(uint256 aidID, uint256 amount, address receiver);

    // Add a new aid record
    function addAidRecord(
        uint256 aidID,
        string memory recipient,
        uint256 amount,
        string memory purpose
    ) public payable  {
        require(bytes(recipient).length > 0, "Recipient cannot be empty");
        require(amount > 0, "Amount must be greater than zero");
        require(bytes(purpose).length > 0, "Purpose cannot be empty");

        aidRecords.push(
            AidRecord({
                aidID: aidID,
                recipient: recipient,
                amount: amount,
                purpose: purpose,
                timestamp: block.timestamp
            })
        );

        aidFunds[aidID] += amount;
        emit DonationReceived(aidID, msg.sender, msg.value);
        emit AidRecordAdded(aidID, recipient, amount, purpose, block.timestamp);
    }

    // Function to receive funds for a specific aid request
    function receiveFunds(
        uint256 aidID,
        uint256 amount,
        string memory uuid,
        address receiver
    ) public payable {
        require(
            keccak256(abi.encodePacked(uuid)) ==
                keccak256(abi.encodePacked(AUTH_UUID)),
            "Unauthorized: Invalid UUID"
        );
        require(aidFunds[aidID] >= amount, "Insufficient funds for this aidID");
        require(receiver != address(0), "Invalid receiver address");

        // Transfer the funds to the receiver
        (bool success, ) = receiver.call{value: amount}("");
        require(success, "Transfer to receiver failed");

        // Deduct the amount from the aidID's total funds
        aidFunds[aidID] -= amount;

        emit FundsReceived(aidID, amount, receiver);
    }

    function getAllRecords() public view returns (AidRecord[] memory) {
        return aidRecords;
    }

     function getAidFunds() public view returns (AidRecord[] memory) {
        return aidRecords;
    }

    function getFundsForAidID(uint256 aidID) public view returns (uint256) {
        return aidFunds[aidID];
    }
}
