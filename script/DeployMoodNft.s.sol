//SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

import {Script, console} from "lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    MoodNft public moodNft;
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sad.svg"); //reading sad.svg file
        string memory happySvg = vm.readFile("./img/happy.svg"); //reading happy.svg file
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(
        //this function conerts svg to base64 all the time we don't need to write it again and again.
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,"; //addring this as a prefix
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        ); //encoding svg to base64
        //we are converting it into a string of bytes and then encoding it to base64
        return string(abi.encodePacked(baseURL, svgBase64Encoded)); // finally returning the complete URI
    }
}
