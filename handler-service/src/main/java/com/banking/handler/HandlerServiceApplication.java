package com.banking.handler;

import java.time.Instant;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@SpringBootApplication
@EnableScheduling
public class HandlerServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(HandlerServiceApplication.class, args);
    }
}

@Component
class HeartbeatScheduler {

    private static final Logger log = LoggerFactory.getLogger(HeartbeatScheduler.class);

    @Scheduled(fixedRate = 30_000)
    void heartbeat() {
        log.info("Heartbeat at {}", Instant.now());
    }
}
