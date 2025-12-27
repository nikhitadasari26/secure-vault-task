# My Secure Vault Project

This project is a safe way to store and withdraw digital money (ETH). I built it using two separate parts to keep things extra secure: a **Vault** to hold the money and a **Manager** to check permissions.

## How it works

### 1. Two-Part Security
Instead of having one big file that does everything, I split it up. The **Vault** holds the ETH, but it isn't allowed to move a single cent unless the **Authorization Manager** says "Yes."

### 2. Preventing "Double-Counting"
A big risk in crypto is someone "replaying" a transaction (using the same permission twice). My system stops this by:
* **Memory Tracking**: Once a signature is used, the Manager remembers it and marks it as "Used." If someone tries to use it again, the transaction fails.
* **Specific Location**: Each permission is locked to this specific vault and this specific network (Chain ID). You can't steal a permission from here and use it somewhere else.

## Project Structure

secure-vault-task/
├── contracts/               
│   ├── SecureVault.sol      
│   └── AuthorizationManager.sol 
├── scripts/                
│   └── deploy.js            
├── docker/                 
│   └── entrypoint.sh       
├── Dockerfile              
├── docker-compose.yml      
├── hardhat.config.js       
├── package.json            
└── README.md                


## How to run it

I've set this up so you don't have to install any complex blockchain tools. You just need **Docker**.

1. Open your terminal in this folder.
2. Type this command:
   ```bash
   docker-compose up --build

   ## Deployment Info (Local)
After the Docker setup finishes, the contracts are live at these addresses:

* **AuthorizationManager:** `0x5FbDB2315678afecb367f032d93F642f64180aa3`
* **SecureVault:** `0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512`
* **Network:** Local Hardhat Node (Chain ID 31337)