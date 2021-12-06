const getWeb3 = () => {
    return new Promise((resolve, reject) => {
        window.addEventListener("load", async () => {
            console.log("getWeb3==>")
            if (window.ethereum) {
                const web3 = new Web3(window.ethereum);
                try {
                    // ask user permission to access his accounts
                    await window.ethereum.request({ method: "eth_requestAccounts" });
                    resolve(web3);


                    const web3 = new Web3("HTTP://127.0.0.1:7545");
                    await window.ethereum.enable();
                    const accounts = await window.ethereum.request({ method: 'eth_requestAccounts'});
                    account = accounts[0];
                    localStorage.setItem("address", account);
                    resolve(account);
                } catch (error) {
                    reject(error);
                }
            } else {
                reject("Must install MetaMask");
            }
        });
    });
};

const getContract = () =>{
    const contractJson = fs.readFileSync('./contract/contract_abi.json');
    const abi = JSON.parse(contractJson);
    let contractInstance = web3.eth.Contract(abi, "0x855df0Aa757B8da7c41508ED5Af52CA38bE932Fb");
    //web3.eth.defaultAccount = '0x855df0Aa757B8da7c41508ED5Af52CA38bE932Fb';
    console.log("before Conloleeeee");

    console.log("before checkBalance");
    let balance = contractInstance.methods.checkBalance();
    console.log("after checkBalance"+ balance);
}