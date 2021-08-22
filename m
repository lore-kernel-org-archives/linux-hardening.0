Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0FC4320E
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673A66128A
	for <linux-hardening@archiver.kernel.org>; Sun, 22 Aug 2021 07:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhHVHwL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 22 Aug 2021 03:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhHVHwK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 22 Aug 2021 03:52:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E7C061575
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so16636133pjb.3
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwHDlRYGw2pe2VpozCEASD85dDS6sHxCPa/xDSIICvM=;
        b=VJB3FTt5q3R3nGTwAgDC29A/KPNoR+UpkxoBw0Dq4oRvBhiadsp7xDfQYieHFnlYbk
         4FxWfTV91NYwkFNCEBLbyPpmTlxrZQr0gC271DLHzeiQnbnlhlxApp/G+sbOQk8iU7Eg
         P4t+2DpWPq78fX+VsMvxWmM5/zw7BIsDMwPjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwHDlRYGw2pe2VpozCEASD85dDS6sHxCPa/xDSIICvM=;
        b=jep83mQSmLD88FPaYddb0KTcuC8wCqjoVs+292pVvZMXRD8uCyjkjrL8c+VGLJVKSp
         DGdyNrgIr0vpA6WkOaO8b0CuyE6L7wmU312i7PFsJWempjpF+4iFpsMlDMgjg8j7mp2D
         u7uv7BTVG4FEEzeRAfRqrhuPPFW71EoyoFMOVGPqjMfLQrBLb1YYidWorvfVhLoVaeQ4
         SAolI+GMQZHwqg3R8hw0yW231C6Qo1qx1PXgz5CXSbMQzzsCw5dnBqApwjI5SQXf/L1V
         /0ARXxc4l4p/HWaM/W8C9erVUj9MDKl2AbPGZiaVV84DZd8+g4HRuloY6l5JEJowyty9
         WE1Q==
X-Gm-Message-State: AOAM5329wM+z8t6BP0o46S+3DXLOzbpOR3fCulQNbJQ+tCcPyrFau27h
        xtu46MdGXM10DPTQPj71PK4W/Q==
X-Google-Smtp-Source: ABdhPJy91PqrhLQGvyTAftsayxdZqXZXrWDF2+1RCGOwRui/AsaObRqzH9olXGQRjCk+pfD4T5l3Nw==
X-Received: by 2002:a17:90a:1f09:: with SMTP id u9mr13451822pja.206.1629618689283;
        Sun, 22 Aug 2021 00:51:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j5sm16177432pjv.56.2021.08.22.00.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 00:51:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
Subject: [PATCH for-next 01/25] scsi: ibmvscsi: Avoid multi-field memset() overflow by aiming at srp
Date:   Sun, 22 Aug 2021 00:50:58 -0700
Message-Id: <20210822075122.864511-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210822075122.864511-1-keescook@chromium.org>
References: <20210822075122.864511-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; h=from:subject; bh=ug7KtAnqHA97F0XIHxj84B1vcjl5KTaHRbDt5BL2iJc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhIgH029iMytTOfEkySdRelPdaDhR6VhLaGeRkdoDa 4ABOm4yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSIB9AAKCRCJcvTf3G3AJjv2D/ 48Fr/XBXtchVss+4cH6PQaHpgRQzDXtB1e3n+pg90FdtK9Gu2IOW5Eeo4HeRN99/sieQG+UcSe490f qdjzZblkN7rCOZs5uC7Qv2WpSpX0BBhVlJiGfxEbCTMtN/McHWDMfDGmctuVYCjiFd7y7Qpjh/L95Y m7MEuz01lgiYVwA7kXYcrKV101D+aRlU+gawH0a187wiLOGq8y3BJAooZKrFbYl1355a2kJZCjPGoC hfz0Zlx7XRVAVlQj2eCSdwACSCDiDmZx+gKHkVGAa0CtgE0F32xohvWP2x4Yt3yFRHQZDV+m2xqDvg jdu7NtA6bQe03uJ61mDeZEZmxbYOgkiliI38njvH83Gv+Oio1sCmUJjxyDGm325T/wynBN5hbw25If e7zPYndMKDwfXXY+dtyCHCMOh0rwCnS8C5qg3Z+ez6sc/fc1H3oGeSo4BsvngOPFd0iFMrdzhmT9Y4 eXJZW8YHVV7l2UMynV+iVHszGnG5p93QrqnK5KN++aRu+Vr8WKiP9AlwHb8ALA+9vT6sy4fojF/6p1 yL/9kO9S1YrHvKzdaJA1a0FZiq0azd5ExdJrqy3oB43u2iZm/iUYWiea6jYZ0NIrVuHaNcIy9Dn8By CUJjki1mhqlzaYinYiWB2xUvQmLUuuYrVcDc6adS96luBv0lQeyKTVjBPPdw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Instead of writing beyond the end of evt_struct->iu.srp.cmd, target the
upper union (evt_struct->iu.srp) instead, as that's what is being wiped.

Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/lkml/yq135rzp79c.fsf@ca-mkp.ca.oracle.com
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Link: https://lore.kernel.org/lkml/6eae8434-e9a7-aa74-628b-b515b3695359@linux.ibm.com
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index e6a3eaaa57d9..3bd3a0124123 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1055,8 +1055,9 @@ static int ibmvscsi_queuecommand_lck(struct scsi_cmnd *cmnd,
 		return SCSI_MLQUEUE_HOST_BUSY;
 
 	/* Set up the actual SRP IU */
+	BUILD_BUG_ON(sizeof(evt_struct->iu.srp) != SRP_MAX_IU_LEN);
+	memset(&evt_struct->iu.srp, 0x00, sizeof(evt_struct->iu.srp));
 	srp_cmd = &evt_struct->iu.srp.cmd;
-	memset(srp_cmd, 0x00, SRP_MAX_IU_LEN);
 	srp_cmd->opcode = SRP_CMD;
 	memcpy(srp_cmd->cdb, cmnd->cmnd, sizeof(srp_cmd->cdb));
 	int_to_scsilun(lun, &srp_cmd->lun);
-- 
2.30.2

