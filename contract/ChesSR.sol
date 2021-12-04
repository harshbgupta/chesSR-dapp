pragma solidity ^0.4.0;

contract ChesSR {
    address public owner;
    mapping(string => Room) public contests;
    mapping(string => bool) public roomIdExistence;
    string[] roomIds;

    constructor() payable{
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "Only Owner can change owner !!!");
        owner = newOwner;
    }

    struct Room {
        string roomId;
        uint256 betAmount;
        address payable[] players;
    }

    function getRoomList() public view returns (Room[] memory){
        Room[] memory rooms ;
        for (uint i=0;i<roomIds.length; i++){
            string memory roomId = roomIds[i];
            rooms[i]= contests[roomId];
        }
        return rooms;
    }

    modifier creatingRoom(string memory roomId,uint betAmount,address payable playerAddress){
        require(msg.value >= 100 wei);

        Room storage room = contests[roomId];
        room.roomId = roomId;
        if(room.betAmount == 0){
            room.betAmount = betAmount;
        } else{
            if(betAmount!=room.betAmount){
                revert("Bet Amount is not same");
            }
        }

        if(room.players.length < 2){
            room.players.push(playerAddress);
        } else{
            revert("Room is already filled");
        }

        contests[roomId] =room;
        require(!roomIdExistence[roomId]);
        roomIds.push(roomId);
        roomIdExistence[roomId] = true;
        _;
    }


    function deposit(string memory roomId, uint betAmount,address payable playerAddress) external payable creatingRoom(roomId, betAmount,playerAddress) returns (bool){
        return true;
    }

    function transfer(address payable receiver, uint256 amount) public returns (bool){
        require(address(this).balance >= amount, "Insufficient funds");
        receiver.transfer(amount);
        return true;
    }

    function checkBalance() public view returns (uint256){
        return (address(this).balance);
    }
}
