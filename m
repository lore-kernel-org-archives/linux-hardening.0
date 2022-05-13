Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8CCC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 13 May 2022 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384229AbiEMUXF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 May 2022 16:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384190AbiEMUWs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 May 2022 16:22:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BE15D33D
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w21-20020a25df15000000b0064b401428bfso7256613ybg.22
        for <linux-hardening@vger.kernel.org>; Fri, 13 May 2022 13:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PfUOUCtWYZGmp8CXclCTWw0GE2v5WPFVxnxla7QB7vw=;
        b=nCubo4qm3EWLu8ph4cU0J48klMHpfNRcdDDHvRk87yHuzwBoIBJ/AU7Zj01a7RdZIF
         t6ik+RXGU61svm9iFsdm0UO6eotpCIPJMowDcoGi43HtZioBN2GSc7Bb/24mH+Y1XxI/
         H2UqwryguqTCBR6WTNv/1J0rrcU4SgUpj/DCVM+I43JCXI9PY0ZuqC6e3pyWT8kxLHXz
         aypLH1zJKclQCdpSo+hy/cCSzYH+emciZNSjzDJjmkCQGnRGZTqaCMDjwLCQp7F7hD8B
         lNK/pR0WZNB0QYRB2IObpdQwuIcXVOFy3fveUYDJmRy2HB/sObRtwd1nPyaJGlvjuvKx
         1jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PfUOUCtWYZGmp8CXclCTWw0GE2v5WPFVxnxla7QB7vw=;
        b=gPV7UbX1/eRgp8k+ne+eXS4FCImoNKJQz6tZ8P69JRLkgG0KHSW4tPBpxozUweIL5m
         hqYj4St0GmcKiEQHpAGFpULRiWFL4GuMltKkZa/5mwZwZWdcA+olzv1gYx0gp1Uxj10R
         GncB1PfEpnTkPYpWtjzdGNk1M5aCH1Pu5HJSZ0uV3R/8+O3ebHrinjdlnwhq+8EqcQQ0
         M9AT0svyje8xpbvogxWGfiJZhfPhDOJnrfVZoI0OC+Sh4aKnoXEnpJclRvnHg4Z6NwNo
         qg3ZNLztAH/3RX/XrdQdzTz/FE1k31mr4dxs5IZ6wUHk/1VMTeoKGKbHZtnequQRQSur
         HjiA==
X-Gm-Message-State: AOAM531nUgLCA8qiSOVOlcL0qrTzQ9qhPEM9tQ2sbdFtgEVz7FPwgy2z
        MyjE38Y3ED/17lnjAbGiKDbGklGkZTB+d7ECf1A=
X-Google-Smtp-Source: ABdhPJw+D7t6SSlbjDlENv5lafSoapQJ6Q274oZIPQGeVXoNM9Zg7HmZCxd74l5G/0JMvVqt1aRLChSV/AE8SNevvWU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:a25:8c03:0:b0:649:c7f8:1fc9 with SMTP
 id k3-20020a258c03000000b00649c7f81fc9mr6802241ybl.587.1652473363438; Fri, 13
 May 2022 13:22:43 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:56 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=867; h=from:subject;
 bh=1zGkTRBFsYQeOh1nY0Ftktys2F76fLo0aIs4c+r3/F0=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3lqAwmlxBUGYGrHtGRBycX29CVlKsWO3WkULXp
 4RXxZyyJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn695QAKCRBMtfaEi7xW7iRJC/
 40aO3dHx7HRqL5IBxJl4LEnss6Sben7NjXL1WF89h7qFltZ5dAJeU01SJQLXBbFrGMVwlJ6QXAdGEj
 635LhB+9rvz3J3LtnqvUssb7EF73SxuPBnb6OMm+qYoJRX6x4QzHFUBMSpT7nQgeSRXxgqGzkDSRup
 vh3xGCK6gB9qpNMP6tfQC0arD6MlBlA6GdKe9mp1HvtqGMQB7swpv2WD9cOCfE9KLcH0y91ynQ6g4U
 UZPiaQZWKDZYiQPJldKSe7moKZrikR0U0Qo5Q553qfQPjeadJ5XvtghpEAkLCafukyveKh4N09VV1w
 S5uP5cVYPc1iWKtXKqmCRwCpMMwF7IuEhjpg+hVIGDfAoBFfQZc7B4mxMlOChIzO8+9ddE4OTx6XxB
 YRAfx/UF3uy7/M0r/sDjqemuUQ62BUUmbl2fY3WLz7xKDa+6xiPI1E+yb9szaxBwq3DbFWH1ubyPnI
 mSllpHUKTR62DNzA8dewcd7rUu26o+Zb8p+isVc2xVeb0=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 18/21] x86/purgatory: Disable CFI
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
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/purgatory/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index ae53d54d7959..b3fa947fa38b 100644
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
2.36.0.550.gb090851708-goog

