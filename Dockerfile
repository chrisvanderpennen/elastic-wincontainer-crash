FROM microsoft/nanoserver
ARG ELASTICSEARCH_VERSION=6.2.1
VOLUME c:\\data

SHELL ["powershell", "-command"]
RUN Set-Service dnscache -StartupType Disabled
# https://github.com/moby/moby/issues/27537
RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\C:\data" -Type String;  

ADD assets/server-jre-8u162-windows-x64.tar.gz /
ADD assets/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz /
ADD assets/config /elasticsearch-${ELASTICSEARCH_VERSION}/config

ENV JAVA_HOME C:\\jdk1.8.0_162
ENV ES_HOME C:\\elasticsearch-${ELASTICSEARCH_VERSION}
ENV CLUSTER_NAME elastic

WORKDIR C:\\elasticsearch-${ELASTICSEARCH_VERSION}
ENTRYPOINT ["bin\\elasticsearch.bat"]
EXPOSE 9200 9300
