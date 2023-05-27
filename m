Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E195EC77B73
	for <linux-hardening@archiver.kernel.org>; Sat, 27 May 2023 02:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjE0CJi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 22:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjE0CJh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 22:09:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2538125
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 19:09:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso1872897b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 19:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685153376; x=1687745376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c++cIpJx1f5qzSfXzzcmil49fI/6fMOTY+nB6uBIMCc=;
        b=N8VoHGMl6BimJpRAvc5OIu4wxUqZEPrio+S4hfMVyQ6AE5UzLj9woYk9IvO0XhPay4
         gE7pV+7KmaDxpei2rn4C4sUJ8bwcZZz2KEYsXnPcnz4O3LX35qZ0Xx6msDm6iL5NXsmH
         hiaLPnRxO3z0pAPKEDV4TI10hALPue1P46wVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685153376; x=1687745376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c++cIpJx1f5qzSfXzzcmil49fI/6fMOTY+nB6uBIMCc=;
        b=lyxxLWFTO3slcsiBvl1PwPDNpJpHmLYUJQPdg0V7I31UYvMhTrNmRS3xncFIHcnAFq
         cnDuDvKVI4kWprThsjZw9MOHMC2TDj19TXQHfFlReunTc6Z3GOkQ6XSA2Zv4N7TxfYK2
         4PcpHlfB2L5311U1jHcHLInM0+gAR9pZ01oko+fDFw2/PyG5rGOO2hI3yIjuCImg2nNZ
         CXOJ47+PigYfIqccSSqK4Dd7rtCrddn/m3FgVDXAcRMXm6oerYZ6nvAtHm2EIOJlUrKA
         Mu8zPhUPwyUgIOTCSRHRj9vbDe/xXnslcqxVcw3i/MEnZU2/jIR+xXrCfZ2IgRKVSM/x
         zN/g==
X-Gm-Message-State: AC+VfDwHUSB0U8COEGlOvg2AVExXC3+YCG074QbCBdnktO4Rns/J/yaT
        /dLsCwpZ1i120koQLBk+h0QRhw==
X-Google-Smtp-Source: ACHHUZ7RuGzeZfjSbChocjTMUr3JMZAgWU0i8TgxNktsr3sCaIQ7KWhcUY5eSBp9cqkQpqpF+j9iSQ==
X-Received: by 2002:a05:6a00:179c:b0:64d:277c:77c3 with SMTP id s28-20020a056a00179c00b0064d277c77c3mr6369519pfg.23.1685153376435;
        Fri, 26 May 2023 19:09:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s132-20020a63778a000000b00502fd70b0bdsm3353650pgc.52.2023.05.26.19.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 19:09:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] checkpatch: Check for 0-length and 1-element arrays
Date:   Fri, 26 May 2023 19:09:33 -0700
Message-Id: <20230527020929.give.261-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; h=from:subject:message-id; bh=vKqvnzCM5SpLhQ8O+O/Nc6PmehDuOz4jt6QWnE/7V4E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkcWZdfT13jXdTYW+YFPsyIvGfnteQWoLDO4dhFPss qBm+SHuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZHFmXQAKCRCJcvTf3G3AJkVZD/ 0Rh075LZZ+5TArpoiQ9NIMQ8hrVZMIQWSNd7X2pVW2zd7g4KRKRfzPLfFZpVR8WwNO91nooz7xfitf qZJStfcgTJQB+FwhBKYzbpUEZIAr/qxDz7fjqlx14dMP0ixcvy03IIPMkhLciK2zX6xreKSzOrUWlH MHk62NGFTV5FTehb+TtzP+z8FcjoylmV0wNaEI2D8OG6q4mclwRF6RU58zLsClEslHslmIm62F7Ost deBOc5xG2dPknpwbX7QJIyv/f9NSEyjE91Xsg74Js1HfNNDVuU5/W+to1tjE81ef3ZnoQMngHXsQqE /cLpu3JO8aFCKjwkp4nx342CwvrWv0/UhFchOa4zy0Y6zmIFxlneWlwDbQy77QiOwcuuSzysU71xAV VX6qG+VX6BtqyALZ8Z+A2G/UrpREs9DoS5ZItyeln4+LRrS8rIxv4hS6Thn+5MNAJFlqI2wwTwo3au CEPSCuO3ZLoPhxHx93VKr1M+reU0pFxUUmchylgqOcndsEiiswy0/g65jixuPNWcmsmUm73wVWwh15 sZN4QoTF3VK2koBB52kJz9m/vgQTTe+1WnXIdbKAzPWH5CKv/fN5DgfX/vfPOmJ2tKK/zk9KhTKYpC XcCazGtX/QKZ+A7F97AOPhNcAi+diKaRdXCtmvLdaSmHtVQtC5nKi1EmkSdA==
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
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Fixed-by: Joe Perches <joe@perches.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230517204530.never.151-kees@kernel.org
---
v3:
 - Switch to ERROR from WARN
 - drop needless struct/union/enum prefix (joe)
 - fix $fixed regs (joe)
v2: https://lore.kernel.org/lkml/20230526173921.gonna.349-kees@kernel.org
v1: https://lore.kernel.org/lkml/20230517204530.never.151-kees@kernel.org
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 30b0b4fdb3bf..5307c85b93d8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7430,6 +7430,21 @@ sub process {
 			}
 		}
 
+# check for array definition/declarations that should use flexible arrays instead
+		if ($sline =~ /^[\+ ]\s*}\s*;\s*$/ &&
+		    $prevline =~ /^\+\s*(?:\}|$Type)\s*$Ident\s*\[\s*(0|1)\s*\]\s*;\s*$/) {
+			if ($1 == '0') {
+				if (ERROR("ZERO_LENGTH_ARRAY",
+					  "Use C99 flexible arrays instead of zero-length arrays - see https://github.com/KSPP/linux/issues/78\n" . $hereprev) &&
+				    $fix) {
+					$fixed[$fixlinenr - 1] =~ s/\[\s*0\s*\]/[]/;
+				}
+			} else {
+				ERROR("ONE_ELEMENT_ARRAY",
+				      "Use C99 flexible arrays instead of one-element arrays - see https://github.com/KSPP/linux/issues/79\n" . $hereprev);
+			}
+		}
+
 # nested likely/unlikely calls
 		if ($line =~ /\b(?:(?:un)?likely)\s*\(\s*!?\s*(IS_ERR(?:_OR_NULL|_VALUE)?|WARN)/) {
 			WARN("LIKELY_MISUSE",
-- 
2.34.1

