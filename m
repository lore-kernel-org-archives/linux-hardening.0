Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C85EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A08261151
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 15:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhJMPCu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:02:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhJMPCt (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 11:02:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A140610FC;
        Wed, 13 Oct 2021 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634137246;
        bh=TXn+PgrUBav6KaMGnAdZqxm9Ab2ARAMDJbrPWj51RR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uH+xXHDXWbUhHOEec9M/jt7uK3ZFMLiyfin3yoSSyCNGKwMk3n5Mhwhk8hrRTA0fS
         Lz8NVU0Qkg4B3coNp0/88166UT/z1T1iR/q1Tlfe3ILh7ZEmmABEM+1kiFOguN2BQA
         6iQGJXgL9n3MWFjUMZ4H/oWuYGlbmApquFRMLNp4SYQbwLiAc0g+wFwD0wiCet38JC
         ll+rET7lfmHxLYqkg/iZbrQnBMiOi5nSoMDt3Qnyszgdnbg0m8SVHDCSJj3WCnpOBf
         RITrDJiebwLyKLOF9PfW4iCUOPA0rgHfs1ZL5ZkjDIq5GFTPApZQbKkfN086I+k7Gi
         /0nUVOLmOzHHA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chomium.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 2/2] kasan: use fortified strings for hwaddress sanitizer
Date:   Wed, 13 Oct 2021 17:00:06 +0200
Message-Id: <20211013150025.2875883-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211013150025.2875883-1-arnd@kernel.org>
References: <20211013150025.2875883-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

GCC has separate macros for -fsanitize=kernel-address and
-fsanitize=kernel-hwaddress, and the check in the arm64 string.h
gets this wrong, which leads to string functions not getting
fortified with gcc. The newly added tests find this:

warning: unsafe memchr() usage lacked '__read_overflow' warning in /git/arm-soc/lib/test_fortify/read_overflow-memchr.c
warning: unsafe memchr_inv() usage lacked '__read_overflow' symbol in /git/arm-soc/lib/test_fortify/read_overflow-memchr_inv.c
warning: unsafe memcmp() usage lacked '__read_overflow' warning in /git/arm-soc/lib/test_fortify/read_overflow-memcmp.c
warning: unsafe memscan() usage lacked '__read_overflow' symbol in /git/arm-soc/lib/test_fortify/read_overflow-memscan.c
warning: unsafe memcmp() usage lacked '__read_overflow2' warning in /git/arm-soc/lib/test_fortify/read_overflow2-memcmp.c
warning: unsafe memcpy() usage lacked '__read_overflow2' symbol in /git/arm-soc/lib/test_fortify/read_overflow2-memcpy.c
warning: unsafe memmove() usage lacked '__read_overflow2' symbol in /git/arm-soc/lib/test_fortify/read_overflow2-memmove.c
warning: unsafe memcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memcpy.c
warning: unsafe memmove() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memmove.c
warning: unsafe memset() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-memset.c
warning: unsafe strcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strcpy-lit.c
warning: unsafe strcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strcpy.c
warning: unsafe strlcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strlcpy-src.c
warning: unsafe strlcpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strlcpy.c
warning: unsafe strncpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strncpy-src.c
warning: unsafe strncpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strncpy.c
warning: unsafe strscpy() usage lacked '__write_overflow' symbol in /git/arm-soc/lib/test_fortify/write_overflow-strscpy.c

Add a workaround to include/linux/compiler_types.h so we always
define __SANITIZE_ADDRESS__ for either mode, as we already do
for clang.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/compiler_types.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index aad6f6408bfa..2f2776fffefe 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -178,6 +178,13 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+/*
+ * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel
+ */
+#ifdef __SANITIZE_HWADDRESS__
+#define __SANITIZE_ADDRESS__
+#endif
+
 /*
  * Sanitizer helper attributes: Because using __always_inline and
  * __no_sanitize_* conflict, provide helper attributes that will either expand
-- 
2.29.2

