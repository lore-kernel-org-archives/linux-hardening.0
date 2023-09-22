Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395743A81
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:50:24 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E384ECC7
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-578af21ff50so1797936a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405017; x=1696009817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9keGpI24f73ClY+CDWArkkyfvsmbI4ZAwNSISbMEuk=;
        b=HCScKNGQ9djV4FJJFL+r/OeIwkUmaW1MHBaCQYB1F6FJlRz0zHwxJJMx71X7QgIYDN
         Aaa0RM1R2lxKqzNqQ0sAHgbyj29/QLqVkiArMhaLIRusL4PfOXkuSWnYsTOgPIyNPCxo
         I81eurxFBlveuYEzV2Z/s5uaKQPeNiDkuFOjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405017; x=1696009817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9keGpI24f73ClY+CDWArkkyfvsmbI4ZAwNSISbMEuk=;
        b=SXSX/dCAcjf5X1u4S5GsKsO2qdWzVOPLmyrMaedpB2Nlh9E5gHTh6s+5EDL27kTxcw
         AQEEbSprKZpwW8MoxHlef6dgRNk5FhgyNxSQK8sxcVAydZ1yzUbjXIbA5VRVKC8J4fUD
         /COg5B41e7RAxrOwkMWrkXJwFI/24TsfwKHdOjsvNKP3vgveLFrUsp+GvNYvDl8sM2p9
         YuazeEi+Ph/1ERnlSP+noOV8Q0AqUH95X5WuRiuDJkce3lnpbXYGONI4O58juL46Sw/2
         M+KzyQ1yrZ+5Jbhp+A68f10XhhReXyWvF+AthUNDgC1idhk70lzJr0nhJlx8fvD3ucxZ
         iUNA==
X-Gm-Message-State: AOJu0YzGKn88wVlz/oKJ2NcvCoONZae6xMx7dAAdHl3rLT5zfjV1CK0j
	YUxi336g3PlvuDOMwHff94upVA==
X-Google-Smtp-Source: AGHT+IGfcvrozhcUEUzeu1USWPMbEzqOOs271XXupxZ4a0g5Mv91RocyYCRFpFcCdsq7ZZYXC5wBrg==
X-Received: by 2002:a05:6a21:1a5:b0:130:7803:57bd with SMTP id le37-20020a056a2101a500b00130780357bdmr225662pzb.3.1695405016897;
        Fri, 22 Sep 2023 10:50:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b0068ffd4eb66dsm3465165pff.35.2023.09.22.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:50:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>
Cc: Kees Cook <keescook@chromium.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] i3c: master: cdns: Annotate struct cdns_i3c_xfer with __counted_by
Date: Fri, 22 Sep 2023 10:50:15 -0700
Message-Id: <20230922175014.work.637-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1216; i=keescook@chromium.org;
 h=from:subject:message-id; bh=nFAdeiJyBBAN2nKXtTbKJp+l0ifJ3TjsMbq5N6rgU9w=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdPXeEDRSo/vrvPQpWyJYQlr8t8eeYkEi3JUW
 aibP2KoNw+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3T1wAKCRCJcvTf3G3A
 JhqAEACFSx47UGcJAEXS4JS+FsFG8ENlzAj09y+6MUbVP+WFjPpnkap95ejxcB4GSfsDCqDxk6l
 LI+ahUhhLo96bzoYSLBN9IV/bTNp+UCcPA60RZwi1hEFT516danvY6/UgAYBXnWHjRT2mwY3odX
 yy3kqrqLDUnE3ETLmj7fMNLBhq3ZuSq/m/XUToa9/h+24FUfhzbUTBikmHvfAcveyS+RuxjO9qY
 ed0C41STALin8Mqjuy9khWvT8vR42ScDvLuGiyXsymCn/mx4I2J4ddu5LH/2IS8VU2YmaMNctjg
 ptvies9UobnLJBW8R/IZHZ04Beol8N6tigZtVT5CCdCkn8LX2w7ZwYR6ajB/A3/IaNSW5exMyyw
 /fok8hnoJA/gcVCwUm16AX3pOIbVUEDyHaFauMP6vJZ0zHV5pJOJCTylmIizWc9HTOYV0NHkpwb
 8JEjbN6xmyxxkPy2SpwEdxWpngNkl4BRwZeyOV2LFic3mtPOPfrJkhQU/qUmsdaqacHAXERuTHh
 2KPB99gvcM+fdO5CeCkrYIa+gNwDc0xfAcKIM3tL0FOVaulCGqw1bIFmIV8j6FJCbGoY+GObpnT
 xUWz5txRoRBsr0UsApv4Bsd5OFnimSTXLoSBWdriF4p1gKcvsPpxrqYI49ejrS4hjpmZDrCM3CX
 mLCiun2 ZcNO3KyQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cdns_i3c_xfer.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: "Przemysław Gaj" <pgaj@cadence.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/i3c/master/i3c-master-cdns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 49551db71bc9..97c1010956a0 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -387,7 +387,7 @@ struct cdns_i3c_xfer {
 	struct completion comp;
 	int ret;
 	unsigned int ncmds;
-	struct cdns_i3c_cmd cmds[];
+	struct cdns_i3c_cmd cmds[] __counted_by(ncmds);
 };
 
 struct cdns_i3c_data {
-- 
2.34.1

