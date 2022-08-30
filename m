Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F9ECAAA1
	for <linux-hardening@archiver.kernel.org>; Tue, 30 Aug 2022 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiH3XcK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 30 Aug 2022 19:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiH3Xb6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC2C72FDD
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 184-20020a2507c1000000b00696056767cfso880957ybh.22
        for <linux-hardening@vger.kernel.org>; Tue, 30 Aug 2022 16:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=stIJrjMqwQ0zAOFApEyjbwm3OExfLqdVzHQ/Ti/K+RQ=;
        b=XT3FqCUj0oWltSKyz0DMYCdz3zG/R+ch6PgREyusoybVfYnjSIIp1QEVmgkw27BMRj
         1bwaWQRauXjRVmhR+FXatY3cAFgTFdHOwv4MeNRe9viWmXCdGh3ZqgTqK/bonGIUbUm2
         nzVQrEYCIwgQuRvzHL9weunLc+sqBtMBzhAT8qbEtdumA2TqedCJySqMrqa0Xf9T3VwZ
         xs9JxjNj3lR1umlvKCUf9SNYAvbTD4J4ebt11ivYnN3e4XZbiJ9Vkff0l7aHJfuG01re
         yOHwdfZzJCRQzCio9+FrwTtHBU/fAgGor0fUpdX6v+iYm5fuK07woR5EljmpbadzEdVA
         zmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=stIJrjMqwQ0zAOFApEyjbwm3OExfLqdVzHQ/Ti/K+RQ=;
        b=LlH2xVDW2vCey+w+hAgI/zFDxhAZhWJwgurSjRNTbyaYA62OnInOfLjzwVQbFdAe5l
         dQxh6cjOqHNp+tcOCBSTaFSJ3cOKOrLHcFgLG6oauR6j++E2Ey1WJxJ8cSoJA+FNvwDb
         unqN52rt63wncm8ElkA97wqSNpjPWJvPqtzF4fCcCBSg/5jh2ZbOFZG47OOQYU8OPabV
         WjMr3smQ7owaGqRjRg0PyEjS1P1kURIoYy6HVJCkMDwd71p1og3orT9bsA6XnNfl0t4G
         n4p6XLuYsUo+sTgDn/cxkB/L5g2sRCamizgW5OjT5vFmGDT3ukEWNfVrLFC9kgDzf48e
         QKJw==
X-Gm-Message-State: ACgBeo3gpFVKl7TQYE4IH70UQqYEXW9QcjpJfRnZnvWdxh+Xf11NkjcI
        hMA2jdwHynS/waeBRc1VTK0FGV4+LJoHFbVmO9o=
X-Google-Smtp-Source: AA6agR5cGTdetFCiErxtdp82eH3P66qCr5xSoNGpsQG/NljG1Kaq9Ijanf8vSqY++9XIfhHa37mVG0A5SaW5IY9d2eE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a81:8803:0:b0:341:6235:8cbe with SMTP
 id y3-20020a818803000000b0034162358cbemr7018693ywf.146.1661902312128; Tue, 30
 Aug 2022 16:31:52 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:15 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=samitolvanen@google.com;
 h=from:subject; bh=qxVnlSZocW9/1UypXlLGEHXfm4CDzclNhcl/lJ18fGo=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3M7+6Z3E3yWx3lSnRphzF4/3RQHI2psdANcTX1
 DniQSb2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzAAKCRBMtfaEi7xW7vYpC/
 wJyHxmthaRukbl+m+7vClm87xKX81E51zW8v/dmnTAiBQ7oT1Ek1XR7SJo/50PfceCBcZ366Psr6wx
 L7143nIwKv3bXT4p97cRjwxu4M0m8HvXeZYxX2Xqsc6uerduxtDTzFjDPWA8VsVsVXpIN5BluFq//1
 Jx120TP9+6zYwQsOBpMcJCq2cr+LMVUG0pX2qqLSJGAE1+2yoL2kBisWcIdDxS1jJ5266S/HoYqktz
 JO/BzYSjJqxWmTxt2M4SzxDHm1EgNjsm5ntVO+KRW+klcvF2/1A+hyopJ1c+SrByL7fc/WNq8q15Gu
 rS6sXoG21TAT7q0EBWR2GYae6G6d/o1Sn1DTQpzi+TfRj8zYXkDPGgdxdflelIoodZ3g3q/vf2hzCC
 Y6S35Cpa4ek9uS8PsTuYFkYecoZCw/xrq+x1R6KPGpwl3/NAuYPWxv8goJ10UY0hjOxJby0LDXRouv
 cp8+PZmKAqFAjGeoHcRcLyUkHJSTY52q00bcKiCKHOdz8=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 07/21] lkdtm: Emit an indirect call for CFI tests
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

Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
direct calls. Move the call into a noinline function that accepts the
target address as an argument to ensure the compiler actually emits an
indirect call instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/cfi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
index 71483cb1e422..5245cf6013c9 100644
--- a/drivers/misc/lkdtm/cfi.c
+++ b/drivers/misc/lkdtm/cfi.c
@@ -20,6 +20,13 @@ static noinline int lkdtm_increment_int(int *counter)
 
 	return *counter;
 }
+
+/* Don't allow the compiler to inline the calls. */
+static noinline void lkdtm_indirect_call(void (*func)(int *))
+{
+	func(&called_count);
+}
+
 /*
  * This tries to call an indirect function with a mismatched prototype.
  */
@@ -29,15 +36,11 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
 	 * Matches lkdtm_increment_void()'s prototype, but not
 	 * lkdtm_increment_int()'s prototype.
 	 */
-	void (*func)(int *);
-
 	pr_info("Calling matched prototype ...\n");
-	func = lkdtm_increment_void;
-	func(&called_count);
+	lkdtm_indirect_call(lkdtm_increment_void);
 
 	pr_info("Calling mismatched prototype ...\n");
-	func = (void *)lkdtm_increment_int;
-	func(&called_count);
+	lkdtm_indirect_call((void *)lkdtm_increment_int);
 
 	pr_err("FAIL: survived mismatched prototype function call!\n");
 	pr_expected_config(CONFIG_CFI_CLANG);
-- 
2.37.2.672.g94769d06f0-goog

