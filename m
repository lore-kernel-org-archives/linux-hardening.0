Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB61C53210
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Jan 2023 21:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbjADV1v (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbjADV1Z (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Jan 2023 16:27:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283ED601E0
        for <linux-hardening@vger.kernel.org>; Wed,  4 Jan 2023 13:21:03 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g16so27562998plq.12
        for <linux-hardening@vger.kernel.org>; Wed, 04 Jan 2023 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hfBhSBEeVR/Fn0HrEuQ880MYtC3rq93jEqLDWrIRMw=;
        b=d/ljK1xNjvnmNQPClypMY7NthrX0dJ4f1EmgRBS4ehLUulZzgPMuUxNL14jLhPbdRk
         VB0imrhMZluktlgYVbD+MPXO1MHEQ7Z0Vsr+LkXuTeneVml+HlS01FkJlcAIMVN4T7uy
         7kgwDCHGZcv9kxNJ+gORs6nIPJ7Nf2suk5LMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hfBhSBEeVR/Fn0HrEuQ880MYtC3rq93jEqLDWrIRMw=;
        b=oKc01cmx3oxKttV5UnLcZSxr7vR7ksuujr6SZXP5r2sLvO9ngU087QpU2B8P9F85ka
         YeiGdHEyezUVEprFlExLqIYsUwUwdAse8cQPUWieUZBn57aPZHO1H9U99nW6tDvR2vwv
         3JtGA94yhuR6mdgOONyc40l1AKsSGnv4dEdWy+8SU6Qoi2hAqosf0Nepw8dMbznHVdUh
         gaEkRcBGZk+VsS3dxScKRugJZ9eaWnuiaVpg7jEO+8nBJz6Vkusr1Ylfpn/V/Edovr7c
         P1LhH8ln1rW/o3iqpbKfje6lNGPVeWJXLoTwIdAayHr9kZyvrA96gE3tsWp9oHbim39D
         HH9g==
X-Gm-Message-State: AFqh2kqRMoEqmvGlVKUC7xSZQ3DGsxgBl/q/WjWSQcvCrL75lquWG32X
        gTMQb9DdRs8nR6RERtTU651fEg==
X-Google-Smtp-Source: AMrXdXsKeXGtpr519xCOW080RFZiOWAh2y3jl+hgdaKT4z5qNzxQ6kZou5BSE/2l/r0y2R+hR0AEPg==
X-Received: by 2002:a17:902:ca89:b0:189:76ef:a1b0 with SMTP id v9-20020a170902ca8900b0018976efa1b0mr46271243pld.57.1672867254539;
        Wed, 04 Jan 2023 13:20:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902cec300b00186a2274382sm24766893plg.76.2023.01.04.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:20:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Nick Terrell <terrelln@fb.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] lib: zstd: Fix -Wstringop-overflow warning
Date:   Wed,  4 Jan 2023 13:20:52 -0800
Message-Id: <20230104212048.gonna.331-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2611; h=from:subject:message-id; bh=HrYRlSpiw8NjSGyFfOnlBNqAWT9ChuUQa2gPPnHJcLg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjte2zv2TP+E05u9eD5sdJ7UCLi1M9EXgRuP8lLkxo Uy3r3xCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7XtswAKCRCJcvTf3G3AJhB8EA CCGVmAc8Aoj7WuJx6zozmcccDcX1XIx12OZxp1wjb4/PJViRqYgqenc8t3l9FEuDDrVp096BX0ZuPx iALCAAWaHIviy+r0qB9gB1VTYUQs0+LM91DKWWpVZ3+l3okrT6+kZBUr7HAZQF1eH0u2qgBwb/E8JY LuwQH/MtMe+Eto/i6E93Zgh7kKo3CJDEEi/T1H/mYpyd/pGlzYi2LZdUaZEOuaaOprsHIAzqAt4jAw a3KGj7mFh0bbsyzNMz+CEFrawOMXHTYu+YU6baQG6nOn8Fxvr8Jb4i1YH9MnnE2mFUGSR9a55xzuaf Jl4JMzphl9PvhmubtsC09JR3oUrkQRkcOeSeTiVXdLuSb/qM8D4PLafSwboZGvCD2TvcVAhkvl2ysM 4Atj8B6HNB8DEBZViLvD1qzvnwFgnIr42X1QYt1N3w9qZ5SKXEvbfChWXqkks65KYzx67SLPovV01k PrQOTqTJg77vwAXVgNHN/I7xtJEerRGkeULDmdhz/63xnnZJdd3dHwimOgi1aJR8EarsinDXdPdFe0 jbnViZrRumskAa0LkT7+GrA2k0Sm1ptN8+y+5S71fkI/vlp2KsjNkqmda6ui27VSqphwKlof2b8hyz qAsr5PaYGjYFZO0r8CL+wCipiDiXQTTrcDvMN92oFQjyDkz/Cp2Xw7zbnvaA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fix the following -Wstringop-overflow warning when building with GCC 11+:

lib/zstd/decompress/huf_decompress.c: In function ‘HUF_readDTableX2_wksp’:
lib/zstd/decompress/huf_decompress.c:700:5: warning: ‘HUF_fillDTableX2.constprop’ accessing 624 bytes in a region of size 52 [-Wstringop-overflow=]
  700 |     HUF_fillDTableX2(dt, maxTableLog,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  701 |                    wksp->sortedSymbol, sizeOfSort,
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  702 |                    wksp->rankStart0, wksp->rankVal, maxW,
      |                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  703 |                    tableLog+1,
      |                    ~~~~~~~~~~~
  704 |                    wksp->calleeWksp, sizeof(wksp->calleeWksp) / sizeof(U32));
      |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/zstd/decompress/huf_decompress.c:700:5: note: referencing argument 6 of type ‘U32 (*)[13]’ {aka ‘unsigned int (*)[13]’}
lib/zstd/decompress/huf_decompress.c:571:13: note: in a call to function ‘HUF_fillDTableX2.constprop’
  571 | static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
      |             ^~~~~~~~~~~~~~~~

by using pointer notation instead of array notation.

This is one of the last remaining warnings to be fixed before globally
enabling -Wstringop-overflow.

Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Nick Terrell <terrelln@fb.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: use "rankValCol_t *" instead of U32
v1: https://lore.kernel.org/lkml/20220330193352.GA119296@embeddedor/
---
 lib/zstd/decompress/huf_decompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index 89b269a641c7..60958afebc41 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -985,7 +985,7 @@ static void HUF_fillDTableX2Level2(HUF_DEltX2* DTable, U32 targetLog, const U32
 
 static void HUF_fillDTableX2(HUF_DEltX2* DTable, const U32 targetLog,
                            const sortedSymbol_t* sortedList,
-                           const U32* rankStart, rankVal_t rankValOrigin, const U32 maxWeight,
+                           const U32* rankStart, rankValCol_t *rankValOrigin, const U32 maxWeight,
                            const U32 nbBitsBaseline)
 {
     U32* const rankVal = rankValOrigin[0];
-- 
2.34.1

