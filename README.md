# 🎨 Mood NFT Collection (On-Chain SVG NFTs)

This project is an **Ethereum smart contract** collection that mints **fully on-chain SVG NFTs**, where each NFT represents a *mood* (Happy or Sad).
The NFT stores all metadata + image **100% on-chain**, with no IPFS or external servers.

Built using:

* **Solidity (0.8.x)**
* **Foundry** (forge, cast)
* **OpenZeppelin ERC721**
* **Base64 encoding**
* **On-chain SVG → tokenURI generation**

---

## 🚀 Features

### ✔ On-Chain SVG Images

Each NFT dynamically stores its SVG inside the contract:

* `HAPPY` → uses the Happy SVG URI
* `SAD` → uses the Sad SVG URI

### ✔ On-Chain Metadata

`tokenURI()` returns a **Base64-encoded JSON** that includes:

* NFT name
* Description
* Attributes
* SVG image data

### ✔ Mood Switching

Every NFT has a mood stored in:

```solidity
enum Mood { HAPPY, SAD }
mapping(uint256 => Mood) private s_tokenIdToMood;
```

When minted, each NFT starts as **HAPPY**.

### ✔ Foundry Test Suite

Included tests verify:

* Correct SVG → Base64 → tokenURI encoding
* Correct mood state
* Correct minting behavior

---

## 📂 Project Structure

```
NFT_Project/
│── src/
│   ├── MoodNft.sol
│   └── DeployMoodNft.s.sol
│
│── test/
│   ├── MoodNftTest.t.sol
│   └── DeployMoodNftTest.t.sol
│
│── img/
│   ├── happy.svg
│   └── sad.svg
│
│── script/
│── broadcast/
│── foundry.toml
│── README.md
```

---

## 🔧 Installation & Setup

### 1️⃣ Install Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 2️⃣ Clone the Repository

```bash
git clone https://github.com/DecentralizedGlasses/NFT_Project
cd NFT_Project
```

### 3️⃣ Install Dependencies

```bash
forge install
```

---

## 🧪 Running Tests

This project includes full Foundry test coverage.

Run all tests:

```bash
forge test -vvv
```

---

## ▶ Deploying the Smart Contract

### To Local Anvil Blockchain

Start Anvil:

```bash
anvil
```

Deploy:

```bash
forge script script/DeployMoodNft.s.sol:DeployMoodNft \
    --rpc-url http://localhost:8545 \
    --private-key <YOUR_PRIVATE_KEY> \
    --broadcast
```

---

## 🖼 Using Your Own SVGs

Place SVGs inside the `img/` folder.

Convert SVG → Base64 URI:

```bash
base64 -i img/happy.svg
```

Then insert the encoded string into your contract constructor when deploying.

---

## 🧬 How the NFT Metadata Is Generated On-Chain

The `tokenURI(uint256 tokenId)` function builds JSON like this **entirely inside Solidity**:

```json
{
  "name": "Mood NFT",
  "description": "An NFT that reflects the owner's mood",
  "attributes": [{ "trait_type": "moodiness", "value": 100 }],
  "image": "data:image/svg+xml;base64,<encodedSVG>"
}
```

Then this JSON is Base64 encoded and returned via:

```solidity
return string(
    abi.encodePacked(
        "data:application/json;base64,",
        Base64.encode(bytes(jsonData))
    )
);
```

Meaning the NFT image + metadata are always available without IPFS, servers, or external URLs.

---

## 🧰 Tools Used

| Tool                     | Purpose                              |
| ------------------------ | ------------------------------------ |
| **Foundry (Forge/Cast)** | Smart contract development & testing |
| **OpenZeppelin**         | ERC721 implementation                |
| **Base64 Library**       | Encoding SVG + metadata              |
| **Anvil**                | Local Ethereum testing node          |

---

## 🛠 Future Improvements

* Add mood-toggle functionality
* Add animation SVGs
* Introduce traits, rarity, and accessories
* Build a frontend for minting & mood switching

---

## 🤝 Contributing

Feel free to open issues, suggest features, or submit PRs!

---

## 📜 License

This project is licensed under the **MIT License**.

---

If you'd like, I can also generate:

✅ A professional GitHub banner
✅ A deployment guide for Sepolia
✅ A frontend template (Next.js) for minting your Mood NFTs

