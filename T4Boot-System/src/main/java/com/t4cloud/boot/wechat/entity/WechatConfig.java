package com.t4cloud.boot.wechat.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;
import com.baomidou.mybatisplus.annotation.TableName;
import com.t4cloud.boot.core.base.annotation.Dict;
import com.t4cloud.boot.core.base.entity.BaseEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotNull;

/**
 * 微信秘钥配置 实体类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-26
 */
@Data
@TableName("wechat_config")
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@ApiModel(value = "WechatConfig对象", description = "微信秘钥配置")
public class WechatConfig extends BaseEntity {

    private static final long serialVersionUID = 1L;


    /**
     * 编号（可以用来区分同一应用下的公众号、小程序、H5等）
     */
    @Excel(name = "编号（可以用来区分同一应用下的公众号、小程序、H5等）", width = 67.5, orderNum = "0", dict = "we_code_type")
    @ApiModelProperty(value = "编号（可以用来区分同一应用下的公众号、小程序、H5等）")
    @NotNull(message = "编号（可以用来区分同一应用下的公众号、小程序、H5等）不允许为空")
    @Dict(code = "we_code_type")
    private Integer code;


    /**
     * 应用名称
     */
    @Excel(name = "应用名称", width = 20.0, orderNum = "1")
    @ApiModelProperty(value = "应用名称")
    private String name;

    /**
     * WX APPID
     */
    @Excel(name = "WX APPID", width = 20.0, orderNum = "1")
    @ApiModelProperty(value = "WX APPID")
    @NotNull(message = "WX APPID不允许为空")
    private String appId;

    /**
     * 对应的secret
     */
    @Excel(name = "对应的secret", width = 22.5, orderNum = "2")
    @ApiModelProperty(value = "对应的secret")
    private String secret;

    /**
     * 状态(1-正常,0-删除)
     */
    @Excel(name = "状态", width = 32.5, orderNum = "2", dict = "common_status")
    @ApiModelProperty(value = "状态")
    @Dict(code = "common_status")
    private Integer status;


}
