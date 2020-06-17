package com.t4cloud.boot.wechat.service;


import com.t4cloud.boot.core.base.service.T4Service;
import com.t4cloud.boot.user.entity.SysUserThird;
import com.t4cloud.boot.wechat.entity.WechatConfig;

/**
 * 微信用户登录 服务类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-26
 */
public interface IWeUserService extends T4Service<WechatConfig> {

    /**
     * 微信公众号登录
     *
     * @param code         微信提供的code
     * @param wechatConfig 微信配置
     *                     <p>
     * @return com.t4cloud.boot.user.entity.SysUserThird
     * --------------------
     * @author TeaR
     * @date 2020/6/8 16:41
     */
    SysUserThird userJsOauth(String code, WechatConfig wechatConfig);

}
