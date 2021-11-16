import pytest
from brownie import network, accounts, exceptions, convert



class TestBeraStorageFactory():

    def test_deploy_storage_contract(self, dao_deployer, bera_storage_factory):
        deployment_addr = bera_storage_factory.deployStorageContract(b'MyStorage').return_value
        assert bera_storage_factory.getStorageContractByName(b'MyStorage') == deployment_addr
        