Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C262C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Sep 2021 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650AF61246
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Sep 2021 09:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhIOJZR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:25:17 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:50331 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhIOJZQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Sep 2021 05:25:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UoT1MUX_1631697829;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0UoT1MUX_1631697829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 17:23:55 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        keescook@chromium.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [RFC] Add additional include path for gcc plugins
Date:   Wed, 15 Sep 2021 17:23:47 +0800
Message-Id: <1631697827-96324-1-git-send-email-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When kernel enables gcc plugin, some header files are missing in some
tool chains (as in the following example)

These header files can be found in other toolchains, and sometimes
the md5hash of these files are same(in most versions).

Should we add a parameter to plugin to allow users to import their own
header file directories?

---
  HOSTCXX scripts/gcc-plugins/stackleak_plugin.so
In file included from scripts/gcc-plugins/gcc-common.h:103:0,
                 from scripts/gcc-plugins/stackleak_plugin.c:30:
/workspace/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu/bin/../
lib/gcc/aarch64-none-linux-gnu/9.2.1/plugin/include/builtins.h:23:17:
 fatal error: mpc.h: No such file or directory
 #include <mpc.h>

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 Makefile                     | 3 +++
 scripts/gcc-plugins/Makefile | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 09bb314..e6134f3 100644
--- a/Makefile
+++ b/Makefile
@@ -1036,6 +1036,9 @@ include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
 
+GCC_PLUGINS_EXT_CFLAGS=
+export GCC_PLUGINS_EXT_CFLAGS
+
 include $(addprefix $(srctree)/, $(include-y))
 
 # scripts/Makefile.gcc-plugins is intentionally included last.
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 1952d3b..0b3e27a 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -23,7 +23,7 @@ GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
 		  -include $(srctree)/include/linux/compiler-version.h \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) $(GCC_PLUGINS_EXT_CFLAGS) -std=gnu++11 \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
 		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag
-- 
2.7.4

