Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF2FC433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112D561019
	for <linux-hardening@archiver.kernel.org>; Thu, 23 Sep 2021 15:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhIWP3x (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:29:53 -0400
Received: from foss.arm.com ([217.140.110.172]:36468 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhIWP3x (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 23 Sep 2021 11:29:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B88CED6E;
        Thu, 23 Sep 2021 08:28:20 -0700 (PDT)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1936E3F719;
        Thu, 23 Sep 2021 08:28:19 -0700 (PDT)
From:   Ross Burton <ross.burton@arm.com>
To:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org
Subject: [PATCH] scripts/gcc-plugins: consistently use HOSTCC
Date:   Thu, 23 Sep 2021 16:28:11 +0100
Message-Id: <20210923152811.406516-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The GCC plugins are built using HOSTCC, but the path to the GCC plugins
headers is obtained using CC.  This can lead to interesting failures if
the host compiler and cross compiler are different versions, and the
host compiler uses the cross headers.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 scripts/gcc-plugins/Kconfig  | 2 +-
 scripts/gcc-plugins/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index ab9eb4cbe33a..5dad6d780138 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -9,7 +9,7 @@ menuconfig GCC_PLUGINS
 	bool "GCC plugins"
 	depends on HAVE_GCC_PLUGINS
 	depends on CC_IS_GCC
-	depends on $(success,test -e $(shell,$(CC) -print-file-name=plugin)/include/plugin-version.h)
+	depends on $(success,test -e $(shell,$(HOSTCC) -print-file-name=plugin)/include/plugin-version.h)
 	default y
 	help
 	  GCC plugins are loadable modules that provide extra features to the
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 1952d3bb80c6..a55363f84e19 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -19,7 +19,7 @@ targets += randomize_layout_seed.h randomize_layout_hash.h
 
 always-y += $(GCC_PLUGIN)
 
-GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
+GCC_PLUGINS_DIR = $(shell $(HOSTCC) -print-file-name=plugin)
 
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
 		  -include $(srctree)/include/linux/compiler-version.h \
-- 
2.25.1

