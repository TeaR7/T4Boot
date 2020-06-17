package com.t4cloud.boot.user.service.impl;

import com.t4cloud.boot.core.base.service.impl.T4ServiceImpl;
import com.t4cloud.boot.user.entity.SysUserThird;
import com.t4cloud.boot.user.mapper.SysUserThirdMapper;
import com.t4cloud.boot.user.service.ISysUserThirdService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 用户第三方登录数据 服务实现类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-04-07
 */
@Slf4j
@Service
@AllArgsConstructor
public class SysUserThirdServiceImpl extends T4ServiceImpl<SysUserThirdMapper, SysUserThird> implements ISysUserThirdService {


}
