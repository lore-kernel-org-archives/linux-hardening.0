Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10483C433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 19 Oct 2021 08:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B8261212
	for <linux-hardening@archiver.kernel.org>; Tue, 19 Oct 2021 08:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhJSIb3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 19 Oct 2021 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhJSIb2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 19 Oct 2021 04:31:28 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555FEC06161C;
        Tue, 19 Oct 2021 01:29:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f5so18648303pgc.12;
        Tue, 19 Oct 2021 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFr6U5adp/cpEW1jFDDWLEXY0Sj6xHUTx2NxqyNWcP8=;
        b=BwBChJJ/ATDvXTTrXEPaR8EyXhyVkkIxN1rsIrWDOYca5XQeUXWhs5b9LsWuvVrwRF
         u2t62KFJiAeWYdiKCk67eQVm5K5mYi/FUy9d5Zjieit5Q5FfkG3yqXW4+XtHPFQ1kzeg
         V+WxvhKNcBtK8AonRyevSbxGZ+nS3Isuk3u43aROJ3T8gshMrbOAMfxTSlHRaUitzB65
         nwCnv8SwSQlfn30uAYmNsQaH03UqVf3snhg1VTn+zKcP73442LdvQvu6G7KuFwkcn7SR
         pEAW3rEy9KB4zdOjrQnvqpqfrhEhudtPPphXkYd5Fd7kyVrp9EW4cRKgMAqYQ1qcqD2m
         F3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFr6U5adp/cpEW1jFDDWLEXY0Sj6xHUTx2NxqyNWcP8=;
        b=vXBSiuzTBkKBssH8WQtBgGybOkjlsOCO2zIyeJ5DnZL/stweOfiarS/nXxyjmlCqEr
         UyU+ocqABTaxz+KoykKP6HkVX7miXKyCqujE5JYKKS9EAh5FaMyE80ynO1qXwcDbfwFX
         vr/o206a/SSBWaGk/iMlS2q7MGHIOvfOb5dmh6XYnNefGkG7oY1Hx79yGXaSjhhhzkkV
         49VfaSoo3+Np9lEJk7mgH/Rz2pgOcqr4rML5QkcrWkSsI+Hv+S51WrrIctECdda2Tnvy
         7+5m86vVX9oKP8MhccLrZ5La2imsaMH/b4iJJlzbWhiLaJ9L7FbUFNXvTTHufWB39r7W
         g/lw==
X-Gm-Message-State: AOAM531ExwMj3bK2ZiiUV/i2+M7NMlvztF0yPwTdurs1ugJ1RxQJsArv
        pm0vpOmRejkn4+3wp8mzJYU=
X-Google-Smtp-Source: ABdhPJxCz5RoqLOp1WigJZ2UajCah//FfCgUXuvSNjzwPHLFhHtyPlR+/CrDOl6JqLHJXO25QUHhRA==
X-Received: by 2002:a63:4c4c:: with SMTP id m12mr3878079pgl.171.1634632155717;
        Tue, 19 Oct 2021 01:29:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ob5sm2035231pjb.2.2021.10.19.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 01:29:15 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     keescook@chromium.org
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH V1] gcc-plugins: remove duplicate include in gcc-common.h
Date:   Tue, 19 Oct 2021 08:29:10 +0000
Message-Id: <20211019082910.998257-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

'tree-ssa-operands.h' included in 'gcc-common.h' is duplicated.
it's also included at line 56.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 scripts/gcc-plugins/gcc-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 62bf1c07b8bf..9a1895747b15 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -86,7 +86,6 @@
 #include "stmt.h"
 #include "gimplify.h"
 #include "gimple.h"
-#include "tree-ssa-operands.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
 #include "gimple-iterator.h"
-- 
2.25.1

