Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4986AECAAD2
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Sep 2022 20:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbiIAU5f (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Sep 2022 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiIAU5e (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Sep 2022 16:57:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE080B5F
        for <linux-hardening@vger.kernel.org>; Thu,  1 Sep 2022 13:57:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id jm11so18163203plb.13
        for <linux-hardening@vger.kernel.org>; Thu, 01 Sep 2022 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6bNaco3dz7IXQ11OXE5kaxXCKtEGcZVScgtt1VLo0BY=;
        b=lz9bmAcSmJgqr7GHx+GhotVgFEl7+NLMUFsxU/Z8181ZKalwXzq956AcPOKxCTD6fS
         5EyA5gCbMzEjufG7GCMLoVPUiKr6r3Ua1lDVdOrMmzUG6PjXUgoSqajP6vOAef2Ssjww
         VXIx89M/XqRQw5ntFMdvGg93Oj8t/Z/2Ubc8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6bNaco3dz7IXQ11OXE5kaxXCKtEGcZVScgtt1VLo0BY=;
        b=nhybtuPptr7fGNdadxTMkfdsr8cuLvr1Herm9COrwNO0jBnYyZ1OzOa0uJDS+PyqAj
         sZU90DsyBH1rRkLW7t4EpDKgsgYEGtLWMoWqy2ABRu6kI4tXhfugdygYIxsKoRx3x5W2
         0V5Ib4GjP7zU2FgEb1Ax46I+etF9/Y5Y3yxwijfCYhYYroWTSAo/+EjymVlLxA0SjBWV
         khUadF1XdYdR8IaZxrjiYJ45WGofIg6UIdWR5Mr33Z569t1xfcJadQgXmefMTNOZf+UR
         NVPfwiQBluDBo+9WLhRv9Fr7w2dE1+DbzBQNeq0vlLNx6ASJ1OibmBUa/w62aJhBxAUB
         M1LA==
X-Gm-Message-State: ACgBeo0y+FOwZWv6uSGQgGtwcjuib0Rg1aSujkdO6g0P8Ciu9xFq7RQX
        IbpGfO2OwhN2l7ZAAJJCxVlY6A==
X-Google-Smtp-Source: AA6agR7iYr8HTflzB5me0MkRmvnvfYeC6NEJ6l7HP5sKFbAtQiONSlkryqRFPN1gOjYeKmeUHaOT2Q==
X-Received: by 2002:a17:902:e549:b0:174:d234:6116 with SMTP id n9-20020a170902e54900b00174d2346116mr19871188plf.131.1662065852382;
        Thu, 01 Sep 2022 13:57:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79d06000000b005379dd2deb5sm26442pfp.137.2022.09.01.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 13:57:31 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bradley Grove <linuxdrivers@attotech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] esas2r: Use flex array destination for memcpy()
Date:   Thu,  1 Sep 2022 13:57:29 -0700
Message-Id: <20220901205729.2260982-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; h=from:subject; bh=oUzuUGbXdkp1+ygGE/o7VtLMEMLuK7W2INwNNN66ZAM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjERy4i+Rf8Ayy4CrbV48DD/6X4DpAkroVm50Cj5uh sv71xE2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxEcuAAKCRCJcvTf3G3AJpDzEA Cd8W1sY7X84DJ0FrmFfuLa+ZjlQQUatfnd7b0ruJ68IJaDPeOBHvXksHzTL/lgsx7soHMIkKWKCSPu RrqxHmvFixKDblA8BpS7hbIIJeegU7sBtdnAki9ia8p9FApIdmXhPFyMMz2fM4FA3CyZgfnRayc48+ 6Smxu+Q99NPoleFhpCsmXinnnJTDd503wTO4NiGpTbcDWrPYeJ5e0x8GnUEAVROhULxlkRlbxpHqI3 6gqMM5Ph1XMND9OCIXJfZcYeLz7SvsMGOEHRmd4w8IhVI//X9y58Q2Cbsx8mY+wIVUgqOCfp85Dg6G m7W2S5lHhnXDb05xNwS5YGl7mS8ThrQ7nJE7lD33AfHhJJlYYgJn2gNah6DT4106PKIO6UcZaVByJE 8PWIl91PWIQ4QNPUqv0n/mnp6B/NP/Mg74OSl2CY0WJaDtHATF/jd20/8QyF4XZB+LlN9ET110uehr lSz3IVpK9tAaZFo0fceOl5ugCL817Up04qN0w+QP5s+DwzvfW5Pg/VgtL2SRHh7vz6odv0UTLW/t5H EuKeL51g+Fr4i1v/AUseF/TmkBqIbnSbs1a9skbGAqagXtVVvITH51oRMKmQYiTe2fICbLIuMHoaw+ A4CNBWPQU66jahnexI3eWPFDQFN/axCMKgHgkMo7CDFwpzIFY1NwOe8EebMw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing run-time destination buffer
bounds checking for memcpy(), specify the destination output buffer
explicitly, instead of asking memcpy() to write past the end of what
looked like a fixed-size object. Silences future run-time warning:

  memcpy: detected field-spanning write (size 80) of single field "trc + 1" (size 64)

There is no binary code output differences from this change.

Cc: Bradley Grove <linuxdrivers@attotech.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/scsi/esas2r/atioctl.h      | 1 +
 drivers/scsi/esas2r/esas2r_ioctl.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/esas2r/atioctl.h b/drivers/scsi/esas2r/atioctl.h
index ff2ad9b38575..dd3437412ffc 100644
--- a/drivers/scsi/esas2r/atioctl.h
+++ b/drivers/scsi/esas2r/atioctl.h
@@ -831,6 +831,7 @@ struct __packed atto_hba_trace {
 	u32 total_length;
 	u32 trace_mask;
 	u8 reserved2[48];
+	u8 contents[];
 };
 
 #define ATTO_FUNC_SCSI_PASS_THRU     0x04
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 08f4e43c7d9e..e003d923acbf 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -947,10 +947,9 @@ static int hba_ioctl_callback(struct esas2r_adapter *a,
 					break;
 				}
 
-				memcpy(trc + 1,
+				memcpy(trc->contents,
 				       a->fw_coredump_buff + offset,
 				       len);
-
 				hi->data_length = len;
 			} else if (trc->trace_func == ATTO_TRC_TF_RESET) {
 				memset(a->fw_coredump_buff, 0,
-- 
2.34.1

