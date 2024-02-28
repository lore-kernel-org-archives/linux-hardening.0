Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024779B7D
	for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161156; cv=none; b=LuIjiRcXijs9M7Q8ATNUxsvcuLMYlPmstXXgAGEdFGM1FP65h8go6Wt+mt1M2QmzPuRM+uI3JghjIN+aQTPvjHgPTpu3b9KBnG+Nmcnuee5B3eVyq/+AQz2X72FDmpG3Iu6tWlyUJ33OTrLTPnEVo8TvmqUwJTdFeXnLC0iu6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161156; c=relaxed/simple;
	bh=To7ZU6TEXywiRaHnSamsifvUq4hwPP/ysQChSO0JU2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S+V0C68jv95aXeZQ4oT3gq4zuSbyAa94dGF/9wipznDPHI3bplEPJdAdBELA7JklnoTeo6HMyXsqlLqJ9ap7MhHbl5+37s4gjbOi9vrCWrfvWlcR+z9zE0GZ4tMTtFChFcAjZIOr4h80s6q/7sF73w4n/8Uo8bum9L1/AVyke3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3m5PPEl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3m5PPEl"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso4450127b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 14:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161153; x=1709765953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pViMbQwWguNjxrb+PJNzy6YtvcZcNKawzSxX92KuoQU=;
        b=F3m5PPElmJQy88IGssNVfgwgucR/V7hNzMexXe8JTjGUGvlnt+rnAygG6mDTr37kuQ
         P30aQZdJj91+KYq4iWg3uWwxxQuGq63BN57oi3EVXh5qtwuY3SH2gfLiG2YigfyMREzG
         94Q8JxuSe35kPbhokdlXdgVHN9/zF54i1wM+3KAyDWiYkFxkkXxEW0y1roiNlzrh0TvS
         xrLX/C1wY6xr6Ha5P8vyKeuEOTgI5j0iKAShlydNABZNMAA0i8xAFGzrLA8UHbwz26ZS
         NZSiRduBm14MerhPiZNhyj+oQins+VbAhYcURg1CZw7dObgqEV/TXD6nHRR2SZ1I9QFf
         e6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161153; x=1709765953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pViMbQwWguNjxrb+PJNzy6YtvcZcNKawzSxX92KuoQU=;
        b=Nd1CQNT75bcfbKaYO//GLfjocEsaesjnOCy3LK3Gv7dHNbk3tv9XTBMAxGt6tuSMfq
         oyx75kJ00TOYO+FjLpQRHyeM/0UfKrM8kzjFIyjfRwZ+kQhHh5xSQQD5h07DKpo1JChJ
         mcoLbM2P9NxKjcdyojpE66zcmkirNacqVZVPmbU727gdU9201u9tAE9g536WOfdVCFMC
         WruzFzQTw2kd3pyfXpVNOiNJsNuff9/lWgf+tWgGDSzHfkA8TvgfwQI7Y+w8T7SyiW4v
         k/GOssRThYz5VNO+uq83qYk01ww3gDMr7Cr4lJMnyILcxyTAE2pQwaLHgLkEATF65qDq
         eGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4aDsxJv65QKnCPe69RoItejfMTdJpYg+4l/lRQPLbTxPRrh8ediC8rKhrEf1ZJ3SUiqbYkqtoQYbsiAcAvXRBcLhL504+/3DTLCcES291
X-Gm-Message-State: AOJu0Yzechp+YkMPJCWSlpgoCHPuXubJrMDLbU9vEwh2aGpjnRGpTHFm
	mV6BTyYs/2hw/9rvY2mSP3iMEXJYznlP9JXxGMcj4CSFYzLzL/tIsRAGA102JxjvtkwjFYkVFYR
	OZG27KVne0I4h6sD7w2Lcog==
X-Google-Smtp-Source: AGHT+IG+CrcPSeuQjCNv+LYZnr9O0qgAPGjwTPP2EKsKr3ZNTjlJRHQOZWnRtpsIS3mScTSFziEoCrfsuBT7tEgW3g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:905:b0:608:aaf0:d8b4 with
 SMTP id cb5-20020a05690c090500b00608aaf0d8b4mr28847ywb.3.1709161153510; Wed,
 28 Feb 2024 14:59:13 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:03 +0000
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=2289;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=To7ZU6TEXywiRaHnSamsifvUq4hwPP/ysQChSO0JU2Y=; b=UNWBEUmFmReM+6jy6/lpJEccGagN1o5lmsEyKnmxCayFBEyaeJUaFqVrDM0O1UvqfN/bbiNa0
 H08DaS5FaNNCmjru8vc0r39+MwfbEMICtUbqZnovavG8cU3+DmJYO4N
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-3-dacebd3fcfa0@google.com>
Subject: [PATCH v2 3/7] scsi: qedf: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

We expect slowpath_params.name to be NUL-terminated based on its future
usage with other string APIs:

|	static int qed_slowpath_start(struct qed_dev *cdev,
|				      struct qed_slowpath_params *params)
...
|	strscpy(drv_version.name, params->name,
|		MCP_DRV_VER_STR_SIZE - 4);

Moreover, NUL-padding is not necessary as the only use for this slowpath
name parameter is to copy into the drv_version.name field.

Also, let's prefer using strscpy(src, dest, sizeof(src)) in two
instances (one of which is outside of the scsi system but it is trivial
and related to this patch).

We can see the drv_version.name size here:
|	struct qed_mcp_drv_version {
|		u32	version;
|		u8	name[MCP_DRV_VER_STR_SIZE - 4];
|	};

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/ethernet/qlogic/qed/qed_main.c | 2 +-
 drivers/scsi/qedf/qedf_main.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index c278f8893042..d39e198fe8db 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1351,7 +1351,7 @@ static int qed_slowpath_start(struct qed_dev *cdev,
 				      (params->drv_rev << 8) |
 				      (params->drv_eng);
 		strscpy(drv_version.name, params->name,
-			MCP_DRV_VER_STR_SIZE - 4);
+			sizeof(drv_version.name));
 		rc = qed_mcp_send_drv_version(hwfn, hwfn->p_main_ptt,
 					      &drv_version);
 		if (rc) {
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index a58353b7b4e8..fd12439cbaab 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -3468,7 +3468,7 @@ static int __qedf_probe(struct pci_dev *pdev, int mode)
 	slowpath_params.drv_minor = QEDF_DRIVER_MINOR_VER;
 	slowpath_params.drv_rev = QEDF_DRIVER_REV_VER;
 	slowpath_params.drv_eng = QEDF_DRIVER_ENG_VER;
-	strncpy(slowpath_params.name, "qedf", QED_DRV_VER_STR_SIZE);
+	strscpy(slowpath_params.name, "qedf", sizeof(slowpath_params.name));
 	rc = qed_ops->common->slowpath_start(qedf->cdev, &slowpath_params);
 	if (rc) {
 		QEDF_ERR(&(qedf->dbg_ctx), "Cannot start slowpath.\n");

-- 
2.44.0.rc1.240.g4c46232300-goog

