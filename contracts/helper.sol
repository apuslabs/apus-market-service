// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import "./lease.sol";
import "./account.sol";
import "./device.sol";

// contract Helper is Lease, Device, Provider, Recipient {
contract Helper is Lease, AccountFactory {

    function onlineServer(string memory _machineId, string memory _serverInfo, Price memory _price, uint _startTime, uint _endTime) public {
        
        uint _stakeAmount = providerStakeCalcute(_startTime, _endTime, _price);
        onlineBlockedFund(_stakeAmount);
        uint _deviceId = online(_machineId, _serverInfo, _price);
        onlineLease(_deviceId, _startTime, _endTime);
    }

    function listDevices(uint _limit, uint _offset) public view returns (deviceInfo [] memory _allDevices){
        deviceInfo [] memory ds = new deviceInfo[](_limit);
        uint counter = 0;
        for (uint i = _offset * _limit; i < devices.length; i++ ) {
            if (devices[i].status == DeviceStatus.Online || devices[i].status == DeviceStatus.Running ) {
                counter ++;
                if (counter > _limit * _offset) {
                    ds[counter - _limit * _offset] = devices[i];
                }

                if  (counter >= _limit * _offset) {
                    return ds;
                }
            }
        }
        return ds;
    }

    function listOwnDevices(address _provider, uint _limit, uint _offset) public view returns (deviceInfo [] memory _ownDevices){
        deviceInfo [] memory ds = new deviceInfo [](_limit);
        uint counter = 0;
        for (uint i = 0; i < devices.length; i++ ) {
            if (devices[i].owner == _provider) {
                if (counter > _limit * _offset) {
                    ds[counter] = devices[i];
                }
                counter ++;
                if  (counter >= _limit * _offset) {
                    return ds;
                }
            }
        }
        return ds;
    }

    // function listLease(address _user, uint _limit, uint _offset) public view returns (leaseInfo [] memory leaseInfos) {
    //     leaseInfo [] memory _ls = new leaseInfo [] (_limit);
    //     uint counter = 0;
    //     for (uint i = 0; i < leases.length; i++ ) {
    //         if (leases[i].provider == _user ) {
    //             counter ++;
    //             if (counter > _limit * _offset) {
    //                 _ls[counter] = leases[i];
    //             }

    //             if  (counter >= _limit * _offset) {
    //                 return _ls;
    //             }
    //         }
    //     }
    //     return _ls;
    // }
}