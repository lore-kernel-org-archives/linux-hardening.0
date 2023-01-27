Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E6CC61DA7
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjA0WlK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjA0WlJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 17:41:09 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849415CE67
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 14:41:04 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso9345916pjs.4
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 14:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvd78EFCFTA+IoyvpWFZxccqfwJZh9nFVURaFlJtDBc=;
        b=agfLhx7DROvc8eWXeDdQfa3G6CG/v8RglC5alUEQUNaIExF6TM/WGU71dVdM4IJEd0
         Few5Ci5zn060UYf3CqDGyt5neRCLPmSFx/yk9kLuvpiQazI+aLwOWog3sSwha/TB3Fi1
         GjM7wcwP5RmjFOCgZZWJUTxvsDHcU8OL6BCPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nvd78EFCFTA+IoyvpWFZxccqfwJZh9nFVURaFlJtDBc=;
        b=O9oiGBu2Om8SLPKnJesBGS6oeLawmWDgSxYBPKiMdfg5PP7NSboIrY6FJfyT1pPMAa
         jus+8aK9XMc9ffOwdwr3upSfr1EyK2pAihvlL+0YZYY2cxcSUhVKvnjEyNvNc7wc/dms
         wdux2MhmzP5OtrFS/j4IzSbL7YPKaGmYT/uAj6yt81PKmnkYMXAe/rTPzy/2S5qVOWwb
         b3Del43qnWkuLUgthiArINzOcDpJUoAv24Y9oZlGBS71vIdRpqPwgB2rkDS0dhT5fxe3
         AHkdJLn2cSGA6zeMQ/iR57xWUP0pqBFME7kVT0+s22J/Wb+qRr2hVhuF2PdS5QN4pGxL
         Y8GA==
X-Gm-Message-State: AO0yUKUsIPm1fEx4W8dXpocKUqIu0+dWCjNFcyf+DFkvRj7TxreTTvlV
        m6MlHDVFJhWa8EKggsOj6c0/+Q==
X-Google-Smtp-Source: AK7set8qDbmK4nDzk0SW/XB6mH16v7+RfkQCuJeeUj7Hw8x0zdqfRqdvi6T5cra68wljX+fkSZvWjQ==
X-Received: by 2002:a17:903:1c3:b0:192:5282:6833 with SMTP id e3-20020a17090301c300b0019252826833mr9440962plh.29.1674859264117;
        Fri, 27 Jan 2023 14:41:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902b60d00b001947982eb8fsm1649328pls.60.2023.01.27.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:41:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scripts/dtc: Replace 0-length arrays with flexible arrays
Date:   Fri, 27 Jan 2023 14:41:02 -0800
Message-Id: <20230127224101.never.746-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1179; h=from:subject:message-id; bh=2yOxUbXEDDQUNUvJ0m5VJd/xFwDVrvCBvEeaOiE+M+o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FL+eQ1tNuRIgnbxa4cY7FJESYrqQEKN0w4GSlkQ 1l7LUBOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RS/gAKCRCJcvTf3G3AJjV2D/ 9DowDxOddhlmPIxQSTCyZoBx7SByob+UC5oA3LWWD9zPj3UGbAOnydxkhjhWNY+Zgu235VKCC7dh4h Zp7i1uMZ3S9akJi3eYmMRhwdG3PDGMAeu3i9gK1uVXfMrHhi05bCY0faVgtYdkxFsQjrbralsrL9Ez WAd7jYgl0lNGIxQpXHaN8Nkag/tW58f0ZmukVqQuC1syhMKB/n23vP0ojH4k8KJpYpaP42clbjURpr RY95xqO4cu2PwfbDnUgn5Rm0Bf88ZPu3FMabRHKMp/BmkN7BX/LDmHCXrgCFR/Tw8NUHemKfEVs8Eq K3+Sbkp7jYvobL9kw0GDOpfBQ/HvYJgdp2gBk6Akrj8EkzE3uFa6WSQw9vCms+uv3uZAbuJOXgYY7b h9UJjENffEDX8Eeay/xjtDnV1nIzL60RALSCmH0/NNc3ZQWLmYW8FBpBVlSZ08WaiV0KiMcFlxwARq imQGXxEwiSCGIyDvxm5a5fGfuzfve+YcGJx6lxiaXbo3n4XpQm689V2mBrgtUm+LZ5ywwyls05v+6q YBot27KlNHBjXCOEFMiVfCmxk6Y68MZF+iIr92iFuag7fCmcxIvBKZBFN1jI3s5Q1VSsHFf+JfssLt LcOEpCvG7UQwv8A49+STJenDtm6RaoCrE6CrabO0XQ2BSGtrWSRn3BVYwQiw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Replace the 0-length array with a C99 flexible array. Seen with GCC 13
under -fstrict-flex-arrays:

In file included from ../lib/fdt_ro.c:2:
../lib/../scripts/dtc/libfdt/fdt_ro.c: In function 'fdt_get_name':
../lib/../scripts/dtc/libfdt/fdt_ro.c:319:24: warning: 'strrchr' reading 1 or more bytes from a region of size 0 [-Wstringop-overread]
  319 |                 leaf = strrchr(nameptr, '/');
      |                        ^~~~~~~~~~~~~~~~~~~~~

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/dtc/libfdt/fdt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt.h b/scripts/dtc/libfdt/fdt.h
index f2e68807f277..0c91aa7f67b5 100644
--- a/scripts/dtc/libfdt/fdt.h
+++ b/scripts/dtc/libfdt/fdt.h
@@ -35,14 +35,14 @@ struct fdt_reserve_entry {
 
 struct fdt_node_header {
 	fdt32_t tag;
-	char name[0];
+	char name[];
 };
 
 struct fdt_property {
 	fdt32_t tag;
 	fdt32_t len;
 	fdt32_t nameoff;
-	char data[0];
+	char data[];
 };
 
 #endif /* !__ASSEMBLY */
-- 
2.34.1

