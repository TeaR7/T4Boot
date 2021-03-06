package com.t4cloud.boot.system.service.impl;

import com.t4cloud.boot.core.base.service.impl.T4ServiceImpl;
import com.t4cloud.boot.system.entity.SysCompany;
import com.t4cloud.boot.system.mapper.SysCompanyMapper;
import com.t4cloud.boot.system.service.ISysCompanyService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 公司表 服务实现类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-15
 */
@Slf4j
@Service
@AllArgsConstructor
public class SysCompanyServiceImpl extends T4ServiceImpl<SysCompanyMapper, SysCompany> implements ISysCompanyService {


}
