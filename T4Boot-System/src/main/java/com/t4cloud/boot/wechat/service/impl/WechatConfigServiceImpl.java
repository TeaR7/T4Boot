package com.t4cloud.boot.wechat.service.impl;

import com.t4cloud.boot.core.base.service.impl.T4ServiceImpl;
import com.t4cloud.boot.wechat.entity.WechatConfig;
import com.t4cloud.boot.wechat.mapper.WechatConfigMapper;
import com.t4cloud.boot.wechat.service.IWechatConfigService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 微信秘钥配置 服务实现类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-26
 */
@Slf4j
@Service
@AllArgsConstructor
public class WechatConfigServiceImpl extends T4ServiceImpl<WechatConfigMapper, WechatConfig> implements IWechatConfigService {


}
