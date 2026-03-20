Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290441A6809
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 01:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969018; cv=none; b=MA/AE18ZrUfdk3XtRWaaXfeatR07tBm4fEeeb1YXEN4VV/bl0Z4HreHzQsbnjkEflI4KG5c3kA8WpKvAxw54YQxnLwvfjuO024MT5GZC/ux6aucFtpuEaP/VPLMLMdCxVzryvsUVwvxf8glEGWD0d3b/li5PHiohceSLhVQruNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969018; c=relaxed/simple;
	bh=27JPzjJMDDgjf2qMis3eedxFTyNiAGX6kPcAnzP2/20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlIcH6cWKezBQEt3zIOm7C1+LfgifL6WEGjjO8DYx5+mxAIGXjzN/lp/puQqvAB3k5NqBm36vzlZ0E1kGFoiQAJChjkE/6PudkeJFPuOGnVjBxedjGTDZcCG1L8Be2gQ3zSBDpEw0o673p6AiEo9nWlhM24RmS7WxPbVerXoMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmZlfiPd; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmZlfiPd"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a8e873ca1so7653757b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773969016; x=1774573816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdP8K3+cAzx0ganXl8vq/PIp0ujTWW+NWr7suf1Oel0=;
        b=kmZlfiPdODOCvSU3eIci9NvNQzSPXDG0VOJinngreh/sycfaobk1/gN6c24bKbGk59
         GUuCkxe3zL7On+7dEWrf/kgfgxgbVJOvh1PLekF8opDHCRhWvsw6V7PRMrC9w8t01cbl
         q2lgoNCY9ajBXG3WXser4o4KH59xPbwJA9wG5bbKnXfA0XFbJ+5zEe07frfc8jFm2D6z
         p4i5XPyruwbw2Td57o4542JOnEmIDemPdV+/IVrenwmFl3q9JqZ8eCYdjicmEJLKHN97
         51p6oHqHs9sTno4SypOBM1ozb6vw70B6Ns8+bT1rJIQuNvH+dfZYDAkVO/NsdvqVHiyn
         bf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969016; x=1774573816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdP8K3+cAzx0ganXl8vq/PIp0ujTWW+NWr7suf1Oel0=;
        b=o99evae+Y3+l8gs0iZ0lceh0Vb0+SwY7hV4Y5zF6rFEb7bmsr0KgFrT5CAkH0vkAYf
         JEJJwHXaLH4Z9PqiBM/n8U5EwsQGERCvRHrKIv4lrPvSZqrfy6lIAc0A6fcHO9h7zG5k
         1BW0rfnrHgtLCOljZ7lkzgh8UgVb8KehgXby14ZrhuvAOt1mC1vJsrIrC3rV93Dz7U/W
         yRwvbrmIoFHQDoRCq0TH4i+Usx+hLMt0nkf5io8ZSRKJ8pkPHxjA0D5pMnZrQhY0lLvY
         SQJmi0RGvttEu5uQS0RLfbi7K7iYEEIXV7px0zp03I5KZKT3q5youjQLUh7uG+hJ9Dw0
         jv0g==
X-Forwarded-Encrypted: i=1; AJvYcCU0zQ6ao7zQal+DxVDjQs8rHjnQOZHs1ZY3Sl7JMIqrQWeEHJIB7XSn6AZmpvhO4qfDRtjFO+FmgiSg72IZ7Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YJXC8Imjh0PPcchrl2sGtctwmbvK0lvLBK8RQ1It1LsuND+Q
	iNVBqHog3GrJbom7MNy7LJ88pFWObud1Zaz00VICi+rwZaVp7s0QBoGK
X-Gm-Gg: ATEYQzzm9/GOgYmF93A/08ikSmfJJYhTNsQ2Ok1GQETLtszHubatNwUEo2BEOJVRrfW
	N1btwCEqIeLPwYA83T/xsyTSydJ3MvIb3qRu3gMIs+hOc/cnSGahTCnO1qabD1Xn3u+VXBvN3oK
	YtZxgvSaxWHJE6KLL8Oxr5Cc5yyCZASuyDCd9PjaBQiTWXEBa3vCMlV9xE6Pxb6opd7PWV7Zezq
	Jruw+/M/69TlBGexChwBlarMkSF/8eruQ3WjhKsJmxHpIfoco+J/t3xC+ymC441zmp3MZoXh6nH
	Vk0ARLixGAqqDFSGwNblQatsLNC8VcQohw9KzOHueSYFK4eEksWqBkwh5kdzUKx8Sy12Rf0Xjsi
	B11ZNCt8fhHfWYVPaIqltl0E2nmJTZtmmAPCoApIdKlxisdX8wkSMf5IgKcPKpzN50QgjATSYJ3
	UbvFrWEZSHOgvUlmi+gT2gozlHCBVqBZugmxES2O1tuoRcoIuD9NtJeKI=
X-Received: by 2002:a05:690e:e11:b0:64a:db29:5e61 with SMTP id 956f58d0204a3-64eaacd241fmr1049059d50.32.1773969016093;
        Thu, 19 Mar 2026 18:10:16 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabd44121sm515493d50.1.2026.03.19.18.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:10:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] scsi: be2iscsi: kzalloc + kcalloc to kzalloc_flex
Date: Thu, 19 Mar 2026 18:09:57 -0700
Message-ID: <20260320010957.32355-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation by using a flexible array member

Added __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/scsi/be2iscsi/be_main.c | 27 ++-------------------------
 drivers/scsi/be2iscsi/be_main.h |  4 ++--
 2 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index fd18d4d3d219..782a21af01a3 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -2470,22 +2470,15 @@ static int beiscsi_alloc_mem(struct beiscsi_hba *phba)
 	struct mem_array *mem_arr, *mem_arr_orig;
 	unsigned int i, j, alloc_size, curr_alloc_size;
 
-	phba->phwi_ctrlr = kzalloc(phba->params.hwi_ws_sz, GFP_KERNEL);
+	phba->phwi_ctrlr = kzalloc_flex(*phba->phwi_ctrlr, wrb_context, phba->params.cxns_per_ctrl);
 	if (!phba->phwi_ctrlr)
 		return -ENOMEM;
 
 	/* Allocate memory for wrb_context */
 	phwi_ctrlr = phba->phwi_ctrlr;
-	phwi_ctrlr->wrb_context = kzalloc_objs(struct hwi_wrb_context,
-					       phba->params.cxns_per_ctrl);
-	if (!phwi_ctrlr->wrb_context) {
-		kfree(phba->phwi_ctrlr);
-		return -ENOMEM;
-	}
 
 	phba->init_mem = kzalloc_objs(*mem_descr, SE_MEM_MAX);
 	if (!phba->init_mem) {
-		kfree(phwi_ctrlr->wrb_context);
 		kfree(phba->phwi_ctrlr);
 		return -ENOMEM;
 	}
@@ -2493,7 +2486,6 @@ static int beiscsi_alloc_mem(struct beiscsi_hba *phba)
 	mem_arr_orig = kmalloc_objs(*mem_arr_orig, BEISCSI_MAX_FRAGS_INIT);
 	if (!mem_arr_orig) {
 		kfree(phba->init_mem);
-		kfree(phwi_ctrlr->wrb_context);
 		kfree(phba->phwi_ctrlr);
 		return -ENOMEM;
 	}
@@ -3992,25 +3984,12 @@ static int hba_setup_cid_tbls(struct beiscsi_hba *phba)
 
 	for (ulp_num = 0; ulp_num < BEISCSI_ULP_COUNT; ulp_num++) {
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported)) {
-			ptr_cid_info = kzalloc_obj(struct ulp_cid_info);
-
+			ptr_cid_info = kzalloc_flex(*ptr_cid_info, cid_array, BEISCSI_GET_CID_COUNT(phba, ulp_num));
 			if (!ptr_cid_info) {
 				ret = -ENOMEM;
 				goto free_memory;
 			}
 
-			/* Allocate memory for CID array */
-			ptr_cid_info->cid_array =
-				kcalloc(BEISCSI_GET_CID_COUNT(phba, ulp_num),
-					sizeof(*ptr_cid_info->cid_array),
-					GFP_KERNEL);
-			if (!ptr_cid_info->cid_array) {
-				kfree(ptr_cid_info);
-				ptr_cid_info = NULL;
-				ret = -ENOMEM;
-
-				goto free_memory;
-			}
 			ptr_cid_info->avlbl_cids = BEISCSI_GET_CID_COUNT(
 						   phba, ulp_num);
 
@@ -4061,7 +4040,6 @@ static int hba_setup_cid_tbls(struct beiscsi_hba *phba)
 			ptr_cid_info = phba->cid_array_info[ulp_num];
 
 			if (ptr_cid_info) {
-				kfree(ptr_cid_info->cid_array);
 				kfree(ptr_cid_info);
 				phba->cid_array_info[ulp_num] = NULL;
 			}
@@ -4175,7 +4153,6 @@ static void beiscsi_cleanup_port(struct beiscsi_hba *phba)
 			ptr_cid_info = phba->cid_array_info[ulp_num];
 
 			if (ptr_cid_info) {
-				kfree(ptr_cid_info->cid_array);
 				kfree(ptr_cid_info);
 				phba->cid_array_info[ulp_num] = NULL;
 			}
diff --git a/drivers/scsi/be2iscsi/be_main.h b/drivers/scsi/be2iscsi/be_main.h
index 71c95d144560..77c9b1a1a488 100644
--- a/drivers/scsi/be2iscsi/be_main.h
+++ b/drivers/scsi/be2iscsi/be_main.h
@@ -241,10 +241,10 @@ struct hwi_wrb_context {
 };
 
 struct ulp_cid_info {
-	unsigned short *cid_array;
 	unsigned short avlbl_cids;
 	unsigned short cid_alloc;
 	unsigned short cid_free;
+	unsigned short cid_array[] __counted_by(avlbl_cids);
 };
 
 #include "be.h"
@@ -968,10 +968,10 @@ struct be_ring {
 };
 
 struct hwi_controller {
-	struct hwi_wrb_context *wrb_context;
 	struct be_ring default_pdu_hdr[BEISCSI_ULP_COUNT];
 	struct be_ring default_pdu_data[BEISCSI_ULP_COUNT];
 	struct hwi_context_memory *phwi_ctxt;
+	struct hwi_wrb_context wrb_context[];
 };
 
 enum hwh_type_enum {
-- 
2.53.0

