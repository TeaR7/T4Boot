package com.t4cloud.boot.system.service.impl;

import com.t4cloud.boot.core.base.service.impl.T4ServiceImpl;
import com.t4cloud.boot.system.entity.SysDict;
import com.t4cloud.boot.system.mapper.SysDictMapper;
import com.t4cloud.boot.system.service.ISysDictService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 字典 服务实现类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-03-04
 */
@Slf4j
@Service
@AllArgsConstructor
public class SysDictServiceImpl extends T4ServiceImpl<SysDictMapper, SysDict> implements ISysDictService {


}
