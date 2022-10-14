FROM jupyter/pyspark-notebook
USER root

RUN echo "spark.jars.packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.0.2,org.mongodb.spark:mongo-spark-connector:10.0.2" >> "${SPARK_HOME}/conf/spark-defaults.conf"

RUN sudo apt update && sudo apt install -y kafkacat

RUN mkdir -p /usr/local/share/ca-certificates/Yandex && wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" -O /usr/local/share/ca-certificates/Yandex/YandexCA.crt

RUN keytool -import -trustcacerts -noprompt -storepass changeit -file /usr/local/share/ca-certificates/Yandex/YandexCA.crt -alias CA_ALIAS -keystore $(dirname $(dirname $(readlink -f $(which java))))/lib/security/cacerts

#USER ${NB_UID}