# Deploy the application binary into a lean image
FROM gcr.io/distroless/base-debian11

WORKDIR /

COPY target/test-runner /test-runner

USER nonroot:nonroot

ENTRYPOINT ["/test-runner"]
