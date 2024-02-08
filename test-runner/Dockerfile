# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY target/test-runner /application

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/application"]

CMD [ "--port 8080" ]