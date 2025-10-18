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
	ABI: "[{\"type\":\"constructor\",\"inputs\":[{\"name\":\"_addrSP\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"addrSM\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"addrSP\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"appendOwner\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"owner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"auditorAddrList\",\"inputs\":[{\"name\":\"\",\"type\":\"uint256\",\"internalType\":\"uint256\"}],\"outputs\":[{\"name\":\"\",\"type\":\"address\",\"internalType\":\"address\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"enrollAccount\",\"inputs\":[{\"name\":\"accountType\",\"type\":\"int256\",\"internalType\":\"int256\"},{\"name\":\"addr\",\"type\":\"address\",\"internalType\":\"address\"},{\"name\":\"pubKey\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"getAuditingLogs\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple[]\",\"internalType\":\"structXZ21.AuditingLog[]\",\"components\":[{\"name\":\"chal\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"proof\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"result\",\"type\":\"bool\",\"internalType\":\"bool\"},{\"name\":\"date\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"stage\",\"type\":\"uint8\",\"internalType\":\"enumXZ21.Stages\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getAuditorAddrList\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"address[]\",\"internalType\":\"address[]\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getFileList\",\"inputs\":[{\"name\":\"owner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"bytes32[]\",\"internalType\":\"bytes32[]\"}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getLatestAuditingLog\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.AuditingLog\",\"components\":[{\"name\":\"chal\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"proof\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"result\",\"type\":\"bool\",\"internalType\":\"bool\"},{\"name\":\"date\",\"type\":\"uint256\",\"internalType\":\"uint256\"},{\"name\":\"stage\",\"type\":\"uint8\",\"internalType\":\"enumXZ21.Stages\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getParam\",\"inputs\":[],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.Param\",\"components\":[{\"name\":\"P\",\"type\":\"string\",\"internalType\":\"string\"},{\"name\":\"U\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"G\",\"type\":\"bytes\",\"internalType\":\"bytes\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"getUserAccount\",\"inputs\":[{\"name\":\"addr\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.Account\",\"components\":[{\"name\":\"pubKey\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"fileList\",\"type\":\"bytes32[]\",\"internalType\":\"bytes32[]\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"registerFile\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"splitNum\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"owner\",\"type\":\"address\",\"internalType\":\"address\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"registerParam\",\"inputs\":[{\"name\":\"paramP\",\"type\":\"string\",\"internalType\":\"string\"},{\"name\":\"paramG\",\"type\":\"bytes\",\"internalType\":\"bytes\"},{\"name\":\"paramU\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"searchFile\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"}],\"outputs\":[{\"name\":\"\",\"type\":\"tuple\",\"internalType\":\"structXZ21.FileProperty\",\"components\":[{\"name\":\"splitNum\",\"type\":\"uint32\",\"internalType\":\"uint32\"},{\"name\":\"creator\",\"type\":\"address\",\"internalType\":\"address\"}]}],\"stateMutability\":\"view\"},{\"type\":\"function\",\"name\":\"setAuditingResult\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"result\",\"type\":\"bool\",\"internalType\":\"bool\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setChal\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"chal\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"function\",\"name\":\"setProof\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"internalType\":\"bytes32\"},{\"name\":\"proof\",\"type\":\"bytes\",\"internalType\":\"bytes\"}],\"outputs\":[],\"stateMutability\":\"nonpayable\"},{\"type\":\"event\",\"name\":\"EventSetAuditingResult\",\"inputs\":[{\"name\":\"hash\",\"type\":\"bytes32\",\"indexed\":false,\"internalType\":\"bytes32\"},{\"name\":\"result\",\"type\":\"bool\",\"indexed\":false,\"internalType\":\"bool\"}],\"anonymous\":false}]",
	Bin: "0x60c060405234801561001057600080fd5b506040516122aa3803806122aa83398101604081905261002f91610099565b6001600160a01b03811661007a5760405162461bcd60e51b815260206004820152600e60248201526d616464725350206973207a65726f60901b604482015260640160405180910390fd5b336080526001600160a01b031660a0526003805460ff191690556100c9565b6000602082840312156100ab57600080fd5b81516001600160a01b03811681146100c257600080fd5b9392505050565b60805160a051612199610111600039600081816101e20152818161035e01528181610fdc01526117470152600081816101bb01528181610bf1015261139001526121996000f3fe608060405234801561001057600080fd5b506004361061010b5760003560e01c806379444d56116100a2578063d91a2fa911610071578063d91a2fa9146102d3578063da234f63146102e6578063df247e7014610306578063fb47e01614610329578063fff8668a1461034957600080fd5b806379444d561461020457806393933bdb1461028d578063b2b43370146102a0578063b94dbf25146102c057600080fd5b8063494b702d116100de578063494b702d1461018e57806358cf520b146101a357806358f5823c146101b65780636b884afb146101dd57600080fd5b8063024486c4146101105780632a2465fc146101255780632cc19d97146101435780632e9598551461016e575b600080fd5b61012361011e3660046118f7565b61035c565b005b61012d61042a565b60405161013a9190611969565b60405180910390f35b6101566101513660046119ca565b610616565b6040516001600160a01b03909116815260200161013a565b61018161017c3660046119ca565b610640565b60405161013a9190611a74565b61019661084f565b60405161013a9190611a8e565b6101236101b1366004611adb565b6108b1565b6101567f000000000000000000000000000000000000000000000000000000000000000081565b6101567f000000000000000000000000000000000000000000000000000000000000000081565b6102636102123660046119ca565b60408051808201909152600080825260208201525060009081526006602090815260409182902082518084019093525463ffffffff8116835264010000000090046001600160a01b03169082015290565b60408051825163ffffffff1681526020928301516001600160a01b0316928101929092520161013a565b61012361029b366004611bbc565b610bef565b6102b36102ae366004611c5b565b610cc3565b60405161013a9190611cb2565b6101236102ce366004611d0e565b610db2565b6101236102e1366004611d0e565b610fda565b6102f96102f43660046119ca565b6111aa565b60405161013a9190611d5a565b610319610314366004611dbe565b61138c565b604051901515815260200161013a565b61033c610337366004611c5b565b61161f565b60405161013a9190611e18565b610123610357366004611e51565b611745565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031633146103ad5760405162461bcd60e51b81526004016103a490611e98565b60405180910390fd5b60008281526006602052604090205463ffffffff166103fd5760405162461bcd60e51b815260206004820152600c60248201526b696e76616c69642066696c6560a01b60448201526064016103a4565b6001600160a01b031660009081526005602090815260408220600190810180549182018155835291200155565b61044e60405180606001604052806060815260200160608152602001606081525090565b600060405180606001604052908160008201805461046b90611ed9565b80601f016020809104026020016040519081016040528092919081815260200182805461049790611ed9565b80156104e45780601f106104b9576101008083540402835291602001916104e4565b820191906000526020600020905b8154815290600101906020018083116104c757829003601f168201915b505050505081526020016001820180546104fd90611ed9565b80601f016020809104026020016040519081016040528092919081815260200182805461052990611ed9565b80156105765780601f1061054b57610100808354040283529160200191610576565b820191906000526020600020905b81548152906001019060200180831161055957829003601f168201915b5050505050815260200160028201805461058f90611ed9565b80601f01602080910402602001604051908101604052809291908181526020018280546105bb90611ed9565b80156106085780601f106105dd57610100808354040283529160200191610608565b820191906000526020600020905b8154815290600101906020018083116105eb57829003601f168201915b505050505081525050905090565b6004818154811061062657600080fd5b6000918252602090912001546001600160a01b0316905081565b61064861183a565b6000828152600760205260409020548061068e5760405162461bcd60e51b81526020600482015260076024820152664e6f206461746160c81b60448201526064016103a4565b600061069b600183611f13565b6000858152600760205260409020805491925090829081106106bf576106bf611f3a565b90600052602060002090600502016040518060a00160405290816000820180546106e890611ed9565b80601f016020809104026020016040519081016040528092919081815260200182805461071490611ed9565b80156107615780601f1061073657610100808354040283529160200191610761565b820191906000526020600020905b81548152906001019060200180831161074457829003601f168201915b5050505050815260200160018201805461077a90611ed9565b80601f01602080910402602001604051908101604052809291908181526020018280546107a690611ed9565b80156107f35780601f106107c8576101008083540402835291602001916107f3565b820191906000526020600020905b8154815290600101906020018083116107d657829003601f168201915b505050918352505060028281015460ff908116151560208401526003840154604084015260048401546060909301921690811115610833576108336119e3565b6002811115610844576108446119e3565b905250949350505050565b606060048054806020026020016040519081016040528092919081815260200182805480156108a757602002820191906000526020600020905b81546001600160a01b03168152600190910190602001808311610889575b5050505050905090565b6000805b60045481101561090757336001600160a01b0316600482815481106108dc576108dc611f3a565b6000918252602090912001546001600160a01b0316036108ff5760019150610907565b6001016108b5565b50806109605760405162461bcd60e51b815260206004820152602260248201527f41757468656e7469636174696f6e206572726f7220284f6e6c79206279205450604482015261412960f01b60648201526084016103a4565b600083815260076020526040902054806109ac5760405162461bcd60e51b815260206004820152600d60248201526c26b4b9b9b4b73390383937b7b360991b60448201526064016103a4565b60006109b9600183611f13565b9050600160008681526007602052604090208054839081106109dd576109dd611f3a565b600091825260209091206004600590920201015460ff166002811115610a0557610a056119e3565b14610a465760405162461bcd60e51b8152602060048201526011602482015270139bdd0815d85a5d1a5b99d4995cdd5b1d607a1b60448201526064016103a4565b8015610ad1576000610a59600183611f13565b60008781526007602052604090208054919250429183908110610a7e57610a7e611f3a565b90600052602060002090600502016003015410610acf5760405162461bcd60e51b815260206004820152600f60248201526e3a34b6b2b9ba30b6b81032b93937b960891b60448201526064016103a4565b505b6000858152600760205260409020805485919083908110610af457610af4611f3a565b906000526020600020906005020160020160006101000a81548160ff02191690831515021790555042600760008781526020019081526020016000208281548110610b4157610b41611f3a565b9060005260206000209060050201600301819055506002600760008781526020019081526020016000208281548110610b7c57610b7c611f3a565b60009182526020909120600460059092020101805460ff19166001836002811115610ba957610ba96119e3565b02179055506040805186815285151560208201527f961a406eff4d590fdb9e54bdba584518be2e6a7f91b34d5714330f83d571b031910160405180910390a15050505050565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b03163314610c375760405162461bcd60e51b81526004016103a490611f50565b60035460ff1615610c8a5760405162461bcd60e51b815260206004820152601e60248201527f446f206e6f74206f7665727772697465207265676973746572506172616d000060448201526064016103a4565b6000610c968482611fe2565b506001610ca38282611fe2565b506002610cb08382611fe2565b50506003805460ff191660011790555050565b6001600160a01b0381166000908152600560205260408120600101546060918167ffffffffffffffff811115610cfb57610cfb611b10565b604051908082528060200260200182016040528015610d24578160200160208202803683370190505b50905060005b6001600160a01b038516600090815260056020526040902060010154811015610daa576001600160a01b0385166000908152600560205260409020600101805482908110610d7a57610d7a611f3a565b9060005260206000200154828281518110610d9757610d97611f3a565b6020908102919091010152600101610d2a565b509392505050565b3360009081526005602052604081208054610dcc90611ed9565b905011610e255760405162461bcd60e51b815260206004820152602160248201527f41757468656e7469636174696f6e206572726f7220284f6e6c792062792053556044820152602960f81b60648201526084016103a4565b6000838152600760205260409020548015610ed4576000610e47600183611f13565b905060026000868152600760205260409020805483908110610e6b57610e6b611f3a565b600091825260209091206004600590920201015460ff166002811115610e9357610e936119e3565b14610ed25760405162461bcd60e51b815260206004820152600f60248201526e139bdd0815d85a5d1a5b99d0da185b608a1b60448201526064016103a4565b505b6040805160c06020601f8601819004028201810190925260a08101848152600092829190879087908190850183828082843760009201829052509385525050604080516020818101835284825285015283018290525060608201819052608090910152600086815260076020908152604082208054600181018255908352912082519293508392600590920201908190610f6e9082611fe2565b5060208201516001820190610f839082611fe2565b5060408201516002808301805492151560ff19938416179055606084015160038401556080840151600484018054919390929116906001908490811115610fcc57610fcc6119e3565b021790555050505050505050565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031633146110225760405162461bcd60e51b81526004016103a490611e98565b600083815260076020526040902054806110725760405162461bcd60e51b81526020600482015260116024820152704d697373696e67206368616c6c656e676560781b60448201526064016103a4565b600061107f600183611f13565b90506000808681526007602052604090208054839081106110a2576110a2611f3a565b600091825260209091206004600590920201015460ff1660028111156110ca576110ca6119e3565b1461110a5760405162461bcd60e51b815260206004820152601060248201526f2737ba102bb0b4ba34b733a83937b7b360811b60448201526064016103a4565b60008581526007602052604090208054859185918490811061112e5761112e611f3a565b9060005260206000209060050201600101918261114c9291906120a2565b5060008581526007602052604090208054600191908390811061117157611171611f3a565b60009182526020909120600460059092020101805460ff1916600183600281111561119e5761119e6119e3565b02179055505050505050565b606060076000838152602001908152602001600020805480602002602001604051908101604052809291908181526020016000905b8282101561138157838290600052602060002090600502016040518060a001604052908160008201805461121290611ed9565b80601f016020809104026020016040519081016040528092919081815260200182805461123e90611ed9565b801561128b5780601f106112605761010080835404028352916020019161128b565b820191906000526020600020905b81548152906001019060200180831161126e57829003601f168201915b505050505081526020016001820180546112a490611ed9565b80601f01602080910402602001604051908101604052809291908181526020018280546112d090611ed9565b801561131d5780601f106112f25761010080835404028352916020019161131d565b820191906000526020600020905b81548152906001019060200180831161130057829003601f168201915b505050918352505060028281015460ff90811615156020840152600384015460408401526004840154606090930192169081111561135d5761135d6119e3565b600281111561136e5761136e6119e3565b81525050815260200190600101906111df565b505050509050919050565b60007f00000000000000000000000000000000000000000000000000000000000000006001600160a01b031633146113d65760405162461bcd60e51b81526004016103a490611f50565b8415806113e35750846001145b6114265760405162461bcd60e51b8152602060048201526014602482015273496e76616c6964206163636f756e74207479706560601b60448201526064016103a4565b8460000361151f57600454600090815b8181101561148657866001600160a01b03166004828154811061145b5761145b611f3a565b6000918252602090912001546001600160a01b03160361147e5760019250611486565b600101611436565b5081156114cd5760405162461bcd60e51b81526020600482015260156024820152744475706c696361746520545041206164647265737360581b60448201526064016103a4565b5050600480546001810182556000919091527f8a35acfbc15ff81a39ae7d344fd709f28e8600b4aa8c65c6b64bfe7fe36bd19b0180546001600160a01b0319166001600160a01b038616179055611614565b6001600160a01b0384166000908152600560205260409020805461154290611ed9565b1590506115885760405162461bcd60e51b8152602060048201526014602482015273111d5c1b1a58d85d194814d5481858d8dbdd5b9d60621b60448201526064016103a4565b6040805160606020601f86018190040282018101835291810184815290918291908690869081908501838280828437600092018290525093855250506040805183815260208082018352948501526001600160a01b038916835260059093525020815181906115f79082611fe2565b506020828101518051611610926001850192019061187b565b5050505b506001949350505050565b60408051808201909152606080825260208201526001600160a01b03821660009081526005602052604090819020815180830190925280548290829061166490611ed9565b80601f016020809104026020016040519081016040528092919081815260200182805461169090611ed9565b80156116dd5780601f106116b2576101008083540402835291602001916116dd565b820191906000526020600020905b8154815290600101906020018083116116c057829003601f168201915b505050505081526020016001820180548060200260200160405190810160405280929190818152602001828054801561173557602002820191906000526020600020905b815481526020019060010190808311611721575b5050505050815250509050919050565b7f00000000000000000000000000000000000000000000000000000000000000006001600160a01b0316331461178d5760405162461bcd60e51b81526004016103a490611e98565b60008263ffffffff16116117d75760405162461bcd60e51b8152602060048201526011602482015270696e76616c69642073706c6974206e756d60781b60448201526064016103a4565b6000838152600660209081526040808320805463ffffffff969096166001600160c01b0319909616959095176401000000006001600160a01b03959095169485021790945591815260058252918220600190810180549182018155835291200155565b6040518060a0016040528060608152602001606081526020016000151581526020016000815260200160006002811115611876576118766119e3565b905290565b8280548282559060005260206000209081019282156118b6579160200282015b828111156118b657825182559160200191906001019061189b565b506118c29291506118c6565b5090565b5b808211156118c257600081556001016118c7565b80356001600160a01b03811681146118f257600080fd5b919050565b6000806040838503121561190a57600080fd5b8235915061191a602084016118db565b90509250929050565b6000815180845260005b818110156119495760208185018101518683018201520161192d565b506000602082860101526020601f19601f83011685010191505092915050565b6020815260008251606060208401526119856080840182611923565b90506020840151601f19808584030160408601526119a38383611923565b92506040860151915080858403016060860152506119c18282611923565b95945050505050565b6000602082840312156119dc57600080fd5b5035919050565b634e487b7160e01b600052602160045260246000fd5b6000815160a08452611a0e60a0850182611923565b905060208301518482036020860152611a278282611923565b91505060408301511515604085015260608301516060850152608083015160038110611a6357634e487b7160e01b600052602160045260246000fd5b806080860152508091505092915050565b602081526000611a8760208301846119f9565b9392505050565b6020808252825182820181905260009190848201906040850190845b81811015611acf5783516001600160a01b031683529284019291840191600101611aaa565b50909695505050505050565b60008060408385031215611aee57600080fd5b8235915060208301358015158114611b0557600080fd5b809150509250929050565b634e487b7160e01b600052604160045260246000fd5b600067ffffffffffffffff80841115611b4157611b41611b10565b604051601f8501601f19908116603f01168101908282118183101715611b6957611b69611b10565b81604052809350858152868686011115611b8257600080fd5b858560208301376000602087830101525050509392505050565b600082601f830112611bad57600080fd5b611a8783833560208501611b26565b600080600060608486031215611bd157600080fd5b833567ffffffffffffffff80821115611be957600080fd5b818601915086601f830112611bfd57600080fd5b611c0c87833560208501611b26565b94506020860135915080821115611c2257600080fd5b611c2e87838801611b9c565b93506040860135915080821115611c4457600080fd5b50611c5186828701611b9c565b9150509250925092565b600060208284031215611c6d57600080fd5b611a87826118db565b60008151808452602080850194506020840160005b83811015611ca757815187529582019590820190600101611c8b565b509495945050505050565b602081526000611a876020830184611c76565b60008083601f840112611cd757600080fd5b50813567ffffffffffffffff811115611cef57600080fd5b602083019150836020828501011115611d0757600080fd5b9250929050565b600080600060408486031215611d2357600080fd5b83359250602084013567ffffffffffffffff811115611d4157600080fd5b611d4d86828701611cc5565b9497909650939450505050565b600060208083016020845280855180835260408601915060408160051b87010192506020870160005b82811015611db157603f19888603018452611d9f8583516119f9565b94509285019290850190600101611d83565b5092979650505050505050565b60008060008060608587031215611dd457600080fd5b84359350611de4602086016118db565b9250604085013567ffffffffffffffff811115611e0057600080fd5b611e0c87828801611cc5565b95989497509550505050565b602081526000825160406020840152611e346060840182611923565b90506020840151601f198483030160408501526119c18282611c76565b600080600060608486031215611e6657600080fd5b83359250602084013563ffffffff81168114611e8157600080fd5b9150611e8f604085016118db565b90509250925092565b60208082526021908201527f41757468656e7469636174696f6e206572726f7220284f6e6c792062792053506040820152602960f81b606082015260800190565b600181811c90821680611eed57607f821691505b602082108103611f0d57634e487b7160e01b600052602260045260246000fd5b50919050565b81810381811115611f3457634e487b7160e01b600052601160045260246000fd5b92915050565b634e487b7160e01b600052603260045260246000fd5b60208082526021908201527f41757468656e7469636174696f6e206572726f7220284f6e6c7920627920534d6040820152602960f81b606082015260800190565b601f821115611fdd576000816000526020600020601f850160051c81016020861015611fba5750805b601f850160051c820191505b81811015611fd957828155600101611fc6565b5050505b505050565b815167ffffffffffffffff811115611ffc57611ffc611b10565b6120108161200a8454611ed9565b84611f91565b602080601f831160018114612045576000841561202d5750858301515b600019600386901b1c1916600185901b178555611fd9565b600085815260208120601f198616915b8281101561207457888601518255948401946001909101908401612055565b50858210156120925787850151600019600388901b60f8161c191681555b5050505050600190811b01905550565b67ffffffffffffffff8311156120ba576120ba611b10565b6120ce836120c88354611ed9565b83611f91565b6000601f84116001811461210257600085156120ea5750838201355b600019600387901b1c1916600186901b17835561215c565b600083815260209020601f19861690835b828110156121335786850135825560209485019460019092019101612113565b50868210156121505760001960f88860031b161c19848701351681555b505060018560011b0183555b505050505056fea26469706673582212201656c2844676e10efdc23645a43c24fb192808c1fc6a68843f8155d4020e9e0464736f6c63430008190033",
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

// GetAuditingLogs is a free data retrieval call binding the contract method 0xda234f63.
//
// Solidity: function getAuditingLogs(bytes32 hash) view returns((bytes,bytes,bool,uint256,uint8)[])
func (_XZ21 *XZ21Caller) GetAuditingLogs(opts *bind.CallOpts, hash [32]byte) ([]XZ21AuditingLog, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "getAuditingLogs", hash)

	if err != nil {
		return *new([]XZ21AuditingLog), err
	}

	out0 := *abi.ConvertType(out[0], new([]XZ21AuditingLog)).(*[]XZ21AuditingLog)

	return out0, err

}

// GetAuditingLogs is a free data retrieval call binding the contract method 0xda234f63.
//
// Solidity: function getAuditingLogs(bytes32 hash) view returns((bytes,bytes,bool,uint256,uint8)[])
func (_XZ21 *XZ21Session) GetAuditingLogs(hash [32]byte) ([]XZ21AuditingLog, error) {
	return _XZ21.Contract.GetAuditingLogs(&_XZ21.CallOpts, hash)
}

// GetAuditingLogs is a free data retrieval call binding the contract method 0xda234f63.
//
// Solidity: function getAuditingLogs(bytes32 hash) view returns((bytes,bytes,bool,uint256,uint8)[])
func (_XZ21 *XZ21CallerSession) GetAuditingLogs(hash [32]byte) ([]XZ21AuditingLog, error) {
	return _XZ21.Contract.GetAuditingLogs(&_XZ21.CallOpts, hash)
}

// GetAuditorAddrList is a free data retrieval call binding the contract method 0x494b702d.
//
// Solidity: function getAuditorAddrList() view returns(address[])
func (_XZ21 *XZ21Caller) GetAuditorAddrList(opts *bind.CallOpts) ([]common.Address, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "getAuditorAddrList")

	if err != nil {
		return *new([]common.Address), err
	}

	out0 := *abi.ConvertType(out[0], new([]common.Address)).(*[]common.Address)

	return out0, err

}

// GetAuditorAddrList is a free data retrieval call binding the contract method 0x494b702d.
//
// Solidity: function getAuditorAddrList() view returns(address[])
func (_XZ21 *XZ21Session) GetAuditorAddrList() ([]common.Address, error) {
	return _XZ21.Contract.GetAuditorAddrList(&_XZ21.CallOpts)
}

// GetAuditorAddrList is a free data retrieval call binding the contract method 0x494b702d.
//
// Solidity: function getAuditorAddrList() view returns(address[])
func (_XZ21 *XZ21CallerSession) GetAuditorAddrList() ([]common.Address, error) {
	return _XZ21.Contract.GetAuditorAddrList(&_XZ21.CallOpts)
}

// GetFileList is a free data retrieval call binding the contract method 0xb2b43370.
//
// Solidity: function getFileList(address owner) view returns(bytes32[])
func (_XZ21 *XZ21Caller) GetFileList(opts *bind.CallOpts, owner common.Address) ([][32]byte, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "getFileList", owner)

	if err != nil {
		return *new([][32]byte), err
	}

	out0 := *abi.ConvertType(out[0], new([][32]byte)).(*[][32]byte)

	return out0, err

}

// GetFileList is a free data retrieval call binding the contract method 0xb2b43370.
//
// Solidity: function getFileList(address owner) view returns(bytes32[])
func (_XZ21 *XZ21Session) GetFileList(owner common.Address) ([][32]byte, error) {
	return _XZ21.Contract.GetFileList(&_XZ21.CallOpts, owner)
}

// GetFileList is a free data retrieval call binding the contract method 0xb2b43370.
//
// Solidity: function getFileList(address owner) view returns(bytes32[])
func (_XZ21 *XZ21CallerSession) GetFileList(owner common.Address) ([][32]byte, error) {
	return _XZ21.Contract.GetFileList(&_XZ21.CallOpts, owner)
}

// GetLatestAuditingLog is a free data retrieval call binding the contract method 0x2e959855.
//
// Solidity: function getLatestAuditingLog(bytes32 hash) view returns((bytes,bytes,bool,uint256,uint8))
func (_XZ21 *XZ21Caller) GetLatestAuditingLog(opts *bind.CallOpts, hash [32]byte) (XZ21AuditingLog, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "getLatestAuditingLog", hash)

	if err != nil {
		return *new(XZ21AuditingLog), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21AuditingLog)).(*XZ21AuditingLog)

	return out0, err

}

// GetLatestAuditingLog is a free data retrieval call binding the contract method 0x2e959855.
//
// Solidity: function getLatestAuditingLog(bytes32 hash) view returns((bytes,bytes,bool,uint256,uint8))
func (_XZ21 *XZ21Session) GetLatestAuditingLog(hash [32]byte) (XZ21AuditingLog, error) {
	return _XZ21.Contract.GetLatestAuditingLog(&_XZ21.CallOpts, hash)
}

// GetLatestAuditingLog is a free data retrieval call binding the contract method 0x2e959855.
//
// Solidity: function getLatestAuditingLog(bytes32 hash) view returns((bytes,bytes,bool,uint256,uint8))
func (_XZ21 *XZ21CallerSession) GetLatestAuditingLog(hash [32]byte) (XZ21AuditingLog, error) {
	return _XZ21.Contract.GetLatestAuditingLog(&_XZ21.CallOpts, hash)
}

// GetParam is a free data retrieval call binding the contract method 0x2a2465fc.
//
// Solidity: function getParam() view returns((string,bytes,bytes))
func (_XZ21 *XZ21Caller) GetParam(opts *bind.CallOpts) (XZ21Param, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "getParam")

	if err != nil {
		return *new(XZ21Param), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21Param)).(*XZ21Param)

	return out0, err

}

// GetParam is a free data retrieval call binding the contract method 0x2a2465fc.
//
// Solidity: function getParam() view returns((string,bytes,bytes))
func (_XZ21 *XZ21Session) GetParam() (XZ21Param, error) {
	return _XZ21.Contract.GetParam(&_XZ21.CallOpts)
}

// GetParam is a free data retrieval call binding the contract method 0x2a2465fc.
//
// Solidity: function getParam() view returns((string,bytes,bytes))
func (_XZ21 *XZ21CallerSession) GetParam() (XZ21Param, error) {
	return _XZ21.Contract.GetParam(&_XZ21.CallOpts)
}

// GetUserAccount is a free data retrieval call binding the contract method 0xfb47e016.
//
// Solidity: function getUserAccount(address addr) view returns((bytes,bytes32[]))
func (_XZ21 *XZ21Caller) GetUserAccount(opts *bind.CallOpts, addr common.Address) (XZ21Account, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "getUserAccount", addr)

	if err != nil {
		return *new(XZ21Account), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21Account)).(*XZ21Account)

	return out0, err

}

// GetUserAccount is a free data retrieval call binding the contract method 0xfb47e016.
//
// Solidity: function getUserAccount(address addr) view returns((bytes,bytes32[]))
func (_XZ21 *XZ21Session) GetUserAccount(addr common.Address) (XZ21Account, error) {
	return _XZ21.Contract.GetUserAccount(&_XZ21.CallOpts, addr)
}

// GetUserAccount is a free data retrieval call binding the contract method 0xfb47e016.
//
// Solidity: function getUserAccount(address addr) view returns((bytes,bytes32[]))
func (_XZ21 *XZ21CallerSession) GetUserAccount(addr common.Address) (XZ21Account, error) {
	return _XZ21.Contract.GetUserAccount(&_XZ21.CallOpts, addr)
}

// SearchFile is a free data retrieval call binding the contract method 0x79444d56.
//
// Solidity: function searchFile(bytes32 hash) view returns((uint32,address))
func (_XZ21 *XZ21Caller) SearchFile(opts *bind.CallOpts, hash [32]byte) (XZ21FileProperty, error) {
	var out []interface{}
	err := _XZ21.contract.Call(opts, &out, "searchFile", hash)

	if err != nil {
		return *new(XZ21FileProperty), err
	}

	out0 := *abi.ConvertType(out[0], new(XZ21FileProperty)).(*XZ21FileProperty)

	return out0, err

}

// SearchFile is a free data retrieval call binding the contract method 0x79444d56.
//
// Solidity: function searchFile(bytes32 hash) view returns((uint32,address))
func (_XZ21 *XZ21Session) SearchFile(hash [32]byte) (XZ21FileProperty, error) {
	return _XZ21.Contract.SearchFile(&_XZ21.CallOpts, hash)
}

// SearchFile is a free data retrieval call binding the contract method 0x79444d56.
//
// Solidity: function searchFile(bytes32 hash) view returns((uint32,address))
func (_XZ21 *XZ21CallerSession) SearchFile(hash [32]byte) (XZ21FileProperty, error) {
	return _XZ21.Contract.SearchFile(&_XZ21.CallOpts, hash)
}

// AppendOwner is a paid mutator transaction binding the contract method 0x024486c4.
//
// Solidity: function appendOwner(bytes32 hash, address owner) returns()
func (_XZ21 *XZ21Transactor) AppendOwner(opts *bind.TransactOpts, hash [32]byte, owner common.Address) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "appendOwner", hash, owner)
}

// AppendOwner is a paid mutator transaction binding the contract method 0x024486c4.
//
// Solidity: function appendOwner(bytes32 hash, address owner) returns()
func (_XZ21 *XZ21Session) AppendOwner(hash [32]byte, owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.AppendOwner(&_XZ21.TransactOpts, hash, owner)
}

// AppendOwner is a paid mutator transaction binding the contract method 0x024486c4.
//
// Solidity: function appendOwner(bytes32 hash, address owner) returns()
func (_XZ21 *XZ21TransactorSession) AppendOwner(hash [32]byte, owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.AppendOwner(&_XZ21.TransactOpts, hash, owner)
}

// EnrollAccount is a paid mutator transaction binding the contract method 0xdf247e70.
//
// Solidity: function enrollAccount(int256 accountType, address addr, bytes pubKey) returns(bool)
func (_XZ21 *XZ21Transactor) EnrollAccount(opts *bind.TransactOpts, accountType *big.Int, addr common.Address, pubKey []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "enrollAccount", accountType, addr, pubKey)
}

// EnrollAccount is a paid mutator transaction binding the contract method 0xdf247e70.
//
// Solidity: function enrollAccount(int256 accountType, address addr, bytes pubKey) returns(bool)
func (_XZ21 *XZ21Session) EnrollAccount(accountType *big.Int, addr common.Address, pubKey []byte) (*types.Transaction, error) {
	return _XZ21.Contract.EnrollAccount(&_XZ21.TransactOpts, accountType, addr, pubKey)
}

// EnrollAccount is a paid mutator transaction binding the contract method 0xdf247e70.
//
// Solidity: function enrollAccount(int256 accountType, address addr, bytes pubKey) returns(bool)
func (_XZ21 *XZ21TransactorSession) EnrollAccount(accountType *big.Int, addr common.Address, pubKey []byte) (*types.Transaction, error) {
	return _XZ21.Contract.EnrollAccount(&_XZ21.TransactOpts, accountType, addr, pubKey)
}

// RegisterFile is a paid mutator transaction binding the contract method 0xfff8668a.
//
// Solidity: function registerFile(bytes32 hash, uint32 splitNum, address owner) returns()
func (_XZ21 *XZ21Transactor) RegisterFile(opts *bind.TransactOpts, hash [32]byte, splitNum uint32, owner common.Address) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "registerFile", hash, splitNum, owner)
}

// RegisterFile is a paid mutator transaction binding the contract method 0xfff8668a.
//
// Solidity: function registerFile(bytes32 hash, uint32 splitNum, address owner) returns()
func (_XZ21 *XZ21Session) RegisterFile(hash [32]byte, splitNum uint32, owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterFile(&_XZ21.TransactOpts, hash, splitNum, owner)
}

// RegisterFile is a paid mutator transaction binding the contract method 0xfff8668a.
//
// Solidity: function registerFile(bytes32 hash, uint32 splitNum, address owner) returns()
func (_XZ21 *XZ21TransactorSession) RegisterFile(hash [32]byte, splitNum uint32, owner common.Address) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterFile(&_XZ21.TransactOpts, hash, splitNum, owner)
}

// RegisterParam is a paid mutator transaction binding the contract method 0x93933bdb.
//
// Solidity: function registerParam(string paramP, bytes paramG, bytes paramU) returns()
func (_XZ21 *XZ21Transactor) RegisterParam(opts *bind.TransactOpts, paramP string, paramG []byte, paramU []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "registerParam", paramP, paramG, paramU)
}

// RegisterParam is a paid mutator transaction binding the contract method 0x93933bdb.
//
// Solidity: function registerParam(string paramP, bytes paramG, bytes paramU) returns()
func (_XZ21 *XZ21Session) RegisterParam(paramP string, paramG []byte, paramU []byte) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterParam(&_XZ21.TransactOpts, paramP, paramG, paramU)
}

// RegisterParam is a paid mutator transaction binding the contract method 0x93933bdb.
//
// Solidity: function registerParam(string paramP, bytes paramG, bytes paramU) returns()
func (_XZ21 *XZ21TransactorSession) RegisterParam(paramP string, paramG []byte, paramU []byte) (*types.Transaction, error) {
	return _XZ21.Contract.RegisterParam(&_XZ21.TransactOpts, paramP, paramG, paramU)
}

// SetAuditingResult is a paid mutator transaction binding the contract method 0x58cf520b.
//
// Solidity: function setAuditingResult(bytes32 hash, bool result) returns()
func (_XZ21 *XZ21Transactor) SetAuditingResult(opts *bind.TransactOpts, hash [32]byte, result bool) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "setAuditingResult", hash, result)
}

// SetAuditingResult is a paid mutator transaction binding the contract method 0x58cf520b.
//
// Solidity: function setAuditingResult(bytes32 hash, bool result) returns()
func (_XZ21 *XZ21Session) SetAuditingResult(hash [32]byte, result bool) (*types.Transaction, error) {
	return _XZ21.Contract.SetAuditingResult(&_XZ21.TransactOpts, hash, result)
}

// SetAuditingResult is a paid mutator transaction binding the contract method 0x58cf520b.
//
// Solidity: function setAuditingResult(bytes32 hash, bool result) returns()
func (_XZ21 *XZ21TransactorSession) SetAuditingResult(hash [32]byte, result bool) (*types.Transaction, error) {
	return _XZ21.Contract.SetAuditingResult(&_XZ21.TransactOpts, hash, result)
}

// SetChal is a paid mutator transaction binding the contract method 0xb94dbf25.
//
// Solidity: function setChal(bytes32 hash, bytes chal) returns()
func (_XZ21 *XZ21Transactor) SetChal(opts *bind.TransactOpts, hash [32]byte, chal []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "setChal", hash, chal)
}

// SetChal is a paid mutator transaction binding the contract method 0xb94dbf25.
//
// Solidity: function setChal(bytes32 hash, bytes chal) returns()
func (_XZ21 *XZ21Session) SetChal(hash [32]byte, chal []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetChal(&_XZ21.TransactOpts, hash, chal)
}

// SetChal is a paid mutator transaction binding the contract method 0xb94dbf25.
//
// Solidity: function setChal(bytes32 hash, bytes chal) returns()
func (_XZ21 *XZ21TransactorSession) SetChal(hash [32]byte, chal []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetChal(&_XZ21.TransactOpts, hash, chal)
}

// SetProof is a paid mutator transaction binding the contract method 0xd91a2fa9.
//
// Solidity: function setProof(bytes32 hash, bytes proof) returns()
func (_XZ21 *XZ21Transactor) SetProof(opts *bind.TransactOpts, hash [32]byte, proof []byte) (*types.Transaction, error) {
	return _XZ21.contract.Transact(opts, "setProof", hash, proof)
}

// SetProof is a paid mutator transaction binding the contract method 0xd91a2fa9.
//
// Solidity: function setProof(bytes32 hash, bytes proof) returns()
func (_XZ21 *XZ21Session) SetProof(hash [32]byte, proof []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetProof(&_XZ21.TransactOpts, hash, proof)
}

// SetProof is a paid mutator transaction binding the contract method 0xd91a2fa9.
//
// Solidity: function setProof(bytes32 hash, bytes proof) returns()
func (_XZ21 *XZ21TransactorSession) SetProof(hash [32]byte, proof []byte) (*types.Transaction, error) {
	return _XZ21.Contract.SetProof(&_XZ21.TransactOpts, hash, proof)
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
// Solidity: event EventSetAuditingResult(bytes32 hash, bool result)
func (_XZ21 *XZ21Filterer) FilterEventSetAuditingResult(opts *bind.FilterOpts) (*XZ21EventSetAuditingResultIterator, error) {

	logs, sub, err := _XZ21.contract.FilterLogs(opts, "EventSetAuditingResult")
	if err != nil {
		return nil, err
	}
	return &XZ21EventSetAuditingResultIterator{contract: _XZ21.contract, event: "EventSetAuditingResult", logs: logs, sub: sub}, nil
}

// WatchEventSetAuditingResult is a free log subscription operation binding the contract event 0x961a406eff4d590fdb9e54bdba584518be2e6a7f91b34d5714330f83d571b031.
//
// Solidity: event EventSetAuditingResult(bytes32 hash, bool result)
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
// Solidity: event EventSetAuditingResult(bytes32 hash, bool result)
func (_XZ21 *XZ21Filterer) ParseEventSetAuditingResult(log types.Log) (*XZ21EventSetAuditingResult, error) {
	event := new(XZ21EventSetAuditingResult)
	if err := _XZ21.contract.UnpackLog(event, "EventSetAuditingResult", log); err != nil {
		return nil, err
	}
	event.Raw = log
	return event, nil
}
