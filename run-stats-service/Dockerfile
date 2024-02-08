# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY target/run-stats-service /run-stats-service

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/run-stats-service"]

CMD [ "--port 8080" ]