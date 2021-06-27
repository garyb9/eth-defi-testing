import { EVM_REVERT } from './helpers'

const DappToken = artifacts.require('./DappToken')

require('chai')
.use(require('chai-as-promised'))
.should()

contract('DappToken', accounts => {
    let dapptoken, minter;

    beforeEach(async () => {
        dapptoken = await DappToken.new(1000000);
        minter = await dapptoken.minter();
    })

    describe('Testing DappToken construction', () =>{
        it('Checks name', async () => {
            expect(await dapptoken.name()).to.be.eq("Dapp Token")
        })
        it('Checks symbol', async () => {
            expect(await dapptoken.symbol()).to.be.eq("DAPP")
        })
        it('Checks standard', async () => {
            expect(await dapptoken.standard()).to.be.eq("Dapp Token v1.0")
        })
        it('Checks balanceOf creator', async () => {
            expect(Number(await dapptoken.balanceOf(minter))).to.be.eq(1000000)
        })
        it('Sets the total supply upon deployment', async () => {
            expect(Number(await dapptoken.totalSupply())).to.be.eq(1000000)
        })
    })

    describe('Testing DappToken transfer', () =>{
        it('Checks contract cannot transfer more than totalSupply', async () => {
            await dapptoken.transfer(accounts[1], 99999999999).should.be.rejectedWith(EVM_REVERT);
        })
        it('Checks contract cannot transfer more than balanceOf sender', async () => {
            await dapptoken.transfer(accounts[0], 99999999999).should.be.rejectedWith(EVM_REVERT);
        })
    })
})