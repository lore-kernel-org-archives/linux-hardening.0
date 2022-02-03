Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4BEC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  3 Feb 2022 17:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352894AbiBCRdK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiBCRdJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 3 Feb 2022 12:33:09 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6FC061714
        for <linux-hardening@vger.kernel.org>; Thu,  3 Feb 2022 09:33:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so10695327pju.2
        for <linux-hardening@vger.kernel.org>; Thu, 03 Feb 2022 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+zBssxH/WxmaUO1sr/ghPwh4fL8f/bXW9MZNrOKPr/w=;
        b=oHqJMzOtTUhUby05qTiPD+GwE2p690AUteZEv8NOXiqzXdXNe9W7NYPJF7Fdhhy0d6
         HrbpsdReZ8syYLPk1n7PqQX0GrdwxvuhtNFpIWiQQ8VoJYKpVRr/YxdoyGUpZA17rTWO
         x1c2kkxyfTcGDUI6iBxO9lRGNTqe/95y+6LxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+zBssxH/WxmaUO1sr/ghPwh4fL8f/bXW9MZNrOKPr/w=;
        b=2mbqcMCCFSioa4/gEEzTiB6gOgDBH9Sl4inc3ohAnXeUKl7CQ2MPQtYdCXg8GVeB7X
         bxeI92feh0dzrJaulrCNFi0Y85s4EFrlxWSvD8JRw/iOcUf4BB40kcwJISIP4IXOehlt
         ihVcDqbe7AQPGnNGVXmOaDMlTKEXwZz/JKJVnif/Ny2ZAdh7Qy9Ctf0zIewKpWmJ5EWn
         qjTWZc9aOH6c9bIpBHWGobZYbGGPS6nXyHWouV4sG2yuNbzjStyb8tYuccZoxVo9/4yy
         EBKQ8KfJ++canz6Rsd7JoiQemZeXygb1YcYfXGl1/Hgw6y2rhuxDEiKYW5HJvlCEEpH/
         Sigw==
X-Gm-Message-State: AOAM531pc7W8awaJt51ghnZV+H8ssqQnYz9NoFHWsRXMcCgS8lDbfFCD
        eHri4iyDI1SrM1p4yW1gYuUgEg==
X-Google-Smtp-Source: ABdhPJwZxP5UEfB4voCN4yq/C38B+fyMmytMwS4/oRagiqzmZRs0yri0Cci2rcPZ2J8Oe8mJzENBOQ==
X-Received: by 2002:a17:90a:290b:: with SMTP id g11mr15030650pjd.8.1643909589126;
        Thu, 03 Feb 2022 09:33:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18sm29724557pfk.14.2022.02.03.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:33:08 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
Date:   Thu,  3 Feb 2022 09:33:05 -0800
Message-Id: <20220203173307.1033257-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220203173307.1033257-1-keescook@chromium.org>
References: <20220203173307.1033257-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; h=from:subject; bh=KMIyemBEeogv0prZ4PjXHBrE0psPPqx5j7gZUW7T9OQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh/BHSjKRmsjxgw96UF0ULSGoSRDajl4PKbrjZ5H1m qvM6GwuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYfwR0gAKCRCJcvTf3G3AJvp+EA CHifGQYlU/vyOgRTFiBUh2o2UcOBRzjmfvCANd+VySak7rvfpyLFYaD2b/KZR+bvpMIwxmKKRMVMgA bcOzv588jJFGqgeabG/ez2ppSc31+DZYscdVT16K5tdTMd56FsbYQWsIauZGy25an5pOe1vdX7qUdU 96CRYKYktuZCj8rLFsN/2ptyObfY0ZDMWx+oY+uT+eQJsk7QICGaycui8n7ZDF+umQ9bXi34Vmm5a0 iq48nXsnOXqWLSFXEfl23DrXjOWRxhf5IMrwX+7pHvxfE1IXC6oTk+t5Y/LqAirc5OqBEUY2kxS94Z 9nblGXGO3EDSh3DAFhTGUqNO/LdU3HuyFeVau3TSCgD2MFV/kePGim0QGn7NTrvbpclEcBDeV+T1cL uqNDvQsvJ2O6c25GtWehSZWPsb3Q5Sn7oW541ZBfAIUZtAz8tT+8AhYQY6rMcJr10BYH7euQgiYSeH j+rdQCt2ux5XL93GfgjCOaeXaEOT2dPN1hm+mcMJksEY1pG2ZoKsDvrZ2Fl+w0tofWJhPpsN6tbmrj 3yojOjQnE0K+C3p0otFZulTm2JsRe9FUxfV/c3Z0FAKDpaea3BE7TjonpuMsJ4HyockIjz+Fv8dJl5 0PPfQL56Ph+nm9i3dFsl0YbJgHJdaKyCmsevhv8YZEyzCZ8lSXCy6HO38Rxg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In order for FORTIFY_SOURCE to use __pass_object_size on an "inline
extern" function, as all the fortified string functions are, the functions
must be marked as being overloadable (i.e. different prototypes).
This allows the __pass_object_size versions to take precedence.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 4ce370094e3a..dc3bf2a6e1c9 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -257,6 +257,18 @@
  */
 #define __noreturn                      __attribute__((__noreturn__))
 
+/*
+ * Optional: not supported by gcc.
+ * Optional: not supported by icc.
+ *
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#overloadable
+ */
+#if __has_attribute(__overloadable__)
+# define __overloadable			__attribute__((__overloadable__))
+#else
+# define __overloadable
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-packed-type-attribute
  * clang: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-packed-variable-attribute
-- 
2.30.2

