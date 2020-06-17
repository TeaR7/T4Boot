package com.t4cloud.boot.wechat.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.t4cloud.boot.core.base.annotation.AutoLog;
import com.t4cloud.boot.core.base.controller.T4Controller;
import com.t4cloud.boot.core.base.entity.dto.R;
import com.t4cloud.boot.core.base.query.T4Query;
import com.t4cloud.boot.core.base.utils.EasyPoiUtil;
import com.t4cloud.boot.wechat.entity.WechatConfig;
import com.t4cloud.boot.wechat.service.IWechatConfigService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Arrays;
import java.util.List;

/**
 * 微信秘钥配置 控制器
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-26
 */
@RestController
@AllArgsConstructor
@Slf4j
@Api(value = "微信秘钥配置", tags = "微信秘钥配置接口", position = 10)
@RequestMapping("/WechatConfig")
public class WechatConfigController extends T4Controller<WechatConfig, IWechatConfigService> {

    /**
     * 详情
     */
    @AutoLog(value = "微信秘钥配置-详情")
    @GetMapping("/detail")
    @RequiresPermissions("wechat:WechatConfig:VIEW")
    @ApiOperation(position = 1, value = "微信秘钥配置-详情", notes = "传入wechatConfig")
    public R<WechatConfig> detail(WechatConfig wechatConfig, HttpServletRequest req) {
        QueryWrapper<WechatConfig> wechatConfigQueryWrapper = T4Query.initQuery(wechatConfig, req.getParameterMap());
        WechatConfig detail = service.getOne(wechatConfigQueryWrapper);
        return R.ok("微信秘钥配置-详情查询成功", detail);
    }

    /**
     * 全部列表 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-全部列表")
    @GetMapping("/list")
    @RequiresPermissions("wechat:WechatConfig:VIEW")
    @ApiOperation(position = 2, value = "微信秘钥配置-全部列表", notes = "传入wechatConfig")
    public R<List<WechatConfig>> list(WechatConfig wechatConfig, HttpServletRequest req) {
        QueryWrapper<WechatConfig> wechatConfigQueryWrapper = T4Query.initQuery(wechatConfig, req.getParameterMap());
        List<WechatConfig> list = service.list(wechatConfigQueryWrapper);
        return R.ok("微信秘钥配置-全部列表查询成功", list);
    }

    /**
     * 分页查询 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-分页查询")
    @GetMapping("/page")
    @RequiresPermissions("wechat:WechatConfig:VIEW")
    @ApiOperation(position = 3, value = "微信秘钥配置-分页查询", notes = "传入wechatConfig")
    public R<IPage<WechatConfig>> page(WechatConfig wechatConfig,
                                       @ApiParam(name = "pageNo")
                                       @RequestParam(name = "pageNo", required = false, defaultValue = "1") Integer pageNo,
                                       @ApiParam(name = "pageSize")
                                       @RequestParam(name = "pageSize", required = false, defaultValue = "10") Integer pageSize,
                                       HttpServletRequest req) {
        QueryWrapper<WechatConfig> wechatConfigQueryWrapper = T4Query.initQuery(wechatConfig, req.getParameterMap());
        IPage<WechatConfig> pages = service.page(new Page<>(pageNo, pageSize), wechatConfigQueryWrapper);
        return R.ok("微信秘钥配置-分页查询查询成功", pages);
    }

    /**
     * 新增 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-新增", operateType = 1)
    @PutMapping("/save")
    @RequiresPermissions("wechat:WechatConfig:ADD")
    @ApiOperation(position = 4, value = "微信秘钥配置-新增", notes = "传入wechatConfig")
    public R save(@Valid @RequestBody WechatConfig wechatConfig, BindingResult bindingResult) {
        return R.ok("微信秘钥配置-新增成功", service.save(wechatConfig));
    }

    /**
     * 修改 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-修改", operateType = 3)
    @PostMapping("/update")
    @RequiresPermissions(value = {"wechat:WechatConfig:ADD", "wechat:WechatConfig:EDIT"}, logical = Logical.OR)
    @ApiOperation(position = 5, value = "微信秘钥配置-修改", notes = "传入wechatConfig")
    public R update(@RequestBody WechatConfig wechatConfig) {
        return R.ok("微信秘钥配置-修改成功", service.updateById(wechatConfig));
    }


    /**
     * 删除 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-删除", operateType = 2)
    @DeleteMapping("/delete")
    @RequiresPermissions("wechat:WechatConfig:DELETE")
    @ApiOperation(position = 8, value = "微信秘钥配置-删除", notes = "传入ids")
    public R delete(@ApiParam(value = "主键集合", required = true) @RequestParam(name = "ids") String ids) {
        return R.ok("微信秘钥配置-删除成功", service.removeByIds(Arrays.asList(ids.split(","))));

    }


    /**
     * 导出 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-导出")
    @GetMapping("/export")
    @RequiresPermissions("wechat:WechatConfig:EXPORT")
    @ApiOperation(position = 9, value = "微信秘钥配置-导出", notes = "传入查询条件，选中的ID（多个用,分割），以及自定义的列（多个用,分割）")
    public void export(WechatConfig wechatConfig,
                       @ApiParam("选中导出的数据") @RequestParam(name = "selectedRowKeys", required = false) String selectedRowKeys,
                       @ApiParam("自定义导出列") @RequestParam(name = "selectedColKeys", required = false) String selectedColKeys,
                       HttpServletRequest req) {
        QueryWrapper<WechatConfig> queryWrapper = StrUtil.isEmpty(selectedRowKeys) ? T4Query.initQuery(wechatConfig, req.getParameterMap()) : new QueryWrapper<WechatConfig>().in("id", selectedRowKeys.split(","));
        super.exportExl("微信秘钥配置", selectedColKeys, queryWrapper);
    }

    /**
     * 导入 微信秘钥配置
     */
    @AutoLog(value = "微信秘钥配置-导入", operateType = 1)
    @PutMapping("/import")
    @RequiresPermissions("wechat:WechatConfig:IMPORT")
    @ApiOperation(position = 10, value = "微信秘钥配置-导入", notes = "传入填好的模板文件即可")
    public R importXls(@ApiParam("EXCEL文件") MultipartFile file) {
        return R.ok("微信秘钥配置-导入成功", service.saveBatch(EasyPoiUtil.importExcel(file, WechatConfig.class)));
    }

    @AutoLog(value = "微信秘钥配置-确认重复信息")
    @GetMapping("/check")
    @RequiresPermissions("wechat:WechatConfig:ADD")
    @ApiOperation(position = 11, value = "微信秘钥配置-确认重复信息", notes = "传入查询属性名和属性值")
    public R check(
            @ApiParam("属性名") @RequestParam("key") String key,
            @ApiParam("属性值") @RequestParam("value") String value) {
        Boolean checkProp = checkProp(key, value);
        return R.ok(key + "：" + value + (checkProp ? "可用，无重名项" : "不可用，存在冲突"), checkProp);
    }

}
