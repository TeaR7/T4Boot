package com.t4cloud.boot.wechat.controller;

import cn.hutool.core.util.StrUtil;
import com.t4cloud.boot.core.base.annotation.AutoLog;
import com.t4cloud.boot.core.base.entity.dto.R;
import com.t4cloud.boot.user.entity.SysUserThird;
import com.t4cloud.boot.wechat.entity.WechatConfig;
import com.t4cloud.boot.wechat.service.IWeUserService;
import com.t4cloud.boot.wechat.service.IWechatConfigService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


/**
 * banner&tips表 控制器
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-07
 */
@RestController
@AllArgsConstructor
@Slf4j
@Api(value = "微信用户操作接口", tags = "微信用户", position = 0)
@RequestMapping("/WeUser")
public class WeUserController {

    @Autowired
    private IWechatConfigService wechatConfigService;
    @Autowired
    private IWeUserService weUserService;

    /**
     * 微信登录
     */
    @AutoLog(value = "微信第三方注册或登录(扫码回调)")
    @PostMapping("/oauth")
    @ApiOperation(position = 1, value = "微信第三方注册或登录", notes = "微信第三方注册或登录(扫码回调）")
    public R<SysUserThird> userOauth(
            @ApiParam(required = true, name = "code", value = "返回的code值")
            @RequestParam(value = "code") String code
    ) {
        log.info("进入授权回调,code:" + code);
        if (StrUtil.isBlank(code)) {
            return R.error("code不允许为空！");
        }
        // 获取租户的微信配置信息
        WechatConfig wechatConfig = wechatConfigService.lambdaQuery().eq(WechatConfig::getCode, 1).one();

        return R.ok("微信用户鉴权成功", weUserService.userJsOauth(code, wechatConfig));
    }

}
