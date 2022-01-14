
MODEL_NAME="modeltest"

pip install -r requirements.txt

mkdir model-store

torch-model-archiver --model-name $MODEL_NAME --version 1.0 \
    --serialized-file model.pt \
    --handler main.py \
    --export-path model-store \
    --force


torchserve  --start --model-store model-store \
            --models=$MODEL_NAME.mar > /dev/null

sleep 10

curl http://localhost:8080/predictions/modeltest
