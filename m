Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09FC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 23:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiKRXn5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiKRXnM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 18 Nov 2022 18:43:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E6C76BA
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 15:24:11 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so657668pjk.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Nov 2022 15:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXVai3qFJ8ArPGICNTEIcWXEgGfS3utWJbObwOpoeVU=;
        b=NFSHO2ZSUb7w5MpWfNQrsU6nV0aGbmYOYqFMaJCHcOg3hTAKqC5IykbTpcmUt3u6Lv
         6eDmhrGA8AAvTeKdSzoVKbV8EbdQ6Ut0tRnph4lQ+iKQaHrc3CmGHkcgGJ3FJJP1u4ma
         r16CmGxHUb+rqEorMytkj4G5ymQJbwaIyVGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iXVai3qFJ8ArPGICNTEIcWXEgGfS3utWJbObwOpoeVU=;
        b=NoxCnRXeoO02kyefYkMma2yDGVLehMWkY7vOfHBqez6WkkArpB0cIeEn29KB56Ct0q
         BFXTOBhC/QHI8fbXGj2TBT0Ugg2Eah7D3XsGVXTU25sIy9EVPOqiV3dDLd7hi5cmWts8
         SgMHYjN0kLSDaS7g5gri2R1hhgCUakcE/zNJCSMR0Mlr7HvYu+JQypqTSXPeCPb91hzy
         XGHb2SMAAJTW/1AcOAMLe3u94FpZAlHMrTnyHYgdY3Fg1QrUnXMtgruLzZj5vLrxO87x
         Rk31eaOb40T3hkv/3G2EUTN3VkFy2wHkzqHQje7eB2G4ThNAueIxq7p2csfYJD8LZzHZ
         siOg==
X-Gm-Message-State: ANoB5plPJyJuL4AyCfhcNn1IhZQzgL4Oto1uWOxw9XnBMU1ir8WHYGfp
        h3coV2CR/zSTZV3n8x+d/zPU+g==
X-Google-Smtp-Source: AA0mqf462QZsPtBpPocdQx/0dVxSHHjjHXfgSRPni9vR4Gor5GuDpiFouzua+89j8xLUx81aVbqNJw==
X-Received: by 2002:a17:90a:6547:b0:213:d08f:a483 with SMTP id f7-20020a17090a654700b00213d08fa483mr9914547pjs.21.1668813833817;
        Fri, 18 Nov 2022 15:23:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8-20020a1709027fc800b00186c37270f6sm4294533plb.24.2022.11.18.15.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:23:53 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] ALSA: seq: Fix function prototype mismatch in snd_seq_expand_var_event
Date:   Fri, 18 Nov 2022 15:23:50 -0800
Message-Id: <20221118232346.never.380-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2388; h=from:subject:message-id; bh=LT8LvayoodyeGcJJmotl0W7abaTXyRbApRilntoVIaM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjeBQGxl97XSZ/V131zxWG6VCVlDXD5V6MNXIDGf3M dU2HgY2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY3gUBgAKCRCJcvTf3G3AJpNYD/ 970LXJu9T/r8J1MdqoqIR+muUaph3v/3r/JnVdIrugZjYUdZroQAGmvpKjF0NaevA5Rz+pYN8ejlBj QCPPFn5ld4zzw7miWLwRD05VvEonWs3fDK6yDqlRABnzMMa9TT0lLFvtxsLxoBMT5s9qf//qz59Q4C kJlTlPyMuRoTP6U3rbnw5ZbjkL1XWiQCUtIds/ZuIZk+lZU8qDtP0jBWfl2GpVsvXReyulyp7AkqbL pv+uGEb/ka/nhxaU7+4bse+EhIbJZ6d4hfuwkwjv6eAgbXjPV0cNc6D9/dKU2W7cvi6bD6bwwY9Z1F kHfxdJvYbQ+B+MTlG3O2mqN22daWBExivwMVg0gqOIyyUle1c4UceAT9IPZXOO5Ytvb3sHAdi3FySz riUxg7OnQoqX4ZuaEAiRtaeIKXp71OaAM2dSFQfZBwB0EkiG+fC5uN3Cs4g0nRt+irHwt1KKCnF/I9 owyMxTCpvATaqHdA3h+cfpn9xjWayAWEFTkd1duwlgCx9gT72iAKCzpDSaVEY1pzHHI+Ln3obru+it k9bsAVVu6S6l/VCU9Ul5sP6yxcHNx/SCeproJkeKDuNgk42tk8FP0RNs9P4BNVvqwszpuwfSwHuLqM exJ4TGIXwDqUUOs4vVncpMokhUYJqkBaLE55d9yYRqhWomued0koClDyDE1A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed.

seq_copy_in_user() and seq_copy_in_kernel() did not have prototypes
matching snd_seq_dump_func_t. Adjust this and remove the casts. There
are not resulting binary output differences.

This was found as a result of Clang's new -Wcast-function-type-strict
flag, which is more sensitive than the simpler -Wcast-function-type,
which only checks for type width mismatches.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202211041527.HD8TLSE1-lkp@intel.com
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 sound/core/seq/seq_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index b7aee23fc387..47ef6bc30c0e 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -113,15 +113,19 @@ EXPORT_SYMBOL(snd_seq_dump_var_event);
  * expand the variable length event to linear buffer space.
  */
 
-static int seq_copy_in_kernel(char **bufptr, const void *src, int size)
+static int seq_copy_in_kernel(void *ptr, void *src, int size)
 {
+	char **bufptr = ptr;
+
 	memcpy(*bufptr, src, size);
 	*bufptr += size;
 	return 0;
 }
 
-static int seq_copy_in_user(char __user **bufptr, const void *src, int size)
+static int seq_copy_in_user(void *ptr, void *src, int size)
 {
+	char __user **bufptr = ptr;
+
 	if (copy_to_user(*bufptr, src, size))
 		return -EFAULT;
 	*bufptr += size;
@@ -151,8 +155,7 @@ int snd_seq_expand_var_event(const struct snd_seq_event *event, int count, char
 		return newlen;
 	}
 	err = snd_seq_dump_var_event(event,
-				     in_kernel ? (snd_seq_dump_func_t)seq_copy_in_kernel :
-				     (snd_seq_dump_func_t)seq_copy_in_user,
+				     in_kernel ? seq_copy_in_kernel : seq_copy_in_user,
 				     &buf);
 	return err < 0 ? err : newlen;
 }
-- 
2.34.1

