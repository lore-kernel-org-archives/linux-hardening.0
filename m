Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4106C38E113
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492686; cv=none; b=GEI76g6cTTSyYSvKfyyLgnK0tUZ8RUuPhwAothyfHOmVGZC/PKooFaPdYi3VwGpKK58CK/wy2nTRR3y25BqO7Pr6IPTsYMx41c8a/W4STmy1XFmWSZf25P38PYokDeiGJ4l5PiD4TEn1zpXOC+tRg8Xmv2CuT1cksT58hQrT9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492686; c=relaxed/simple;
	bh=W5KdYZIHsz/j2/tnh3bD/Ct1McJK/qbX4N67gEgOXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmUx0n0/HiEJIt7CifNbyIOH7aEY8dq2LNK5NU+ESOyxZTc6jgXfjj40F9FWBGuceAsSKFza4LGQ5JRKB3Qcf5RZc2rHiRxTedN87UqUwMjU0CR5oCLXMGGopcKhRAGM5Crq0YMvgJoeKulCJ69rZ0rcw/Wzr5NE21IERoxcMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEU8SlAn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEU8SlAn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b062069f80so2832005ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 19:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492684; x=1775097484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0QALCq0GXggBo+60L36Krt74tg9xn3fuWENkieQ6lk=;
        b=MEU8SlAnTEMkfuyroE52j+A8nOtbRJ5K4fGrLDNeLEHfNbyWs4ojwVROWGRx04Wvqv
         RhPfYTJ3zKHDf/ffhoi6iRlvVDOpHIxhR1E/JFs9Kvga6nvbkkxf8pDlyMGfag05H/sD
         YtRBmukNP3i8ldqoeI15ngojtklIZhBP7+reKu7ayuIm7TgJdId+QWdtxAuIKNhFfUoX
         LTo5Li3gHzULWWUTLx2FSxCoeEtQD47cetMVhNAw+SpiAMXtspDou6Zkr6btFvP63Xqm
         AFMPyd6b0BtIEsyClOZX5BfKs82iido4QFNfsRPluxCQZDBv2LFtKB/B4g6A3ll3s6eQ
         jGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492684; x=1775097484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0QALCq0GXggBo+60L36Krt74tg9xn3fuWENkieQ6lk=;
        b=s7rBhux0U6M0mJ6C4i+IUlyOT4P7heTsz+xAvyANp8VVGloIDAupvx1nXFcvugyANP
         R1kQYwJ2+cM256JOmIP88H4QuHzLVhGUxB3Pu3T5MuzrEPbtAts7iDVOzABm3+2Aagim
         SyQ6qdhGIw+3ibbPOm3YC8Ag4gSGuJ3vnG5LPagH88N41TO4VJB/5JYb6q7S1EzR2T7C
         UHnu/ViZDuv+vgMDNDmPqm33Z07t7DrrT0aQcsNJMojnxxLBWL7jh048qgP/kbU4nVnL
         LI84Pkp3c4Vmd9yC3U1zJ/N9d21bFUliLtJ4Vf1sHdbwjWQtxYYP+b1S2wBkcebGKkx7
         nXYw==
X-Forwarded-Encrypted: i=1; AJvYcCXFS6Ud0OxNQGwMeEmRKIs6juAk/XwHIuVSrWFAphxgNWOrrBI7C09gZQbnVG5e2h/zCQqUNyPnHeb3ghlZhCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlJ9hinpCm4vUFliZpIHYsuI/CSwRkMPMelH2A3DwGdEdPSLb
	1c23gwNN9Nn0/okJaYrOPPNa41DNiuklQ0mnO7n+npIg94z/SFus4xAn
X-Gm-Gg: ATEYQzz87X+DgKrXQsyOUUyjPmhm0cU9XKM+NfNyCwty0HoV1KAdVI+v/0HqHUDOYEG
	sSdw59F5htHEMu5WA/JGj+8cIhELuMVRChC3E+F2fen27DI6ZRQZwm9JSpCeXlCHAcNiZDmvZe/
	lkzhuOOgeQppMgY+qFR5BlGlO/K4Pl7fne9Ej3hyQ0wc8stoNlBweLRdakvjY9PSTlRgMlsD6CP
	q8NLlBRwA92GG7LyQ3vqmTLp1rpRHah2cAr3XefaTAfjvZf75tXyn45jtV3ShAlcwws/+M0NKlE
	d50MEJyvjIyFeRvqqNntiLAmink10qr9Kodo2Q9BWAwGL/a0i3uFYUn6EVrc5RzDPtr4oaIe+VT
	p9CpLCHU705+3JDKzZJJM0h2GlDmd7TQZWQvPHpV7s9c96ktdjUbKIyl5apitUYhX6KfaMq0a97
	egVm+BNLziGaFE5xBM2p+/cCvh8TKkY1LiJNv8BjEUmnp4fFU/LtRQLe8=
X-Received: by 2002:a17:902:c943:b0:2ae:567f:fd7e with SMTP id d9443c01a7336-2b0b09a717fmr65559855ad.4.1774492684516;
        Wed, 25 Mar 2026 19:38:04 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8fb099sm12398075ad.72.2026.03.25.19.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:38:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] vfio: pci: use kzalloc_flex
Date: Wed, 25 Mar 2026 19:37:47 -0700
Message-ID: <20260326023747.54485-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member and kzalloc_flex.
Less memory management needed.

Use __counted_by for extra runtime analysis. Move assignment to after
allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 3a803923141b..40e7e035a720 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -14,12 +14,12 @@ struct vfio_pci_dma_buf {
 	struct vfio_pci_core_device *vdev;
 	struct list_head dmabufs_elm;
 	size_t size;
-	struct phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
 	u8 revoked : 1;
+	struct phys_vec phys_vec[] __counted_by(nr_ranges);
 };
 
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -95,7 +95,6 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
 		up_write(&priv->vdev->memory_lock);
 		vfio_device_put_registration(&priv->vdev->vdev);
 	}
-	kfree(priv->phys_vec);
 	kfree(priv);
 }
 
@@ -258,33 +257,28 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (ret)
 		goto err_free_ranges;
 
-	priv = kzalloc_obj(*priv);
+	priv = kzalloc_flex(*priv, phys_vec, get_dma_buf.nr_ranges);
 	if (!priv) {
 		ret = -ENOMEM;
 		goto err_free_ranges;
 	}
-	priv->phys_vec = kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges);
-	if (!priv->phys_vec) {
-		ret = -ENOMEM;
-		goto err_free_priv;
-	}
 
-	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
+	priv->vdev = vdev;
 	priv->size = length;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
 					     priv->nr_ranges);
 	if (ret)
-		goto err_free_phys;
+		goto err_free_priv;
 
 	kfree(dma_ranges);
 	dma_ranges = NULL;
 
 	if (!vfio_device_try_get_registration(&vdev->vdev)) {
 		ret = -ENODEV;
-		goto err_free_phys;
+		goto err_free_priv;
 	}
 
 	exp_info.ops = &vfio_pci_dmabuf_ops;
@@ -323,8 +317,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	dma_buf_put(priv->dmabuf);
 err_dev_put:
 	vfio_device_put_registration(&vdev->vdev);
-err_free_phys:
-	kfree(priv->phys_vec);
 err_free_priv:
 	kfree(priv);
 err_free_ranges:
-- 
2.53.0

