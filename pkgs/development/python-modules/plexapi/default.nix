{ lib
, buildPythonPackage
, fetchFromGitHub
, requests
, tqdm
, websocket_client
, isPy27
}:

buildPythonPackage rec {
  pname = "PlexAPI";
  version = "4.6.0";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "pkkid";
    repo = "python-plexapi";
    rev = version;
    sha256 = "sha256-qTetHtQ7nQ72N8nXl7hYfwwwkfmE0w7m/IBZgK4kMPw=";
  };

  propagatedBuildInputs = [
    requests
    tqdm
    websocket_client
  ];

  # Tests require a running Plex instance
  doCheck = false;
  pythonImportsCheck = [ "plexapi" ];

  meta = with lib; {
    description = "Python bindings for the Plex API";
    homepage = "https://github.com/pkkid/python-plexapi";
    license = licenses.bsd3;
    maintainers = with maintainers; [ colemickens ];
  };
}
