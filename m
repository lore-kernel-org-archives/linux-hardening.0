Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446A4C48BE6
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E332611EE
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Jun 2021 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhFPV0x (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Jun 2021 17:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhFPV0s (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Jun 2021 17:26:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5905C061574
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 14:24:40 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q15so3079534pgg.12
        for <linux-hardening@vger.kernel.org>; Wed, 16 Jun 2021 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5E1SQNLd76ibUeH+2DFu6KGFVDhFo4DV7kkPa4G354=;
        b=kjburgoT0Xs7ejnUzYiQsdkffwpvSyj1yiMQlzNc6vQxwrj158PoGNbVSh76DkKhjB
         O+yrJMIi8csmOnOvj8poT6urfk0gWYo2EiuU/8CDBd1qbq+J1j3qhc0IWXQLGx8lk2cw
         258uU0G4uOgcwtxFjaCmaR+Q8liLnibb8sCxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b5E1SQNLd76ibUeH+2DFu6KGFVDhFo4DV7kkPa4G354=;
        b=VqTiZhR2u3/VO2mdr6Jb+Rf4h/PhYIQ8XyKPyRF6Q1/ZeQ4kh8HX5aoZQDuOmM+WRa
         sa3fuqs5EiZzbtF/zqKGjVDjFMF2xm80xbjjSNeicpQufCA5fks7t497OUfZDXLVpQFJ
         qzCcJLqopUgg1TwTb8MNc2R+g9hGqQJbPBiZWZqNLMn/k6HIo94ADrvJR8tc+YKybytg
         aE3dWl+4vOQEuQm3DT/RRnb3kNvTS54BTMKqS8H2USp7dcVQQfWSi38KMo6awnkgAPN0
         sWRp/hiO7sEIJzzEkbY/UJ6oDtFTbHX8Sx7RtyvRDUo2sX9mn9PsK1I3WCdKC4jBXp3m
         0qIg==
X-Gm-Message-State: AOAM5308wPR0ZifcMGtnDIAAMHC9M+an1w1glBXPpwLolbXmOsJ6KBQP
        Q58BT0c1/g56tyBsPwhbCP+bew==
X-Google-Smtp-Source: ABdhPJw/i6BOFV5Z8bye48TPZhuk582hhtCYa7kDZqBjGxNK0+Z4XgEEZfZozGj5TqCljFOXpTwAWw==
X-Received: by 2002:a63:be45:: with SMTP id g5mr1582906pgo.311.1623878680508;
        Wed, 16 Jun 2021 14:24:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm3034662pfd.115.2021.06.16.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 14:24:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: aha1740: Avoid over-read of sense buffer
Date:   Wed, 16 Jun 2021 14:24:37 -0700
Message-Id: <20210616212437.1727088-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=9f276be9ba86c59e1cfc8f9e74692a89f74de447; i=HxhY6VrBZGZSXnwIUli+yDHcYLcVQ3aitUx2JWkck24=; m=YYp1KgEft0ENRYsItgScCTB25EGR9fHPvH0/GU15nJg=; p=vw5wds5l94thyHGmfxjvXMUhEQWT0JLvYm0YcfDaCdE=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKbBUACgkQiXL039xtwCYiQRAAp5e iITQxZgNNb0oMihKejso0bRTU4jiwrDe84T9B85NKWlx7RD5xxznTXcZVnh4MjLnb9FYEE5BHWdH1 XF5PmnA/cApQYgo0MVJTNpwLYZQMxBicdyvpnLLIThqy1B4JHvYqzGNCcRMu5LG/BI02WT3ewVkND JE0ZAeV0zSEBruZbfPvsOar6zuDPRzKEX4Cj52n8/g9Vk4HEw9zpCIu47kxoOAFK8a0uRfHD3N3+6 VDf5D1CX4bH5Ki4lyj2foHMTG3XdR+tdOy1I30nHRJrsL3/3pAYVsvYo6s6zdEm7aZeRKeDgUAuSM rl/GG11/r6UOzxjI+oHugUXB0cR2DUVseeXZ2UYfmRGlgXtaYRCUrcZiWVhXuJHa6xDCQo7dePfKX se3rjGdbscTV5VLB65I7Tg8rImFV6WLdDtxfLnhk2ixLvQSA/oCCh0RI1WrHrm83oN2n3kO/DJjls KkhUTTdTdfzYkIUExqo5d5TnLCrbWbEu7vsNVi0QDSRCEE1s/tLtihOIYfLtvYZCc3GCMB5iurJnj /zO6vOOTDXoRzolxq/w4RzvNDcUN3bj/78Wo3Jsw5zlVvFXOl0iUo6tzp79xxE6FLj4bv6kiHZklK wWIUsWVVCBFJul//Uu1exZSIWI05bVHHyLGs7H6Z+ehmT5SN/gxgZHvtQnhYPZRc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally reading across neighboring array fields.

SCtmp->sense_buffer is 96 bytes, but ecbptr->sense is 14 bytes. Instead
of over-reading ecbptr->sense, copy only the actual contents and zero
pad the remaining bytes, avoiding potential over-reads.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/aha1740.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index 0dc831026e9e..39d8759fe558 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -267,8 +267,11 @@ static irqreturn_t aha1740_intr_handle(int irq, void *dev_id)
 			   guarantee that we will still have it in the
 			   cdb when we come back */
 			if ( (adapstat & G2INTST_MASK) == G2INTST_CCBERROR ) {
-				memcpy(SCtmp->sense_buffer, ecbptr->sense, 
-				       SCSI_SENSE_BUFFERSIZE);
+				memcpy_and_pad(SCtmp->sense_buffer,
+					       SCSI_SENSE_BUFFERSIZE,
+					       ecbptr->sense,
+					       sizeof(ecbptr->sense),
+					       0);
 				errstatus = aha1740_makecode(ecbptr->sense,ecbptr->status);
 			} else
 				errstatus = 0;
-- 
2.25.1

