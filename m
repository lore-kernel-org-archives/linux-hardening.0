Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFC317159
	for <linux-hardening@vger.kernel.org>; Wed,  1 Apr 2026 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775081223; cv=none; b=Ivq4qkJ8nF3jMYy2kGY0dzIU9QX3nhBfgZhuL8s7pGp8Tmj4IYQ8doWgh1GFeM3oyI0rzGRBE5XZWSLzjdU7k9otD9DNvfbo2NfGqdUdddeI6N/tvoQ5fKAcvT70a1lC291NyeslkUcj5V4ngWIUHStb75YqBH90mVQr2kXxZ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775081223; c=relaxed/simple;
	bh=4isAXu8GsEMTQ84+cb9goVx2QJXHy/pHRFXm2xfgkYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPhhBvegOM5Io1kCeelYKsUHqXVhvSrKFeK4W6qpDOoiOvQRokUFpgimTfINoUs1NhkS59sR3hGpujQFMJ7AK6vG9ts8xQ9bp5T5/CGVa9ZgF2+Zi8oj8dKHAqV3ZkaOuKneA608Y72P97gHThLWo7GXQw1SxLvBEvG8g8vdDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SD09SWne; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD09SWne"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732e6a123so645249c88.1
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775081222; x=1775686022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rRronI06lIok0fDejOYVVuN665UjtkDK5qK1tzC967Q=;
        b=SD09SWneYcrJ80k1idCFzG/Vv270DRTdPP37rUKtxF1VlkSMLQF/LyCpCMWl292W3T
         ySXAmkqJx03qZ0jvZdays/2WxgWIRwekCqS18dBOZIslhz8gSgcgm5CrdIwvYrU79XFQ
         xDweVnVdjuMmpsZqVe68hdq9LWo1hxhxaURE/TuWuiUNwGDI2k+S9fSj3TcgToGu9a6y
         2HWeWGnqe2BUXAef7Rw88sSG+/hW81Bjvs0Lkiq4Lr+1xokxdiHqImsWL6wpJ/hq+Avr
         A1ieubT1sgQuujNXBBmSkG2m1YDuiWKpArK+aBfYVCw+Xx6vawmmHQAxy75etWWE3jMn
         iuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775081222; x=1775686022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRronI06lIok0fDejOYVVuN665UjtkDK5qK1tzC967Q=;
        b=IyHGRSKV4n1Gaf4GFZUWK/XaHDlb3fmwpAVp/e/7fQloosrUQbhkin40MPAdnEiKgc
         duLFulB4M/Ti9pj3p+zrCe6WkkMpNgAe5H/giFJIbehMDXpvEEP1NkN3QcI0vxiUV3p4
         eFnAOBMNTGD6e2NQClsH0XWNUc3scQfS2Ab7NzPTqvWurJPUlcnstsQgQ/nm/3VPYS+E
         0OoLfxQ6iDeiUY3GXxxkawmf5U0i94G7a/KGl+mokTiIsh5Btecw8lWx0EFjJgcqkNtO
         LUkkSci8VA2JluNXpb5Uj4D/qwxvOEZ/rdBATs/VoOhcXgroscuvFTQrI+R8saWvD3un
         QkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTKuKvywNfG2HpbeKqsdPLo398Hl2MoYmWNs5H8Ioh2Wi++y62tVSfulf6IDDLiifwKrphpcST2NMLSs5ajmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUWU4yGYjXCHv2U3N4l0+m5NlpNi/ITW3P1k+Zah5+ZrbnagA
	R8k1UjjOs+smsXGd6ew54I+fPGHZbEZ0bkQhL97okkwOkONEdaFWQpfh
X-Gm-Gg: ATEYQzxGP7p4WFetjhKAvfv3OquJK6fzeCrmn5jCxtUt5OEQSm7bNgeAgmpE2pV1Yxi
	CqN3wR2/2Yzv7Im6hzjRCl2ES0qshAycEodr/92opnxlP1QSRek0v4Ut9h2hr4C4TBaYQvS1/Jy
	ctCZJK/k4ttCW4Qh2EpDvs0+CRP/LkS8jY/GVObTs5W1Mc6WI66lpmHTPldLcG+8Cr4/iO79HF5
	sgwhROlAFD7/1HkuyEkNibXwWIXAlsxHgithWVVAQkQ9AIyGyJKAFpSKWrI/CD5QT8tQKMeWOw8
	2zzy0PGAj66rO0VG+fj/iVJxvCmq2ldMHdWonVfF+QPrK04CQaum/mLMY4S0SSqmCVb87hl29Br
	SkOE8e5HsTGIhDS6k4GJ5bS7QtECC2rv2ynB4xtcejLedMYViHzkPKMUew9FfJHObopuDTVrtbm
	qdTh2rJKqntvnnEpK176uuDHsM2kSl1cXXli34ZoADFw2isQ3HMqe3Zc6qfz/mkIWEPA==
X-Received: by 2002:a05:7022:698b:b0:12a:7165:7405 with SMTP id a92af1059eb24-12be640d75amr3359834c88.8.1775081221588;
        Wed, 01 Apr 2026 15:07:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede54ba8sm1605984c88.10.2026.04.01.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 15:07:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	dri-devel@lists.freedesktop.org (open list:QUALCOMM CLOUD AI (QAIC) DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
Date: Wed,  1 Apr 2026 15:06:43 -0700
Message-ID: <20260401220643.12802-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the two-element allocation into a single allocation using a
flexible array member. This reduces memory fragmentation and simplifies
the error path by eliminating the need to check for allocation failure
between the two allocations.

Add __counted_by for runtime bounds checking.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use macro for number of elements. reword commit message.
 drivers/accel/qaic/qaic.h     | 4 ++--
 drivers/accel/qaic/qaic_drv.c | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index fa7a8155658c..e237020f6aa9 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -152,8 +152,6 @@ struct qaic_device {
 	struct list_head	cntl_xfer_list;
 	/* Synchronizes MHI control device transactions and its xfer list */
 	struct mutex		cntl_mutex;
-	/* Array of DBC struct of this device */
-	struct dma_bridge_chan	*dbc;
 	/* Work queue for tasks related to MHI control device */
 	struct workqueue_struct	*cntl_wq;
 	/* Synchronizes all the users of device during cleanup */
@@ -206,6 +204,8 @@ struct qaic_device {
 	void			*ssr_mhi_buf;
 	/* DBC which is under SSR. Sentinel U32_MAX would mean that no SSR in progress */
 	u32			ssr_dbc;
+	/* Array of DBC struct of this device */
+	struct dma_bridge_chan	dbc[] __counted_by(num_dbc);
 };

 struct qaic_drm_device {
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 63fb8c7b4abc..1dda8dfea5a4 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -43,6 +43,7 @@ MODULE_IMPORT_NS("DMA_BUF");
 #define QAIC_DESC			"Qualcomm Cloud AI Accelerators"
 #define CNTL_MAJOR			5
 #define CNTL_MINOR			0
+#define DBC_NUM				16

 struct qaic_device_config {
 	/* Indicates the AIC family the device belongs to */
@@ -405,15 +406,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	struct drm_device *drm;
 	int i, ret;

-	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
+	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, DBC_NUM), GFP_KERNEL);
 	if (!qdev)
 		return NULL;

+	qdev->num_dbc = DBC_NUM;
 	qdev->dev_state = QAIC_OFFLINE;
-	qdev->num_dbc = 16;
-	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
-	if (!qdev->dbc)
-		return NULL;

 	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
 	if (IS_ERR(qddev))
--
2.53.0

