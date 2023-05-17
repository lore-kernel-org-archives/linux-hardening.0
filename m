Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B65C77B75
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 20:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjEQUON (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 16:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEQUOL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 16:14:11 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF417DBB
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 13:13:57 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52cb78647ecso802845a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684354436; x=1686946436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BqECuYQi/BexhqCaWU6Yoz79CpBk7jbeernIWMF7QVk=;
        b=aTbdQjslnWdSGECP6mJqlAZ/Gg2G/B3kd3iA/yGWBHRGfay9ONe8auaJb2FbjuQMbo
         M7OS7Rmk2yfSIDs3kqLO+CSw9KxgF3ZUEImxiI1ux+vi48iZS9VWmDCVqZyZkfNtJnMe
         WQMgIFq6UDNiFHt4e82ee7xDZgFg5ES+WBjAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684354436; x=1686946436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqECuYQi/BexhqCaWU6Yoz79CpBk7jbeernIWMF7QVk=;
        b=beHhAYEVoQlw0lvutYntwbTEjYm9xbBfJHz9hTrKEDtj1C3tw9bUk2kTk4j9JqgZdF
         YYiaRUFm6y3nMjsyCVGTMoNO6cNi75p0lvpRuryYMxr1xaw7G8wIU05q7pMBwWzhTgBG
         uhyM+USAHqDATGiLArDZ91oo2zq97Gm1VRF5dCGP5MyH4Td/ZP+ffByCGW+K1w/S5B5n
         fvYA14wmaJvH1vGwDRKMs62NyNoubXDAr49j5RRlt0CKt6ASDGCBumoRqgu5keWwn+Pj
         F0ZhnaCFA6NrgQlZ50y/iBqDMHcHaHXz+3DiOrLAc7tocmJcsjYnHW8zmvAXFTVW2/Ub
         SQpQ==
X-Gm-Message-State: AC+VfDzrutTB70MASqwwVMub2nQAQdSDc4l2vtMjUsGgYKSzlMBHyYWi
        PxdectGziza3NExArC0aI5mcAw==
X-Google-Smtp-Source: ACHHUZ78ijEMOnSmHFC1MzanWEh3cChgLp/bfufsYxMsApF2gCkUFBYXcs5MoxmSiDTcLkWiXntQIw==
X-Received: by 2002:a17:90a:950c:b0:252:8593:3f1d with SMTP id t12-20020a17090a950c00b0025285933f1dmr77162pjo.13.1684354436524;
        Wed, 17 May 2023 13:13:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090a899400b0025356cce0e4sm442303pjn.24.2023.05.17.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 13:13:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] checkpatch: Check for strcpy and strncpy too
Date:   Wed, 17 May 2023 13:13:52 -0700
Message-Id: <20230517201349.never.582-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; h=from:subject:message-id; bh=rEuHsrlOEVpdJxK4L3u/zAvRu1BId4xaiF0CnFr2c+Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkZTWAMsKYAhVvTuYu7xCHxHTcQxNX1TgY3Gp2tXHa NPtUBteJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZGU1gAAKCRCJcvTf3G3AJkBLD/ 95rgKeSIVrYE4jBce1O2Im8HeVkYK2k7zzsuDge8SqoyQM5P2sNAO6F+xw5C06r7x8pJnsUUYhxfjl su8+cSlwwl2StnZ0Mw/OoL3GWl1pUcfQ3Lf0BWqKB7klycO/7KlPJU/GY8Iw9yRoPO8k7x77iOoV0/ Na47QCoHfG7odtxN6/nauCMxPnQDnGnuGV11SAM7B2+5AHYuv+3jAJwV22YsnZlHUi/okWoCs6/kM0 Ws87TmUOgPRdNbzuSJmiRhKDKiFzZT/udluEEinMwhazaJSEKuws3TVGBSe30gHxvYxl21uxAMRA5z mN6NHAtW1vGuAySzB4WxMTWNRlRcLHMXhkLgfpWnbLrFFtXxC8VJvrfT70eNW2T5Vv8ZkfxDu+O9Xq /C+Wahj3cNpQBbTVwfPWi3w3UoySz47yqQ0TuymaRkHT5TKOC9yai7wgLJPWsjpcoP78IdngvER3KH XkXfwaI7FvSlZP8pajhRvRpY6J8hNAQizi8Iq1kNZ6JthxxAuOs76Qw9qnDTicK1CcBPlCVLbRMb2r 7d7LFvkQjxj9A33SuZWKnsUSg7ArKAqsTDksJU+xJiA9+jQquRNAhT3S1dOoCEjhSmXdSXFV4isgkD DsE3CTSHHg6kO40vHAptv0QwqcGXdOJ3AvdJVxzYmuC8ZkV1X3PUmii7Fnow==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Warn about strcpy(), strncpy(), and strlcpy(). Suggest strscpy() and
include pointers to the open KSPP issues for each, which has further
details and replacement procedures.

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/checkpatch.pl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b30114d637c4..a90e0ede53ad 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6997,10 +6997,22 @@ sub process {
 #			}
 #		}
 
+# strcpy uses that should likely be strscpy
+		if ($line =~ /\bstrcpy\s*\(/) {
+			WARN("STRCPY",
+			     "Use of strcpy has been replaced with strscpy - see: https://github.com/KSPP/linux/issues/88\n" . $herecurr);
+		}
+
 # strlcpy uses that should likely be strscpy
 		if ($line =~ /\bstrlcpy\s*\(/) {
 			WARN("STRLCPY",
-			     "Prefer strscpy over strlcpy - see: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw\@mail.gmail.com/\n" . $herecurr);
+			     "Use of strlcpy has been replaced with strscpy - see: https://github.com/KSPP/linux/issues/89\n" . $herecurr);
+		}
+
+# strncpy uses that should likely be strscpy or strscpy_pad
+		if ($line =~ /\bstrncpy\s*\(/) {
+			WARN("STRNCPY",
+			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
 # typecasts on min/max could be min_t/max_t
-- 
2.34.1

