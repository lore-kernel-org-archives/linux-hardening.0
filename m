Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA89C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 05:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiBXFko (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Feb 2022 00:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiBXFkn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Feb 2022 00:40:43 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BB7253BFB
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 21:40:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 27so844627pgk.10
        for <linux-hardening@vger.kernel.org>; Wed, 23 Feb 2022 21:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUrjnSR2O207wl/KgPF4WFxzn/5+qyXjBbdrgpn74ec=;
        b=Zcva9b79EO27FMwaZqhkQmi2C3qXN1cjHhc6RAFneX/fNCPfxov3sHq6b7HNY1rauX
         6dLQXz99cSK5012k50Rn4vOaEFKP1Zw9ZynrshJkBNT2ZZiKVundssVvLLFocPhqce9p
         gys42g6Uz9gOskZuIs896Iv1zCZThSQLt7d0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KUrjnSR2O207wl/KgPF4WFxzn/5+qyXjBbdrgpn74ec=;
        b=x037xGauiU6vdr8Z2kYXAOfOX+5khbBf+pq9AzWmK8A+SmuhNcAPbwP21Vput+pXlb
         Rmxg3v3vxhrkAF/DDWl5y3aqduOYa6UrH/vONt+RdQ0Rki4I3wlEwSUDBv35SGCQNPWB
         IVj0KELH0ous1h0T5zdsoX7SEu3ZnD6ogY8wW5PccrZvbK7zNDlHq9u0qVlbzCq9i3Ue
         r6fueYyIYR2/WJ3JYB9N/IeN7R9QBQMHyorMXNie4Z7MZoIdPLkH6kf11IRKrRCfBRrR
         GOG9GzYbBy7L39+dyhmFGVCEaoQSKT25Sb6jokuEbqIx9D4iueLCw/d2fs+clfmj/+4+
         O+0A==
X-Gm-Message-State: AOAM530bL9gCUDT0Wbnjvg/BeftpdZSNlYXUuvv1tIpOgyWfqNcmIe2a
        ZxMdVZhqMFrgErG2sK6CyS0P7A==
X-Google-Smtp-Source: ABdhPJyJTZwbrBYIgzpKU3TSYvloJombRvUFLeu3xy1uW0E6d/GTsYL7IVSSKPu2DJeUDlfClhY1Lw==
X-Received: by 2002:a05:6a00:148f:b0:4bc:fb2d:4b6f with SMTP id v15-20020a056a00148f00b004bcfb2d4b6fmr1213264pfu.62.1645681212842;
        Wed, 23 Feb 2022 21:40:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm1448848pfu.79.2022.02.23.21.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:40:12 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ELF: Properly redefine PT_GNU_* in terms of PT_LOOS
Date:   Wed, 23 Feb 2022 21:40:11 -0800
Message-Id: <20220224054011.1852264-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; h=from:subject; bh=YPig1YOT1VAMyQwHwKMHLoGk8gDQ7+8i5Oupd/upzAI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFxo6UL94HlohdKVbWsom4kOiCRaxulVCwE/ewmxB IK6bY2+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcaOgAKCRCJcvTf3G3AJuw5EA CHaz3ExoZEfKFLE5GrkSqVhaiRerpzFFMZsQCgfdu/v5FyREohk7aJLs6wlN2QTfF4KJSgyWPHjZTE ypwcVnsGs19FUCVge376LOqDNQ/oaCdPIgOzcEnIT8dGvMtJjCljG1MTs6cbA/EvYeQjIN0xOB1obx aSiHROgTHk/M0ICsMsDQ1iCAEWzZIQ3pPHwqQBPKQUHKoTDWiCq6uIgjUzWbiedr4f39NHEQnohiVi Ec4K3KIdKDLMiVHeTlTmBzf+TlciIJjKeDwlpiItZJR6ycacCU0AaYO+slSe1j7ui1fdmOASjEXh7a GbjxKvXwRX2mBv1rgAvRnMoEQHq6xyIOPWo/19NG0YCymkRdfBCKJvpYaGPibsHZiQjY9siVRDRtuP kGNNRLoBrrnVcl2Y7pwt1zBbTYRjFNzbFUNJHnptJjHoUBmsgBmnXnR7gyYGtqpJ/ho8GPBTryAIrw EmsYyEAlfFjinmAidjZnsAaCIFzFOq12AJb/kwya8XbeVkcphs1rCZ9svlXnA9RRHs7Bspoi6tv+4+ 9LI7OE0HSqjWlTXrxA8r226/3HpMmhRNbn8LV+AWtqHU8TXajNJ8CeHL/0AkVsYF2jmG5NPsJIMPBu +S/pg8iXlt6zhnUPhwXyO/hI7Z1vGoXz5KY5k51PAHkPsnoDjr5Sf4rBmTwA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The PT_GNU_* program header types are actually offsets from PT_LOOS,
so redefine them as such, reorder them, and add the missing PT_GNU_RELRO.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/elf.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..6438d55529bf 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -35,10 +35,11 @@ typedef __s64	Elf64_Sxword;
 #define PT_HIOS    0x6fffffff      /* OS-specific */
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
-#define PT_GNU_EH_FRAME		0x6474e550
-#define PT_GNU_PROPERTY		0x6474e553
-
+#define PT_GNU_EH_FRAME	(PT_LOOS + 0x474e550)
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+#define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
+#define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
+
 
 /*
  * Extended Numbering
-- 
2.30.2

