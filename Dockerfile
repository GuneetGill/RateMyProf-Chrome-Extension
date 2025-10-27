FROM public.ecr.aws/lambda/python:3.10

# Copy requirements.txt
COPY requirements.txt ${LAMBDA_TASK_ROOT}

# Install the specified packages
RUN pip install -r requirements.txt

# Copy the database folder code (which is used by the API)
COPY ./database ${LAMBDA_TASK_ROOT}/database

# Copy the API code (this contains the main logic)
COPY ./api ${LAMBDA_TASK_ROOT}/api

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
# Since we copied 
CMD ["api.main.handler"]