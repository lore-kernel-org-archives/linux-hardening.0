Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02FDC54EE9
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Sep 2022 21:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIHVz6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Sep 2022 17:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIHVzd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FAB8A40
        for <linux-hardening@vger.kernel.org>; Thu,  8 Sep 2022 14:55:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q8-20020a170902dac800b001753aa66955so16906plx.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Sep 2022 14:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=hxVlN6rWLARdYy3dC6gMYDiNdzPlrI9Em0RdQMqLWyE=;
        b=YixyhnGLxPM5IyBq+Cx3ROpfwgkmWSL/S+Z9WY9aAlV7aqP076z0Be803EmoxgmZSI
         QPaV8mCVsgLhPK0aWX376YklGiCJfSTQGO1TR9S0NuD23n3U49BRqiD9JQRLbsJS1gPo
         KDdIn8Ft5t+LqAtHkX2xDrILJvARG24X0A1g3yXOFgW4s5rrBn+hl8I8C1z7wNlYB5sS
         B5b4ju+vHNFK6prjhEKAeNilCbI2oaOjKYSm+B9K8L0AQmCslqzX6I5rLytuYw+tivqQ
         fj5gWZIuFxcERHDKBIHCixAvaqoKbaIi7sNWgZ6OjyRKxDhxAeTOB1qkIq/GII7+iKz3
         2mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=hxVlN6rWLARdYy3dC6gMYDiNdzPlrI9Em0RdQMqLWyE=;
        b=ssekSwYb+gmnsGIhXiRzlmxR4v87Giz7Lrpn8NFZ6XlLH6lEAbkSSc2A2AYwMHVCz7
         FFZjxMtQ/nqGa5bZ6AFMmgX2zOG/alXvyw5fK8M09G1ZVmJkc4rxOfc46C3b6Lvg10qS
         qArTtvweVn1SWCId4aBHlq4Gf66AP+MiPPZPbv8cIIWLo+5dIky7x2T5N7kb18ZLuNYF
         n9/ORvlXnJk2ZJ/RFaFcrdTCwh8wrG3rMWsRPVg1sM/V2zz/cnAJveFaNEFvbElzxfDi
         ow9yJbe+v5TYNxRaGc61S6pPBExz7HPGqnGoNlshCqtCwoYF+0+jvqNwAnTDlUEMadbx
         Jb2A==
X-Gm-Message-State: ACgBeo337hUNT/LZrfxroFLQgYIg/tAHQpbZrwXWBMLsQ0HrjTm8+qtN
        sl5kOVTwTxFaazo8VCYUdzsh02Ao+SffzrVUClE=
X-Google-Smtp-Source: AA6agR65qo+hoOIT4XctxXEnKYpVkqbDPe1kpMaIsXT3ELQK8UbHn7uKhuVpWc1mlSHvRk67rOv9sIorlVrSO2geSOA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:ac4:b0:535:c08:2da7 with
 SMTP id c4-20020a056a000ac400b005350c082da7mr11099784pfl.69.1662674125665;
 Thu, 08 Sep 2022 14:55:25 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:49 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=samitolvanen@google.com;
 h=from:subject; bh=Y4Uf5ZGPYU6AVUx35/Ny2uohOGmi5MxjylrWIxxHQXk=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmS0Or7SZXmXRk+ugEb0v0gF1mhowC/k7HonApWp
 lUIZjtGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpktAAKCRBMtfaEi7xW7rh9C/
 9iq8SJMhpp0douzn0NEiuSP+kUubtmt5lc4Ok7KEerIJ/4MOPE+/l7P1ebhCfDc9WP0hGgMpwU/x0t
 SJk/5fVgawWQ+TwNz5JgujDI77rc2mVF5orGjQoukvQ9vBOvYnvttyAO8/r189bsgyQicv9rhmTBpY
 EcXryiDMh3OmYogpOQQsbtgPmHgVLy6xJzU/dU0s8jD5F/A3gQSWdJH8KUqJNsaW/CGS1u9pfiSHtr
 XNWjIJfmS2QQBXL+cJh0XD9OHMcnS8zIgUMxXywsk1AcobJws5sQYF4uPhOg5agf8SCVeR2vemS4ig
 6UfOqd8bUCL7kpK5vGnAv+NDRItdIzJWQiukTpzP379idLXQ07ItKJFjXcLeh0p6/K6q53vum6j+HX
 gtICAhP23tyItKQUf+XD6MaKkqENs0dgpVPjNynyYBpbJgTcOdInrZfntnE9z7YEnHQNIWq7bZQ6Lo
 VWytjgNgdX/N5z5lbv2dVuSB0Cbc7hlz3BBDwnxPLuvOs=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 07/22] lkdtm: Emit an indirect call for CFI tests
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
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
2.37.2.789.g6183377224-goog

