FROM ghcr.io/u8f69/open-webui:main

COPY sync_data.sh sync_data.sh

RUN chmod -R 777 ./data && \
    chmod -R 777 ./open_webui && \
    sed -i "1r sync_data.sh" ./start.sh
