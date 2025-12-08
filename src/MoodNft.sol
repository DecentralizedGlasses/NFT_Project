//SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol"; //it converts our svg to base64, 32 bytes to

contract MoodNft is ERC721 {
    //errors
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter; //to keep track of tokenIds
    string private s_sadSvgTokenUri; //storage variable for sad mood svg
    string private s_happySvgTokenUri; //storage variable for happy mood svg

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood; //mapping token Id to Mood

    constructor(
        string memory sadSvgTokenUri, //constructor for sad mood svg
        string memory happySvgTokenUri // constructor for happy mood svg
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_sadSvgTokenUri = sadSvgTokenUri;
        s_happySvgTokenUri = happySvgTokenUri;
    }

    function mintNft() public {
        //to mint a mood NFT
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; //set default mood to HAPPY
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        // first we only want the owner of the NFT to be able to flip th mood
        if (
            getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender
        ) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            //this changes the mood of the NFT
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgTokenUri;
        } else {
            imageURI = s_sadSvgTokenUri;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), //can add any name here
                                '", "description":"An NFT that reflects the owners mood.",',
                                '"attributes":[{"trait_type":"moodiness", "value": 100}],',
                                '"image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
