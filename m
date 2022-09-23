Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98016C07E9D
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Sep 2022 23:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiIWXy2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Sep 2022 19:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiIWXy2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Sep 2022 19:54:28 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5868E137E52
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 16:54:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so1612352pgb.4
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XZgu+4WTEVr8tsHAkmjkN91xmzCAu9lFrz5OWrjxVlA=;
        b=N9d46R2OydsCwvysTY6wI+B0RBRTzFbm7zSISZ+XYNu7zgaqRypAsrdD7x+CGE0evI
         z//2LWAPTDH8rv12vaxvJW9s2y1YwJcSl5vuQopFZSu8kPCZlnaXNF8rEhaIzNC2lOC9
         3BR7Qd0tb3chVfZbDDzmuyRoBpLfCERw+jcds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XZgu+4WTEVr8tsHAkmjkN91xmzCAu9lFrz5OWrjxVlA=;
        b=5/woBMsrK6x3ytzIxjpKXyLVbmJ1j6/3uBZ4dsiOIILu3nIHyqneiTYMjmqVjiDF+x
         gY/TbDXgDXbN5Mgqm1926fNpGynFSL+1w+E1oRV687a3m1oVAYmkVWdO9161MNGAo6eG
         Dthw88iT06LjaPnovjl57+6uMTOQb2M/u7CXuo2ZfjzlqG1ejlpkYq5ORUXlSG/zlSA6
         3IexSKT7LKyxWX7HX6fX3h4zpKWTVSAXYElx1LxxCwBB29pbaWeyPw76BrkZmbj0WC1f
         i3MmkIImQ3JJe4hrp2XnFKLer5z8trX1bqlspABVvoOuVacjxxpZeOMGmw1dIIqgWNM+
         sMDg==
X-Gm-Message-State: ACrzQf32CuRm4OyczSFwFZ+a9yS0ubjChpD/2iY9QmsytJEPyeTUSFk5
        FwiGuAGOSBgYRMCp9N9PmashSRZLd0lr2Q==
X-Google-Smtp-Source: AMsMyM6MYUWhgvG1ob0cAa+4DUrHq6mbb4EknUl+05Il8WDOxlkYip+kT2Xi9KFXMpdOlI775uYW+A==
X-Received: by 2002:a63:cc43:0:b0:43a:2f12:d326 with SMTP id q3-20020a63cc43000000b0043a2f12d326mr9707289pgi.320.1663977266882;
        Fri, 23 Sep 2022 16:54:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7961d000000b00537e1b30793sm7097955pfg.11.2022.09.23.16.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 16:54:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Compiler Attributes: Introduce __access_*() function attribute
Date:   Fri, 23 Sep 2022 16:54:24 -0700
Message-Id: <20220923235424.3303486-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2374; h=from:subject; bh=2w2oy8m3RymOvBpsDwpOU5cXBF7PtcM3RxTXIn2u7x8=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBjLkcvkBRDe1nEBv5NJ3db3NwuBfc73EWw6zb2nCCc I+BDuwiJAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy5HLwAKCRCJcvTf3G3AJpVcD/ QKp+uagSNwmLWgpC1z61wlgg2n2ekVNehID2Hqvt19vxT1Q7aX9A9n0OThZ5scbFrof3HqYiEYDNkU x5TZC3VMdLZjiWb2u4qAnErG1QnmIdNMaw6tNachIzNuf8+/fcXqH2RRn3+z0NE5lCGE80ROxWIHyz FCLhFGGMdd64ydbE/lyAv/xKghoP1DDVVUIrd4pzcc6xEtQByTo9SQN/tSiWFfxiRlIhcDc5I4BLBr RIk4A7Gmu3OXCEzRJSg4JFJ5/2MlyVY41qgNs3iVLS8iWp10n3CrC7hrKAiYD+nYKJopIZZvLWHqaX LUau9cWVhSM4pNia4Th+Y0sHq63E8ASD5kS5i+d9tfvlSuW4pvDLn/arJdzPIAh0VBH8ZvL3YPMsDM N+yt67Zj1MqrIrG9fdrtWmbXK93vy/UK2IKTe6YajKjf6LH4eED1DAUcSSliZcI1YvsMJyexiO768O BDmYxNxqczq1O74F1Qg2VgyM8kwaRWADTVMk+7n67/j+agb70CQNyXflJmUI3+XHMkPa+4oF2XNbAH fwvbCXVhP63XZmTXoQH9wHZRWnxIkl9U9s1AqOr0ECpc6iK6nEwiXg8vqJvgMVPzxUzlgHsvGyv10l NU8u8yVI89mtjDmmlmGNKkS/4pM4Xbgtw3Cece3pAt9KCa+Iew/b4hj53K
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Added in GCC 10.1, the "access" function attribute to mark pointer
arguments for how they are expected to be accessed in a given function.
Both their access type (read/write, read-only, or write-only) and bounds
are specified. While it is legal to provide only the pointer argument
position and access type, design the kernel macros to require also the
bounds (element count) argument position: if a function has no bounds
argument, refactor the code to include one.

These can be used multiple times. For example:

__access_wo(2, 3) __access_ro(4, 5)
int copy_something(struct context *ctx, u32 *dst, size_t dst_count,
		   u8 *src, int src_len);

(And if "dst" will also be read, it could use __access_rw(2, 3) instead.)

These can inform the compile-time diagnostics of GCC including
-Warray-bounds, -Wstringop-overflow, etc, and can affect
__builtin_dynamic_object_size() results.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 9a9907fad6fd..6f3d40f7ee5e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -20,6 +20,22 @@
  * Provide links to the documentation of each supported compiler, if it exists.
  */
 
+/*
+ * Optional: only supported since gcc >= 10
+ * Optional: not supported by Clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-access-function-attribute
+ */
+#if __has_attribute(__access__)
+#define __access_rw(ptr, count)	__attribute__((__access__(read_write, ptr, count)))
+#define __access_ro(ptr, count)	__attribute__((__access__(read_only,  ptr, count)))
+#define __access_wo(ptr, count)	__attribute__((__access__(write_only, ptr, count)))
+#else
+#define __access_rw(ptr, count)
+#define __access_ro(ptr, count)
+#define __access_wo(ptr, count)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-alias-function-attribute
  */
-- 
2.34.1

