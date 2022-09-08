Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F33EC6FA82
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIHV5k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIHV5G (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:57:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE5D9A9F3
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:56:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3456e0bcd5aso91026107b3.20
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=YYrJQHPp1VsbrnyKnikDXxJr0Q0IFfWdTrn7QSp/nlU=;
        b=RAO9dBKDPKviMcOwBkkzZY0G3x+gnPOK29NFIOS/Zr8789LtLOlEaeHEybcNsvLdIW
         K+pwExbWGqldW8BJjVtsPZMGTJR3YhH90i0Txv330av0oqQtT/I4/nvWGh5MKlakz2so
         5hIN+nonzm6i3iZB181y8mY7MbESrP96/nYqECARK6XBLztCpkuitNQRkrC/fKBt390x
         C1uQ3nyJhQju/9EuNJyjkAoZ68HF9wch5/WFjrih+g8E79RhgyzSuuDTd6bYOLqDJcZ2
         y7uASan7GCfY1xHDXgLVyn2OJADPTnjC8NCdgKG5ywLhIO7aMrDjSH/GSa7QdsPmgHM1
         CyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=YYrJQHPp1VsbrnyKnikDXxJr0Q0IFfWdTrn7QSp/nlU=;
        b=Npwj/1gyxJo6y8pkRn9OrFbNo79eoHRLNWAMpW5PuW8KoxykQQv/ZaBUczunbsN/Ss
         ZhwNlnbYWK5dZ6//q6l4OfU+/JuzrLdFuQr6JXmZfAGn6DTrxHzESD3FhE1AYKpPhXev
         t9bFs/2ZRZkqbdVzitou6gdm6eZ1bbaLBnL5JOrbcYyGfck7JqB+VYZvZ2MEhV5PtBer
         x1OqgkJCELV+qXeJ+yNun1TCEXu+NGPIqthzQ2N0FChIsR3oZSKUhqpaILYOCh6Qx6hn
         f2ckp5zBZuNr/eRhVhTuOu1IGr8xapMTuj2aGXpYw6S5FMe03oJLxwzcPT02Q8WtO2EQ
         ZJTA==
X-Gm-Message-State: ACgBeo2KEXMmC+tHhXWzajMsqYySGw4OulY1ojwX/Wbraw80+f/hgPsu
        nnoAiCxGUZOJqndMxKDFjZdi9u895e0OEk7ZQmw=
X-Google-Smtp-Source: AA6agR5Q1US6p1T5MS7XFebio75PXfPm+oTSo10BuqyTKkQ0gqAhJ38ETDbGBcDqV94PluTx9li4JMCPkaAkCGoLKLU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1543:b0:6a9:adf8:14f9 with
 SMTP id r3-20020a056902154300b006a9adf814f9mr9806374ybu.271.1662674162251;
 Thu, 08 Sep 2022 14:56:02 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:55:03 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-22-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011; i=samitolvanen@google.com;
 h=from:subject; bh=UWuLwE4y600ClTatyK0xTSLvu56hvYR9AUlhuy/RYBM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS2BBGj4qMjQc0TkhRxkWipukSgdHFHNJbxjALg
 KA9XqJGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktgAKCRBMtfaEi7xW7tnDC/
 0YewJWckrPSkwmm2Cp5oCkhzPhtbyWs+Y0ti12HWfm4sxYzV1zNPdfoO/xlWW4YUT3EGNpRhm652XA
 1YZnjCMK8RJ9VL0Mkj7BJ885cDES9oNpu/gFc5tvXbign7Whrk+XzM/OStzrXx7yhwZYc+B8eIBZD7
 /sv3RgkBqGX7aNahcU4xiVpdwE9rdGjjov/qxhkiKbltHSgKqBzPeAagsC/HXzYiAJlS/HUVSc/1Oh
 USSeATQh0fDw+EKujE2ITbZC9M2xnRw4dltthWBXcJupkTYvL+AkR6N1b5Nym/rwwYCYftIuFUZyVF
 EzVcnJCbq4gaQpyF85+NOzZUESoUrn0BLrMWYvfQae/Ekp6s0jQWwsIy18tgEV6VaDF8gS3nzAh6KX
 3zL1l5wpZ7U0i197vi++LJVnvNti2UHclotv6EWBHZkZyGdf34HOHcAgdCxorRqu6n4mbDVi3q+yzs
 EEJlV55qqrvRL3C2yd4Mt1uIUXywud8dPE1BGXLm4eKII=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 21/22] x86/purgatory: Disable CFI
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

Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 31c634a22818..58a200dc762d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -55,6 +55,10 @@ ifdef CONFIG_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
+ifdef CONFIG_CFI_CLANG
+PURGATORY_CFLAGS_REMOVE		+= $(CC_FLAGS_CFI)
+endif
+
 CFLAGS_REMOVE_purgatory.o	+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_purgatory.o		+= $(PURGATORY_CFLAGS)
 
-- 
2.37.2.789.g6183377224-goog

