const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const {interface, bytecode} = require('../compile');

let lottery;
let accounts;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();

    lottery = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({ 
        data: bytecode
    })
    .send({ 
        from: accounts[0],
        gas: '1000000'
    });
});


describe('Lottery Contract', () => {
    it('deploys a contract', () =>{
        assert.ok(lottery.options.address);
    });

    // it('has a default message', async () => {
    //     const message = await lottery.methods.message().call();
    //     assert.strictEqual(message, 'Hi there!');
    // });

    // it('can change the message', async () => {
    //     await lottery.methods.setMessage('bye').send({from: accounts[0]});
    //     const message = await lottery.methods.message().call();
    //     assert.strictEqual(message, 'bye');
    // });
});