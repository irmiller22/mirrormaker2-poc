# MirrorMaker 2 POC

## Background

This is a POC for MirrorMaker 2. This will test out replication via MirrorMaker 2, and
will also determine the steps necessary for successful replication.

The following are required as part of this POC:

- 2 Zookeeper clients
- 2 Kafka brokers
- 1 Confluent Connect instance

## POC Test Requirements

- [ ] Set up Confluent Connect successfully
- [ ] Replicate messages across brokers successfully
- [ ] Replicate multiple topics
- [ ] Replicate multiple topics using Schema Registry
- [ ] Confirm consumer picks up where it left off post-migration
