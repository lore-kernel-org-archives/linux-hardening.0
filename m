Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA96C3DA7A
	for <linux-hardening@archiver.kernel.org>; Fri,  6 Jan 2023 05:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAFFcE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 6 Jan 2023 00:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAFFcE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 6 Jan 2023 00:32:04 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427CB59FBF
        for <linux-hardening@vger.kernel.org>; Thu,  5 Jan 2023 21:32:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cp9-20020a17090afb8900b00226a934e0e5so4899074pjb.1
        for <linux-hardening@vger.kernel.org>; Thu, 05 Jan 2023 21:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDx13T1WyNEDcHgL9peK/d02wCsf6cJRukFaj1+Gvbw=;
        b=Q3mGGyvELCxJWF4lwpfWiujWC98eGd3PWJaTtu8NNQ1LC0obDeBWAM4pzJ92/B4sNF
         y0gJV/F4JiSymfTO7jWtvDungpO79zLd7SzReYTdsaJcX8UAyYrzOpMoFh5n600lgzdq
         4yGR5VUoefF/cGBxrGRYy++5Fm4wjKy7EUqoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDx13T1WyNEDcHgL9peK/d02wCsf6cJRukFaj1+Gvbw=;
        b=pZsl12ks6fbe0xXh+xh4s44aSE326/15J1qu5+DRCLm9adkmOuIN2YLSSpNPx997x0
         K++GchJYpCysABQQ/QFAUv15rlNSycerIQUF+GujPHCFcJS+ld6Hz1l5upS1YqgsIIlv
         EgGSSw55t1H2kt222SNr1XC7y59sATWjo8zGQNWUM03xphboHo1QSqY3kBtkvnfebZd8
         w0j8T1ZArRxyY2BWYSJox1TqHYDuDyQdRzQrOAclVIAyJ6e4Kut/tByS7UEdpqr148uj
         IkobejTAMk0p+F0mOhY+HSfRYQiM/hwAgUTXxMlHufBJwjDLZEdKyoTfQEabheGDybkt
         7rxA==
X-Gm-Message-State: AFqh2kp8YH8OOklgR9Z4cfMyl5Y47xeHEgBCgzEhw8d71FJfWEufhE+j
        M6SJEb8Pe3QwJ51v7uZjMk2l7g==
X-Google-Smtp-Source: AMrXdXuqhDqfl+8sh8p9pCHUOC5BZD44rVXtZ8kRGU/Wn/ZdYH9TqqBtPCeRFJTUnMscjFsTKnu9EQ==
X-Received: by 2002:a17:902:e884:b0:192:c014:f6ba with SMTP id w4-20020a170902e88400b00192c014f6bamr28912909plg.33.1672983122755;
        Thu, 05 Jan 2023 21:32:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b00177faf558b5sm26793562plg.250.2023.01.05.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 21:32:01 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: Add flexible array member for SGLs
Date:   Thu,  5 Jan 2023 21:32:00 -0800
Message-Id: <20230106053153.never.999-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; h=from:subject:message-id; bh=PC3YosJyPt0nZ3KotlfA6dcjv2ic/ypDVABveuPLVK0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjt7JPI4muvKe6X1dF8Tnm4AnDl5f26NWnzSTTup/O RyGk19SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7eyTwAKCRCJcvTf3G3AJiOkD/ 9mpgZd9EQxRFqOiY8Gklqldv7yrl9/sXFuydGTdfAoIfVTCv0izWV7ES+DGHywTbTtrLX6tWXzd+Yc BBajhlPUvW8ZyweXeV79hdwQkQJzOvT9FmXRkq9xYd0kIGd9JWS/z6gZFLsXw/TBTzLGuKv9835QBl NyvV47ggnZdgGWQqMDcVZ/yJraIj6WtI7YeVgu0+zapMUm8TxXHPzoLuVaJdRabDeGV/aiQFsYHkB3 Vrthbu0iZFSZtUoCHRfE9Ndso56Xmn66Tw0NysFITdITLPzLmsGLMOs9PcHgi2sqtNPLK/gJk8/Ruh yZkpFFnHT18hhLbCSJfa1LKE35XsdcpPqyzo18J/YPsq2yG5k0H+FSyiM+LyKDoJIbtZNiWmJfmuUG tFrmi4liD1BZgYq9MgSdmMB8jiUiDpi4c5JaN3NUnQJ0UuadlTfuTeSAOleb93JIUnPqMOF5ppjExt XSIw0GUxdz/Mn5gKgEK9yoOrCmooQnLdxd2/XwFU85Er0VNuvPwCtAy/7LJifhlA/85XhRTS+HLXQF J12bl9csOPN64j6q0zxJwfHeOvTvd2YfMm5QmQ08x1GkJ4xH/b7Fah5xlLivGHDytoYU/Dg+fyWEqp Q5UHufwTIuwEbUh4H64d92uIbLgrvF97RvS0qY89yBUOcuY3W8+RFXdhk9vQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

struct MPI2_RAID_SCSI_IO_REQUEST ends with a single SGL, but expects to
copy multiple. Add a flexible array member so the compiler can reason
about the size of the memcpy(). This will avoid the run-time false
positive warning:

  memcpy: detected field-spanning write (size 128) of single field "&r1_cmd->io_request->SGL" at drivers/scsi/megaraid/megaraid_sas_fusion.c:3326 (size 16)

This change results in no binary output differences.

Reported-by: Holger Kiehl <Holger.Kiehl@dwd.de>
Link: https://lore.kernel.org/all/88de8faa-56c4-693d-2d3-67152ee72057@diagnostix.dwd.de/
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: megaraidlinux.pdl@broadcom.com
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Holger, are you able to test this change? I expect it should do the
trick, but I don't have the hardware.
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index fe70f8f11435..6597e118c805 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3323,7 +3323,7 @@ static void megasas_prepare_secondRaid1_IO(struct megasas_instance *instance,
 	/* copy the io request frame as well as 8 SGEs data for r1 command*/
 	memcpy(r1_cmd->io_request, cmd->io_request,
 	       (sizeof(struct MPI2_RAID_SCSI_IO_REQUEST)));
-	memcpy(&r1_cmd->io_request->SGL, &cmd->io_request->SGL,
+	memcpy(r1_cmd->io_request->SGLs, cmd->io_request->SGLs,
 	       (fusion->max_sge_in_main_msg * sizeof(union MPI2_SGE_IO_UNION)));
 	/*sense buffer is different for r1 command*/
 	r1_cmd->io_request->SenseBufferLowAddress =
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.h b/drivers/scsi/megaraid/megaraid_sas_fusion.h
index 49e9a9048ee7..b677d80e5874 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.h
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.h
@@ -526,7 +526,10 @@ struct MPI2_RAID_SCSI_IO_REQUEST {
 	__le32			Control;                        /* 0x3C */
 	union MPI2_SCSI_IO_CDB_UNION  CDB;			/* 0x40 */
 	union RAID_CONTEXT_UNION RaidContext;  /* 0x60 */
-	union MPI2_SGE_IO_UNION       SGL;			/* 0x80 */
+	union {
+		union MPI2_SGE_IO_UNION       SGL;		/* 0x80 */
+		DECLARE_FLEX_ARRAY(union MPI2_SGE_IO_UNION, SGLs);
+	};
 };
 
 /*
-- 
2.34.1

