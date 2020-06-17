package com.t4cloud.boot.config;

import com.github.xiaoymin.swaggerbootstrapui.annotations.EnableSwaggerBootstrapUI;
import com.t4cloud.boot.core.base.config.Swagger2Config;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Swagger配置文件，集中剥离
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @date 2020/1/15 14:22
 */
@Configuration
@EnableSwagger2
@EnableSwaggerBootstrapUI
public class SwaggerConfig extends Swagger2Config {

    /**
     * api文档的详细信息函数,注意这里的注解引用的是哪个
     *
     * @return
     */
    @Override
    protected ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                // //大标题
                .title("T4Boot 后台服务API接口文档 Override！")
                // 版本号
                .version("0.1")
                .termsOfServiceUrl("https://t4cloud.com/")
                // 描述
                .description("T4Boot 企业级后台管理系统 后台API接口")
                // 作者
                .contact(new Contact("TeaR<zqr.it@t4cloud.com>", "https://t4cloud.com/", "zqr.it@t4cloud.com"))
                .license("商用版权")
                .licenseUrl("")
                .build();
    }

}
