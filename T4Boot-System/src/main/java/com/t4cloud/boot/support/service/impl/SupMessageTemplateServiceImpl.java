package com.t4cloud.boot.support.service.impl;

import com.t4cloud.boot.core.base.service.impl.T4ServiceImpl;
import com.t4cloud.boot.support.entity.SupMessageTemplate;
import com.t4cloud.boot.support.mapper.SupMessageTemplateMapper;
import com.t4cloud.boot.support.service.ISupMessageTemplateService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 消息模板 服务实现类
 *
 * <p>
 * --------------------
 *
 * @author TeaR
 * @since 2020-03-16
 */
@Slf4j
@Service
@AllArgsConstructor
public class SupMessageTemplateServiceImpl extends T4ServiceImpl<SupMessageTemplateMapper, SupMessageTemplate> implements ISupMessageTemplateService {


}
