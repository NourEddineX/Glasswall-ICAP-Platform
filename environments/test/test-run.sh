export thepath=`pwd`
docker run -ti --entrypoint /bin/bash -v $thepath:/opt glasswallsolutions/c-icap-client:manual-v1
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-dev-nor.dev.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-dev-nor.pdf -v
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-dev-ukw.dev.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-dev-ukw.pdf -v

#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-prod-ukw.prod.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-prod-ukw.pdf -v
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-prod-uks.prod.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-prod-uks.pdf -v
#/usr/local/c-icap/bin/c-icap-client -tls -tls-method TLSv1_2 -tls-no-verify -i gw-icap-prod-nor.prod.icap-proxy.curlywurly.me -p 443 -s gw_rebuild -f /opt/sample.pdf -o /opt/sample-rebuild-prod-nor.pdf -v
