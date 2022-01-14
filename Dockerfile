FROM pytorch/torchserve:latest-cpu


# USER model-server

# copy model artifacts, handler
COPY model.pt /home/model-server/model.pt
COPY main.py /home/model-server/main.py

# expose health and prediction listener ports from the image
EXPOSE 8080
EXPOSE 8081

ENV MODEL_NAME="recberto"


WORKDIR /home/model-server/

RUN torch-model-archiver --model-name $MODEL_NAME --version 1.0 \
    --serialized-file /home/model-server/model.pt \
    --handler /home/model-server/main.py \
    --export-path model-store \
    --force

CMD ["torchserve", \
    "--start", \
    "--models=$MODEL_NAME.mar", \
    "--model-store", "/home/model-server/model-store"] \