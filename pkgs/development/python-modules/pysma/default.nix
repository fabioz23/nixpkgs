{ lib
, aiohttp
, aioresponses
, attrs
, buildPythonPackage
, fetchPypi
, jmespath
, async-timeout
, pytest-aiohttp
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pysma";
  version = "0.5.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "19ffniz82qgc3xbkycsz0yqcpxv8sm2cd70zqhp7xd2xlrdrw3nb";
  };

  propagatedBuildInputs = [
    aiohttp
    async-timeout
    attrs
    jmespath
  ];

  checkInputs = [
    aioresponses
    pytest-aiohttp
    pytestCheckHook
  ];

  pythonImportsCheck = [ "pysma" ];

  meta = with lib; {
    description = "Python library for interacting with SMA Solar's WebConnect";
    homepage = "https://github.com/kellerza/pysma";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
