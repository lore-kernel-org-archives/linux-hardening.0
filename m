Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55673C54EBD
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 17:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjAMRpC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAMRoh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:37 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E314D801EA
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 09:31:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9so24089030pll.9
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ajo4CWXsqrUX3ohXlBgBJ+26DhK51lKwOhdTubtp1w=;
        b=Y1oOYqzI0RHDiNGu/mAaa4CrQgYa0yjxlmFCX7cKtOZFCdtQXEHoUM39Pt8wsk4NOT
         tZWt8fmmpjLzGI5OGAhKKwByKjmS/aEplehloP/sREnFbbWDTkd4da5fc3OfELLfunN3
         Nzvt2QYmMpcds5Wt7ZBK7k0vPoTYQ/2u8mgCQFn+7iw/OB8/9XXKgZOhFaWTDuxkiOK0
         59GIxncoACFjSq4biZhJNNG8QHYhTPttvOeI0bYOn1TQ/yjdq0hEOWYXOgAM3sGx9QHR
         AcKFmnKDpQGDtrLkE7aKStuMwf/VqvTRgkoLz1oQJ0bgPFh2N9Zpx/7uacJYInhHEY3z
         H7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ajo4CWXsqrUX3ohXlBgBJ+26DhK51lKwOhdTubtp1w=;
        b=BIaeEqlyuyWoqzeLWCp1q+NewVlVCvEhpsqbzxdcXMK1kZV1+gGSBBGhJdCcwq1Cgd
         W3dheRswoDzt8OMdvdmH64jXOOZr8ZuS4lPPAp2fqjpB0+I+PMETQIdcq7NdiCpzt1f5
         xxklk0PBFcWdTnWHE2H7/rjxWYKh+fVggjrN2IO3pTXLYSI5QxR0IdebVGfZ94aBsZ+M
         /bmStpE/dl9fkV8sHidjG5ZtgxIk+9KSdWYJ9cQ0mGsTz6Y3R9gBLIcLCXtHnsSxtwKv
         8U0+Is5KfZ4zSVXOy5lwp2SspMb68iv+8Qzl1wH6TaHDnEmycoA0AtNRoVM7laiClAJh
         LsUg==
X-Gm-Message-State: AFqh2kq9QTJaUCdwN0lWtRO5+K4oPcO7uY9hNLtuomFPGhVvavD8jBLE
        4KTMyO7kxw2CUJ6+11I+o+lCzTXU+/wxu49C
X-Google-Smtp-Source: AMrXdXtq0KqJCC/8WUZ4V8rO6nzK5QxkOTH+IcmgHZYLtCiymWG6fGBh5hTBAc4cR0Bq5k5ctok6RA==
X-Received: by 2002:a17:902:ebca:b0:191:117a:414f with SMTP id p10-20020a170902ebca00b00191117a414fmr94043643plg.27.1673631115023;
        Fri, 13 Jan 2023 09:31:55 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00168dadc7354sm14466494plg.78.2023.01.13.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:31:54 -0800 (PST)
Subject: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Date:   Fri, 13 Jan 2023 09:30:33 -0800
Message-Id: <20230113173033.4380-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     keescook@chromium.org
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The upcoming GCC release has refactored the gimple plugin interface a
bit and unless gimple-iterator.h is included before gimple-fold.h I end
up with a bunch of missing declarations when building the stack
protector plugin.

Link: https://inbox.sourceware.org/gcc-patches/CAFiYyc2q%2Bc-0uZb-zAskmR_U%2BM%2BxQfp-W00ZbLErfjx=j5qHGg@mail.gmail.com/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 scripts/gcc-plugins/gcc-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9a1895747b15..2c3a3079128a 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -72,6 +72,7 @@
 #include "stor-layout.h"
 #include "internal-fn.h"
 #include "gimple-expr.h"
+#include "gimple-iterator.h"
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -88,7 +89,6 @@
 #include "gimple.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
-#include "gimple-iterator.h"
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 
-- 
2.39.0

