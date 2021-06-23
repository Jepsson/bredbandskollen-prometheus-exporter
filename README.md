![Logo bredbandskollen-prometheus-exporter](https://github.com/aolde/bredbandskollen-prometheus-exporter/blob/main/assets/logo.png?raw=true)

# bredbandskollen-prometheus-exporter
Export Internet speed tests from Bredbandskollen to Prometheus

Built for ARM 64-bit, tested on Raspberry Pi 3
## Exported Metrics

| Metric | Description | Labels |
|-|-|-|
| bredbandskollen_test_server_count | Times test has been performed against test server | test_server |
| bredbandskollen_latency_ms | Latency in milliseconds | test_server |
| bredbandskollen_download_mbps | Download speed in megaits per second | test_server |
| bredbandskollen_upload_mbps | Upload speed in megabits per second | test_server |

## Docker

```
docker build -t bredbandskollen-prometheus-exporter:aarch64 .
```

```
docker run --rm --name bbk-exporter \
    -p 3001:80 \
    bredbandskollen-prometheus-exporter:aarch64
```

```
curl http://localhost:3001/metrics
```
