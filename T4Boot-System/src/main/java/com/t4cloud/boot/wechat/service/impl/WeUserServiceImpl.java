package com.t4cloud.boot.wechat.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.t4cloud.boot.core.base.entity.dto.R;
import com.t4cloud.boot.core.base.exception.T4CloudException;
import com.t4cloud.boot.core.base.service.impl.T4ServiceImpl;
import com.t4cloud.boot.user.entity.SysUserThird;
import com.t4cloud.boot.wechat.entity.WechatConfig;
import com.t4cloud.boot.wechat.mapper.WechatConfigMapper;
import com.t4cloud.boot.wechat.service.IWeUserService;
import com.t4cloud.boot.wechat.util.WxUtils;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 微信用户登录 服务实现类
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
public class WeUserServiceImpl extends T4ServiceImpl<WechatConfigMapper, WechatConfig> implements IWeUserService {

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
    @Override
    public SysUserThird userJsOauth(String code, WechatConfig wechatConfig) {

        //1.通过code换取openid以及access_token
        String response = WxUtils.getAccessToken(code, wechatConfig);
        JSONObject jsonObject = JSONUtil.parseObj(response);
        log.info("用户从微信端获取的信息:" + response);
        if (null != jsonObject.get("errcode")) {
            throw new T4CloudException("微信扫描通过code换取openid以及access_token失败");
        }
        String openid = jsonObject.getStr("openid");
        String accessToken = jsonObject.getStr("access_token");
        String expires = jsonObject.getStr("expires_in");

        //2.通过access_token和openid获取用户信息
        String userInfomation = WxUtils.getUserInformation(accessToken, openid);
        log.info("从微信端获取通过access_token和openid获取用户信息:", userInfomation);
        JSONObject userInfo = JSONUtil.parseObj(userInfomation);
        if (null != userInfo.get("errcode")) {
            throw new T4CloudException("微信扫描通过access_token和openid获取用户信息失败");
        }
        log.info("用户的信息userInfoObject:{}", userInfo);
        //唯一标识unionId
        String unionId = userInfo.getStr("unionid");
        if (StrUtil.isBlank(unionId)) {
            unionId = openid;
        }
        //头像
        String headimgurl = userInfo.getStr("headimgurl");
        if (headimgurl.startsWith("http:")) {
            headimgurl = headimgurl.replace("http:", "https:");
        }
        //昵称
        String nickname = userInfo.getStr("nickname");
        //表情替換
//        nickname = EmojiParser.removeAllEmojis(nickname);

        //性别
        String sex = userInfo.getStr("sex");
        //登录方式
        String loginType = "WX";

        //组装用户第三方信息对象
        SysUserThird userThird = new SysUserThird();

        userThird.setOutId(unionId);
        userThird.setAccessToken(accessToken);
        userThird.setExpress(new Date(System.currentTimeMillis() + Long.parseLong(expires)));

        userThird.setImg(headimgurl);
        userThird.setNickName(nickname);
        userThird.setGender(sex);
        userThird.setLoginType(loginType);

        return userThird;
    }
}
