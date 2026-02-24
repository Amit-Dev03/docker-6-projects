#Multi-stage build for a Flask application with dependency management

#Stage:01- Builder stage
FROM python:3.9-slim AS builder

WORKDIR /app

#copy requirements first
COPY requirements.txt .

#install dependencies

#RUN pip install --user --no-cache-dir -r requirements.txt ;- here --user flag is not required bcz containers typically run as a dedicated user anyway.
#hence remove --user flag and remove env PATH=/home/appuser/.local/bin/:$PATH from final stage
RUN pip install --no-cache-dir -r requirements.txt
#---------------------------------------------------------------------------------#
#Stage:02- Final stage
FROM python:3.9-slim

#creating non-root user for security
RUN useradd -m -u 1000 appuser && \
    mkdir -p /app && \
    chown -R appuser:appuser /app

#set working directory
WORKDIR /app

#Copy python dependencies from builder stage
COPY --from=builder --chown=appuser:appuser /root/.local /home/appuser/.local

#Copy application code
COPY --chown=appuser:appuser . .

#set environment variables for Flask
# ENV PATH=/home/appuser/.local/bin:$PATH \     <-----------not required
#     PYTHONUNBUFFERED=1 \
#     PTHONDONTWRITEBYTECODE=1

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

#switch to non-root user
USER appuser

EXPOSE 5000

#Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1  

#using gunicorn as production server
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]



