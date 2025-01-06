// Code generated - DO NOT EDIT.
// This file is a generated binding and any manual changes will be lost.

package xz21

import (
	"errors"
	"math/big"
	"strings"

	ethereum "github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/event"
)

// Reference imports to suppress errors if they are not otherwise used.
var (
	_ = errors.New
	_ = big.NewInt
	_ = strings.NewReader
	_ = ethereum.NotFound
	_ = bind.Bind
	_ = common.Big1
	_ = types.BloomLookup
	_ = event.NewSubscription
	_ = abi.ConvertType
)

// XZ21Account is an auto generated low-level Go binding around an user-defined struct.
type XZ21Account struct {
	PubKey   []byte
	FileList [][32]byte
}

// XZ21AuditingLog is an auto generated low-level Go binding around an user-defined struct.
type XZ21AuditingLog struct {
	Chal   []byte
	Proof  []byte
	Result bool
	Date   *big.Int
	Stage  uint8
}

// XZ21FileProperty is an auto generated low-level Go binding around an user-defined struct.
type XZ21FileProperty struct {
	SplitNum uint32
	Creator  common.Address
}

// XZ21Param is an auto generated low-level Go binding around an user-defined struct.
type XZ21Param struct {
	P string
	U []byte
	G []byte
}

// XZ21MetaData contains all meta data concerning the XZ21 contract.
var XZ21MetaData = &bind.MetaData{
	ABI: "[{\"type\":\"constructor\",\"inputs\":[{\"name\":\"_addrSP\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"AppendOwner\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"_owner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"EnrollAccount\",\"inputs\":[{\"name\":\"_type\",\"type\":\"int256\",\"internalType\":\"int256\"},{\"name\":\"_addr\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"_pubKey\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"GetAuditingLogs\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple[]\",\"internalType\":\"structXZ21.AuditingLog[]\",\"components\":[{\"name\":\"chal\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"proof\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"result\",\"type\":\"bool\",\"internalType\":\"bool\"},{\"name\":\"date\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"stage\",\"type\":\"uint8\",\"internalType\":\"enumXZ21.Stages\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"GetAuditorAddrList\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address[]\",\"internalType\":\"address[]\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"GetFileList\",\"inputs\":[{\"name\":\"_owner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bytes32[]\",\"internalType\":\"bytes32[]\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"GetLatestAuditingLog\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.AuditingLog\",\"components\":[{\"name\":\"chal\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"proof\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"result\",\"type\":\"bool\",\"internalType\":\"bool\"},{\"name\":\"date\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"stage\",\"type\":\"uint8\",\"internalType\":\"enumXZ21.Stages\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"GetParam\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.Param\",\"components\":[{\"name\":\"P\",\"type\":\"string\",\"internalType\":\"string\"},{\"name\":\"U\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"G\",\"type\":\"bytes\",\"internalType\":\"bytes\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"GetUserAccount\",\"inputs\":[{\"name\":\"_addr\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.Account\",\"components\":[{\"name\":\"pubKey\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"fileList\",\"type\":\"bytes32[]\",\"internalType\":\"bytes32[]\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"RegisterFile\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"_splitNum\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"_owner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"RegisterParam\",\"inputs\":[{\"name\":\"_p\",\"type\":\"string\",\"internalType\":\"string\"},{\"name\":\"_g\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"_u\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"SearchFile\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.FileProperty\",\"components\":[{\"name\":\"splitNum\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"creator\",\"type\":\"address\",\"internalType\":\"address\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"SetAuditingResult\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"_result\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"SetChal\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"_chal\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"SetProof\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"_proof\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"addrSM\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"addrSP\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"auditorAddrList\",\"inputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"event\",\"name\":\"EventSetAuditingResult\",\"inputs\":[{\"name\":\"_hash\",\"type\":\"bytes32\",\"indexed\":false,\"internalType\":\"bytes32\"},{\"name\":\"_result\",\"type\":\"bool\",\"indexed\":false,\"internalType\":\"bool\"}],\"anonymous\":false}]",
	Bin: "0x60c0604052348015600f57600080fd5b506040516122fd3803806122fd833981016040819052602c91604a565b336080526001600160a01b031660a0526003805460ff191690556078565b600060208284031215605b57600080fd5b81516001600160a01b0381168114607157600080fd5b9392505050565b60805160a05161223d6100c0600039600081816102420152818161066b015281816113e901526117d90152600081816102060152818161035c0152611104015261223d6000f3fe608060405234801561001057600080fd5b506004361061010b5760003560e01c80638a04d5e5116100a2578063c1f16b1611610071578063c1f16b16146102ec578063ca0fed72146102ff578063d746cdd01461031f578063debffd9a14610332578063f64b362a1461034557600080fd5b80638a04d5e5146102845780639a2b5e6314610299578063b55957a0146102b9578063b645fd63146102d957600080fd5b806358f5823c116100de57806358f5823c146102015780635a955455146102285780636b884afb1461023d5780637f8382111461026457600080fd5b8063043c90771461011057806322dd2b18146101385780632cc19d971461014d578063537322e314610178575b600080fd5b61012361011e366004611a0e565b610358565b60405190151581526020015b60405180910390f35b61014b610146366004611a68565b610669565b005b61016061015b366004611aaf565b610760565b6040516001600160a01b03909116815260200161012f565b6101d7610186366004611aaf565b60408051808201909152600080825260208201525060009081526006602090815260409182902082518084019093525463ffffffff8116835264010000000090046001600160a01b03169082015290565b60408051825163ffffffff1681526020928301516001600160a01b0316928101929092520161012f565b6101607f000000000000000000000000000000000000000000000000000000000000000081565b61023061078a565b60405161012f9190611ac8565b6101607f000000000000000000000000000000000000000000000000000000000000000081565b610277610272366004611aaf565b6107ec565b60405161012f9190611bec565b61028c6109ce565b60405161012f9190611c50565b6102ac6102a7366004611cb1565b610bba565b60405161012f9190611d0f565b6102cc6102c7366004611cb1565b610ca9565b60405161012f9190611d22565b61014b6102e7366004611d5b565b610dcf565b61014b6102fa366004611e3c565b611102565b61031261030d366004611aaf565b6111d8565b60405161012f9190611edb565b61014b61032d366004611eee565b6113e7565b61014b610340366004611eee565b6115b9565b61014b610353366004611f3a565b6117d7565b60007f0000000000000000000000000000000000000000000000000000000000000000336001600160a01b038216146103ac5760405162461bcd60e51b81526004016103a390611f66565b60405180910390fd5b8515806103b95750856001145b6103f45760405162461bcd60e51b815260206004820152600c60248201526b496e76616c6964207479706560a01b60448201526064016103a3565b85600003610529576000805b60045481101561045257866001600160a01b03166004828154811061042757610427611f94565b6000918252602090912001546001600160a01b03160361044a5760019150610452565b600101610400565b5080156104995760405162461bcd60e51b81526020600482015260156024820152744475706c696361746520545041206164647265737360581b60448201526064016103a3565b6104d86040518060400160405280601f81526020017f456e726f6c6c20545041206163636f756e742028416464726573733a257329008152508761189e565b50600480546001810182556000919091527f8a35acfbc15ff81a39ae7d344fd709f28e8600b4aa8c65c6b64bfe7fe36bd19b0180546001600160a01b0319166001600160a01b03871617905561065d565b6001600160a01b0385166000908152600560205260409020805461054c90611faa565b1590506105925760405162461bcd60e51b8152602060048201526014602482015273111d5c1b1a58d85d194814d5481858d8dbdd5b9d60621b60448201526064016103a3565b6105d16040518060400160405280601e81526020017f456e726f6c6c205355206163636f756e742028416464726573733a25732900008152508661189e565b6040805160606020601f87018190040282018101835291810185815290918291908790879081908501838280828437600092018290525093855250506040805183815260208082018352948501526001600160a01b038a16835260059093525020815181906106409082612035565b5060208281015180516106599260018501920190611908565b5050505b50600195945050505050565b7f0000000000000000000000000000000000000000000000000000000000000000336001600160a01b038216146106b25760405162461bcd60e51b81526004016103a390611f66565b60008363ffffffff16116106fc5760405162461bcd60e51b8152602060048201526011602482015270696e76616c69642073706c6974206e756d60781b60448201526064016103a3565b506000838152600660209081526040808320805463ffffffff969096166001600160c01b0319909616959095176401000000006001600160a01b03959095169485021790945591815260058252918220600190810180549182018155835291200155565b6004818154811061077057600080fd5b6000918252602090912001546001600160a01b0316905081565b606060048054806020026020016040519081016040528092919081815260200182805480156107e257602002820191906000526020600020905b81546001600160a01b031681526001909101906020018083116107c4575b5050505050905090565b606060076000838152602001908152602001600020805480602002602001604051908101604052809291908181526020016000905b828210156109c357838290600052602060002090600502016040518060a001604052908160008201805461085490611faa565b80601f016020809104026020016040519081016040528092919081815260200182805461088090611faa565b80156108cd5780601f106108a2576101008083540402835291602001916108cd565b820191906000526020600020905b8154815290600101906020018083116108b057829003601f168201915b505050505081526020016001820180546108e690611faa565b80601f016020809104026020016040519081016040528092919081815260200182805461091290611faa565b801561095f5780601f106109345761010080835404028352916020019161095f565b820191906000526020600020905b81548152906001019060200180831161094257829003601f168201915b505050918352505060028281015460ff90811615156020840152600384015460408401526004840154606090930192169081111561099f5761099f611b5b565b60028111156109b0576109b0611b5b565b8152505081526020019060010190610821565b505050509050919050565b6109f260405180606001604052806060815260200160608152602001606081525090565b6000604051806060016040529081600082018054610a0f90611faa565b80601f0160208091040260200160405190810160405280929190818152602001828054610a3b90611faa565b8015610a885780601f10610a5d57610100808354040283529160200191610a88565b820191906000526020600020905b815481529060010190602001808311610a6b57829003601f168201915b50505050508152602001600182018054610aa190611faa565b80601f0160208091040260200160405190810160405280929190818152602001828054610acd90611faa565b8015610b1a5780601f10610aef57610100808354040283529160200191610b1a565b820191906000526020600020905b815481529060010190602001808311610afd57829003601f168201915b50505050508152602001600282018054610b3390611faa565b80601f0160208091040260200160405190810160405280929190818152602001828054610b5f90611faa565b8015610bac5780601f10610b8157610100808354040283529160200191610bac565b820191906000526020600020905b815481529060010190602001808311610b8f57829003601f168201915b505050505081525050905090565b6001600160a01b0381166000908152600560205260408120600101546060918167ffffffffffffffff811115610bf257610bf2611d90565b604051908082528060200260200182016040528015610c1b578160200160208202803683370190505b50905060005b6001600160a01b038516600090815260056020526040902060010154811015610ca1576001600160a01b0385166000908152600560205260409020600101805482908110610c7157610c71611f94565b9060005260206000200154828281518110610c8e57610c8e611f94565b6020908102919091010152600101610c21565b509392505050565b60408051808201909152606080825260208201526001600160a01b038216600090815260056020526040908190208151808301909252805482908290610cee90611faa565b80601f0160208091040260200160405190810160405280929190818152602001828054610d1a90611faa565b8015610d675780601f10610d3c57610100808354040283529160200191610d67565b820191906000526020600020905b815481529060010190602001808311610d4a57829003601f168201915b5050505050815260200160018201805480602002602001604051908101604052809291908181526020018280548015610dbf57602002820191906000526020600020905b815481526020019060010190808311610dab575b5050505050815250509050919050565b6000805b600454811015610e2557336001600160a01b031660048281548110610dfa57610dfa611f94565b6000918252602090912001546001600160a01b031603610e1d5760019150610e25565b600101610dd3565b5080610e735760405162461bcd60e51b815260206004820152601860248201527f5450412061757468656e7469636174696f6e206572726f72000000000000000060448201526064016103a3565b60008381526007602052604090205480610ebf5760405162461bcd60e51b815260206004820152600d60248201526c26b4b9b9b4b73390383937b7b360991b60448201526064016103a3565b6000610ecc6001836120f5565b905060016000868152600760205260409020805483908110610ef057610ef0611f94565b600091825260209091206004600590920201015460ff166002811115610f1857610f18611b5b565b14610f595760405162461bcd60e51b8152602060048201526011602482015270139bdd0815d85a5d1a5b99d4995cdd5b1d607a1b60448201526064016103a3565b8015610fe4576000610f6c6001836120f5565b60008781526007602052604090208054919250429183908110610f9157610f91611f94565b90600052602060002090600502016003015410610fe25760405162461bcd60e51b815260206004820152600f60248201526e3a34b6b2b9ba30b6b81032b93937b960891b60448201526064016103a3565b505b600085815260076020526040902080548591908390811061100757611007611f94565b906000526020600020906005020160020160006101000a81548160ff0219169083151502179055504260076000878152602001908152602001600020828154811061105457611054611f94565b906000526020600020906005020160030181905550600260076000878152602001908152602001600020828154811061108f5761108f611f94565b60009182526020909120600460059092020101805460ff191660018360028111156110bc576110bc611b5b565b02179055506040805186815285151560208201527f961a406eff4d590fdb9e54bdba584518be2e6a7f91b34d5714330f83d571b031910160405180910390a15050505050565b7f0000000000000000000000000000000000000000000000000000000000000000336001600160a01b0382161461114b5760405162461bcd60e51b81526004016103a390611f66565b60035460ff161561119e5760405162461bcd60e51b815260206004820152601e60248201527f446f206e6f74206f7665727772697465205265676973746572506172616d000060448201526064016103a3565b60006111aa8582612035565b5060016111b78382612035565b5060026111c48482612035565b50506003805460ff19166001179055505050565b6111e0611953565b600082815260076020526040902054806112265760405162461bcd60e51b81526020600482015260076024820152664e6f206461746160c81b60448201526064016103a3565b60006112336001836120f5565b60008581526007602052604090208054919250908290811061125757611257611f94565b90600052602060002090600502016040518060a001604052908160008201805461128090611faa565b80601f01602080910402602001604051908101604052809291908181526020018280546112ac90611faa565b80156112f95780601f106112ce576101008083540402835291602001916112f9565b820191906000526020600020905b8154815290600101906020018083116112dc57829003601f168201915b5050505050815260200160018201805461131290611faa565b80601f016020809104026020016040519081016040528092919081815260200182805461133e90611faa565b801561138b5780601f106113605761010080835404028352916020019161138b565b820191906000526020600020905b81548152906001019060200180831161136e57829003601f168201915b505050918352505060028281015460ff9081161515602084015260038401546040840152600484015460609093019216908111156113cb576113cb611b5b565b60028111156113dc576113dc611b5b565b905250949350505050565b7f0000000000000000000000000000000000000000000000000000000000000000336001600160a01b038216146114305760405162461bcd60e51b81526004016103a390611f66565b600084815260076020526040902054806114805760405162461bcd60e51b81526020600482015260116024820152704d697373696e67206368616c6c656e676560781b60448201526064016103a3565b600061148d6001836120f5565b90506000808781526007602052604090208054839081106114b0576114b0611f94565b600091825260209091206004600590920201015460ff1660028111156114d8576114d8611b5b565b146115185760405162461bcd60e51b815260206004820152601060248201526f2737ba102bb0b4ba34b733a83937b7b360811b60448201526064016103a3565b60008681526007602052604090208054869186918490811061153c5761153c611f94565b9060005260206000209060050201600101918261155a92919061211c565b5060008681526007602052604090208054600191908390811061157f5761157f611f94565b60009182526020909120600460059092020101805460ff191660018360028111156115ac576115ac611b5b565b0217905550505050505050565b33600090815260056020526040812080546115d390611faa565b9050116116225760405162461bcd60e51b815260206004820152601760248201527f53552061757468656e7469636174696f6e206572726f7200000000000000000060448201526064016103a3565b60008381526007602052604090205480156116d15760006116446001836120f5565b90506002600086815260076020526040902080548390811061166857611668611f94565b600091825260209091206004600590920201015460ff16600281111561169057611690611b5b565b146116cf5760405162461bcd60e51b815260206004820152600f60248201526e139bdd0815d85a5d1a5b99d0da185b608a1b60448201526064016103a3565b505b6040805160c06020601f8601819004028201810190925260a0810184815260009282919087908790819085018382808284376000920182905250938552505060408051602081810183528482528501528301829052506060820181905260809091015260008681526007602090815260408220805460018101825590835291208251929350839260059092020190819061176b9082612035565b50602082015160018201906117809082612035565b5060408201516002808301805492151560ff199384161790556060840151600384015560808401516004840180549193909291169060019084908111156117c9576117c9611b5b565b021790555050505050505050565b7f0000000000000000000000000000000000000000000000000000000000000000336001600160a01b038216146118205760405162461bcd60e51b81526004016103a390611f66565b60008381526006602052604090205463ffffffff166118705760405162461bcd60e51b815260206004820152600c60248201526b696e76616c69642066696c6560a01b60448201526064016103a3565b506001600160a01b031660009081526005602090815260408220600190810180549182018155835291200155565b6118e382826040516024016118b49291906121dd565b60408051601f198184030181529190526020810180516001600160e01b031663319af33360e01b1790526118e7565b5050565b80516a636f6e736f6c652e6c6f67602083016000808483855afa5050505050565b828054828255906000526020600020908101928215611943579160200282015b82811115611943578251825591602001919060010190611928565b5061194f929150611994565b5090565b6040518060a001604052806060815260200160608152602001600015158152602001600081526020016000600281111561198f5761198f611b5b565b905290565b5b8082111561194f5760008155600101611995565b80356001600160a01b03811681146119c057600080fd5b919050565b60008083601f8401126119d757600080fd5b50813567ffffffffffffffff8111156119ef57600080fd5b602083019150836020828501011115611a0757600080fd5b9250929050565b60008060008060608587031215611a2457600080fd5b84359350611a34602086016119a9565b9250604085013567ffffffffffffffff811115611a5057600080fd5b611a5c878288016119c5565b95989497509550505050565b600080600060608486031215611a7d57600080fd5b83359250602084013563ffffffff81168114611a9857600080fd5b9150611aa6604085016119a9565b90509250925092565b600060208284031215611ac157600080fd5b5035919050565b6020808252825182820181905260009190848201906040850190845b81811015611b095783516001600160a01b031683529284019291840191600101611ae4565b50909695505050505050565b6000815180845260005b81811015611b3b57602081850181015186830182015201611b1f565b506000602082860101526020601f19601f83011685010191505092915050565b634e487b7160e01b600052602160045260246000fd5b6000815160a08452611b8660a0850182611b15565b905060208301518482036020860152611b9f8282611b15565b91505060408301511515604085015260608301516060850152608083015160038110611bdb57634e487b7160e01b600052602160045260246000fd5b806080860152508091505092915050565b600060208083016020845280855180835260408601915060408160051b87010192506020870160005b82811015611c4357603f19888603018452611c31858351611b71565b94509285019290850190600101611c15565b5092979650505050505050565b602081526000825160606020840152611c6c6080840182611b15565b90506020840151601f1980858403016040860152611c8a8383611b15565b9250604086015191508085840301606086015250611ca88282611b15565b95945050505050565b600060208284031215611cc357600080fd5b611ccc826119a9565b9392505050565b60008151808452602080850194506020840160005b83811015611d0457815187529582019590820190600101611ce8565b509495945050505050565b602081526000611ccc6020830184611cd3565b602081526000825160406020840152611d3e6060840182611b15565b90506020840151601f19848303016040850152611ca88282611cd3565b60008060408385031215611d6e57600080fd5b8235915060208301358015158114611d8557600080fd5b809150509250929050565b634e487b7160e01b600052604160045260246000fd5b600067ffffffffffffffff80841115611dc157611dc1611d90565b604051601f8501601f19908116603f01168101908282118183101715611de957611de9611d90565b81604052809350858152868686011115611e0257600080fd5b858560208301376000602087830101525050509392505050565b600082601f830112611e2d57600080fd5b611ccc83833560208501611da6565b600080600060608486031215611e5157600080fd5b833567ffffffffffffffff80821115611e6957600080fd5b818601915086601f830112611e7d57600080fd5b611e8c87833560208501611da6565b94506020860135915080821115611ea257600080fd5b611eae87838801611e1c565b93506040860135915080821115611ec457600080fd5b50611ed186828701611e1c565b9150509250925092565b602081526000611ccc6020830184611b71565b600080600060408486031215611f0357600080fd5b83359250602084013567ffffffffffffffff811115611f2157600080fd5b611f2d868287016119c5565b9497909650939450505050565b60008060408385031215611f4d57600080fd5b82359150611f5d602084016119a9565b90509250929050565b60208082526014908201527320baba3432b73a34b1b0ba34b7b71032b93937b960611b604082015260600190565b634e487b7160e01b600052603260045260246000fd5b600181811c90821680611fbe57607f821691505b602082108103611fde57634e487b7160e01b600052602260045260246000fd5b50919050565b601f821115612030576000816000526020600020601f850160051c8101602086101561200d5750805b601f850160051c820191505b8181101561202c57828155600101612019565b5050505b505050565b815167ffffffffffffffff81111561204f5761204f611d90565b6120638161205d8454611faa565b84611fe4565b602080601f83116001811461209857600084156120805750858301515b600019600386901b1c1916600185901b17855561202c565b600085815260208120601f198616915b828110156120c7578886015182559484019460019091019084016120a8565b50858210156120e55787850151600019600388901b60f8161c191681555b5050505050600190811b01905550565b8181038181111561211657634e487b7160e01b600052601160045260246000fd5b92915050565b67ffffffffffffffff83111561213457612134611d90565b612148836121428354611faa565b83611fe4565b6000601f84116001811461217c57600085156121645750838201355b600019600387901b1c1916600186901b1783556121d6565b600083815260209020601f19861690835b828110156121ad578685013582556020948501946001909201910161218d565b50868210156121ca5760001960f88860031b161c19848701351681555b505060018560011b0183555b5050505050565b6040815260006121f06040830185611b15565b905060018060a01b0383166020830152939250505056fea264697066735822122058d870d6b38e3e3c4d62d5c2b933644e15582e3540e1e2623229769fc622e2ce64736f6c63430008190033",
}

// XZ21ABI is the input ABI used to generate the binding from.
// Deprecated: Use XZ21MetaData.ABI instead.
var XZ21ABI = XZ21MetaData.ABI

// XZ21Bin is the compiled bytecode used for deploying new contracts.
// Deprecated: Use XZ21MetaData.Bin instead.
var XZ21Bin = XZ21MetaData.Bin

// DeployXZ21 deploys a new Ethereum contract, binding an instance of XZ21 to it.
func DeployXZ21(auth *bind.TransactOpts, backend bind.ContractBackend, _addrSP common.Address) (common.Address, *types.Transaction, *XZ21, error) {
	parsed, err := XZ21MetaData.GetAbi()
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	if parsed == nil {
		return common.Address{}, nil, nil, errors.New("GetABI returned nil")
	}

	address, tx, contract, err := bind.DeployContract(auth, *parsed, common.FromHex(XZ21Bin), backend, _addrSP)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &XZ21{XZ21Caller: XZ21Caller{contract: contract}, XZ21Transactor: XZ21Transactor{contract: contract}, XZ21Filterer: XZ21Filterer{contract: contract}}, nil
}

// XZ21 is an auto generated Go binding around an Ethereum contract.
type XZ21 struct {
	XZ21Caller     // Read-only binding to the contract
	XZ21Transactor // Write-only binding to the contract
	XZ21Filterer   // Log filterer for contract events
}

// XZ21Caller is an auto generated read-only Go binding around an Ethereum contract.
type XZ21Caller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// XZ21Transactor is an auto generated write-only Go binding around an Ethereum contract.
type XZ21Transactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// XZ21Filterer is an auto generated log filtering Go binding around an Ethereum contract events.
type XZ21Filterer struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// XZ21Session is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type XZ21Session struct {
	Contract     *XZ21             // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// XZ21CallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type XZ21CallerSession struct {
	Contract *XZ21Caller   // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts // Call options to use throughout this session
}

// XZ21TransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type XZ21TransactorSession struct {
	Contract     *XZ21Transactor   // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// XZ21Raw is an auto generated low-level Go binding around an Ethereum contract.
type XZ21Raw struct {
	Contract *XZ21 // Generic contract binding to access the raw methods on
}

// XZ21CallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type XZ21CallerRaw struct {
	Contract *XZ21Caller // Generic read-only contract binding to access the raw methods on
}

// XZ21TransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type XZ21TransactorRaw struct {
	Contract *XZ21Transactor // Generic write-only contract binding to access the raw methods on
}

// NewXZ21 creates a new instance of XZ21, bound to a specific deployed contract.
func NewXZ21(address common.Address, backend bind.ContractBackend) (*XZ21, error) {
	contract, err := bindXZ21(address, backend, backend, backend)
	if err != nil {
		return nil, err
	}
	return &XZ21{XZ21Caller: XZ21Caller{contract: contract}, XZ21Transactor: XZ21Transactor{contract: contract}, XZ21Filterer: XZ21Filterer{contract: contract}}, nil
}

// NewXZ21Caller creates a new read-only instance of XZ21, bound to a specific deployed contract.
func NewXZ21Caller(address common.Address, caller bind.ContractCaller) (*XZ21Caller, error) {
	contract, err := bindXZ21(address, caller, nil, nil)
	if err != nil {
		return nil, err
	}
	return &XZ21Caller{contract: contract}, nil
}

// NewXZ21Transactor creates a new write-only instance of XZ21, bound to a specific deployed contract.
func NewXZ21Transactor(address common.Address, transactor bind.ContractTransactor) (*XZ21Transactor, error) {
	contract, err := bindXZ21(address, nil, transactor, nil)
	if err != nil {
		return nil, err
	}
	return &XZ21Transactor{contract: contract}, nil
}

// NewXZ21Filterer creates a new log filterer instance of XZ21, bound to a specific deployed contract.
func NewXZ21Filterer(address common.Address, filterer bind.ContractFilterer) (*XZ21Filterer, error) {
	contract, err := bindXZ21(address, nil, nil, filterer)
	if err != nil {
		return nil, err
	}
	return &XZ21Filterer{contract: contract}, nil
}

// bindXZ21 binds a generic wrapper to an already deployed contract.
func bindXZ21(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor, filterer bind.ContractFilterer) (*bind.BoundContract, error) {
	parsed, err := XZ21MetaData.GetAbi()
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, *parsed, caller, transactor, filterer), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_XZ21 *XZ21Raw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _XZ21.Contract.XZ21Caller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_XZ21 *XZ21Raw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _XZ21.Contract.XZ21Transactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_XZ21 *XZ21Raw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _XZ21.Contract.XZ21Transactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_XZ21 *XZ21CallerRaw) Call(opts *bind.CallOpts, result *[]interface{}, method string, params ...interface{}) error {
	return _XZ21.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_XZ21 *XZ21TransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _XZ21.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_XZ21 *XZ21TransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _XZ21.Contract.contract.Transact(opts, method, params...)
}

// GetAuditingLogs is a free data retrieval call binding the contract method 0x7f838211.
//
// Solidity: function GetAuditingLogs(bytes32 _hash) view returns((bytes,bytes,bool,uint256,uint8)[])
func (_XZ21 *XZ21Caller) GetAuditingLogs(opts *bind.CallOpts, _hash [32]byte) ([]XZ21AuditingLog, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "GetAuditingLogs", _hash)

	if err != nil {
		return *new([]XZ21AuditingLog), err
	}

	out0 := *abi.ConvertType(out[0], new([]XZ21AuditingLog)).(*[]XZ21AuditingLog)

	return out0, err

}

// GetAuditingLogs is a free data retrieval call binding the contract method 0x7f838211.
//
// Solidity: function GetAuditingLogs(bytes32 _hash) view returns((bytes,bytes,bool,uint256,uint8)[])
func (_XZ21 *XZ21Session) GetAuditingLogs(_hash [32]byte) ([]XZ21AuditingLog, error) {
	return _XZ21.Contract.GetAuditingLogs(&_XZ21.CallOpts, _hash)
}

// GetAuditingLogs is a free data retrieval call binding the contract method 0x7f838211.
//
// Solidity: function GetAuditingLogs(bytes32 _hash) view returns((bytes,bytes,bool,uint256,uint8)[])
func (_XZ21 *XZ21CallerSession) GetAuditingLogs(_hash [32]byte) ([]XZ21AuditingLog, error) {
	return _XZ21.Contract.GetAuditingLogs(&_XZ21.CallOpts, _hash)
}

// GetAuditorAddrList is a free data retrieval call binding the contract method 0x5a955455.
//
// Solidity: function GetAuditorAddrList() view returns(address[])
func (_XZ21 *XZ21Caller) GetAuditorAddrList(opts *bind.CallOpts) ([]common.Address, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "GetAuditorAddrList")

	if err != nil {
		return *new([]common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new([]common.Address)).(*[]common.Address)

	return out0, err

}

// GetAuditorAddrList is a free data retrieval call binding the contract method 0x5a955455.
//
// Solidity: function GetAuditorAddrList() view returns(address[])
func (_XZ21 *XZ21Session) GetAuditorAddrList() ([]common.Address, error) {
	return _XZ21.Contract.GetAuditorAddrList(&_XZ21.CallOpts)
}

// GetAuditorAddrList is a free data retrieval call binding the contract method 0x5a955455.
//
// Solidity: function GetAuditorAddrList() view returns(address[])
func (_XZ21 *XZ21CallerSession) GetAuditorAddrList() ([]common.Address, error) {
	return _XZ21.Contract.GetAuditorAddrList(&_XZ21.CallOpts)
}

// GetFileList is a free data retrieval call binding the contract method 0x9a2b5e63.
//
// Solidity: function GetFileList(address _owner) view returns(bytes32[])
func (_XZ21 *XZ21Caller) GetFileList(opts *bind.CallOpts, _owner common.Address) ([][32]byte, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "GetFileList", _owner)

	if err != nil {
		return *new([][32]byte), err
	}

	out0 := *abi.ConvertType(out[0], new([][32]byte)).(*[][32]byte)

	return out0, err

}

// GetFileList is a free data retrieval call binding the contract method 0x9a2b5e63.
//
// Solidity: function GetFileList(address _owner) view returns(bytes32[])
func (_XZ21 *XZ21Session) GetFileList(_owner common.Address) ([][32]byte, error) {
	return _XZ21.Contract.GetFileList(&_XZ21.CallOpts, _owner)
}

// GetFileList is a free data retrieval call binding the contract method 0x9a2b5e63.
//
// Solidity: function GetFileList(address _owner) view returns(bytes32[])
func (_XZ21 *XZ21CallerSession) GetFileList(_owner common.Address) ([][32]byte, error) {
	return _XZ21.Contract.GetFileList(&_XZ21.CallOpts, _owner)
}

// GetLatestAuditingLog is a free data retrieval call binding the contract method 0xca0fed72.
//
// Solidity: function GetLatestAuditingLog(bytes32 _hash) view returns((bytes,bytes,bool,uint256,uint8))
func (_XZ21 *XZ21Caller) GetLatestAuditingLog(opts *bind.CallOpts, _hash [32]byte) (XZ21AuditingLog, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "GetLatestAuditingLog", _hash)

	if err != nil {
		return *new(XZ21AuditingLog), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21AuditingLog)).(*XZ21AuditingLog)

	return out0, err

}

// GetLatestAuditingLog is a free data retrieval call binding the contract method 0xca0fed72.
//
// Solidity: function GetLatestAuditingLog(bytes32 _hash) view returns((bytes,bytes,bool,uint256,uint8))
func (_XZ21 *XZ21Session) GetLatestAuditingLog(_hash [32]byte) (XZ21AuditingLog, error) {
	return _XZ21.Contract.GetLatestAuditingLog(&_XZ21.CallOpts, _hash)
}

// GetLatestAuditingLog is a free data retrieval call binding the contract method 0xca0fed72.
//
// Solidity: function GetLatestAuditingLog(bytes32 _hash) view returns((bytes,bytes,bool,uint256,uint8))
func (_XZ21 *XZ21CallerSession) GetLatestAuditingLog(_hash [32]byte) (XZ21AuditingLog, error) {
	return _XZ21.Contract.GetLatestAuditingLog(&_XZ21.CallOpts, _hash)
}

// GetParam is a free data retrieval call binding the contract method 0x8a04d5e5.
//
// Solidity: function GetParam() view returns((string,bytes,bytes))
func (_XZ21 *XZ21Caller) GetParam(opts *bind.CallOpts) (XZ21Param, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "GetParam")

	if err != nil {
		return *new(XZ21Param), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21Param)).(*XZ21Param)

	return out0, err

}

// GetParam is a free data retrieval call binding the contract method 0x8a04d5e5.
//
// Solidity: function GetParam() view returns((string,bytes,bytes))
func (_XZ21 *XZ21Session) GetParam() (XZ21Param, error) {
	return _XZ21.Contract.GetParam(&_XZ21.CallOpts)
}

// GetParam is a free data retrieval call binding the contract method 0x8a04d5e5.
//
// Solidity: function GetParam() view returns((string,bytes,bytes))
func (_XZ21 *XZ21CallerSession) GetParam() (XZ21Param, error) {
	return _XZ21.Contract.GetParam(&_XZ21.CallOpts)
}

// GetUserAccount is a free data retrieval call binding the contract method 0xb55957a0.
//
// Solidity: function GetUserAccount(address _addr) view returns((bytes,bytes32[]))
func (_XZ21 *XZ21Caller) GetUserAccount(opts *bind.CallOpts, _addr common.Address) (XZ21Account, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "GetUserAccount", _addr)

	if err != nil {
		return *new(XZ21Account), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21Account)).(*XZ21Account)

	return out0, err

}

// GetUserAccount is a free data retrieval call binding the contract method 0xb55957a0.
//
// Solidity: function GetUserAccount(address _addr) view returns((bytes,bytes32[]))
func (_XZ21 *XZ21Session) GetUserAccount(_addr common.Address) (XZ21Account, error) {
	return _XZ21.Contract.GetUserAccount(&_XZ21.CallOpts, _addr)
}

// GetUserAccount is a free data retrieval call binding the contract method 0xb55957a0.
//
// Solidity: function GetUserAccount(address _addr) view returns((bytes,bytes32[]))
func (_XZ21 *XZ21CallerSession) GetUserAccount(_addr common.Address) (XZ21Account, error) {
	return _XZ21.Contract.GetUserAccount(&_XZ21.CallOpts, _addr)
}

// SearchFile is a free data retrieval call binding the contract method 0x537322e3.
//
// Solidity: function SearchFile(bytes32 _hash) view returns((uint32,address))
func (_XZ21 *XZ21Caller) SearchFile(opts *bind.CallOpts, _hash [32]byte) (XZ21FileProperty, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "SearchFile", _hash)

	if err != nil {
		return *new(XZ21FileProperty), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21FileProperty)).(*XZ21FileProperty)

	return out0, err

}

// SearchFile is a free data retrieval call binding the contract method 0x537322e3.
//
// Solidity: function SearchFile(bytes32 _hash) view returns((uint32,address))
func (_XZ21 *XZ21Session) SearchFile(_hash [32]byte) (XZ21FileProperty, error) {
	return _XZ21.Contract.SearchFile(&_XZ21.CallOpts, _hash)
}

// SearchFile is a free data retrieval call binding the contract method 0x537322e3.
//
// Solidity: function SearchFile(bytes32 _hash) view returns((uint32,address))
func (_XZ21 *XZ21CallerSession) SearchFile(_hash [32]byte) (XZ21FileProperty, error) {
	return _XZ21.Contract.SearchFile(&_XZ21.CallOpts, _hash)
}

// AddrSM is a free data retrieval call binding the contract method 0x58f5823c.
//
// Solidity: function addrSM() view returns(address)
func (_XZ21 *XZ21Caller) AddrSM(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "addrSM")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// AddrSM is a free data retrieval call binding the contract method 0x58f5823c.
//
// Solidity: function addrSM() view returns(address)
func (_XZ21 *XZ21Session) AddrSM() (common.Address, error) {
	return _XZ21.Contract.AddrSM(&_XZ21.CallOpts)
}

// AddrSM is a free data retrieval call binding the contract method 0x58f5823c.
//
// Solidity: function addrSM() view returns(address)
func (_XZ21 *XZ21CallerSession) AddrSM() (common.Address, error) {
	return _XZ21.Contract.AddrSM(&_XZ21.CallOpts)
}

// AddrSP is a free data retrieval call binding the contract method 0x6b884afb.
//
// Solidity: function addrSP() view returns(address)
func (_XZ21 *XZ21Caller) AddrSP(opts *bind.CallOpts) (common.Address, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "addrSP")

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// AddrSP is a free data retrieval call binding the contract method 0x6b884afb.
//
// Solidity: function addrSP() view returns(address)
func (_XZ21 *XZ21Session) AddrSP() (common.Address, error) {
	return _XZ21.Contract.AddrSP(&_XZ21.CallOpts)
}

// AddrSP is a free data retrieval call binding the contract method 0x6b884afb.
//
// Solidity: function addrSP() view returns(address)
func (_XZ21 *XZ21CallerSession) AddrSP() (common.Address, error) {
	return _XZ21.Contract.AddrSP(&_XZ21.CallOpts)
}

// AuditorAddrList is a free data retrieval call binding the contract method 0x2cc19d97.
//
// Solidity: function auditorAddrList(uint256 ) view returns(address)
func (_XZ21 *XZ21Caller) AuditorAddrList(opts *bind.CallOpts, arg0 *big.Int) (common.Address, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "auditorAddrList", arg0)

	if err != nil {
		return *new(common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new(common.Address)).(*common.Address)

	return out0, err

}

// AuditorAddrList is a free data retrieval call binding the contract method 0x2cc19d97.
//
// Solidity: function auditorAddrList(uint256 ) view returns(address)
func (_XZ21 *XZ21Session) AuditorAddrList(arg0 *big.Int) (common.Address, error) {
	return _XZ21.Contract.AuditorAddrList(&_XZ21.CallOpts, arg0)
}

// AuditorAddrList is a free data retrieval call binding the contract method 0x2cc19d97.
//
// Solidity: function auditorAddrList(uint256 ) view returns(address)
func (_XZ21 *XZ21CallerSession) AuditorAddrList(arg0 *big.Int) (common.Address, error) {
	return _XZ21.Contract.AuditorAddrList(&_XZ21.CallOpts, arg0)
}

// AppendOwner is a paid mutator transaction binding the contract method 0xf64b362a.
//
// Solidity: function AppendOwner(bytes32 _hash, address _owner) returns()
func (_XZ21 *XZ21Transactor) AppendOwner(opts *bind.TransactOpts, _hash [32]byte, _owner common.Address) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "AppendOwner", _hash, _owner)
}

// AppendOwner is a paid mutator transaction binding the contract method 0xf64b362a.
//
// Solidity: function AppendOwner(bytes32 _hash, address _owner) returns()
func (_XZ21 *XZ21Session) AppendOwner(_hash [32]byte, _owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.AppendOwner(&_XZ21.TransactOpts, _hash, _owner)
}

// AppendOwner is a paid mutator transaction binding the contract method 0xf64b362a.
//
// Solidity: function AppendOwner(bytes32 _hash, address _owner) returns()
func (_XZ21 *XZ21TransactorSession) AppendOwner(_hash [32]byte, _owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.AppendOwner(&_XZ21.TransactOpts, _hash, _owner)
}

// EnrollAccount is a paid mutator transaction binding the contract method 0x043c9077.
//
// Solidity: function EnrollAccount(int256 _type, address _addr, bytes _pubKey) returns(bool)
func (_XZ21 *XZ21Transactor) EnrollAccount(opts *bind.TransactOpts, _type *big.Int, _addr common.Address, _pubKey []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "EnrollAccount", _type, _addr, _pubKey)
}

// EnrollAccount is a paid mutator transaction binding the contract method 0x043c9077.
//
// Solidity: function EnrollAccount(int256 _type, address _addr, bytes _pubKey) returns(bool)
func (_XZ21 *XZ21Session) EnrollAccount(_type *big.Int, _addr common.Address, _pubKey []byte) (*types.Transaction, error) {
	return _XZ21.Contract.EnrollAccount(&_XZ21.TransactOpts, _type, _addr, _pubKey)
}

// EnrollAccount is a paid mutator transaction binding the contract method 0x043c9077.
//
// Solidity: function EnrollAccount(int256 _type, address _addr, bytes _pubKey) returns(bool)
func (_XZ21 *XZ21TransactorSession) EnrollAccount(_type *big.Int, _addr common.Address, _pubKey []byte) (*types.Transaction, error) {
	return _XZ21.Contract.EnrollAccount(&_XZ21.TransactOpts, _type, _addr, _pubKey)
}

// RegisterFile is a paid mutator transaction binding the contract method 0x22dd2b18.
//
// Solidity: function RegisterFile(bytes32 _hash, uint32 _splitNum, address _owner) returns()
func (_XZ21 *XZ21Transactor) RegisterFile(opts *bind.TransactOpts, _hash [32]byte, _splitNum uint32, _owner common.Address) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "RegisterFile", _hash, _splitNum, _owner)
}

// RegisterFile is a paid mutator transaction binding the contract method 0x22dd2b18.
//
// Solidity: function RegisterFile(bytes32 _hash, uint32 _splitNum, address _owner) returns()
func (_XZ21 *XZ21Session) RegisterFile(_hash [32]byte, _splitNum uint32, _owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterFile(&_XZ21.TransactOpts, _hash, _splitNum, _owner)
}

// RegisterFile is a paid mutator transaction binding the contract method 0x22dd2b18.
//
// Solidity: function RegisterFile(bytes32 _hash, uint32 _splitNum, address _owner) returns()
func (_XZ21 *XZ21TransactorSession) RegisterFile(_hash [32]byte, _splitNum uint32, _owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterFile(&_XZ21.TransactOpts, _hash, _splitNum, _owner)
}

// RegisterParam is a paid mutator transaction binding the contract method 0xc1f16b16.
//
// Solidity: function RegisterParam(string _p, bytes _g, bytes _u) returns()
func (_XZ21 *XZ21Transactor) RegisterParam(opts *bind.TransactOpts, _p string, _g []byte, _u []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "RegisterParam", _p, _g, _u)
}

// RegisterParam is a paid mutator transaction binding the contract method 0xc1f16b16.
//
// Solidity: function RegisterParam(string _p, bytes _g, bytes _u) returns()
func (_XZ21 *XZ21Session) RegisterParam(_p string, _g []byte, _u []byte) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterParam(&_XZ21.TransactOpts, _p, _g, _u)
}

// RegisterParam is a paid mutator transaction binding the contract method 0xc1f16b16.
//
// Solidity: function RegisterParam(string _p, bytes _g, bytes _u) returns()
func (_XZ21 *XZ21TransactorSession) RegisterParam(_p string, _g []byte, _u []byte) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterParam(&_XZ21.TransactOpts, _p, _g, _u)
}

// SetAuditingResult is a paid mutator transaction binding the contract method 0xb645fd63.
//
// Solidity: function SetAuditingResult(bytes32 _hash, bool _result) returns()
func (_XZ21 *XZ21Transactor) SetAuditingResult(opts *bind.TransactOpts, _hash [32]byte, _result bool) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "SetAuditingResult", _hash, _result)
}

// SetAuditingResult is a paid mutator transaction binding the contract method 0xb645fd63.
//
// Solidity: function SetAuditingResult(bytes32 _hash, bool _result) returns()
func (_XZ21 *XZ21Session) SetAuditingResult(_hash [32]byte, _result bool) (*types.Transaction, error) {
	return _XZ21.Contract.SetAuditingResult(&_XZ21.TransactOpts, _hash, _result)
}

// SetAuditingResult is a paid mutator transaction binding the contract method 0xb645fd63.
//
// Solidity: function SetAuditingResult(bytes32 _hash, bool _result) returns()
func (_XZ21 *XZ21TransactorSession) SetAuditingResult(_hash [32]byte, _result bool) (*types.Transaction, error) {
	return _XZ21.Contract.SetAuditingResult(&_XZ21.TransactOpts, _hash, _result)
}

// SetChal is a paid mutator transaction binding the contract method 0xdebffd9a.
//
// Solidity: function SetChal(bytes32 _hash, bytes _chal) returns()
func (_XZ21 *XZ21Transactor) SetChal(opts *bind.TransactOpts, _hash [32]byte, _chal []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "SetChal", _hash, _chal)
}

// SetChal is a paid mutator transaction binding the contract method 0xdebffd9a.
//
// Solidity: function SetChal(bytes32 _hash, bytes _chal) returns()
func (_XZ21 *XZ21Session) SetChal(_hash [32]byte, _chal []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetChal(&_XZ21.TransactOpts, _hash, _chal)
}

// SetChal is a paid mutator transaction binding the contract method 0xdebffd9a.
//
// Solidity: function SetChal(bytes32 _hash, bytes _chal) returns()
func (_XZ21 *XZ21TransactorSession) SetChal(_hash [32]byte, _chal []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetChal(&_XZ21.TransactOpts, _hash, _chal)
}

// SetProof is a paid mutator transaction binding the contract method 0xd746cdd0.
//
// Solidity: function SetProof(bytes32 _hash, bytes _proof) returns()
func (_XZ21 *XZ21Transactor) SetProof(opts *bind.TransactOpts, _hash [32]byte, _proof []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "SetProof", _hash, _proof)
}

// SetProof is a paid mutator transaction binding the contract method 0xd746cdd0.
//
// Solidity: function SetProof(bytes32 _hash, bytes _proof) returns()
func (_XZ21 *XZ21Session) SetProof(_hash [32]byte, _proof []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetProof(&_XZ21.TransactOpts, _hash, _proof)
}

// SetProof is a paid mutator transaction binding the contract method 0xd746cdd0.
//
// Solidity: function SetProof(bytes32 _hash, bytes _proof) returns()
func (_XZ21 *XZ21TransactorSession) SetProof(_hash [32]byte, _proof []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetProof(&_XZ21.TransactOpts, _hash, _proof)
}

// XZ21EventSetAuditingResultIterator is returned from FilterEventSetAuditingResult and is used to iterate over the raw logs and unpacked data for EventSetAuditingResult events raised by the XZ21 contract.
type XZ21EventSetAuditingResultIterator struct {
	Event *XZ21EventSetAuditingResult // Event containing the contract specifics and raw log

	contract *bind.BoundContract // Generic contract to use for unpacking event data
	event    string              // Event name to use for unpacking event data

	logs chan types.Log        // Log channel receiving the found contract events
	sub  ethereum.Subscription // Subscription for errors, completion and termination
	done bool                  // Whether the subscription completed delivering logs
	fail error                 // Occurred error to stop iteration
}

// Next advances the iterator to the subsequent event, returning whether there
// are any more events found. In case of a retrieval or parsing error, false is
// returned and Error() can be queried for the exact failure.
func (it *XZ21EventSetAuditingResultIterator) Next() bool {
	// If the iterator failed, stop iterating
	if it.fail != nil {
		return false
	}
	// If the iterator completed, deliver directly whatever's available
	if it.done {
		select {
		case log := <-it.logs:
			it.Event = new(XZ21EventSetAuditingResult)
			if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
				it.fail = err
				return false
			}
			it.Event.Raw = log
			return true

		default:
			return false
		}
	}
	// Iterator still in progress, wait for either a data or an error event
	select {
	case log := <-it.logs:
		it.Event = new(XZ21EventSetAuditingResult)
		if err := it.contract.UnpackLog(it.Event, it.event, log); err != nil {
			it.fail = err
			return false
		}
		it.Event.Raw = log
		return true

	case err := <-it.sub.Err():
		it.done = true
		it.fail = err
		return it.Next()
	}
}

// Error returns any retrieval or parsing error occurred during filtering.
func (it *XZ21EventSetAuditingResultIterator) Error() error {
	return it.fail
}

// Close terminates the iteration process, releasing any pending underlying
// resources.
func (it *XZ21EventSetAuditingResultIterator) Close() error {
	it.sub.Unsubscribe()
	return nil
}

// XZ21EventSetAuditingResult represents a EventSetAuditingResult event raised by the XZ21 contract.
type XZ21EventSetAuditingResult struct {
	Hash   [32]byte
	Result bool
	Raw    types.Log // Blockchain specific contextual infos
}

// FilterEventSetAuditingResult is a free log retrieval operation binding the contract event 0x961a406eff4d590fdb9e54bdba584518be2e6a7f91b34d5714330f83d571b031.
//
// Solidity: event EventSetAuditingResult(bytes32 _hash, bool _result)
func (_XZ21 *XZ21Filterer) FilterEventSetAuditingResult(opts *bind.FilterOpts) (*XZ21EventSetAuditingResultIterator, error) {

	logs, sub, err := _XZ21.contract.FilterLogs(opts, "EventSetAuditingResult")
	if err != nil {
		return nil, err
	}
	return &XZ21EventSetAuditingResultIterator{contract: _XZ21.contract, event: "EventSetAuditingResult", logs: logs, sub: sub}, nil
}

// WatchEventSetAuditingResult is a free log subscription operation binding the contract event 0x961a406eff4d590fdb9e54bdba584518be2e6a7f91b34d5714330f83d571b031.
//
// Solidity: event EventSetAuditingResult(bytes32 _hash, bool _result)
func (_XZ21 *XZ21Filterer) WatchEventSetAuditingResult(opts *bind.WatchOpts, sink chan<- *XZ21EventSetAuditingResult) (event.Subscription, error) {

	logs, sub, err := _XZ21.contract.WatchLogs(opts, "EventSetAuditingResult")
	if err != nil {
		return nil, err
	}
	return event.NewSubscription(func(quit <-chan struct{}) error {
		defer sub.Unsubscribe()
		for {
			select {
			case log := <-logs:
				// New log arrived, parse the event and forward to the user
				event := new(XZ21EventSetAuditingResult)
				if err := _XZ21.contract.UnpackLog(event, "EventSetAuditingResult", log); err != nil {
					return err
				}
				event.Raw = log

				select {
				case sink <- event:
				case err := <-sub.Err():
					return err
				case <-quit:
					return nil
				}
			case err := <-sub.Err():
				return err
			case <-quit:
				return nil
			}
		}
	}), nil
}

// ParseEventSetAuditingResult is a log parse operation binding the contract event 0x961a406eff4d590fdb9e54bdba584518be2e6a7f91b34d5714330f83d571b031.
//
// Solidity: event EventSetAuditingResult(bytes32 _hash, bool _result)
func (_XZ21 *XZ21Filterer) ParseEventSetAuditingResult(log types.Log) (*XZ21EventSetAuditingResult, error) {
	event := new(XZ21EventSetAuditingResult)
	if err := _XZ21.contract.UnpackLog(event, "EventSetAuditingResult", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}
