Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53283C7EE21
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 18:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjEDSQt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 May 2023 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDSQt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 May 2023 14:16:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E617A5FCC
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 11:16:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab01bf474aso5982045ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683224204; x=1685816204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXQeNTUSEong62Vror8xVSChXRwu6FtDvEgec06owZ4=;
        b=J1WWY+i7jhLBegYr6b6HmLGJ98kfTdbFbhvJhjuv9qMeBQnoiq9Dwhnf1r7g7oIHHZ
         uZUzKphZeq44jGeCDhzpocsJqipArAa7BssFqcDPedphXgtSDszXlpgDu+2iUCvPJHtI
         JtXIm3n0eN7gTTmDasV4V+hwXDyQU0Jbanqpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224204; x=1685816204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXQeNTUSEong62Vror8xVSChXRwu6FtDvEgec06owZ4=;
        b=iy+r70+hihibU3DFQg4Ik98PKTu2pUQIRsaH0KsODJkLyoFamVe6We5nVNReKIkAHn
         P7lzLv53qNB75KsEBKkuIYtUsFMDLfluJuDFutitI8gfiq9IB1nQaBm+IfBv1aN0S0lD
         io2rUeFzWQjS0yQzVuoN3Ao7ExP0iFj3T9EnvcVE+36shS4qQvfcTDNxgzGuf5KPp39u
         uJ2IYlYripUHYVZn+13MD3v38VD+rH9VSrVMS7EiCYY6PLQlaWZpIsyul82T+rHL7FAE
         DeyuBOMA1PhVXMxxg2wD7j3f6+1kcxUkp0yIrBLGyrLNLk+VQ8nPvTcaj6xeObtW9ccZ
         87zg==
X-Gm-Message-State: AC+VfDzjG1jXBf3ji4dVfyrjg+Z2n7uCXAWlwHq7NDbHPTA2j+GBygth
        MjhSe682PCyYLRxenM666wHu0g==
X-Google-Smtp-Source: ACHHUZ4t4m2KI1ZZpb74ZUMtPcgcjTETqeooPsztCoSk5Y8jFEBVg3Mc747ZgM3jhekYrgAsiIVjvw==
X-Received: by 2002:a17:902:f546:b0:1ab:665:c152 with SMTP id h6-20020a170902f54600b001ab0665c152mr5709411plf.2.1683224204376;
        Thu, 04 May 2023 11:16:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902a40100b001a95c7742bbsm20776082plq.9.2023.05.04.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:16:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Bill Wendling <morbo@google.com>,
        Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] Compiler Attributes: Add __counted_by macro
Date:   Thu,  4 May 2023 11:16:40 -0700
Message-Id: <20230504181636.never.222-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2109; h=from:subject:message-id; bh=ZZVhkccqX0gN2ZpOQzLw0LgD5LDDhdJ0xAF81wHxMcM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkU/aIn4jwQLsifklJUZJmvfhIRBYyZ+lsu/IPOgfg mLn3cTmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZFP2iAAKCRCJcvTf3G3AJo9aD/ 4o4NOVJZWnBsCZtrAcyzbyXBYf23SyNb1UXLrLwJnaG9eMfmrKcfCpacgb6MNkUgAJnL8F94VWd6cN EsN9zHk05L17yhEXlR8JoZyrd0OVuHd1UW/gkZfxqgCaE7STq0MrlmB4iv1z6nGlQW+60P8xAwsaI2 QEK1tVRy4kGoM8b1fTsmjl4zEjf2MwkDHR40lawFik+v1kXSxozZ/JqbyL8vvRx6ZQO9oMA6Zs3Cvu v++PwPb8dqtjSiGaA/5XYMsLeWjTdBarFqfXR1X2jCE397GHDdrPM71W7/v/zFBq5e8lyo42Y7J6PQ 4ly8ONkbZE7vuxccHrLrOjRcBEBy/R7DEmdEBJCa0vvHJDG9kb/M7DHcL5l0DjhcMG1ozwIspLi/+R F21y4cCHNljg2jnl2NlgQwDNpkK2awo2GKKAXOslngDWb30/7JVFDvgHvjf2YdqdXxQhIrDpPgWXE6 WOvMGbOcO5Q2PQzvfWQ6o3MvH1qB43X/kyMAt2jGgKzLl4x3Wo9Tuym+lUpbn8zdTxrpM4BS4FuwXb kz/LpHXzKCx6Jtf7O/Sc17PwCk0YB6K41UiYdxl6UE3CW303Os2MOHJG77pyAqgrQCwLIBIMCmfGUV JwETEBb/mBuvfd4ssqpUc1uV96cVJJcL8aEOscd9qEL7HAMmmzRhMVV4iRZQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In an effort to annotate all flexible array members with their run-time
size information, the "element_count" attribute is being introduced by
Clang[1] and GCC[2] in future releases. This annotation will provide
the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
to perform run-time bounds checking on otherwise unknown-size flexible
arrays.

Even though the attribute is under development, we can start the
annotation process in the kernel. This requires defining a macro for
it, even if we have to change the name of the actual attribute later.
Since it is likely that this attribute may change its name to "counted_by"
in the future (to better align with a future total bytes "sized_by"
attribute), name the wrapper macro "__counted_by", which also reads more
clearly (and concisely) in structure definitions.

[1] https://reviews.llvm.org/D148381
[2] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Qing Zhao <qing.zhao@oracle.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Cc: llvm@lists.linux.dev
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index e659cb6fded3..9d63fe2024d5 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -123,6 +123,18 @@
 # define __designated_init
 #endif
 
+/*
+ * Optional: future support coming in clang 17 and gcc 14
+ *
+ *   gcc: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108896
+ * clang: https://reviews.llvm.org/D148381
+ */
+#if __has_attribute(__element_count__)
+# define __counted_by(member)		__attribute__((__element_count__(member)))
+#else
+# define __counted_by(member)
+#endif
+
 /*
  * Optional: only supported since clang >= 14.0
  *
-- 
2.34.1

