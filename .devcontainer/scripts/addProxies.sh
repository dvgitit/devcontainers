function addProxies()
{
  /tmp/yq -i '.proxies.default.httpProxy = strenv(HTTP_PROXY)' ~/.docker/config.json
  /tmp/yq -i '.proxies.default.httpsProxy = strenv(HTTP_PROXY)' ~/.docker/config.json
  /tmp/yq -i '.proxies.default.noProxy = strenv(NO_PROXY)' ~/.docker/config.json
}

grep proxies $HOME/.docker/config.json
r=$?
if [ $r -ne 0 ]
then
	#./yq_linux_amd64 '.neu = "neuvalue"' ~/.docker/config.json
  curl -L -o /tmp/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 && chmod +x /tmp/yq
	addProxies
fi
