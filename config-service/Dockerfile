# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY target/config-service /config-service

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/config-service"]

CMD [ "--port 8080" ]