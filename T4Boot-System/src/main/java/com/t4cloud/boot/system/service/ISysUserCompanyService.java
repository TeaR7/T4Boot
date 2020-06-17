package com.t4cloud.boot.system.service;


import com.t4cloud.boot.core.base.service.T4Service;
import com.t4cloud.boot.system.entity.SysCompany;
import com.t4cloud.boot.system.entity.SysUserCompany;

import java.util.List;

/**
 * 用户公司表 服务类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-15
 */
public interface ISysUserCompanyService extends T4Service<SysUserCompany> {

    /**
     * 获取某用户的所有公司
     *
     * @param username 用户名
     *                 <p>
     * @return java.util.List<com.t4cloud.t.system.entity.SysCompany>
     * --------------------
     * @author TeaR
     * @date 2020/4/15 14:11
     */
    List<SysCompany> getUserCompanyList(String username);
}
