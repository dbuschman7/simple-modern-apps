# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY target/config-service /config-service

EXPOSE 5000

USER nonroot:nonroot

ENTRYPOINT ["/config-service"]

CMD [ "--port 5000" ]