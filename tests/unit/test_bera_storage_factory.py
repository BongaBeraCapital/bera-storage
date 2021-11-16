import pytest
from brownie import network, accounts, exceptions

from tests.conftest import bera_storage_factory




class TestBeraStorageFactory(bera_storage_factory):
    
    def test_deploy(contract):
        deployment_addr = bera_storage_factory.deploy("MyStorage")
        assert bera_storage_factory.getContractByName()
        