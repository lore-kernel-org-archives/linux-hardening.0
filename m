Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A02DF6E6
	for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120663; cv=none; b=qYbSgoySYDbyLtLLoYuwQT3IJ89fYrRxSflq0mQAJ+Yqiy5GV1Ls5MiHjoh5/5Siq7osswbMylOKrPBKQKWvbewFq7eSQ/2uaTAuPCkTyPGrGEMoNkal94prIMh/Zhf0yiHm99x7A0ElXgAi/8VxQXFu12L6YeEir8h1UrozWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120663; c=relaxed/simple;
	bh=AQohWIPdx6o7olSCZG8FkfZL18WDcqfud6RonHxb344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEa1W6UsTWfEKIR4y9WxtJm8e7mHmeGa1fF+wrVK+mrF04jlEaAwnYIP7DZnOIdfHzfCjLor9cfCe09U5KdpY7EnW1VU7dQyu21FK7zs9Yb3t2dfVlKnl3lpdhjyvwqpDcuuzFoV7nR+g4W9gUVVu/V7Mu+YhTrYRfsWZ3ieOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHWtSNRF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHWtSNRF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8299f1ca894so1846443b3a.2
        for <linux-hardening@vger.kernel.org>; Sat, 21 Mar 2026 12:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774120662; x=1774725462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfhTSNbMCa18G8KLItlOBWL7f74p2rCgKRxLJUa+eaQ=;
        b=DHWtSNRFHGjX50z+QniAoDPqz3RJHnWyX+fvi24jWqQoRdPJGeBV40JQeYmrEDIsJV
         hWhkr//qbZn4xVW1b1/NpSa9B76KJxMMGxtWvr8bPUPQPT2e2UEP/Jyk7RnOK2koETwe
         Yu6XxaFj5TzmgscUUDa/EMwflgYLz7hx/M8zYwkhUPFvBnsXwUqJtAnPpaTCP5V4t+rk
         hdvPXBXLNElww/zb48UEaugRRQHY+PrMfpW0FYawA+fVk0pHzKH5lqk7hgIGHVr9Ntx1
         v4/WetbnMcPkWrexwDbEbkJxkshwCu7n13550/zVXzR5beBWDn5h9h052+5newXdGXNE
         B7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774120662; x=1774725462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfhTSNbMCa18G8KLItlOBWL7f74p2rCgKRxLJUa+eaQ=;
        b=Kp5mPWKKQr0PaO9A17mASMX8oCA65v9wrCGzRQFhg1cxMoGimiG4cE5VDpHI0+4rQB
         BU/Wtv9wh4yfbcAyfNf4mEy+q79uKTsfixmKU/tTTXh98IoY+k1ZaX98QN7IxIsSJCHt
         SBoM2xpvnxgk8liaTFeheLMBP/zZlORP4ns38XQ45jEQVysWY2Xm8PUwnZRB2MbRjJw9
         CMp8vCDyF9RykNBoRppTaxmSdxCvuM/NXvakB/m7wHknTcbXduDClVIY7guCo3Mz98q2
         t66ZSULKzEgkqBNwiA0XwnUxlI/3If+turjIbMgdrZbEuXrYexzH1gB+uA12E5mBDdUS
         Giwg==
X-Forwarded-Encrypted: i=1; AJvYcCWH8ebpYyJ+VRxm0AQ96T4PdT7mwcsxbZXficwccFTK97cbinP2+K+ca+Qe1sz2OQ3o5TaW+g1Ppv2j+X/fmK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR9dOnKlYtK4qH4J8ULwmQh8yLWPmowH2NnXfIBK8tApWTxp51
	X5YbNApI4h6JUCRL2FHz8Q/5Z3aSU+QYRMrf7d9nH2qLrFwW4a9LJxQf
X-Gm-Gg: ATEYQzyl1sDyXaLkaPZyoHFHp5T1uUhaOHb051NcSKrK19rCWn9f5IoYCb5ebyP2mF/
	vhWVfzhNByLTJGf03TM9yzs6a9U4XBEnerFOlTeGxyz4Pzl06B1l+X0r4iIq6y/C2yaa5ocTkkr
	m0c58ePgbdl2sUpfbIEuk8xFnISbw+ef8z3FWAiaVkgQU5vtsMK2Uy6LF1jBUgLzvTB/aplV2t/
	pL5QN3CZEkKpwmuw83mWZ+FUyXG8L+ZSv45lmB+oUDCGpyMTnGgxDchXrZUHDODYVmk+PJNUAIM
	jxOvSJ03ToX9T8ZlXTg2zFOKH/0+7EUpHcSzXwLLthsPlQ4sMZZYII9IrB8S61Q3GtWnsqiAS0g
	Ni1dHBeiistHF9mxzG/PC/ZfmrWDsY/WVbd36J2PB7yYJYP2iSXr8B7VgaaktNPLMEaTSdGLpbb
	OaJJjrzoSeKAyGlEblBVNttnyxIu4YO4/1ZVfXPkifxdr/J8WZB8r8O/I=
X-Received: by 2002:a05:6a21:9981:b0:39b:c469:6c81 with SMTP id adf61e73a8af0-39bceb20ca0mr6375833637.33.1774120661821;
        Sat, 21 Mar 2026 12:17:41 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc9edsm4319968a12.23.2026.03.21.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 12:17:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 1/2] scsi: be2iscsi: simplify cid_array allocation
Date: Sat, 21 Mar 2026 12:17:21 -0700
Message-ID: <20260321191722.19235-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321191722.19235-1-rosenp@gmail.com>
References: <20260321191722.19235-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kzalloc_flex to allocate cid_array to allocate cid_array as part of
the overall struct.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/scsi/be2iscsi/be_main.c | 17 ++---------------
 drivers/scsi/be2iscsi/be_main.h |  2 +-
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index fd18d4d3d219..aa5320535c1f 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -3992,25 +3992,14 @@ static int hba_setup_cid_tbls(struct beiscsi_hba *phba)
 
 	for (ulp_num = 0; ulp_num < BEISCSI_ULP_COUNT; ulp_num++) {
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported)) {
-			ptr_cid_info = kzalloc_obj(struct ulp_cid_info);
+			ptr_cid_info = kzalloc_flex(*ptr_cid_info, cid_array,
+						    BEISCSI_GET_CID_COUNT(phba, ulp_num));
 
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
 
@@ -4061,7 +4050,6 @@ static int hba_setup_cid_tbls(struct beiscsi_hba *phba)
 			ptr_cid_info = phba->cid_array_info[ulp_num];
 
 			if (ptr_cid_info) {
-				kfree(ptr_cid_info->cid_array);
 				kfree(ptr_cid_info);
 				phba->cid_array_info[ulp_num] = NULL;
 			}
@@ -4175,7 +4163,6 @@ static void beiscsi_cleanup_port(struct beiscsi_hba *phba)
 			ptr_cid_info = phba->cid_array_info[ulp_num];
 
 			if (ptr_cid_info) {
-				kfree(ptr_cid_info->cid_array);
 				kfree(ptr_cid_info);
 				phba->cid_array_info[ulp_num] = NULL;
 			}
diff --git a/drivers/scsi/be2iscsi/be_main.h b/drivers/scsi/be2iscsi/be_main.h
index 71c95d144560..b5f8e746deab 100644
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
-- 
2.53.0

