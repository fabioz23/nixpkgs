{ lib
, buildPythonPackage
, cryptography
, ecdsa
, fetchPypi
, pytest-cov
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "PyJWT";
  version = "2.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-pccKBuHzPYHvJe7NUNUL0w403hyosrn6P+Daqrz2m/c=";
  };

  propagatedBuildInputs = [
    cryptography
    ecdsa
  ];

  checkInputs = [
    pytest-cov
    pytestCheckHook
  ];

  # ecdsa changed internal behavior
  disabledTests = [ "ec_verify_should_return_false_if_signature_invalid" ];
  pythonImportsCheck = [ "jwt" ];

  meta = with lib; {
    description = "JSON Web Token implementation in Python";
    homepage = "https://github.com/jpadilla/pyjwt";
    license = licenses.mit;
    maintainers = with maintainers; [ prikhi ];
  };
}
