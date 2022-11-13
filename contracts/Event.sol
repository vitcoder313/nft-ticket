// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Event is Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private eventIds;

    constructor() {}

    struct EventData {
        string name;
        string location;
        string description;
        string hashImage;
        address eventManager;
        uint64 priceUnit;
        uint256 startDay;
        uint256 endDay;
        bool disable;
    }

    mapping(uint256 => EventData) events; // Each event of event manager
    mapping(address => bool) approvedEventManager;

    event NewEvent(
        uint256 eventId,
        string name,
        string location,
        string description,
        string image,
        address eventManager,
        uint64 priceUnit,
        uint256 startDay,
        uint256 endDay
    );

    // Modifiers
    modifier isEventManager() {
        require(
            approvedEventManager[msg.sender] == true,
            "Only Event Managers are allowed to do this action"
        );
        _;
    }

    // Function
    /**
     * @dev Allows the Contract admin to approve the Event Manager
     * @notice onlyOwner modifier should be invoked
     * @param address_ address that request to be event manager
     * @return bool true/false if the approval was successful of not
     */
    function approveEventManager(address address_)
        external
        onlyOwner
        returns (bool)
    {
        require(
            approvedEventManager[address_] == false,
            "Event manager already approved before"
        );

        approvedEventManager[address_] = true;

        return true;
    }

    /**
     * @dev Allows the Event Manager to create event
     * @notice isEventManager modifier should be invoked
     * @notice params is data of event struct
     * @notice emit NewEvent after create event
     * @return eventId
     */
    function createEvent(
        string memory name_,
        string memory location_,
        string memory description_,
        string memory image_,
        uint64 priceUnit_,
        uint256 startDate_,
        uint256 endDate_
    ) external isEventManager returns (uint256) {
        uint256 currentEventId = eventIds.current();

        events[currentEventId].name = name_;
        events[currentEventId].location = location_;
        events[currentEventId].description = description_;
        events[currentEventId].hashImage = image_;
        events[currentEventId].eventManager = msg.sender;
        events[currentEventId].priceUnit = priceUnit_;
        events[currentEventId].startDay = startDate_;
        events[currentEventId].endDay = endDate_;
        events[currentEventId].disable = false;
        eventIds.increment();

        emit NewEvent(
            currentEventId,
            name_,
            location_,
            description_,
            image_,
            msg.sender,
            priceUnit_,
            startDate_,
            endDate_
        );

        return currentEventId;
    }

    function getApprovedEventManager(address address_)
        external
        view
        returns (bool)
    {
        return approvedEventManager[address_];
    }
}
