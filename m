Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ACE1DE8BE
	for <linux-hardening@vger.kernel.org>; Sun,  8 Mar 2026 22:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773008523; cv=none; b=UcsZGASipB1fD3LrVzuFUiSpw9nWH5eA7eyEplb4UbRWLy6C1I1PY2DlZnlwYC03nXn3Oz716nsgKonyyj31yZmpu3Jzas0kTxq3+6fo3GRalUkAQu41Iew9tyR2NoPxBLKfZchGBoMApPGW/L91DYY8zAG8NM0e8ucjmvPVEFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773008523; c=relaxed/simple;
	bh=nndh+a3GF6Dx34O1Z3osTj/jDZqj7Dm/ms8tc9Udpig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hY0C73JtMDo+sfN+DRndDwA93S00Vv5Cz7uwm4QDDwscWBSzq76M8UTXcXIdxd93cZLoYQLnyV/i3193RS2WUTxa3XypZPQGU1GGJQCWjCVc/9ZW562xqJv0klMEbBAt607KikJ+RHnPGP+gOnX2W1UAoNG4eGXLkceTxiJJP+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koARFApJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koARFApJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae43042ea7so86479235ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 08 Mar 2026 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773008521; x=1773613321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sC+col1RB5k/y2v4aqOHES194K6Qsz6loLkbUW5Pqd8=;
        b=koARFApJogUypHHaMVjwTSVMQ6PdkTQ8LnakU3gvTgq8Mwg0ejV2A1ItcUViq33fzP
         6baFJjQVPNEIemeGpu2FqGrfJFYyOb0dMLO7yoal2qe94dGzAN9PqNyO/Yoy7OjaXwQK
         Noa/NUUKQViGnzMKNFCoT5yhG9O0T8qz29hv0oETWgsSegVYskS2T/9uMiO9HiJyKJiz
         JH+fLthE5Vtu6JNuiPwDcjQsPf6uyGIWw2zxN6SqIo/WhssOmpuNTz5XojzC+IVtlNZH
         1/Vj1p3xdsioYtDjaBtbJysz44Abf0NnPBj/0sb2Bm26ThziDVION5oe48nmInG2eoor
         DidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773008521; x=1773613321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC+col1RB5k/y2v4aqOHES194K6Qsz6loLkbUW5Pqd8=;
        b=Cjh0Yoy0S/FI8KRnTVnbQgkcYuxQMvRENbEBHuxwUZheDIxZwSZtESC9bSSBd7eCMx
         avMLM9WDWMYERavWOHdgznJOLYj4KFiI2a5KebFECL7pxPNYTjOMeBWbG67BJp/9rHEn
         qXP8+Ff45+0qxlE9WCNGFTVE0rdpaEYI/ghEFXvdZQY/PvsE4ri8uy9dGL/ImUgh2zBJ
         omujr69kJAh60bth5LSrtrJsR3n3j9yNaTGf5N7tTqErF3S33NWjbVCdKaXU9P7yVUek
         K4q1rQiaIc+F6MwUBWkHxZq+1nTQMvhBILE/LNA6ZLzugSgpDe+5rdtAKIGO79eQcSbH
         y6gA==
X-Forwarded-Encrypted: i=1; AJvYcCUx0R/V9SF2dsWFrgSyX2adRH+PQLPHNGoRy3BJNukhv5TZGm5/aWh6bcnx9Gwgkf8FRXrxv0cKQjRWK+UH0uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOfIHfq33hcVu1nlIkOmzXvUxKkIND/qOyuDdy86j2JgpJaEjJ
	vI7uiAU7v0odEzfKvo7mwSeu4fHCLrGyfxYhP858GHlx96NurAhaN6ZE
X-Gm-Gg: ATEYQzzZPMMDRpR9SFW4y2QURFEqAcu4/bTnMdC+e8WV0kRzmCBZutlhMR9twCXXN30
	f3D4heMbWr2sfV2qrYyfvppcOiDzYSUIvAofOkAfQSHjwXS/9lVKx+WSfkCw2POYOWpA0pA2zHc
	M4AVWZYYT7SFmPUkRXbHbtma5hY25SBJ9euzHcIb5KnHYeYJUV8DZZROuwOoJOIu80IrsLGsRFS
	puJIVm2twnD9Q3gDJhkb3x6SAHR7qyL98MiROxlBwJUq9MpCXPI2NBYJ3g8e+VfD3c+sXHCrwPw
	ELcg6qq92WcGCj2tbzVbjsadz4QNeSLbElU7e5GQi5Q75lgVQoncgRJd4uyfzMIkJiq0SO9Orrb
	5xoX97qRWngdYntzJDHrlsFr8jLWdRMS3zjwqwjMacsoMJ/uta4rLdPIVi4qfUkkQgO1mYerjkV
	gC6zrWuMboSz+fEpOChAJkFAHZI+EoN9p06Tk1D3vECzHnpUBGHP8GBQ==
X-Received: by 2002:a17:903:234a:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2ae82366c40mr82171715ad.12.1773008521473;
        Sun, 08 Mar 2026 15:22:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57b1fsm117932915ad.12.2026.03.08.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:22:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/MILBEAUT ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] dmaengine: milbeaut-hdmac: use kzalloc_flex
Date: Sun,  8 Mar 2026 15:21:43 -0700
Message-ID: <20260308222143.50186-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reduces allocation to a single one for simplicity.

Added __counted_by for extra runtime analysis.

Replace loop with memcpy. The loop adds no value here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/milbeaut-hdmac.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/milbeaut-hdmac.c b/drivers/dma/milbeaut-hdmac.c
index b4ebc09e80d0..2e15a2256b55 100644
--- a/drivers/dma/milbeaut-hdmac.c
+++ b/drivers/dma/milbeaut-hdmac.c
@@ -58,10 +58,10 @@
 
 struct milbeaut_hdmac_desc {
 	struct virt_dma_desc vd;
-	struct scatterlist *sgl;
 	unsigned int sg_len;
 	unsigned int sg_cur;
 	enum dma_transfer_direction dir;
+	struct scatterlist sgl[] __counted_by(sg_len);
 };
 
 struct milbeaut_hdmac_chan {
@@ -260,25 +260,16 @@ milbeaut_hdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 {
 	struct virt_dma_chan *vc = to_virt_chan(chan);
 	struct milbeaut_hdmac_desc *md;
-	int i;
 
 	if (!is_slave_direction(direction))
 		return NULL;
 
-	md = kzalloc_obj(*md, GFP_NOWAIT);
+	md = kzalloc_flex(*md, sgl, sg_len, GFP_NOWAIT);
 	if (!md)
 		return NULL;
 
-	md->sgl = kzalloc_objs(*sgl, sg_len, GFP_NOWAIT);
-	if (!md->sgl) {
-		kfree(md);
-		return NULL;
-	}
-
-	for (i = 0; i < sg_len; i++)
-		md->sgl[i] = sgl[i];
-
 	md->sg_len = sg_len;
+	memcpy(md->sgl, sgl, sg_len * sizeof(*sgl));
 	md->dir = direction;
 
 	return vchan_tx_prep(vc, &md->vd, flags);
@@ -395,7 +386,6 @@ static void milbeaut_hdmac_desc_free(struct virt_dma_desc *vd)
 {
 	struct milbeaut_hdmac_desc *md = to_milbeaut_hdmac_desc(vd);
 
-	kfree(md->sgl);
 	kfree(md);
 }
 
-- 
2.53.0

