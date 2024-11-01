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

    struct Record {
        string name;
    }

    AidRecord[] public aidRecords;
    Record[] mRecords;

    mapping(uint256 => uint256) private aidFunds; // Maps aidID to total funds received

    event AidRecordAdded(
        uint256 aidID,
        string recipient,
        uint256 amount,
        string purpose,
        uint256 timestamp
    );

    event ShowNames(Record[] srecords);

    function addAidRecord(
        uint aidID,
        string memory recipient,
        uint256 amount,
        string memory purpose
    ) public {
        require(bytes(recipient).length > 0, "Recipient cannot be empty");
        require(amount > 0, "Amount must be greater than zero");
        require(bytes(purpose).length > 0, "Purpose cannot be empty");

        // Add a new aid record
        aidRecords.push(
            AidRecord({
                aidID: aidID,
                recipient: recipient,
                amount: amount,
                purpose: purpose,
                timestamp: block.timestamp
            })
        );

        // Update total funds for the given aidID
        aidFunds[aidID] += amount;

        mRecords.push(Record({name: recipient}));

        emit AidRecordAdded(aidID, recipient, amount, purpose, block.timestamp);
    }

    function getAllRecords() public view returns (AidRecord[] memory) {
        return aidRecords;
    }

    function getAllNames() public {
        emit ShowNames(mRecords);
    }

    function getFundsForAidID(uint256 aidID) public view returns (uint256) {
        return aidFunds[aidID];
    }
}
