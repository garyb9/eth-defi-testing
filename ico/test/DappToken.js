// import { tokens, ether, ETHER_ADDRESS, EVM_REVERT, wait } from './helpers'

const DappToken = artifacts.require('./DappToken')

require('chai')
.use(require('chai-as-promised'))
.should()

contract('DappToken', ([accounts]) => {
    let dapptoken;

    beforeEach(async () => {
        dapptoken = await DappToken.new();
    })

    describe('Testing DappToken', () =>{
        it('Sets the total supply upon deployment', async () => {
            expect(Number(await dapptoken.totalSupply())).to.be.eq(1000000)
        })
    })
})