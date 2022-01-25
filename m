Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15208C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Jan 2022 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453745AbiAYI65 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Jan 2022 03:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453806AbiAYIzv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Jan 2022 03:55:51 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66AC049640
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 23:51:32 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i65so18885538pfc.9
        for <linux-hardening@vger.kernel.org>; Mon, 24 Jan 2022 23:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/aENFTNzjAM+uwrag3B1qHd/TFz6oxzOU+9OgjpBY0=;
        b=IHPSFI00pYZGfTVdBdN2epoh1vkXxSzZ97M46BMuvnIKU74J96xadoI9PzAegAn3HK
         RIlGWMpclfeWbmKM7y7qayMtalDQ/RF0tlQ8WByl4Ru38QaCouqw1q9qoVNUMiFCKjO5
         xUfU1iOsT1D0C3i5Mue2dPzRsYfbYBWHX6U40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A/aENFTNzjAM+uwrag3B1qHd/TFz6oxzOU+9OgjpBY0=;
        b=ZMx5JvFnlcfO2t6Ekf1z7sizcSdU4HXUMJ5SUjud+e7DGOX2kU8/eF7VYsAMT1o43T
         xvoIq9n9UOwt6LX0+FmpRmE+g0+BWhRA/GfPyqY8T9+gOja/ai+YuY1vCFhvAdHulDQ9
         /b122AIh5vdHNVtaDuyq2rzKsfjrJRoQyqj6pDGsuCT9MzEiweDZ+OTPUBas4TAjSsKG
         RFpm6v8MvPlWmsOgF9Hg+t8o1KDAS1uTekm3JMn4dH0Dj3iEx5DJgIbFR6Qch0WSkpQ9
         rBA54KB8fuVFWqkyHEWx0pRhfLjyENk74O1pCwpERAVhOZerRF8ES12FU/oyUNSncleK
         5hXA==
X-Gm-Message-State: AOAM533uii6GLlhRI6v8wNU8OEyxT5ZZj1Yj92dB1RTA4W2EpPfirubh
        kAIbfaJQcGlazhy61qGM7dXQHg==
X-Google-Smtp-Source: ABdhPJxYMmUV6UNJ1kx5yW1QIZXaLDl74r72N+JUDDQM3aNEgpZhzyMmtW9/b2H7LKIZg17H45nJGg==
X-Received: by 2002:a05:6a00:d64:b0:4ba:cb6f:87e0 with SMTP id n36-20020a056a000d6400b004bacb6f87e0mr17310243pfv.72.1643097091380;
        Mon, 24 Jan 2022 23:51:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h25sm18804198pfn.208.2022.01.24.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 23:51:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Isabella Basso <isabbasso@riseup.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v3] Kconfig.debug: Make DEBUG_INFO selectable from a choice
Date:   Mon, 24 Jan 2022 23:51:26 -0800
Message-Id: <20220125075126.891825-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8150; h=from:subject; bh=Sk6bdOF055YpWVSI90zrcLZOsF2giKdwSSCMnUw/2Vc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh76v+ed6XRMKylDRICIuwyHz3AwiXdzYskYuNnvYs U5jvS1KJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYe+r/gAKCRCJcvTf3G3AJnEpD/ sHGPkKwHcb4aul5Defn5aISeEIE7j6GeWdkuhaVJsmMhkekO/EU3P6qUMn8KdFv+6IyD+juTzcMn9o uNwAk0ebBEO9iXbhJajo2zpcvStmsNCyDpCI5H2b1rgsog4c4DLIr8NxE3eEyzK88lif/ckVR9/XYW BxPfrINbO11OfCPfiU0GA6octLNFabW3cUtZp5mlz0/JreZqfEHrjLmfU7i++tQLFONKWxg7gTzL1L KezpUoWAYGmVkFr5uh8p5gtlYugsB8ahPMXNSMnAm5aQjK/K080pnKK75X9J6jVIrCrKMpRjEJ6cRE DDtgfDSS8ASRQPZ0k0s01GveNJNFkFyb3dxJESfUkbGxTYOIbjD81MeYoa/xCfsja2SANNkJRNSu4F RjpQU4FfuOrGwg1As29AugdBUwVO78OI3rmihqd4QgoWYqOSV7sko4iSWCQg5Axza/OL+Iu70A1TKV YpWt0B90Iu0XJzu090yd46D+mh0dIGcnFwdw+xd7SJsoCvjTDUtTdbgLwv3tKGzLXCwbl7LA2UrHh1 yegRWwUfWaT4xFVbEtglhuY6cQ/d6KYMBdgBT91Spc+xuXpWfce3YJDo1PzXYWiLQGJ1lFlvfKlnfM nyBDaIot7t3BoqR7n/G3UQUv0/lQzPptdRx9LrqmdZzOcaufS8e5d1++p6sg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Currently it's not possible to enable DEBUG_INFO for an all*config build,
since it is marked as "depends on !COMPILE_TEST". This generally makes
sense because a debug build of an all*config target ends up taking much
longer and the output is much larger. Having this be "default off" makes
sense. However, there are cases where enabling DEBUG_INFO for such builds
is useful for doing treewide A/B comparisons of build options, etc.

Make DEBUG_INFO selectable from any of the DWARF version choice options,
with DEBUG_INFO_NONE being the default for COMPILE_TEST. The mutually
exclusive relationship between DWARF5 and BTF must be inverted, but the
result remains the same. Additionally moves DEBUG_KERNEL and DEBUG_MISC
up to the top of the menu because they were enabling features _above_
it, making it weird to navigate menuconfig.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20211210000910.3597609-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220121001204.4023842-1-keescook@chromium.org
v3: - rebase to v5.17-rc1
---
 lib/Kconfig.debug | 140 +++++++++++++++++++++++++---------------------
 1 file changed, 75 insertions(+), 65 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 14b89aa37c5c..1290e0906236 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -208,20 +208,88 @@ config DEBUG_BUGVERBOSE
 
 endmenu # "printk and dmesg options"
 
+config DEBUG_KERNEL
+	bool "Kernel debugging"
+	help
+	  Say Y here if you are developing drivers or trying to debug and
+	  identify kernel problems.
+
+config DEBUG_MISC
+	bool "Miscellaneous debug code"
+	default DEBUG_KERNEL
+	depends on DEBUG_KERNEL
+	help
+	  Say Y here if you need to enable miscellaneous debug code that should
+	  be under a more specific debug option but isn't.
+
 menu "Compile-time checks and compiler options"
 
 config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL && !COMPILE_TEST
+	bool
 	help
-	  If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
+	  A kernel debug info option other than "None" has been selected
+	  in the "Debug information" choice below, indicating that debug
+	  information will be generated for build targets.
+
+choice
+	prompt "Debug information"
+	depends on DEBUG_KERNEL
+	default DEBUG_INFO_NONE if COMPILE_TEST
+	help
+	  Selecting something other than "None" results in a kernel image
+	  that will include debugging info resulting in a larger kernel image.
 	  This adds debug symbols to the kernel and modules (gcc -g), and
 	  is needed if you intend to use kernel crashdump or binary object
 	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
-	  Say Y here only if you plan to debug the kernel.
 
-	  If unsure, say N.
+	  Choose which version of DWARF debug info to emit. If unsure,
+	  select "Toolchain default".
+
+config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+	bool "Rely on the toolchain's implicit default DWARF version"
+	select DEBUG_INFO
+	help
+	  The implicit default version of DWARF debug info produced by a
+	  toolchain changes over time.
+
+	  This can break consumers of the debug info that haven't upgraded to
+	  support newer revisions, and prevent testing newer versions, but
+	  those should be less common scenarios.
+
+config DEBUG_INFO_DWARF4
+	bool "Generate DWARF Version 4 debuginfo"
+	select DEBUG_INFO
+	help
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+
+	  If you have consumers of DWARF debug info that are not ready for
+	  newer revisions of DWARF, you may wish to choose this or have your
+	  config select this.
+
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	select DEBUG_INFO
+	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	help
+	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
+	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
+	  draft features until 7.0), and gdb 8.0+.
+
+	  Changes to the structure of debug info in Version 5 allow for around
+	  15-18% savings in resulting image and debug info section sizes as
+	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
+	  extensions such as accelerators for symbol indexing and the format
+	  for fission (.dwo/.dwp) files. Users may not want to select this
+	  config if they rely on tooling that has not yet been updated to
+	  support DWARF Version 5.
+
+config DEBUG_INFO_NONE
+	bool "Disable debug information"
+	help
+	  Do not build the kernel with debugging information, which will
+	  result in a faster and smaller build.
+
+endchoice # "Debug information"
 
 if DEBUG_INFO
 
@@ -267,56 +335,12 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
-choice
-	prompt "DWARF version"
-	help
-	  Which version of DWARF debug info to emit.
-
-config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
-	bool "Rely on the toolchain's implicit default DWARF version"
-	help
-	  The implicit default version of DWARF debug info produced by a
-	  toolchain changes over time.
-
-	  This can break consumers of the debug info that haven't upgraded to
-	  support newer revisions, and prevent testing newer versions, but
-	  those should be less common scenarios.
-
-	  If unsure, say Y.
-
-config DEBUG_INFO_DWARF4
-	bool "Generate DWARF Version 4 debuginfo"
-	help
-	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
-
-	  If you have consumers of DWARF debug info that are not ready for
-	  newer revisions of DWARF, you may wish to choose this or have your
-	  config select this.
-
-config DEBUG_INFO_DWARF5
-	bool "Generate DWARF Version 5 debuginfo"
-	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
-	depends on !DEBUG_INFO_BTF
-	help
-	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
-	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
-	  draft features until 7.0), and gdb 8.0+.
-
-	  Changes to the structure of debug info in Version 5 allow for around
-	  15-18% savings in resulting image and debug info section sizes as
-	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
-	  extensions such as accelerators for symbol indexing and the format
-	  for fission (.dwo/.dwp) files. Users may not want to select this
-	  config if they rely on tooling that has not yet been updated to
-	  support DWARF Version 5.
-
-endchoice # "DWARF version"
-
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
 	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	depends on BPF_SYSCALL
+	depends on !DEBUG_INFO_DWARF5
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert
@@ -585,20 +609,6 @@ source "lib/Kconfig.kcsan"
 
 endmenu
 
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_MISC
-	bool "Miscellaneous debug code"
-	default DEBUG_KERNEL
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here if you need to enable miscellaneous debug code that should
-	  be under a more specific debug option but isn't.
-
 menu "Networking Debugging"
 
 source "net/Kconfig.debug"
-- 
2.30.2

