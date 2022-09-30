Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D001C4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 30 Sep 2022 06:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiI3GGe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 30 Sep 2022 02:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI3GGc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 30 Sep 2022 02:06:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1741C45BB
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 23:06:31 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b23so3362263pfp.9
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 23:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=i61OOr58zfCwmexOF8+V4sJvwXGh54OgnBPaDfVHlGA=;
        b=XrUm2q7pHn5YVcdWCabm5lL8LorV8ISHr/1212QXQdrjg3/Kt+SvDhuzuXEaddLwT1
         68wupfeFMGa5cVABPm6j3CZIKARFcpzYJdErZIisU0Pbl3tPfaYCJewbDmauYWjBg7NX
         LZ567LM6Y+rRC4b3ctDg+e3Q3aAqx+jyUdjGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=i61OOr58zfCwmexOF8+V4sJvwXGh54OgnBPaDfVHlGA=;
        b=KpzXB6QQtiV5L7atHTmt0xijgJ/O91OD1cRfVFawor5ZLD8knVyUAKxUVy5BkjH1MB
         HG4XXOgPwYd0TQsPFdE3AayL5kBl6vZ1gXfyjlUlbQHtJzTU3GB4BzP8HLNa5k4wyTar
         nVbqsRbLTb9hM1CVZV05jo9WngiDVR2N4RUTwyJ000w02nBQQAoXHtYBRampsP8Llaam
         snHmN2lWuW29OYh3mWJ6s8kpjlqmsKn7OplAMAJKuIL7oVbVunnhK4r3y7OkDNW0WaaS
         285l/iv54cpF6uxd1MTeTkqvNpGGaGearh9LY9IPtEzctGbsF/Fe4mWj4m85AlidAVMj
         sYig==
X-Gm-Message-State: ACrzQf3hwOrg3KnjOPP2nTzoW9wEaXg1hgPALykSX7JMmGyXWlWUjckx
        vidFUVa/B0u5K75Leiztr+4k4g==
X-Google-Smtp-Source: AMsMyM5NdWi48t1xNiMrpGz/Drk58wReh3dQyhi+9lyFbKCYyeIBcK8Mr0cBbc6xo9tPqc3oVIsMiA==
X-Received: by 2002:a63:77c4:0:b0:435:4224:98b6 with SMTP id s187-20020a6377c4000000b00435422498b6mr6262577pgc.94.1664517990821;
        Thu, 29 Sep 2022 23:06:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6-20020a628706000000b005375a574846sm776607pfe.125.2022.09.29.23.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 23:06:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] hardening: Remove Clang's enable flag for -ftrivial-auto-var-init=zero
Date:   Thu, 29 Sep 2022 23:06:24 -0700
Message-Id: <20220930060624.2411883-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; h=from:subject; bh=nee5BjW/8fsDLojYzngsPv0G3HZZqrClAK92SqD+Bm0=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBjNodfq65LRtk/UBksZoj1vtyFkICUBDgXDFDpBHwd P7zBojCJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYzaHXwAKCRCJcvTf3G3AJl82D/ dWwl4+QkOkCDHzckmUB8wlGj5qqJ6Fg8GDdTURrwdWm7l3PYhAA67RhthYa8ayfPxLo/4KMTDa07Dh SKEw0FdHsNd41lVDcbsKEFoR9hhg0yRb0UJvpnpT84bLCpmuDAfgzEFxuDcYgUoTypf//twXA6ejgG 293hWR8BTuCijVkZsoba5WxIAJ6GMUWsSC+UzE0+Dm9NWWmBH9bEUKWVReE89ndReqRjLqr0urjp9k V0VN4f0j3pqWhswGfwTebVGEH98nwKaqtc3mCREYDdFL/KRqwJe3e183oCFmb4ZLY1A0uTzkxt/jVB xxGHrQiQ1eO0V6S5BalYSdRP5z+PFp5LVOuXJadkOTug+IjCKAX6o03zztUa9GocDU6F24pcx99PJn MMxaI5PgqmoKAx8CEe6Axg/Dl290DQmRh1ptHpKgVFCN7fz6FmG7Hv9sl4eUD2EQKbwJFjgqrzQuU9 OamayeMH/oDl4ecPo+1lP/iHCJEQaoO/2Dsj1j02cQ3Rt6FSB9uD35Z8UMo3XnRv8mU1iNH/28e6Kl h64GD6EPMJMUcVSJWXM9ITMfpr44Zz0SOdTKuLFMve/6S/+4P9gsNqs4fj1KZIiZVdl2qvWgh5pijw pR81kGTon+9ktJZM4SGbMTZg720WxYOk7TcaWROUL/d2JQBgWdW+jH8k+B
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Now that Clang's -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
option is no longer required, remove it from the command line. Clang 16
and later will warn when it is used, which will cause Kconfig to think
it can't use -ftrivial-auto-var-init=zero at all. Check for whether it
is required and only use it when so.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev
Cc: stable@vger.kernel.org
Fixes: f02003c860d9 ("hardening: Avoid harmless Clang option under CONFIG_INIT_STACK_ALL_ZERO")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile                   |  4 ++--
 security/Kconfig.hardening | 14 ++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index c7705f749601..02c857e2243c 100644
--- a/Makefile
+++ b/Makefile
@@ -831,8 +831,8 @@ endif
 # Initialize all stack variables with a zero value.
 ifdef CONFIG_INIT_STACK_ALL_ZERO
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero
-ifdef CONFIG_CC_IS_CLANG
-# https://bugs.llvm.org/show_bug.cgi?id=45497
+ifdef CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER
+# https://github.com/llvm/llvm-project/issues/44842
 KBUILD_CFLAGS	+= -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
 endif
 endif
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index bd2aabb2c60f..995bc42003e6 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -22,11 +22,17 @@ menu "Memory initialization"
 config CC_HAS_AUTO_VAR_INIT_PATTERN
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
-config CC_HAS_AUTO_VAR_INIT_ZERO
-	# GCC ignores the -enable flag, so we can test for the feature with
-	# a single invocation using the flag, but drop it as appropriate in
-	# the Makefile, depending on the presence of Clang.
+config CC_HAS_AUTO_VAR_INIT_ZERO_BARE
+	def_bool $(cc-option,-ftrivial-auto-var-init=zero)
+
+config CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER
+	# Clang 16 and later warn about using the -enable flag, but it
+	# is required before then.
 	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
+	depends on !CC_HAS_AUTO_VAR_INIT_ZERO_BARE
+
+config CC_HAS_AUTO_VAR_INIT_ZERO
+	def_bool CC_HAS_AUTO_VAR_INIT_ZERO_BARE || CC_HAS_AUTO_VAR_INIT_ZERO_ENABLER
 
 choice
 	prompt "Initialize kernel stack variables at function entry"
-- 
2.34.1

