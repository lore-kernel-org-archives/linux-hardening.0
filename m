Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F7C433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiBCRdO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352888AbiBCRdK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 12:33:10 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E015C061744
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 09:33:10 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so3715589pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 09:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MUiPfv0b7HtsA+1Jcxd4DfVz2PUbbY6hEsnvf5ttu8A=;
        b=jQX8gcsSwOP/KkAMh84nBim4wKeykymorf6yx9m/h38b779HWbddx6xXTzDoKpAb75
         nVQ5JeWLhwZae6+zxQb2tpP83N409i3WWRcHX5vCKkFgiXL9NyftIiPvIL+qIe2+zKrY
         6kxji9nYmzRSU+WUV+bq9onehswNvGSwRL7vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MUiPfv0b7HtsA+1Jcxd4DfVz2PUbbY6hEsnvf5ttu8A=;
        b=OESe6CzKMazNzEgvjzTxQ8TvolbH37VKo0o6aa6/4IcnwvcvwkMVw4CkRmiGpgQbPv
         /fBc2HIRK7GHMGpgbms9SDlSVRKoVKW+TeqsSWlmSUKepXccP3ILBDTHaykhDNjCaxgF
         M68Zf5UMvZyAkP0NXgd15dEVWtGtJM9zWLiGatLVsAJxp04kD2TzFR+N8PXcX0H8k3N9
         /RH1N6ItIUVoa6lhhsVHvAT8ldZ6hQob3vhCZDOFpg6fSdnba0EPE8ZSNvoMmw/vqkux
         B4Tt/LBdwaZxcgi5OQk2n29AFRiBU5r7cyAAT1o9w55gwdhY/vcy1nZTTt0dNQsTZaYX
         rzrg==
X-Gm-Message-State: AOAM533P5cGWdcqm2qFcKC7Oc7X7zYHZUsk9Qp/5ftaoiXBLYB1lXt9u
        h4JrRwclev7yCQZmrXatTTfm1w==
X-Google-Smtp-Source: ABdhPJwm1hJ64GoD9Ys8S1VDk2Ymu61lFup/+cIM4lzAuJOKaqXIk0DUkZSlFidJmOUh9Hqg1vGtlw==
X-Received: by 2002:a17:902:7d97:: with SMTP id a23mr36351894plm.92.1643909589655;
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb3sm11414786pjb.47.2022.02.03.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v6 1/4] Compiler Attributes: Add __pass_object_size for Clang
Date:   Thu,  3 Feb 2022 09:33:04 -0800
Message-Id: <20220203173307.1033257-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203173307.1033257-1-keescook@chromium.org>
References: <20220203173307.1033257-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; h=from:subject; bh=4kvv64bSH/70KUK07qLc8wQXlhwvQ6HObY6O2DORONc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/BHSjG3rQ/CXubaKddHLMHMFjiyYRstsDgXydL47 wn/JpEeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfwR0gAKCRCJcvTf3G3AJh/yEA CxCjO7ReiNJg3LHPAqDhDOOCqIutYxL53os7hP2tTYD942c2cdT1Qu6VZNnwNRaRUNPiuo+UcKUgzX MqClYq+59CuiJr4gfKJyN0ixxXMuC7YEghZpE2sJnWSGRaRI7XUDjlDnYtdn9sW48QUDfr0cySO4Fd xJ7lY93vsK51fYyRcCGNX0+AGfqa+Q6I0vORoo1WnyhRh50sSfETEEtXM4H8FDqZ8f0fnldWuZKc1N NotoKcD3pvIe5pKTWWxvTyxe9vc1wQtbyWevg/uFVx35supMhYFgHlAxCO4A7in5wBKwH+SBB56x2B 5aV8yQ17ZpKOyLfb8KZG7ZD7mIpOWcsoFaRF8wNTanonUyRuDlToGhRaskCPAjaIXvpeZub+BJGczy 4/Q8LOoJHGu8KQqKNvmDbzZp0xtvatffWwty+zBcBukYxgauzeA9MJdeEJ5HsZFEKKcCJa35indnoB s1SsYtjfMlnlajZ2Tpd43Ys1Ir+mOcbe4mY/j0FuY5cjzit3HBuMv0afU1cgqwsYDx46hwwNJQJ5ce QH5fBHLI7oxky0aDplTKbq/41yqQiH0Z3FQASlOZHVhKkdln4gGoSGrDFP9vuu90k7Gcfph47fcleZ F/8Tc9qTDACdqzb08XSs6+if8D6I8LClaqvaXkPkvAYuEhQ8fHYxSOBSJ8RA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order to gain greater visibility to type information when using
__builtin_object_size(), Clang has a function attribute "pass_object_size"
that will make size information available for marked arguments in
a function by way of implicit additional function arguments that are
then wired up the __builtin_object_size().

This is needed to implement FORTIFY_SOURCE in Clang, as a workaround
to Clang's __builtin_object_size() having limited visibility[1] into types
across function calls (even inlines).

Since any usage must also be const, include it in the macro.

This attribute has an additional benefit that it can be used even on
non-inline functions to gain argument size information.

[1] https://github.com/llvm/llvm-project/issues/53516

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 37e260020221..4ce370094e3a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -263,6 +263,20 @@
  */
 #define __packed                        __attribute__((__packed__))
 
+/*
+ * Note: the "type" argument should match any __builtin_object_size(p, type) usage.
+ *
+ * Optional: not supported by gcc.
+ * Optional: not supported by icc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#pass-object-size-pass-dynamic-object-size
+ */
+#if __has_attribute(__pass_object_size__)
+# define __pass_object_size(type)	const __attribute__((__pass_object_size__(type)))
+#else
+# define __pass_object_size(type)
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-pure-function-attribute
  */
-- 
2.30.2

