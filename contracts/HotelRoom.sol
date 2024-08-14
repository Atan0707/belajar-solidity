//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    // Vacant
    // Ocupie
    enum Statuses { 
        Vacant, 
        Occupied 
        }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor () {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        // Check status
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier costs(uint _amount) {
        // Check price
        require(msg.value >= _amount, "Not enough ether provided.");
        _;
    }
    
    function book() public payable  onlyWhileVacant costs(2){
        
        
        currentStatus = Statuses.Occupied;
        //owner.transfer(msg.value);
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);

        emit Occupy(msg.sender, msg.value);
    }

    function checkout() public {
        currentStatus = Statuses.Vacant;
    } 

}