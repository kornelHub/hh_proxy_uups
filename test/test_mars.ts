import hre from "hardhat";
import assert from "assert";

before("get factories", async function() {
    this.Mars = await hre.ethers.getContractFactory("Mars");
    this.MarsV2 = await hre.ethers.getContractFactory("MarsV2");
    this.MarsV3 = await hre.ethers.getContractFactory("MarsV3");
});

it("goes to mars", async function() {
    const mars = await hre.upgrades.deployProxy(this.Mars, {kind: "uups"});
    assert(await mars.version() === "v1!")

    const marsv2 = await hre.upgrades.upgradeProxy(mars, this.MarsV2);
    const fee_tx = await marsv2.assingFee(22);
    await fee_tx.wait();
    assert(await marsv2.version() === "v2!");
    assert.equal(await marsv2.getFee(), 22);

    const marsv3 = await hre.upgrades.upgradeProxy(mars, this.MarsV3);
    assert(await marsv3.version() === "v3!");
    assert.equal(await marsv3.getFee(), 22);

    const tax_tx = await marsv3.assingTax(2137);
    await tax_tx.wait();
    assert.equal(await marsv3.getTax(), 2137);
    assert.equal(await marsv3.getFee(), 22);
})