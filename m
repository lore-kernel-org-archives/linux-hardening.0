Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5A322A
	for <linux-hardening@vger.kernel.org>; Mon,  6 Apr 2026 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504685; cv=none; b=OdB9n5qfE4IRdKuZN0dJqz1Z2bjpcU/kPPklrTLMPKKqxVIAq9tfP0PyfdsE61MbR1KR41tN1k8A7ZvMXFHiI3Pky4gbLOMoAIJilxg/ojV1AmsqNC+1k/KuG6obtEZ6SOFHIsp8vwDuypjae/mHxTqdIn9LnJgsUj89mvFjzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504685; c=relaxed/simple;
	bh=GR2DfTz553Yog8V3bm8Wviid+hmeEqLWZb0hdHRbJqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1d/r+NsCYy6Grhm93vYUAA7oWISqrtYLhSTiLmdyabsSoH4RpXJSantttGUzEGvFAT6NnEg4m9R8WRDrW4u54SPPuslfwSBnsy2ciFXFFI71I0lnrA1PJR+IMApP08Ubg0ltcavu8SKP2Mp9YU5hZEuCqUkClChkulMx7NxRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlcThNXc; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlcThNXc"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8a016799d2cso57779806d6.1
        for <linux-hardening@vger.kernel.org>; Mon, 06 Apr 2026 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775504683; x=1776109483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8TKUkyB7WvjQA6crvLqj/5jSGIGyrb8D9bz30WYCfA4=;
        b=AlcThNXcUsJCE30LnfdKvG6lIi7PWMEKIoNJhnHzSxnSS4FpaACodnbUh6m6C7/nEc
         dcvsXCL4VqINHvBuT3o/IIroQyhsCovZ5z/KhQ7ug/tR137nWPj6hyqB/IKzlNqlLBgA
         WwoQZmvA19bBXFagJG8NBvQumw5eftu2x/RzS5fs/5yR2oQxR2MBKa4FLEC/78jTVU7I
         mO3xa1ImnGCw4ZT9VonelXB2Ot2ZkZE8r2UnLJMh/UK72oSlk62LB8cNqxogrQmBRfa4
         XPohfquQRbxvNwg15l07kFQ0jriekKFXil9xgHMiyHYAy8KK2mRmh5+ji33z0p16ymTk
         MZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775504683; x=1776109483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TKUkyB7WvjQA6crvLqj/5jSGIGyrb8D9bz30WYCfA4=;
        b=aKqQG+yzTlyqHh4Mw2nraUH6YoIBhle8ekAYznISIrP/+IyTNmtsvXh7KlLEiVzws6
         P1UhvHIrCGZRS0ZYXJvRI0u71J5LjRtDJXhV4aNmZ2cQvAWkTEBPYulRjn6OoQiT3lfK
         mJN0TIhawa3dnCBHqbOnG+LQ2OmklEVBeigoHvZ4t0apZ/wLJ9ydfVLqXpJO5eMZ7g3q
         /SWx3xFyvy0xiIsAIL7B5/1EyHvIJ7a0u453KoQ/OogOIHqXfMYh2VmlqtKBlO6DMfke
         akZACeKuR5Sscop9hB3RJN1Cwr5KoV+m3omqHCaU5+SFzfmg68EKcgMqJ+miFf6mz4et
         xd3g==
X-Forwarded-Encrypted: i=1; AJvYcCX6hLLbcz28L90r4ku4JplzoJZnkvoj3LTqFrtzoO8gFD+DR+TpX77WWe5cKMDz/FobhJ46dSmOipJpx1g7KRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wY4Mq8KMCU2ZpSSW8no4FzNans8lWPhOtt7GJCzBVq1L3Qqn
	7IK2RYa0KmZEbCXT98PUYpilQKgJDCdEB7Jo7uIpq2ySsvmn+Mg3NzoQ
X-Gm-Gg: AeBDiesY+8yXm19HyBgS0KD3LsUo09lhazlSUKATEANxSTgkmcJz9s/L8j6qKpP7y+P
	02zUbJosAU4yDQ243aB8U+OG8M1+JcDCCo3yu2/YqkC+c6MaSl5PC+OKbz7CNxOx4F95dwEWC5Y
	Mvx8tZ+oi7op457PEdtnhVlwB18/Zuenuw0IQSfI2RRaLj1WsC7ltqpFVNMTdevaR9S3tGxXb0T
	0V5rwujvzMW7bjhLM9reqXt4tliBe9hZVNwuxTyhfGlOmcPLo1fcgLudw63zZzS+NmCV6y5yDOO
	TL3IvIEHx/odf5o+1haqVmmcJR7TWt0PsDywOnfVtDeklmic0vS++leM7mZHMcIyn5cWq+A5JAD
	PqYCO+DHm5HXFNlzmFu/mq5E7IzJ6WybNVTS5DIXODaUbw9GvxWlbXqkgIfoMkHtdwuG+7v7jAA
	p3IF0rQ4UukgJCtQRcJP7g94XKG8EQaVCXCRIMp9Kay4TCfDqDu3tK/8A=
X-Received: by 2002:a05:6214:f0c:b0:89c:c668:9d3a with SMTP id 6a1803df08f44-8a7022bb7c9mr241401586d6.12.1775504682954;
        Mon, 06 Apr 2026 12:44:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5969156d3sm129833856d6.31.2026.04.06.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 12:44:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] dmaengine: dw-axi-dmac: simplify allocation
Date: Mon,  6 Apr 2026 12:44:24 -0700
Message-ID: <20260406194424.13365-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member with kzalloc_flex() to combine allocations.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use () for kzalloc_flex in description.
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +-------
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 4 ++--
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4d53f077e9d2..d3ca202dc478 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -294,15 +294,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
 {
 	struct axi_dma_desc *desc;
 
-	desc = kzalloc_obj(*desc, GFP_NOWAIT);
+	desc = kzalloc_flex(*desc, hw_desc, num, GFP_NOWAIT);
 	if (!desc)
 		return NULL;
 
-	desc->hw_desc = kzalloc_objs(*desc->hw_desc, num, GFP_NOWAIT);
-	if (!desc->hw_desc) {
-		kfree(desc);
-		return NULL;
-	}
 	desc->nr_hw_descs = num;
 
 	return desc;
@@ -339,7 +334,6 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
 	}
 
-	kfree(desc->hw_desc);
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
 	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 67cc199e24d1..a04a4e03eb3d 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -98,14 +98,14 @@ struct axi_dma_hw_desc {
 };
 
 struct axi_dma_desc {
-	struct axi_dma_hw_desc	*hw_desc;
-
 	struct virt_dma_desc		vd;
 	struct axi_dma_chan		*chan;
 	u32				completed_blocks;
 	u32				length;
 	u32				period_len;
 	u32				nr_hw_descs;
+
+	struct axi_dma_hw_desc		hw_desc[] __counted_by(nr_hw_descs);
 };
 
 struct axi_dma_chan_config {
-- 
2.53.0

