// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ChessGame is ERC721Enumerable, Ownable {
    using SafeMath for uint256;

    struct Game {
        address player1;
        address player2;
        address winner;
        bool isCompleted;
        string moves;
        uint8[8][8] board;
    }

    Game[] public games;
    uint256 public gameCount;
    uint256 public maxGames = 100; // Maximum number of games allowed

    event NewGame(uint256 indexed gameId, address indexed player1, address indexed player2);
    event Move(uint256 indexed gameId, address indexed player, string move);
    event GameCompleted(uint256 indexed gameId, address indexed winner);

    constructor() ERC721("ChessGameNFT", "CGNFT") {}

    function createGame(address _player2) external {
        require(!isPlayerInGame(msg.sender), "Player is already in a game");
        require(_player2 != address(0), "Invalid player address");
        require(gameCount < maxGames, "Maximum number of games reached");
        games.push(Game(msg.sender, _player2, address(0), false, "", getDefaultBoard()));
        uint256 gameId = games.length - 1;
        gameCount++;
        emit NewGame(gameId, msg.sender, _player2);
    }

    function isPlayerInGame(address player) public view returns (bool) {
        for (uint256 i = 0; i < games.length; i++) {
            if (games[i].player1 == player || games[i].player2 == player) {
                return true;
            }
        }
        return false;
    }

    function addMove(uint256 _gameId, string memory _move) external {
        require(_gameId < games.length, "Invalid game ID");
        Game storage game = games[_gameId];
        require(!game.isCompleted, "Game is already completed");
        require(msg.sender == game.player1 || msg.sender == game.player2, "Unauthorized player");
        require(validateMove(game, _move), "Invalid move");
        applyMove(game, _move);
        game.moves = string(abi.encodePacked(game.moves, _move));
        emit Move(_gameId, msg.sender, _move);
    }

    function validateMove(Game storage game, string memory _move) internal view returns (bool) {
        
        return true;
    }

    function applyMove(Game storage game, string memory _move) internal {
        

    }

    function getDefaultBoard() internal pure returns (uint8[8][8] memory) {
    
    uint8[8][8] memory board;
   

    return board;
}

    function completeGame(uint256 _gameId, address _winner) external onlyOwner {
    require(_gameId < games.length, "Invalid game ID");
    Game storage game = games[_gameId];
    require(!game.isCompleted, "Game is already completed");
    }
}
