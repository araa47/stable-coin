pragma solidity 0.4.19;


import "dappsys.sol";


// auth, token, math
import "solovault.sol";
import "GateRoles.sol";
import "FiatToken.sol";
import "Gate.sol";
import "TransferFeeController.sol";
import "LimitController.sol";


contract GateWithFee is Gate {
    address public feeCollector;

    TransferFeeController transferFeeController;

    function GateWithFee(DSAuthority _authority, DSToken fiatToken, LimitController _limitController, address feeCollector_, TransferFeeController transferFeeController_)
    public
    Gate(_authority, fiatToken, _limitController)
    {
        feeCollector = feeCollector_;
        transferFeeController = transferFeeController_;
    }

    function setFeeCollector(address feeCollector_)
    public
    auth
    {
        feeCollector = feeCollector_;
    }

    function setTransferFeeCollector(address feeCollector_)
    public
    auth
    {
        (FiatToken(token)).setTransferFeeCollector(feeCollector_);
    }

    function setTransferFeeController(TransferFeeControllerInterface transferFeeController_)
    public
    auth
    {
        (FiatToken(token)).setTransferFeeController(transferFeeController_);
    }

    function mintWithFee(address guy, uint wad, uint fee) public {
        super.mint(guy, wad);
        super.mint(feeCollector, fee);
    }

    function burnWithFee(address guy, uint wad, uint fee) public {
        super.burn(guy, sub(wad, fee));
        token.transferFrom(guy, feeCollector, fee);
    }

    event InterestPaymentRequest(address by, uint amount);

    event InterestPaymentSuccess(address by, uint amount);

    function requestInterestPayment(address by, uint amount) public auth {
        InterestPaymentRequest(by, amount);
    }

    function processInterestPayment(address by, uint amount) public auth {
        (FiatToken(token)).transferFrom(by, feeCollector, amount);
        InterestPaymentSuccess(by, amount);
    }
}
