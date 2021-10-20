Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973B2C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678D46103D
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 20:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJTUC5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhJTUC5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 16:02:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6516AC061749
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 13:00:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so16947018plb.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oC4xL40TX4gXKdUr3q9ajhThG3X3Mfmq07w1fzRH4Aw=;
        b=OmdDlCItAcCb/kTnNchESefFDugeJRmqEOURb8x56zQo5I5kRPFFNpZ3AZHKV3RgdH
         odz+moYgtrmUkutIShXd8I7cTi4l7Vl4MiDSTLbkBlPJpUzM/jnX15Bvbae1BrUGSwnr
         BucewZViScIzDAeYr+Z6HUxqtNPww80bAlcw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oC4xL40TX4gXKdUr3q9ajhThG3X3Mfmq07w1fzRH4Aw=;
        b=4aDWs+aYV3AfpIk4bS7pkrGR1JYNleRPD9KmwxYD4p4mltnlwf1L8Rz6PTty0caTx/
         hufIo9zZ+aGagUcpzVuzyIahF0L2p86ATpPvm4XhnF8Kp8TV773Z9ZODm5La8Cxul3zz
         rugGaAa5knRcBQuOaC1KPCG1hPEjkKawuUby9aKSuYA5HOFJi3AZwc3YF5+ncC90bl4C
         kZt4GMYs7oifFqIaYFTGdvXHomgv4PTFvgTIh10nY3xhjOZpHbSp3I+mNFaMu+TxBiWw
         uwiG8gCnoOyOHzUx/pH2+JYzd99WeSeXlpnRFIxd8/74wpxNC0Cd1we/HR5TddHAqFZ8
         OGrQ==
X-Gm-Message-State: AOAM531LAOKtdO94AiXWOp7VEDmr5JwtoV3Yqx/mrKmKlnGSX9BCWBUd
        7nnwDQ+Vt12hMX6L+f6BzCihwg==
X-Google-Smtp-Source: ABdhPJziP9LVUxU+YqB3uVIUzBuHVCmv8WTkmy2mskoXonbs2k9JCSeYUVdaD6Ey6BRqbGKTFtcAJg==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr1252632pjr.138.1634760041858;
        Wed, 20 Oct 2021 13:00:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm3395267pgj.63.2021.10.20.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:00:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under hwaddress sanitizer
Date:   Wed, 20 Oct 2021 13:00:39 -0700
Message-Id: <20211020200039.170424-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2522; h=from:subject; bh=+AiIfOEWeU4E8zLDOWbiVHd+8UI+lXGPUfqkac57NL8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcHVme5xsJftDfqmCCSgSYRYO6v7mHerNYn5Qyc6C BdJDITyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXB1ZgAKCRCJcvTf3G3AJn6rD/ 9CXjeQGLjf3oKlM6TefCvtpbxL4/ogO5zIGXingOCOmIkTeHY9aC1xQlWJlNU92OMNrNQJ9R6tU7mj hGSwd3u0IrZokg9OjaDGX1gYqrcxbtUlqp3yOgA6CR04920Ck1Ymg7gnv2p4DPSS5oMLZ6Fk5Z7aRp D0aKpCQlBUwvE8wp2/kQSdyJ5lKillOvaVBIK8Hud/yLPlHZi/LtNaC7DP6yT+OaCFBgE/o8T14fEC 7MfAhnUVNLkC5KCZtj3dA2zzUY1CvbzOHNyEdUorP8QcgiaWOR49E6gKrrxaPRheOIahz1qzOpfuyP GM3YbY4v6HIOQU72kDHavZfOo/bmiVXLwivVfKage1nJu6O1nSDiqkm9tfkLjDbzrdR7SR8cKYEdbj X2zBRXCQQq2yfaPIKVYIO8N5fPROW8WoQgdMqmfegeBjD/QQVSGVYPQMm1M30I1lV4K2N2H+gupzlm EhXmmU0Z7bBAKxTlPRJSIb7GtfLrjEC9NrOAKXiX09GOGJlmV6/I2Cm6KPo1WNNdU8tXHY8ClFvGzY rldZo6Bq35Ff3oXFAcWNeGDRDnGSRKkmFpj1Vv86OnQH7cnX9pmvnaAx+Qa/KuzYw0XvlFxTOMESdb OeV7Ic+Z33LM4bzofOue5WZCp3HcpGv7+Fy2SBnjzRMgzpsQGigkHLOl4QHQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When Clang is using the hwaddress sanitizer, it sets __SANITIZE_ADDRESS__
explicitly:

 #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
 /* Emulate GCC's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
 #endif

Once hwaddress sanitizer was added to GCC, however, a separate define
was created, __SANITIZE_HWADDRESS__. The kernel is expecting to find
__SANITIZE_ADDRESS__ in either case, though, and the existing string
macros break on supported architectures:

 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
          !defined(__SANITIZE_ADDRESS__)

where as other architectures (like arm32) have no idea about hwaddress
sanitizer and just check for __SANITIZE_ADDRESS__:

 #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)

This would lead to compiler foritfy self-test warnings when building
with CONFIG_KASAN_SW_TAGS=y:

warning: unsafe memmove() usage lacked '__read_overflow2' symbol in lib/test_fortify/read_overflow2-memmove.c
warning: unsafe memcpy() usage lacked '__write_overflow' symbol in lib/test_fortify/write_overflow-memcpy.c
...

Sort this out by also defining __SANITIZE_ADDRESS__ in GCC under the
hwaddress sanitizer.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm intending to take this via my overflow series, since that is what introduces
the compile-test regression tests (which found this legitimate bug). :)

-Kees
---
 include/linux/compiler-gcc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 6f24eb8c5dda..ccbbd31b3aae 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -121,6 +121,14 @@
 #define __no_sanitize_coverage
 #endif
 
+/*
+ * Treat __SANITIZE_HWADDRESS__ the same as __SANITIZE_ADDRESS__ in the kernel,
+ * matching the defines used by Clang.
+ */
+#ifdef __SANITIZE_HWADDRESS__
+#define __SANITIZE_ADDRESS__
+#endif
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
-- 
2.30.2

