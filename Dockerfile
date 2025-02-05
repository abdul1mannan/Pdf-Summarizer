FROM python:3.11

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

# EXPOSE 8502
EXPOSE 8080
ENV PORT 8080

# HEALTHCHECK CMD curl --fail http://localhost:8502/_stcore/health 
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s CMD curl --fail http://localhost:$PORT/_stcore/health || exit 1

# ENTRYPOINT [ "streamlit","run","streamlit_app.py", "--server.port=8502", "--server.address=0.0.0.0"]
ENTRYPOINT ["sh", "-c", "streamlit run streamlit_app.py --server.port=$PORT --server.address=0.0.0.0"]
