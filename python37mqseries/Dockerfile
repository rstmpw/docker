FROM python:3.7.7-slim-buster

# Install IBM MQ client
RUN export DEBIAN_FRONTEND=noninteractive \
    # Deps
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
       curl tar sed \
    # Download and extract packages
    && mkdir -p /tmp/mq \
    && cd /tmp/mq \
    && curl -LO http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev915_ubuntu_x86-64.tar.gz \
    && tar -zxvf ./*.tar.gz \
    && cd /tmp/mq/MQServer \
    # Accept the license and proceed to installation
    && sed -i 's/^UNAME_FLAG=-i/UNAME_FLAG=-m/' ./mqlicense.sh && ./mqlicense.sh -text_only -accept \
    && apt install ./ibmmq-client* ./ibmmq-runtime* ./ibmmq-sdk* ./ibmmq-gskit* \
    # Default MQ installation
    && /opt/mqm/bin/setmqinst -p /opt/mqm -i \
    # Cleanup
    && rm -rf /tmp/mq \
    && rm -rf /var/lib/apt/lists/*