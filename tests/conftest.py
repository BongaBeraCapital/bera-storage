import pytest

from brownie import BeraStorageFactory, accounts

@pytest.fixture()
def bera_storage_factory():
    return BeraStorageFactory.deploy([], {"from": accounts[0]})

@pytest.fixture()
def dao_deployer():
    return accounts[0]




