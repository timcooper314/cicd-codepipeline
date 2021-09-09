import pytest
from stack1.src.hello_world import lambda_handler


def test_should_hello_world():
    lambda_handler('event', 'context')
    assert True
