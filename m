Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0339C77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 16:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjFAQHx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjFAQHw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 12:07:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A48134
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 09:07:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b0218c979cso5819125ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685635670; x=1688227670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ptENFxKbm4BTPW2fyYK4ck/4kFfei85Tl5hA/P3P81k=;
        b=nIMy7+glyu95wXf2F7WSITqWfxz3shA2pXTfd0MG76mzBDcgI7O4t5ncc3S8rImzOg
         nlCX3LiRdXHtocFGO+h4+WLBu1M0b6u4sLiv9nN5+S7FD3wZShVLY0R2IJOkRal8nG0M
         UNXXDOhFPUfhc62Exg6ohA7N43YaGJ6diToJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685635670; x=1688227670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptENFxKbm4BTPW2fyYK4ck/4kFfei85Tl5hA/P3P81k=;
        b=enHjRenIfDdl+rLFaVSPf99XUJHvAb9cMxrTCvlwVl7FIrjkBtRlyOUPSOtVByqTFq
         yUzCf3PJZWDDv7I7HU56k9cWWi3kWWmqHGddbbY85VfASYDgXlFqBamW6kVf20nwKCM6
         WQUTudipXbscO+g/Hs/vrj54EeT0Ntb+c1xvjchqWBAdON8Iscgh39Y6GGeXDmbMb++P
         uaHhj0XYGTeIYobQuZztlM6quA+OpTmsVtAE5kGHYLZV39weNEPScQhYQLtY2r3ZlEgS
         QWYihU5y39kX8FvknzP5C7SipjFF37ijoxKdOHM9MYuM2xJB6ijw6bm9O+XYzk0fS1MK
         JJnQ==
X-Gm-Message-State: AC+VfDx7oFNqJ/xJFW1IHybDSZAlcieIaLeQhpeauRnhsB0rTI9vTore
        HzuMTJXmmuvU9Upf6qD9/hoPfg==
X-Google-Smtp-Source: ACHHUZ6c9IS7MJmN3ewUf0ExCKG50U+SAO85uPPcvGreQTOiQMGxBZzsoOF8iprneSq3ILQdRkxp+w==
X-Received: by 2002:a17:903:124a:b0:1ae:2b97:f387 with SMTP id u10-20020a170903124a00b001ae2b97f387mr7067548plh.21.1685635669705;
        Thu, 01 Jun 2023 09:07:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902b21100b001b04772d33esm3685993plr.165.2023.06.01.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:07:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v5] checkpatch: Check for 0-length and 1-element arrays
Date:   Thu,  1 Jun 2023 09:07:46 -0700
Message-Id: <20230601160746.up.948-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; h=from:subject:message-id; bh=Ri1hqFTbNjmSVno27v3dRpLFm+KeBWhWBQ6I+IwFrC4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkeMJSBduqASZO2GAtVRLjMkiTzHZjLkFlU0AY1WZr Phd0IEaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHjCUgAKCRCJcvTf3G3AJjcgD/ 0QZIVPVjslonLl4fLkf0G7X8Gb/Ka5nJF42klnAnMfNQBctzyLeLnAdv8+17cvcjwSvxShngunIKEG OVrmK03jWLaxs1CZIAduQGTmSbRrscLmEeloDsWM3NRgI+P0QMvmc4doMItjlz/kNbrTpwERM3DPJs +/J5d+sqHWqU1EPeLmN2WXbQjIR4lx1ASalncfhg3wfK3fFkURyvxHeEcwBl4rweAv1Dxj3OEfoJTA T3u4s4mKg/LCL/sZzISMxZr61UICYdPS1rEn90ujBfQM+NOw07wcsL+GhNhm/5UTFtaNLmVfXNuo8D quRjFuspKvtryoayFe4w+yaBhvJLgGTCzqFXNp9nG82YXsSyDEc6fqd+xMdynThtbYu4X7dkjboqbr EBfRSgCYLOTWgco1noATVgPywwGKz8BeKRJfIGtJHn1X4QYD7O101Xyn45kmCGi1FgzoY3Q3aoHWX5 PcM8eSvOmZFQ2+jeU08U1xcKQPpKbObOATbDWtBJ56PC+NRo+Mn43lmCTeuYiNj3O5ocfnGV8sYtRz U9XyId4UkIJg2/RbDfa3QPTQya6zxuDGkm16QgwNsAmtZdeRoAz3WdoDGFLVkr8PV35CxnrUBI37+v sLb/5uQ9rB4pnEyKA670BWQZ44/227qsIoCTY0q7KPLsbSeK6Iq/f5kBxpOw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fake flexible arrays have been deprecated since last millennium. Proper
C99 flexible arrays must be used throughout the kernel so
CONFIG_FORTIFY_SOURCE and CONFIG_UBSAN_BOUNDS can provide proper array
bounds checking.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Fixed-by: Joe Perches <joe@perches.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
---
v5: - add __packed to outer struct regex too (joe)
v4: https://lore.kernel.org/lkml/20230531004929.you.436-kees@kernel.org
v3: https://lore.kernel.org/r/20230527020929.give.261-kees@kernel.org
v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
---
 scripts/checkpatch.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30b0b4fdb3bf..7bfa4d39d17f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7430,6 +7430,16 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*\}(?:\s*__packed)?\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:\}(?:\s*__packed\s*)?|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if (ERROR("FLEXIBLE_ARRAY",
+				  "Use C99 flexible arrays - see https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays\n" . $hereprev) &&
+			    $1 == '0' && $fix) {
+				$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
-- 
2.34.1

