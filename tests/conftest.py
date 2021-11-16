import pytest

from brownie import BeraStorageFactory, accounts

@pytest.fixture()
def bera_storage_factory():
    return BeraStorageFactory.deploy(0, [])




