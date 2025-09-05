# test.py
import pytest
import fonctions as f

def test_1():
		assert f.puissance(2,3) == 8
		assert f.puissance(2,2) == 4

def test_2():
		assert f.puissance(-1,2) == 1
		assert f.puissance(-1,3) == -1
		assert f.puissance(-1,-1) == -1
		assert f.puissance(-1,-2) == 1
		assert f.puissance(-2,-1) == -0.5

def test_3():
    # pour tout x > 0 : 0^x = 0
    for x in (1, 2, 3, 5, 10):
        assert f.puissance(0, x) == 0


def test_4():
    # 0^x avec x < 0 : indéfini
    for x in (-1, -2, -5):
        with pytest.raises(ZeroDivisionError):
            f.puissance(0, x)

def test_type_errors():
    with pytest.raises(TypeError):
        f.puissance(2.5, 3)
    with pytest.raises(TypeError):
        f.puissance(2, 3.0)
