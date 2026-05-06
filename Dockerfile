# Official Lambda Python base image — CMD must be: ["module.function"] (exec form).
FROM public.ecr.aws/lambda/python:3.11

COPY requirements.txt ${LAMBDA_TASK_ROOT}
RUN pip install -r requirements.txt

COPY ./database ${LAMBDA_TASK_ROOT}/database
COPY ./api ${LAMBDA_TASK_ROOT}/api

CMD ["api.main.handler"]

