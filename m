Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E91CCA47D
	for <linux-hardening@archiver.kernel.org>; Fri, 10 Jun 2022 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbiFJXhK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 10 Jun 2022 19:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350668AbiFJXgN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:13 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9676428E737
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n8-20020a635908000000b00401a7b6235bso220932pgb.5
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jun 2022 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CWnNitbfOLhQnF7KkKjy4PcZy+klQjLs8QMKloYSIpw=;
        b=fOZfXeQdSLKswErXzMBZH9XsLCV42ds3eR5iT/7CIuVvEL2CCXe6ogNKHZycEH5fSc
         I9Mt77cwarZsc1g5kHXr1LrCXwmOn9rV8yo2E0BPZh+LfhtBGF0hCQprmFkhMsjFnBuF
         8clyclrxB9kyvIRLisF6NBatfOsNEBNuCs486j3/4U3o1he+Ok+oVmrK4i8jWnXTG5M2
         goqMX0mHSOAs0iPVG25etd8mGbAIjXNViN4Ote72KVzFfA78hpojPIUYojP1apOs9cDG
         e2BP0ff46laOy9l68gFg+J/nAhP3/QVByydQi72KFbVYp+oe9NAbTJrelf3wRnn+ccz+
         GMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CWnNitbfOLhQnF7KkKjy4PcZy+klQjLs8QMKloYSIpw=;
        b=jDxOQkGSeLl2nsASIANqeKl1xkUU1uF2aZJQG/aEEE1AmV0KpfCdt5R1mokp0G+D/P
         c5UdDGcCLhnNVPBi0+X4YBZP5skWkLjZP0TRBty+7K4HZT+BwJ0Sch+W5X3qDz2VTzcM
         1qAeNCqONfem8yko/Iz08BrVeRYsPE4E8+/0VYKOjfrlTzBmgKGYaxoA2RwyLyzLxews
         +LBJNMdKeYN/RsNyCk7C+AUpra9A9zbZKVYNLXxm56sOMZOvGsDBNbiuGibM7zCrb8ox
         b1N1imkEnUbrrFq/cmagGSHN2DJmFQ1WyZeL3MSVnSSd9YIWQHxAkt07dez+IGCS0MDZ
         fWzg==
X-Gm-Message-State: AOAM531JnpU7BfpjSAcs2dR8oEA5oxQ+JwMEj1y4H89iLnDpss/0BqfR
        FfEZjXJit/jf4Clsm1tX1utuU3i9rz1xAsa2ccg=
X-Google-Smtp-Source: ABdhPJzJklmv83ib9dtumF3fDVXJ9/rnRX9l9AVErVMeN4n1H7BI0knzO6HKqP+CaB8vXHb9J3DEA6NWMza5OrCMQc8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with
 SMTP id t9-20020a17090a024900b001e0a8a33c6cmr5764pje.0.1654904154496; Fri, 10
 Jun 2022 16:35:54 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:09 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; h=from:subject;
 bh=9rYz65/wFLeb1wFYDqW9Deb8ZW7BFIBQKHutwryD6DM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UuSzS/L5UlnMGrcbfC1pmfBwffJXbgXfbB5jSx
 rV4Yi9yJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLgAKCRBMtfaEi7xW7moiC/
 9XAXjotNlz2/1MUykpfa5HJDtB/UC1cKV1C2vbIvC8Nob+RP6JDzgeNg/n7iO4t2W7K8heycv4p+HA
 GaGtEc/SNKc408QLjeNjUCgOLdzu6ebxXXZ/fzYqK4QqVB6vSYs5vKf0XuNzy7eb/yx7BTbXYc2tn/
 NLvFCzQqcBWM63EUH8jlTwIUzbZINqxxcHlWIQLYYxN42fDyC5ujTdlDhDCRYxJIHQG62jM5UILFLI
 EyrkN5dLeWVUKb/8Xsbbzoveos+qFNW7lA8fp9WjcB0nueoMIeV5Ym3UO0P2FXahgiAlt5qyrl9z0D
 O8UnxBAbuy8SKLir3fZ3GonQo0d6y8V2cMyeee6EfaG1HcuYOtgbF2abSEiyjavNOSDullUCbDJE6Q
 9L9efkVBhKsjjjabk3WstXIdMtX+0mePBDqpPyIQgDv1m7hxCs4B/bLjt8d318b2rU8ZKSQ92REnWa
 Y+l/wx2h/+m6D4u624xHxXJlHdl3wqoJJ08s2A6ln2qqU=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 16/20] kallsyms: Drop CONFIG_CFI_CLANG workarounds
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

With -fsanitize=kcfi, the compiler no longer renames static
functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
up the ThinLTO hash from the function names.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/kallsyms.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fbdf8d3279ac..2fbb94817e02 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -179,7 +179,6 @@ static bool cleanup_symbol_name(char *s)
 	 * character in an identifier in C. Suffixes observed:
 	 * - foo.llvm.[0-9a-f]+
 	 * - foo.[0-9a-f]+
-	 * - foo.[0-9a-f]+.cfi_jt
 	 */
 	res = strchr(s, '.');
 	if (res) {
@@ -187,22 +186,6 @@ static bool cleanup_symbol_name(char *s)
 		return true;
 	}
 
-	if (!IS_ENABLED(CONFIG_CFI_CLANG) ||
-	    !IS_ENABLED(CONFIG_LTO_CLANG_THIN) ||
-	    CONFIG_CLANG_VERSION >= 130000)
-		return false;
-
-	/*
-	 * Prior to LLVM 13, the following suffixes were observed when thinLTO
-	 * and CFI are both enabled:
-	 * - foo$[0-9]+
-	 */
-	res = strrchr(s, '$');
-	if (res) {
-		*res = '\0';
-		return true;
-	}
-
 	return false;
 }
 
-- 
2.36.1.476.g0c4daa206d-goog

