Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65810C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  3 May 2022 20:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbiECU6v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 3 May 2022 16:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiECU6r (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 3 May 2022 16:58:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B7035DE2
        for <linux-hardening@vger.kernel.org>; Tue,  3 May 2022 13:55:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so3042006pjf.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 May 2022 13:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7gjgj4/4LSK9c/JAyPIXqGgMKHVguykDn2bHyT8voA=;
        b=lPFLR0C5AR5qKEBPAIWTWtzBk+9lgyDMXniJNA7VZybl5Svtynw7Q/xjEYdb832RxY
         jR+mmBUtRcDesMD4DEG7CNWGz0KtJaT50b3NMMS76x0LFx22QrYMECu2xX38hf/AwNb7
         MMJL5gT3MvziRSysXThA4xSGWJAbkPXC9dKQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7gjgj4/4LSK9c/JAyPIXqGgMKHVguykDn2bHyT8voA=;
        b=LHzrCSdZ8w13itWoF9j0fNXNxwNdC22w8Bgy4UaFVqU+q7UgWic9W1gav13JXYIXIf
         90f78n3MD/VqrW2n8mSYhT09BJAsW/QXPK+HP3Kw16JkL1+zz01wE9Kusq8kCm5CwGQX
         U43u9LtHHLA2rBXpnmpmvPKn3HJ8tUxqVwlCinE1Jajyl+h4H4Yi9DLR4bJvNJ2Hbb0m
         y9Z0VJHm8ZaxlTkriS9uuszdoBNGZwAZG6aEq69SDVLrkdJUq5iIarUVaZmX6xBzJqDP
         6aLye+RPlGNu2fQfBnW6ZGRtrvZYwo4DxSXJAk/e3tWllgGERekub9/4AVDx2K+zEvm5
         TxqQ==
X-Gm-Message-State: AOAM532KyludDhlI+QGEsUQkiXPvU8ZGWeHN69DO5Yajk6zUwPOC8mh3
        fUjjIy2k2TvxaQHY5aTzjgFVww==
X-Google-Smtp-Source: ABdhPJzlRQDlCCwN12p3T2iXLOmaoOKLrPyOTgiWQ5BWcgjSqfBDOLgzhdNXlPBULmM7f+FaLlbpCA==
X-Received: by 2002:a17:902:bb90:b0:158:a031:2ff2 with SMTP id m16-20020a170902bb9000b00158a0312ff2mr18429818pls.117.1651611311296;
        Tue, 03 May 2022 13:55:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10-20020a63450a000000b003c14af50607sm13111823pga.31.2022.05.03.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 6/6] randstruct: Enable Clang support
Date:   Tue,  3 May 2022 13:55:03 -0700
Message-Id: <20220503205503.3054173-7-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2492; h=from:subject; bh=70QhakHoqRBTF2BhS4yZEwFNAa1mWnEa/ie6xwzJGBY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZamZGgPTMDtkz2lAP6v2msQMzZKulCSX+KAGB5j E1bmlEqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpgAKCRCJcvTf3G3AJlU5D/ 9Xyd51aYNqszUUL7SvvNyC19VjSU0o+jEEkpPilQKRN1uRHK9nWVWsrPw3aFhoMz4iTS5XBzAGpYfE DZEIcZQKS7f0MQGz6vgp5cG+EgrB5CcQ4ePyGGRn7IdfAg53lo+OIxP2oilAbt8NP58LUyzfd4EjYV kt5olI/+81/6ht6froYHo+0Qv+4W3GPz9sGufyfAEbFQyXjsEcy9Ro2qAdyOxtoCS8aDDznVpsbfQL 9z41A3ZD5ml0/L04Rk485Bom22yCPUP/1gkISFHvDq23I4slmV8kNHcqAFOPhTq4bc4MJ8+3dUZqmD VvFFb5wmyDS0grBSDnO9ihBplIWn5/Aq5sH2CcmQKp7DKALkQPjHNdED2ABfy/jQdoGogxCHAyuP9F zW7FjuKazB8lTmSMZKxUakxyGS0ANjJR32zyrofE+RdyI7hElnpEzP7vnVTb3vnK8zo+Vk6KYGGEzZ 4yZIbE1lnLdCkvvS3GxZubDQI7e/adQqf/kcL2bKQ9RXvw4IAWaBA4onxJpmaRDtEBar+YGUT9jS3E hcT67gCbpkmG3Vccv5IlmGAI/6hpgM986H4ODejuZbIJymhKClI/n8pqWJdg9ZBGccPsezfwigdKIu oPS4Fo4Cf2D4ZToRh8wuX98q/HcA7kcOkiuSlaUmKQWv49ct43TIINfIBBkQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Clang 15 will support randstruct via the -frandomize-layout-seed-file=...
option. Update the Kconfig and Makefile to recognize this feature.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.randstruct |  3 +++
 security/Kconfig.hardening  | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.randstruct b/scripts/Makefile.randstruct
index 4d741e6db554..24e283e89893 100644
--- a/scripts/Makefile.randstruct
+++ b/scripts/Makefile.randstruct
@@ -7,6 +7,9 @@ randstruct-cflags-y	\
 	+= -fplugin=$(objtree)/scripts/gcc-plugins/randomize_layout_plugin.so
 randstruct-cflags-$(CONFIG_RANDSTRUCT_PERFORMANCE)		\
 	+= -fplugin-arg-randomize_layout_plugin-performance-mode
+else
+randstruct-cflags-y	\
+	+= -frandomize-layout-seed-file=$(objtree)/scripts/basic/randstruct.seed
 endif
 
 export RANDSTRUCT_CFLAGS := $(randstruct-cflags-y)
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 0277ba578779..bd2aabb2c60f 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -266,9 +266,12 @@ config ZERO_CALL_USED_REGS
 
 endmenu
 
+config CC_HAS_RANDSTRUCT
+	def_bool $(cc-option,-frandomize-layout-seed-file=/dev/null)
+
 choice
 	prompt "Randomize layout of sensitive kernel structures"
-	default RANDSTRUCT_FULL if COMPILE_TEST && GCC_PLUGINS
+	default RANDSTRUCT_FULL if COMPILE_TEST && (GCC_PLUGINS || CC_HAS_RANDSTRUCT)
 	default RANDSTRUCT_NONE
 	help
 	  If you enable this, the layouts of structures that are entirely
@@ -297,13 +300,20 @@ choice
 
 	config RANDSTRUCT_FULL
 		bool "Fully randomize structure layout"
-		depends on GCC_PLUGINS
+		depends on CC_HAS_RANDSTRUCT || GCC_PLUGINS
 		select MODVERSIONS if MODULES
 		help
 		  Fully randomize the member layout of sensitive
 		  structures as much as possible, which may have both a
 		  memory size and performance impact.
 
+		  One difference between the Clang and GCC plugin
+		  implementations is the handling of bitfields. The GCC
+		  plugin treats them as fully separate variables,
+		  introducing sometimes significant padding. Clang tries
+		  to keep adjacent bitfields together, but with their bit
+		  ordering randomized.
+
 	config RANDSTRUCT_PERFORMANCE
 		bool "Limit randomization of structure layout to cache-lines"
 		depends on GCC_PLUGINS
-- 
2.32.0

