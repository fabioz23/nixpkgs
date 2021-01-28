{ lib
, stdenv
, buildPythonPackage
, fetchFromGitHub
, isPy27
, aiofiles
, graphene
, itsdangerous
, jinja2
, python-multipart
, pyyaml
, requests
, ujson
, aiosqlite
, databases
, pytestCheckHook
, pytest-asyncio
, pytest-cov
, typing-extensions
, ApplicationServices
}:

buildPythonPackage rec {
  pname = "starlette";
  version = "0.14.1";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "encode";
    repo = pname;
    rev = version;
    sha256 = "sha256-EpT3BZ4XRHLMTMYHqtJpcj8LHeZrz2+MSa2wTj2gH2g=";
  };

  propagatedBuildInputs = [
    aiofiles
    graphene
    itsdangerous
    jinja2
    python-multipart
    pyyaml
    requests
    ujson
  ] ++ lib.optional stdenv.isDarwin [ ApplicationServices ];

  checkInputs = [
    aiosqlite
    databases
    pytest-asyncio
    pytest-cov
    pytestCheckHook
    typing-extensions
  ];

  pytestFlagsArray = [ "--ignore=tests/test_graphql.py" ];
  # https://github.com/encode/starlette/issues/1131
  disabledTests = [ "test_debug_html" ];

  pythonImportsCheck = [ "starlette" ];

  meta = with lib; {
    homepage = "https://www.starlette.io/";
    description = "The little ASGI framework that shines";
    license = licenses.bsd3;
    maintainers = with maintainers; [ wd15 ];
  };
}
