package com.t4cloud.boot.system;

import com.t4cloud.boot.core.base.annotation.T4BootApplicationStarter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;

import java.net.InetAddress;
import java.net.UnknownHostException;

@Slf4j
@T4BootApplicationStarter
public class T4BootApplication {

    public static void main(String[] args) throws UnknownHostException {

        ConfigurableApplicationContext application = SpringApplication.run(T4BootApplication.class, args);
        Environment env = application.getEnvironment();
        String ip = InetAddress.getLocalHost().getHostAddress();
        String port = env.getProperty("server.port");
        String path = env.getProperty("server.servlet.context-path");
        log.info("\n----------------------------------------------------------\n\t" +
                "Application T4Boot is running! Access URLs:\n\t" +
                "Local: \t\thttp://localhost:" + port + (StringUtils.isEmpty(path) ? "" : path) + "/\n\t" +
                "External: \thttp://" + ip + ":" + port + (StringUtils.isEmpty(path) ? "" : path) + "/\n\t" +
                "swagger-ui: \thttp://" + ip + ":" + port + (StringUtils.isEmpty(path) ? "" : path) + "/swagger-ui.html\n\t" +
                "Doc: \t\thttp://" + ip + ":" + port + (StringUtils.isEmpty(path) ? "" : path) + "/doc.html\n" +
                "----------------------------------------------------------");
    }

}
