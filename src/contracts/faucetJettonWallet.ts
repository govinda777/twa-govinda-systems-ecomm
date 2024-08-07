import { fromNano as _fromNano, Contract, ContractProvider, Address, Cell, contractAddress as _contractAddress, beginCell as _beginCell, toNano as _toNano, Sender as _Sender } from "ton-core";

export default class FaucetJettonWallet implements Contract {
  async getBalance(provider: ContractProvider) {
    const { stack } = await provider.get("get_wallet_data", []);
    return _fromNano(stack.readBigNumber());
  }

  constructor(
    readonly address: Address,
    readonly init?: { code: Cell; data: Cell }
  ) {}
}
