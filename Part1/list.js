const { ethers } = require('ethers'); 
const contractABI = require('./BARTokenABI.json'); //We need to have the ABI of our BAR token.
const tokenAddress = '0x...'; // Address of the BAR ERC20 token contract
const walletAddresses = ['0x...', '0x...', '0x...']; // Lista de direcciones de cartera de interés
const yearsAgo = 1; // Number of years ago to take into account

async function getTransfers() {
    const provider = new ethers.providers.JsonRpcProvider; // We will need to specify the RCP provider

    const contract = new ethers.Contract(tokenAddress, contractABI, provider);

    const currentBlock = await provider.getBlockNumber();
    const pastBlock = currentBlock - (365 * yearsAgo * 24 * 60 * 60 / 15); // Considering there are 15 seconds per block

    const filter = {
        address: tokenAddress,
        fromBlock: pastBlock,
        toBlock: 'latest',
        topics: [
            ethers.utils.id('Transfer(address,address,uint256)')
        ]
    };

    const transferEvents = await provider.getLogs(filter);

    const relevantTransfers = transferEvents.filter(event => {
        const decodedEvent = contract.interface.parseLog(event);
        return walletAddresses.includes(decodedEvent.args.from) || walletAddresses.includes(decodedEvent.args.to);
    });

    return relevantTransfers;
}

getTransfers().then(transfers => {
    console.log("Transfers to display:");
    console.log(transfers);
}).catch(error => {
    console.error("Error when obtaining transfers:", error);
});