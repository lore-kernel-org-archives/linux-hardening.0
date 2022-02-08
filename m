Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA73C4332F
	for <linux-hardening@archiver.kernel.org>; Tue,  8 Feb 2022 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiBHWyK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiBHWyH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 8 Feb 2022 17:54:07 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC7C0612AA
        for <linux-hardening@vger.kernel.org>; Tue,  8 Feb 2022 14:53:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so611940pls.5
        for <linux-hardening@vger.kernel.org>; Tue, 08 Feb 2022 14:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/PVhh2GGyEZ/OpySoYuE0Voq9bNBLeTXsuiI5yskHY=;
        b=ZmzxPMF6hBbzUNNzlgL6cg7rdtNMhqny9ks5UBnjgosAkl9T3gHUY4pLvcjQUIykVG
         xgZH2BNzHJ2VsxUcBoFK5r/TS3Avs2olzzWfMX0FhY++VPdu/VedLwWRFs4f8+3ijpnu
         4WSBhQnELzGzsTJ51tb/vR7jxubPqsnTZrQEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/PVhh2GGyEZ/OpySoYuE0Voq9bNBLeTXsuiI5yskHY=;
        b=M2ZbZeOKqbi4nD2Z515dLWTb+YOWy5jg0ItTXJnGSsfYf84M0bNtliloxzy23KL8e0
         YRnlRvuzz0gYjF1pajkDDtKQHTjIoOTF0cpVMDF3NIyoD372DvVWkBi9uELCkUG/wsvu
         beDkGTn2YzLTv2mpMQzTFwcSv7HRJFsBKY/E0ib+MH6qpsETEfMiQ9/sHklK2oAoBqop
         dQlid0fHENbGBDCByl1R92F27SURwLhyfC01vG1/o/4rbyl+W7kGYkz/oKcqGJYM8Iuo
         5+aGBaTejiu7vsTbx93J5tZ08M8/Pe6deSH2ulvwwv/+Xhvl+Mo3oUI9lpAGeSkNg2VF
         5EBA==
X-Gm-Message-State: AOAM5308lu4GTakOWPC/xiFb+tm75MJrRNagxOFsuJDgxsnhNaYDjnEC
        J8KBUCvgdb90WlskxqFqwCknIQ==
X-Google-Smtp-Source: ABdhPJxxe2mPIAdq1qIBhh/HsddVIVmPauN8pL832p2JJRZVYQZsJyA04rFHJRX7Qa6uaHLpqAStXg==
X-Received: by 2002:a17:90b:1b46:: with SMTP id nv6mr206541pjb.105.1644360834076;
        Tue, 08 Feb 2022 14:53:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pf8sm3953732pjb.20.2022.02.08.14.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 14:53:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v7 7/8] fortify: Make sure strlen() may still be used as a constant expression
Date:   Tue,  8 Feb 2022 14:53:49 -0800
Message-Id: <20220208225350.1331628-8-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208225350.1331628-1-keescook@chromium.org>
References: <20220208225350.1331628-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; h=from:subject; bh=x0eO+QDq4SY1xj1KazbfZHej8GhFXPKxChBqWEMgyXk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiAvR98C7j5hKV7f7E3A2woQIyNSxiyRCxHsDAXHnD p1tjCnGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgL0fQAKCRCJcvTf3G3AJqUED/ 4/Uw1zXc3soNRZuOJXIGr0vVZQJi8Zs371ZIAhRPRIej8MJHKof1likyWfRx/uf4cv9zccrOpB7mwW DY5ULp9uEtD9Nh/Z4cyIkNyzDFa/p46H8h5ZVT4y3y9IcpUxMaXU2jJ00aNbNNGgCUOx9XjlBoNjM7 AxvxamkuT5MUywf5+raTMeXktKrC7VffAO1cJyaoXANfCXLs3lH5UceD6pcdzxbn+vz0aQZQhDRwMi CrWoevmY9go+zZEUw+hW4cVW8gmedWQ5RMlnWpzepT/294hza9/XVWQ0ugmewmZD3SJFFr95I+KBq0 pmGtNruHMUVHxGY2iexfwareMdWGUVradhj8JCXNFwiKLMdP54kwA3SIzeIAHE0Aa+IBW55XeWeCa8 SILOWmNX1VvxDgBGX8j9KrumiZT9/C+A6/fj8eMBZbcGn3qcrqoKIW2MFNbzY5NFgUG565yZVWBVuS COPv+WauZVejhzLU+vUQYCQ2vJa+pCyMa9yDiaFLkGNEVjdomfJSEGTez9QHoBP+iDLe5/8SOOeMMK ZJ4sYpUKufPja+UGwdx5KBwqmImWNgKF/yeM+oDdwXFeiH6MJjEp112rEYHn1bMX1l2FVej25gREpG FWj1bEtWcTrSgU19gsQPV0/++Q6E2IX6XbOiT6cdN7+NGmEdLuEfEdcem+pQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for enabling Clang FORTIFY_SOURCE support, redefine
strlen() as a macro that tests for being a constant expression
so that strlen() can still be used in static initializers, which is
lost when adding __pass_object_size and __overloadable.

An example of this usage can be seen here:
	https://lore.kernel.org/all/202201252321.dRmWZ8wW-lkp@intel.com/

Notably, this constant expression feature of strlen() is not available
for architectures that build with -ffreestanding. This means the kernel
currently does not universally expect strlen() to be used this way, but
since there _are_ some build configurations that depend on it, retain
the characteristic for Clang FORTIFY_SOURCE builds too.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index db1ad1c1c79a..f77cf22e2d60 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_FORTIFY_STRING_H_
 #define _LINUX_FORTIFY_STRING_H_
 
+#include <linux/const.h>
+
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline
 #define __RENAME(x) __asm__(#x)
 
@@ -95,9 +97,16 @@ __FORTIFY_INLINE __kernel_size_t strnlen(const char * const p, __kernel_size_t m
 	return ret;
 }
 
-/* defined after fortified strnlen to reuse it. */
+/*
+ * Defined after fortified strnlen to reuse it. However, it must still be
+ * possible for strlen() to be used on compile-time strings for use in
+ * static initializers (i.e. as a constant expression).
+ */
+#define strlen(p)							\
+	__builtin_choose_expr(__is_constexpr(__builtin_strlen(p)),	\
+		__builtin_strlen(p), __fortify_strlen(p))
 __FORTIFY_INLINE __diagnose_as(__builtin_strlen, 1)
-__kernel_size_t strlen(const char * const p)
+__kernel_size_t __fortify_strlen(const char * const p)
 {
 	__kernel_size_t ret;
 	size_t p_size = __builtin_object_size(p, 1);
-- 
2.30.2

