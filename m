Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE9C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 22:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6702661205
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Sep 2021 22:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhIJWer (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Sep 2021 18:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhIJWeq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Sep 2021 18:34:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43DC061756
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 15:33:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id dw14so1424038pjb.1
        for <linux-hardening@vger.kernel.org>; Fri, 10 Sep 2021 15:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KogNB3CtDBsoiP5ldOgQwTIvqBJIsD4GKdTNops/1yQ=;
        b=UAcBDFc4nu5xZI6NItqQaW4uU+bEx/u8k4HW1GNr1alzZ+dJCw5o4F/TIiweOUn9XM
         jfkwHzpJAGwuzuC1y/meZn2t0ezhHF2T2AtC5ptWbsnG6Bf410hWfZ/8t2wce4j9GqRc
         OP2T/PaLaV6KNHZFyq94a1gz+S+v0PEJNN5kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KogNB3CtDBsoiP5ldOgQwTIvqBJIsD4GKdTNops/1yQ=;
        b=3dWcua4l7uPugMmnwhYSBY6Vh6wYW66b2IW4tDY0zcNog75wju56amvxKzfm53WsIs
         BlWFtS3D6bqoDwOcZNEnxHxn6B7+MQ6XCTDcphlRB0p1+YEpNgzqmBqZr3HINa0bDiWh
         HqhAAArxi6x5DGNQ48k/3p09ftqimCUB2Wua0nxj7/dai9KJn1jxgdkMlWCzTESbmThr
         ltnonStL+4MLSkHfbtR0HlRkCl3E57qLIaqP0zmvA4lLhfZY52ASioBmGOUwKyk6N9Wm
         JfPJg5+Di/Ak9wcd1nbNADiXelztsTxOPJOX5SnRCQwzQ8XmO/3QJ0HQleTufOJRmyfi
         q3gw==
X-Gm-Message-State: AOAM531q8cxpkzbhtTxA+qewL4Eg3s3zhmITqffkzA1pFs7/d9qprUqT
        aHCyMqhsi2xkh4+XYxsblmjTMw==
X-Google-Smtp-Source: ABdhPJzfwmfRvWdToI2+EeTaBgjO6k13GnYIyiNMix4a+TwjSBOIXZho41aZN2Zo/RN4o0U7QfITCg==
X-Received: by 2002:a17:90b:4f8f:: with SMTP id qe15mr12032956pjb.37.1631313214885;
        Fri, 10 Sep 2021 15:33:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c11sm5801619pfm.55.2021.09.10.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 15:33:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/asm: Fix setz size enqcmds() build failure
Date:   Fri, 10 Sep 2021 15:33:32 -0700
Message-Id: <20210910223332.3224851-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; h=from:subject; bh=E3AZeKoawYriHgTNF4IibG7kRb7S+kCAfy4Ad/M7+Zc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhO907BcW/2wXObLve9DtfyCZRObXWuInD8NopPI3D GjS1i0qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTvdOwAKCRCJcvTf3G3AJmvAD/ 9rKjmYwePN6cFMXAGn+acaF/iBCzmO+UhDVFUKBzchwyPg6VuQVIe+bxX6vjUucMXUlAtodrf6dNCp A2yOiIuNFTJge5PTr88TF3Ym5riBXNOJn5Ottojs+BQae/sV70M+LFda0pxThtviA632LB5k2lzR/D 8HDHNgD8SIzC/bfRaRJEE4+p+6u3lWZOUVuVL36W0WlGK7t/a90EjgUnX3Dg5z6To04woiBWIsTKM2 hIHSjBJy+qj4i4mnb/I9d7S2EYVpYXYngjljwQr4paBZSOSHMWYXBX387L3BOYOwbIOyr9ty4Q1+hi BU87g0w2COuBanDs8MFMhp2Z1mdhwTgrnXBKy7/BKPNc55nws4ObVNa8JmOu8k2JDxeDav3DR4SeSl t8JqzE4XE7YvgpKUMtBJta8DC+xHJBg6GBC8ENgo9PwlMY6pAsDI3OwNMijay84Om8ZPUS89rgbmAx XVtqaCn6tOZv4OXxRPupCuMY6CVHjmtmxmW5onI8gP6jwGDjupo8WHUfuBemug9Qoh8428PjxfOYLP w83Hvjnr4u6+zy8trHar6m39tdlJvwUmgBbTVPmEqpzoRCCR4YDFBz0wxNGd/3agEdUACD+7CiM2Wm ls4IGR4fQvtlDAr9P33+D25h1F7F4oldm+dmHzOIhTYmn3nvrXH0xQtnmXOw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building under GCC 4.9 and 5.5:

arch/x86/include/asm/special_insns.h: Assembler messages:
arch/x86/include/asm/special_insns.h:286: Error: operand size mismatch for `setz'

Fix the type to "bool" for condition code arguments, as documented.

Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction")
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: kernel test robot <lkp@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I tripped over this myself, but I found Arnd's version, so this is
basically a v2 of:
https://lore.kernel.org/lkml/20210802145356.1154321-1-arnd@kernel.org/
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index f3fbb84ff8a7..68c257a3de0d 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -275,7 +275,7 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 {
 	const struct { char _[64]; } *__src = src;
 	struct { char _[64]; } __iomem *__dst = dst;
-	int zf;
+	bool zf;
 
 	/*
 	 * ENQCMDS %(rdx), rax
-- 
2.30.2

