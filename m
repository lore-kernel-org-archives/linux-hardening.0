Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD3BC433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Jul 2022 00:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiGBAqp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGBAqo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 1 Jul 2022 20:46:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44D377DA
        for <linux-hardening@vger.kernel.org>; Fri,  1 Jul 2022 17:46:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m2so3817125plx.3
        for <linux-hardening@vger.kernel.org>; Fri, 01 Jul 2022 17:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5RCZ7eFf7DG+bb/K0Fo4I4OVu7EXZEP7BsL1eeuLJo=;
        b=bmwgsoe8otKVtotDYJhzt/jQr6yWchQ0guIlu1EFiVjMr0KOIcQ/nKIuVo1Ps7+spj
         S9MwjARzDWcYO4eMSuFK8OccdxI8Bq0u0zJmssAkdgSk9YmNIkUMnwm1uysp2saw8HMU
         gQLZqQ+eT0ZR96CQsbuem7QsUOQkwDSXcqIY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z5RCZ7eFf7DG+bb/K0Fo4I4OVu7EXZEP7BsL1eeuLJo=;
        b=XKWhBbmT6hZJMvsH+EWTGtKPJjvqEQd9PQNG5ornjcFUzy4ZYUnEbP7ZzKvf/0u7oV
         J3cXW/SaP3xjET0NFIYyAe6wgx1/++ZNwcUgrNfKd9iNpLkqzdREmydfg1LIaWi/ag+D
         lieQnxJOLwZsd52kzh9okrnuId63tZae5juvwp0kKEUMIET4MujVZ3MqIzM/ThNP5MGL
         FLqo+FP0ItX3W3c9tmsQ8rdQ2xGO8EZ29poXvQbci9Z977K7AUvOZOXH1afJrLvxtCCo
         r6dKrPKfOpsB3E8sCJ4J4ANDBl87GaJaSu9QQIuJBL61A4UIHD3Wy9TKH7GlSIeBrSXX
         zQ3Q==
X-Gm-Message-State: AJIora9za4MY76fW6Mj6FkCML4YUPbKpVb/0Hep5kVZFpIScQG4CwMUn
        b0xg8D6Wo8cK9xsC7Z4RCS0rJHRGkENsBg==
X-Google-Smtp-Source: AGRyM1ve4YUGA7V2Z9Wnx8QjYt12AgSq4PN+wkt7vlENvY7OoY5yig3Cy+8JuDYeTNu7QIRgdAw+sQ==
X-Received: by 2002:a17:902:db0b:b0:16b:a4ff:c9d6 with SMTP id m11-20020a170902db0b00b0016ba4ffc9d6mr14613002plx.15.1656722802266;
        Fri, 01 Jul 2022 17:46:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm16842396pff.148.2022.07.01.17.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 17:46:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     keescook@chromium.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add a general "kernel hardening" section
Date:   Fri,  1 Jul 2022 17:46:38 -0700
Message-Id: <20220702004638.2486003-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3372; h=from:subject; bh=D5UHUo1K/mbMYL0LorOoDOvKGWk+5IBEegx+/wvLazw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiv5VtcKZMiRsnO85YZL+A4W3igpu+YcXZHhE34+sS F6IJn2yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYr+VbQAKCRCJcvTf3G3AJgQzEA CqKReyJ1ivVmHrIMPx5edQh5vStKNRJWzpqrd7EwtsXHGfKB2sO995YJjmY++Jc79VDVmUexB0fQFm ppLAqXdHChJ6WdA9ifdBoJde4S4AvABkO7NpVfkCCKcC6/jJnEgLl62wStHckxzwD+OxHpvOsYR6Iy jQR6rnIR3BjXeqp3eMYUoqsJSWoNSFZb6Lp65sbBLLCKqgCww2QEpkhHHm3edc/oeLwLnBnwlJ9R3k VXPSfv6hdTszUiXU/yUaefuU4IFEbT/kd2eftnIcTbNf7PMvI9Ie6hvurrFBXwyLFknXsuQwPmnZ5E WmuH+JGoYOGzfLrEm4/u9YfyzFbvwT6cHIcXm/vzPg/4+79/5YRQlKoMsZ0rxwGMFHDZ43cEG11xdb fxRtb54NwQ36yBIXVYRPxVMxvSCXpOJHpjMcyk854i+XeBfqLetMUBi85OPSDeP9DGPssxUrqRAf3+ 8Tkcb+HvQhSXN8oPd4LjfYNqJ3KjMFQhOc+Y5CCSMGlCruQ4BYFsrUfKdfNDpYqbCZN+tYLalvoU3J MDpyAC6X1N4wCo9DXzf3DFo5DjaGtWNUCJmNfS2Y9QJqhCIlZ6xscg2qwEEkY+pXXPU+olip8Rg+7z iwcglNkqA/BtHSkCWxrNGFXfnCvuTK9BbbS4BJY9uI2hnZXH+IjRM8dAKkRw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

While many large subsystems related to kernel hardening have their own
distinct MAINTAINERS entries, there are some smaller collections that
don't, but are maintained/reviewed by linux-hardening@vger.kernel.org.
Add a section to capture these, add (or replace defunct) trees that are
now all carried in the hardening tree.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..2702b29e922f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4873,7 +4873,7 @@ R:	Nick Desaulniers <ndesaulniers@google.com>
 L:	llvm@lists.linux.dev
 S:	Supported
 B:	https://github.com/ClangBuiltLinux/linux/issues
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/clang/features
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/cfi.h
 F:	kernel/cfi.c
 
@@ -7783,6 +7783,7 @@ FORTIFY_SOURCE
 M:	Kees Cook <keescook@chromium.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	include/linux/fortify-string.h
 F:	lib/test_fortify/*
 F:	scripts/test_fortify.sh
@@ -8225,6 +8226,7 @@ GCC PLUGINS
 M:	Kees Cook <keescook@chromium.org>
 L:	linux-hardening@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/kbuild/gcc-plugins.rst
 F:	scripts/Makefile.gcc-plugins
 F:	scripts/gcc-plugins/
@@ -10742,6 +10744,17 @@ F:	scripts/mk*
 F:	scripts/mod/
 F:	scripts/package/
 
+KERNEL HARDENING (not covered by other areas)
+M:	Kees Cook <keescook@chromium.org>
+L:	linux-hardening@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
+F:	include/linux/overflow.h
+F:	include/linux/randomize_kstack.h
+F:	mm/usercopy.c
+K:	\b(add|choose)_random_kstack_offset\b
+K:	\b__check_(object_size|heap_object)\b
+
 KERNEL JANITORS
 L:	kernel-janitors@vger.kernel.org
 S:	Odd Fixes
@@ -11542,7 +11555,7 @@ F:	drivers/media/usb/dvb-usb-v2/lmedm04*
 LOADPIN SECURITY MODULE
 M:	Kees Cook <keescook@chromium.org>
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git lsm/loadpin
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/admin-guide/LSM/LoadPin.rst
 F:	security/loadpin/
 
@@ -17857,7 +17870,7 @@ M:	Kees Cook <keescook@chromium.org>
 R:	Andy Lutomirski <luto@amacapital.net>
 R:	Will Drewry <wad@chromium.org>
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/seccomp
 F:	Documentation/userspace-api/seccomp_filter.rst
 F:	include/linux/seccomp.h
 F:	include/uapi/linux/seccomp.h
@@ -21993,7 +22006,7 @@ F:	include/linux/yam.h
 YAMA SECURITY MODULE
 M:	Kees Cook <keescook@chromium.org>
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git yama/tip
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
 F:	Documentation/admin-guide/LSM/Yama.rst
 F:	security/yama/
 
-- 
2.32.0

