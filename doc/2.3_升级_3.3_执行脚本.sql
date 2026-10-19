USE xxl_job;

-- 1) 新增 token 列
ALTER TABLE `xxl_job_user`
    ADD COLUMN `token` varchar(100) DEFAULT NULL COMMENT '登录token' AFTER `password`;

-- 2) 加宽 password（SHA-256 是 64 位，varchar(50) 装不下）
ALTER TABLE `xxl_job_user`
    MODIFY COLUMN `password` varchar(100) NOT NULL COMMENT '密码加密信息';

-- 3) 重置 admin 密码为 123456（3.x 用 SHA-256 存储）
UPDATE `xxl_job_user`
SET `password` = '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92'
WHERE `username` = 'admin';