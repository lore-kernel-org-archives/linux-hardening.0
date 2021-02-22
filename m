Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA684C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 13:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7324964E61
	for <linux-hardening@archiver.kernel.org>; Mon, 22 Feb 2021 13:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBVNvT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 Feb 2021 08:51:19 -0500
Received: from m12-18.163.com ([220.181.12.18]:46193 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231641AbhBVNuS (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 Feb 2021 08:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TIPps
        w+BKq5HNDlpTAjQIuNk60ODO35dI88xCeKgYLo=; b=EST01pgJPo8cYOkh8fOv8
        Z/ClIfLl2OJBKSFsaHQVDhcX+p5zuU+t5M0Jvin14k4lBihvmgOZ4ZS/BQrAsw6L
        voUYaaqqC1gcNBwBWGbw7bZs8k6nvDqWcGs2LAFAScqqdL46bQ3rCDN8Mao3GY08
        d8JkjvCEwVvV8fQa60y/Vk=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAAnKfdmsjNg32x7VQ--.9375S2;
        Mon, 22 Feb 2021 21:32:25 +0800 (CST)
From:   zuoqilin1@163.com
To:     keescook@chromium.org
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] scripts/gcc-plugins: remove unneeded variable: "ret"
Date:   Mon, 22 Feb 2021 21:32:18 +0800
Message-Id: <20210222133218.1601-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAnKfdmsjNg32x7VQ--.9375S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1rGFyxtF17CFy3ur4fAFb_yoW3ZFgEyw
        n2gr1DWFWDZw4FvrWxW398AFyqgrsxtFW8ZFyrtF9rZrWDGws8uFWDWrn7GrWayw4fCF9x
        u3s2kr1UtF1UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0enQUUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiTglBiVUDH0hkLQAAsH
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

remove unneeded variable: "ret"

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 scripts/gcc-plugins/structleak_plugin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index 29b480c..d7190e4 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -170,7 +170,6 @@ static void initialize(tree var)
 static unsigned int structleak_execute(void)
 {
 	basic_block bb;
-	unsigned int ret = 0;
 	tree var;
 	unsigned int i;
 
@@ -200,7 +199,7 @@ static unsigned int structleak_execute(void)
 			initialize(var);
 	}
 
-	return ret;
+	return 0;
 }
 
 #define PASS_NAME structleak
-- 
1.9.1


