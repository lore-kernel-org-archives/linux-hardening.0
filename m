Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F181DF73A
	for <linux-hardening@vger.kernel.org>; Tue, 17 Mar 2026 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707454; cv=none; b=RqiRcrgMcvJiaPEPd3XPWHF76nSSXqut71W6r5G5MlN8YRg7oijZgoSuA/RECGbWXVU/pi46FQ/exuKm4ENtD+L1qCMGa++IoBNY38tECCaLh3OMr6MWJCFrZ3CRKKda7CDAotV0Wf/OjsGZ6ish0foiNxUVI38pOUx7ZdHUWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707454; c=relaxed/simple;
	bh=Mx0l2NxLKzer7ADCbLsi4hxQxnDoZ0MKjOO+1vhGXy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TorCb2Tihb0LnGgZK1d8G9cAv4gBM0OJ0mzbEGRNjI2wioFQzNp9X6juBOeBeaN8QUd5TjfP61ltHRtkLo8C8oP5BlyPDgoRQJT4o2uo8+vHC4k6TDzMzgA16hqebPHRAhPnfU0I/gdfdTUsJ7Qr7S+hd6koRkk5+DCnXuKH8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPr75XCq; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPr75XCq"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82990763921so4749851b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707452; x=1774312252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMczMzhV3A2GonGYjmIFHjc1BY+/VEDhWUtNnoc7Cvo=;
        b=lPr75XCqF6GDfeAyItC3R2jSd835lFwfig2+XZLM4ammQ2RGCh/l9Zgx2FeFLjoK2z
         OG/U0xOBbDzBCzXjh5nzFmBD6zg/+Xx04rDcH+6xYSfHvJSABall7uoIII1dj66G1RtU
         F5rPVZvb7USEwya3i3p+SR4HbrqDY8NEHuOKZk23MpDNfFqIfVjCS4bJQNgyq4ixXf51
         D6lUA9NHtGNTwE9gvP5rZL1L8Wqw9pBNWMhM7iM+oj27Vw5h1ETgmITM4RWre3ziMNfN
         IprK/EKo/H2Xdf/XzhguLqyr1hsSWPkl82tEqAG5VQRluwdtW/Q92WUj8RMLG/bPSuoi
         2zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707452; x=1774312252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMczMzhV3A2GonGYjmIFHjc1BY+/VEDhWUtNnoc7Cvo=;
        b=CFFib6Kj08rZd54hnYpGEQA929F1bYSS7WmBYkYkwPEVZjnra5lgk8kKQZTjqMVk63
         cQydPhA/cC1vYw3ePUykjf9fs9C+o/cYrE4tQHhLy+dxQOwZMHyu6mtIjKieo0Z6MD8l
         RpZUobmXiUSNWUcM8GIBh9sXKxclcaCXhJuY7Rw3nXXhyWyK6s+PJnbNdOmXFCXUB2xh
         G3ZhNwz9U+NierkFk40i2W7ffqdnomlcLcS02lPA9q3vYLnsfEHQYP6Lq954FuONUP2R
         aMAm1Qm4NSXwAUgZkKuQorETyEVL11ZADtQjMdAgN+Y1Dm2opXFClSopY4VQ/9zjKP9/
         xfDg==
X-Forwarded-Encrypted: i=1; AJvYcCXVspZxnKY35zqkydQpiX0KCNVHxEYQkrHd1pP/jVmQSVMoGQqs/mcCPF4oAzJqKp8rb0I01XMVHizeoiBNnC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9nPP8yZN3u7nZQCMTplaAXCamLGfsZXcl2I5oJhsWDrwPCAH
	odKj4mB9Uke3Iu6un1lIuyrV9sQKU97vGGfjcE1ZhgAvwmpLib86EhKk
X-Gm-Gg: ATEYQzx4QaW/oQmpn5tyn4FNbIEbvtejjqefvKhraoOzSyholVuOPtHoxDq+KCLu6Xj
	COMvJZGi9cyXEe5od2y0vDO3vDTgS84WuIlaNyK57m+5q+gKV7APRr8BDf/eNGOesn9j8LCBLTQ
	Mi8Eu3sfx4avh5OA8z9VwyfLq7yhtTZcKYrWW08YclmyGfqB/70U7rqR4R+H0hMgIYsDuS1KbZb
	HeiNmzvOCfyBpgBrxbzDvNyLIGP9yYWTlgli7pmIwFbU36Ul9A/aHvZrfpcXHX+WMk2Coh9F6Qr
	lzS9eqDklxvCSRPz6wrgpNyUS6ro/9meCCtULvBM42vdn6UyVd6FTfBnTxZxQOCFNOYODGH2aQd
	msV+yGyNEFVxtRyYTtuNKGprd/piK3aAKI5jZCzrLOiFJA3aN3E6wmYgh8me38BEaG58iQTTZnr
	+NMfTEP4rExKbDWQHFuvUHYY3LJ0h0WIEtQdbmXX9TEXRoF192ytCVlso=
X-Received: by 2002:aa7:8896:0:b0:823:1212:8e87 with SMTP id d2e1a72fcca58-82a198d7220mr13987513b3a.32.1773707452151;
        Mon, 16 Mar 2026 17:30:52 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0736deb4sm14420074b3a.44.2026.03.16.17.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:30:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-msm@vger.kernel.org (open list:QUALCOMM CLOUD AI (QAIC) DRIVER),
	dri-devel@lists.freedesktop.org (open list:QUALCOMM CLOUD AI (QAIC) DRIVER),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] accel/qaic: kcalloc + kzalloc to kzalloc
Date: Mon, 16 Mar 2026 17:30:34 -0700
Message-ID: <20260317003034.71618-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine allocations by using a flexible array member.

Use __counted_by for extra runtime analysis. Move counting variable
assignment as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/accel/qaic/qaic.h     | 4 ++--
 drivers/accel/qaic/qaic_drv.c | 7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

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
index 63fb8c7b4abc..ab428ecd26f5 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -405,15 +405,12 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	struct drm_device *drm;
 	int i, ret;
 
-	qdev = devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
+	qdev = devm_kzalloc(dev, struct_size(qdev, dbc, 16), GFP_KERNEL);
 	if (!qdev)
 		return NULL;
 
-	qdev->dev_state = QAIC_OFFLINE;
 	qdev->num_dbc = 16;
-	qdev->dbc = devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc), GFP_KERNEL);
-	if (!qdev->dbc)
-		return NULL;
+	qdev->dev_state = QAIC_OFFLINE;
 
 	qddev = devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, struct qaic_drm_device, drm);
 	if (IS_ERR(qddev))
-- 
2.53.0

