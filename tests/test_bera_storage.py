import pytest
from brownie import network, BeraStorage, accounts, exceptions


class TestBeraStorage():

    @pytest.fixture()
    def contract(self):
        if network.show_active() not in ["development", "dev"] or "fork" in network.show_active():
            pytest.skip("Only for local testing")
        output = BeraStorage.deploy()
        return output

    def test_add(contract):
        assert 1 == 1