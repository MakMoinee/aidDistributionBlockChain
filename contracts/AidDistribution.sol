// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

contract AidDistribution {
    struct AidRecord {
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

    event AidRecordAdded(
        string recipient,
        uint256 amount,
        string purpose,
        uint256 timestamp
    );

    event ShowNames(Record[] srecords);

    function addAidRecord(
        string memory recipient,
        uint256 amount,
        string memory purpose
    ) public {
        require(bytes(recipient).length > 0, "Recipient cannot be empty");
        require(amount > 0, "Amount must be greater than zero");
        require(bytes(purpose).length > 0, "Purpose cannot be empty");

        aidRecords.push(
            AidRecord({
                recipient: recipient,
                amount: amount,
                purpose: purpose,
                timestamp: block.timestamp
            })
        );

        mRecords.push(Record({name: recipient}));

        emit AidRecordAdded(recipient, amount, purpose, block.timestamp);
    }

    function getAllRecords() public view returns (AidRecord[] memory) {
        return aidRecords;
    }

    function getAllNames() public {
        emit ShowNames(mRecords);
    }
}
