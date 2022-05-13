Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9141C43217
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384151AbiEMUXO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384162AbiEMUWv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706D158F8C
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g129-20020a25db87000000b0064b0d671050so8180379ybf.6
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dlbVbF+zSH65SmcGkXw1HXEqEtfYUZQQn63+I2niGUI=;
        b=suo26qtPRItoyTwDfbbz3LASboBjKdoSMFI8aXUKdlLp7CvixfOiS0uW8H0gGPFal2
         ufgd4A/bFbLLb35MHsIFdaYntoAIZwz2uyf3z8bMRt81n9k1SU3nJTLVFvOQgb2SG8Fu
         bxKBgJRrvLFgiFjcPBc5Ql/tiiDyCHMFHdMWHyl55ksvDj3IxU5xl8BS15jw7IGglpoD
         rCWQ6dehGYNUVVdSLJleQQBFDeVcxeS2wdMj89py0SHeVj1/phR+9VxOKeAhx/R3o0y3
         dxmzZBsr6Kb5ReKmsDe4eAPOCfkU7q2HMZmt2/P07pSpGYOWb8T5SJmlzQByOBASF86u
         WdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dlbVbF+zSH65SmcGkXw1HXEqEtfYUZQQn63+I2niGUI=;
        b=2plpicpZwgYJHKXdHh4rCx6rgH0ZO1j/fYJESjBABImmNGj5/9bTpN8YIEBJfOLfZb
         7B4lFtdA8KzHZow5U9M+CbgsejF2Mi/HnxKeLGZgRjozFCbmu5yLv9ZWLtRv/9yZCfTB
         9ji/cLssaoHT5yISlDoQrr3VmscEI7MPqk6O02pnDn+XHQcTibotkT6DxLF4z9cuAoQe
         kYdpOg4oVS8xKxZq5GktsPq66HFkSWlenVMrh7r2IxIumMbCJAdzIkqa8Ycx75tfNgnz
         CMOqORZTbsnFe9jy4uOZZq+pgz5hmC/VNoqVIwb5Vsqsx4cVXTi/Zisx9OGuVzpVg1Ze
         45sA==
X-Gm-Message-State: AOAM533Zr0xL5uChDOJ5Tff+ZOurtNmds50ucY+zjlefREuBSWg6Vl0G
        U+/O+icmRXf6qnMq3Q0RqfSoZGQYTht9c8xOCWM=
X-Google-Smtp-Source: ABdhPJzFM48oKh50rHebCrOHf34tcszegLHZxSEku5WBt1TgwOcHyEAQ0+hAqjBZ97NekznHKYIzAU+Im42Yn+P0SW0=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:3441:0:b0:64b:dc55:bdd2 with SMTP
 id b62-20020a253441000000b0064bdc55bdd2mr2715370yba.75.1652473369915; Fri, 13
 May 2022 13:22:49 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:59 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; h=from:subject;
 bh=EnKTZWbwTuwhGtVwGe8P9VjRM8gy1nwr12ORzB61S+o=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3mfZ8/2S8lWN4wX+IbgzR7T53VLtyDzI5tt2rz
 WJL+EaaJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695gAKCRBMtfaEi7xW7pVmC/
 9a3zu00Ju5TXxz0xiUJonHs8P0BGs4hr5NmWM2GMbyFjujv8hZeNGa4mbYKHKM5PCQQ5gvZgix8xN7
 pycP7Dh2F7rK9HP2Fk6aH55ONw1ChCEHEzVNMB01KLR5+6/b4c4y7TCE3ZD3mF3h76hXjR8das2Zy8
 /l8yvdEZQEHquOWm1zBiS8yJvQi3QiroJFJv29MfZwGqv77y80QGHlf3OYSNsl1cli2prx6ZgDNeja
 U700rcBs2hsB/3Idgu5rWH2o1LwNQhhLXRSSPCJ+RDTgVj3o3z2qnQbJNcqWpzelCvO9OedQQVoUBc
 ijxVLEzzl1xpeBdNk1MBk5Yt1djJtfSIXAccu2h/e8gme3qYn4dkUdt/4mtjccvvFGzy5KZnCTFIAk
 UTsfhTj2V9f+6fyGCQ3hu/sQOzwh7XJUzd+IyJINOyFAw+0gRm/XHYEstiM2STE6izuoI7QWPXRpM3
 9+1GAAvAXf8upx6jl7Yk6dH45w3SkswkAp7IP4wLfr7Y4=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 21/21] init: Drop __nocfi from __init
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

It's no longer necessary to disable CFI checking for all __init
functions. Drop the __nocfi attribute.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 76058c9e0399..a0a90cd73ebe 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -47,7 +47,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline __nocfi
+#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
-- 
2.36.0.550.gb090851708-goog

