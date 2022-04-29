Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6962AC433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Apr 2022 20:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380914AbiD2UlL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Apr 2022 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380947AbiD2UlC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Apr 2022 16:41:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D3C90FC
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb7d137101so84825677b3.12
        for <linux-hardening@vger.kernel.org>; Fri, 29 Apr 2022 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pCRF8WxuKsJLhQegFtXAhQOgdkZIXxpUFMBNWofutJg=;
        b=rb5PJBXqZ7PDnTljG6ifIE8gyd72IC34q/VtcjXuyOJl6AMtdmAjmsfq0lfuEQekK+
         pMx1HTeDGFvMcB0zYoRjn8iodh+Cl+ug6t0NujoKdJdq5JfOpcm53hx9cYRc9czaoM6V
         wCCo8uZtcZNwjZnC3yaMKuANSRu6vyIDn4uQlpbz9pEsr0iVULxkNpsgUh09QxYqO+bt
         8ih8Yb01J1emTtSHlr8jVVrGUw/d4znoCzHf779F0LEMOL9mgrcOcmkCJcbSd2cORoDr
         xqfesnGB09orA1eomT3hmGVMGTGc6KccZjw7UoOwSyooZfLr+oU9LAzuLtNDPJOImR+j
         aHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pCRF8WxuKsJLhQegFtXAhQOgdkZIXxpUFMBNWofutJg=;
        b=P1ai0FvKK6q6xVAEiqITwGL79CrM9jXtWyd9p/OPhpYM92iCjZTesiTKAQlYTLPSJD
         6dHOVY5jd1pvLBpuC1AjrQdfmlXYOcKJI4J6fcMSwVqsrzzq2Vnl3DKLb+tLmvBApw99
         /6upBjexLu85BmtdXQQUcP6CCL6wKgHgEbOWZQ/W6Y3eHce2eoCq6AcJJuERJp6Uc5PT
         L25rsDpKiz+ultLwheeuXQ0j8DAiztjszexxWmcRhqizulpf2VdSz04Kl7fpvEMOZf6Q
         5TVRNhFIU8O3q9xTOFsXcdGcgdyQLQE2tSfmMiFThrTmjhBnno4Bc/3+wF54/lbO7rMa
         gHGw==
X-Gm-Message-State: AOAM533PU3KJOdvMOnOQ8Nl7Q5JZ68zlE1Jis2hVYjlpBL6aQIVGpFjc
        cLykyVfnGMwYKjxzn/SLPzMso5qerYMD50oBi8w=
X-Google-Smtp-Source: ABdhPJxW/4+AcaZSu3uuWyLU6uIyltSWFVdpdAXqDeDs5bikx77gj1C032JW2iKcFOB1vCKNvHaYzdWvZDktOIt6B6I=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:351:bea9:f158:1021])
 (user=samitolvanen job=sendgmr) by 2002:a0d:ddcf:0:b0:2f7:dc0d:93e0 with SMTP
 id g198-20020a0dddcf000000b002f7dc0d93e0mr1144605ywe.9.1651264648287; Fri, 29
 Apr 2022 13:37:28 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:36:40 -0700
In-Reply-To: <20220429203644.2868448-1-samitolvanen@google.com>
Message-Id: <20220429203644.2868448-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=641; h=from:subject;
 bh=DxQc6EGDGB8zEXE4dDnKQIh2BeDsSr/ulqb1I/8a6/M=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBibExXdkK4E+eES2dE3iysIrEucJWLi1au+dxYyIiv
 PoIr2IqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYmxMVwAKCRBMtfaEi7xW7jN+C/
 9NuHLivGVpdnQ5h09S1KucfK0dDYhnxeXvjJsVMWhnO+lQDVoYHCCl5XS5s1fIVTqbdKMprLkXjWt6
 pmEkoXNNEA9NLrUjE6YWmfUmUHDQ5qLnl1zZRAdfrDM+TwEdRrdk76z3O1H72HxKW2Fhdo0fp7rO/S
 AfFpWddva2zdjw6GUPJcbTB08W2/n/QuoReY4FJI2CiZ5dhhjeP9UA+yefvCFQNmyhaUX30cg8Jxm8
 H651xE0f2VrSPBcSVmrVMN29dgeghi1M0QnTu3SWABhA9Zq/sWAq4dmOhnHAjFfwPVr/B5TDzIadY0
 yt/QHe4RXgBdIpCeYc+nV8hl/cRLKQ+KtM1YfepHZV2Pn7EqOwnvmiMRpDIt8VWv/W5SqdpE4SNG4K
 wS1d/ZasQIzQxU+EC3z7E5RijhdSJh9X5+J0iYeI4YuT6IhQsCVsn3zqUwQLXusdt9Iu6hwIiOOJ/5
 V86zuETn5IGcbe1euGU6/Eo3BmgfEx8DHtnulobHhXn+A=
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [RFC PATCH 17/21] x86/tools/relocs: Ignore __kcfi_typeid_ relocations
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

Ignore __kcfi_typeid_ symbols. These are compiler-generated constants
that contain CFI type identifiers.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/tools/relocs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..2925074b9a58 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
 	"VDSO|"
+	"__kcfi_typeid_|"
 	"__crc_)",
 
 /*
-- 
2.36.0.464.gb9c8b46e94-goog

