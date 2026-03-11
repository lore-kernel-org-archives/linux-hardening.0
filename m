Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C40313520
	for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773271519; cv=none; b=kkfURDoZvev8x7HPsH6lHFOnAv48Jy6yjQt8L87r0VfTXTPYwcQIuHvuINAz8ycXlOl4J5v22zv3zgatMHNHosWfHvcvyKmk2X1Gf3ny4Ph9Qt35WdhiKh9MrlhClx8klhPeV2N/wYfoK7esawK4EZEUlcrMopVEvmNfALtsM5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773271519; c=relaxed/simple;
	bh=4fdZArySZ+XJjROcq5s1A1cNbYsiBB6urEHx6VMBwqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPaqUg73XbSsr1t+9eRSNeB3StJd/SnD3eI0+Ws2IWtp/YBZNzD2S+M7tHQoKlZThmKyyLNm1PB97oYQ9/zLdf2eYy4Fvpq7//XWfhDpYEVolgYfl5i/iyB7zVIn9efUnY2Yz8tdQtRrCL8DkGOSC91gDpBxgTlS/39rAEKpi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvT10Yrw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvT10Yrw"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a8fba3f769so2460525ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773271518; x=1773876318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arrtkfrkfm9vk7ifZKS0o1irVWoYoX4yhM9Zhp08W/o=;
        b=KvT10Yrw/oN4XGNmA1PuisFXM/Hg1bYrsUSNKfgZIy+t0RinBfzdZWCwxkLA3ua7sF
         cZH7ziLmLR0d12LwfXfLdXrQmqnX0OUeZEeO1r2bNWvplXmnIDfJ4le8Q9HFodPtA7SJ
         gqKp+VdE9NjkfVcP4R2fopqA7P+5FPyPKSjOqoWPDKvqrhPdGSJtKTc40E6955macLsF
         rcaKf/pHhNCU2x681tJusFoxyWK+a1mVBwJoAcaw/kpZvIAnshBQR8jRLRyUr3GpFEx2
         zGYXGWdwnNIFfjKHQy+FeCmMjl6PvJy+2fXGSgHq7eOTGYj7GrhijOJYzwKZ4Yey9myY
         KwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773271518; x=1773876318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arrtkfrkfm9vk7ifZKS0o1irVWoYoX4yhM9Zhp08W/o=;
        b=NJ8U90/wLFn/vERL74M1jnd2JC8Gw7K3utIKCMz6G7/NHMQbAjd9E62MoTLDTAvwL5
         y9rxxc5reXZ/UzagbsCNnszaBfW3xK6OR/CDIJ75R0bxJVc//Hf8RNjX4ky2+oMa+HLX
         p1Bsv1M+0UeJ1TtxAQqI+na0YkMFiNyEvpUK19NqmCpIZAL3Qhez82R2Ia0MQQfiuXs6
         mrFucsKwJoo7hCsw3kkEOOjLxj4c2nFQDdSbxBKVmvZIvwQg1EAr0WiaWBYAZF/XAI3m
         Vg/So+Y5bexRezmOeb57KGggFvQYZCeeMZc/Uf5etXY/cSkLljUUXIsxFsg9UvGA8uzQ
         JVGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw+odUM5H15u+tbB6uiuVvIDR0zUiNyJgdIhHSsA6f6xPlljcuRtMgLKuxILaiOS/3gl5ZHUi4Y6jZ/XjkC8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0RIZJXdGjpVkloOmNTzMZzQ8LYwozyGt++LIzRi+5m69eh0V
	2HbNQEILrDdfh//737wDQb7beyoivKwDw3yzgDjT30kTQNNPxbmM3Bd6
X-Gm-Gg: ATEYQzxs0bMmzWm07oZIL/uoM2GPRUtrogYwdoQOojlv5MYBDXP3K/OJWwOqkvDVH43
	OMZvJlgVueb2aapBFPB6K1MJa5I5FvEY0KHTnwtC9TrVCNLHzEP0kNkRONtI9xzima5RnJFLEBX
	z60D2VJpD3duOSlbiGJgI7NzcQdhVJbAG2JrBZ26A9VfLQfWlE8V3HiegxjsxgM/Lh+c23iyuEp
	aR0sCgy9lxYW4rriJUy553rzdUWXEw9xuaUaLzm3L0N206iEEliiP0CXTc0Lh9x9uH21mVnZKl+
	f8qJC+icvJG01dmx2A3NoUokkvGOPb/0p3vzP+cD9fdw+DLPkMyTEZreNuVtATYufTrVMN1vB/L
	SxmeFHwcCJmOMxPrBImAZRsEOdqBWeRt/JDYU+bx6uK2tzfsHTS5uUJpSPvNZCHBS8ZyaAiWaNe
	wF4IZ8DVhNPyP4Oq8lnKNZdRrUYzDnUp8SDWdRXxFixOmKeBijkyYiMA==
X-Received: by 2002:a17:903:2350:b0:2ae:ac0c:5a1c with SMTP id d9443c01a7336-2aeae7cb26emr42527175ad.15.1773271517601;
        Wed, 11 Mar 2026 16:25:17 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae246fe5sm38453045ad.28.2026.03.11.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 16:25:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] comedi: isadma: use kzalloc_flex
Date: Wed, 11 Mar 2026 16:24:59 -0700
Message-ID: <20260311232459.18407-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switched struct pointer member to a flexible array member to get rid of
kzalloc_objs as there's no need for them to be separately allocated.

AAdded __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/comedi/drivers/comedi_isadma.c | 21 +++++++--------------
 include/linux/comedi/comedi_isadma.h   |  2 +-
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
index 04ce3eb9ae4f..c35811bde735 100644
--- a/drivers/comedi/drivers/comedi_isadma.c
+++ b/drivers/comedi/drivers/comedi_isadma.c
@@ -161,14 +161,10 @@ struct comedi_isadma *comedi_isadma_alloc(struct comedi_device *dev,
 	if (n_desc < 1 || n_desc > 2)
 		goto no_dma;
 
-	dma = kzalloc_obj(*dma);
+	dma = kzalloc_flex(*dma, desc, n_desc);
 	if (!dma)
 		goto no_dma;
 
-	desc = kzalloc_objs(*desc, n_desc);
-	if (!desc)
-		goto no_dma;
-	dma->desc = desc;
 	dma->n_desc = n_desc;
 	if (dev->hw_dev) {
 		dma->dev = dev->hw_dev;
@@ -231,15 +227,12 @@ void comedi_isadma_free(struct comedi_isadma *dma)
 	if (!dma)
 		return;
 
-	if (dma->desc) {
-		for (i = 0; i < dma->n_desc; i++) {
-			desc = &dma->desc[i];
-			if (desc->virt_addr)
-				dma_free_coherent(dma->dev, desc->maxsize,
-						  desc->virt_addr,
-						  desc->hw_addr);
-		}
-		kfree(dma->desc);
+	for (i = 0; i < dma->n_desc; i++) {
+		desc = &dma->desc[i];
+		if (desc->virt_addr)
+			dma_free_coherent(dma->dev, desc->maxsize,
+					  desc->virt_addr,
+					  desc->hw_addr);
 	}
 	if (dma->chan2 && dma->chan2 != dma->chan)
 		free_dma(dma->chan2);
diff --git a/include/linux/comedi/comedi_isadma.h b/include/linux/comedi/comedi_isadma.h
index 9d2b12db7e6e..7514ce222fa6 100644
--- a/include/linux/comedi/comedi_isadma.h
+++ b/include/linux/comedi/comedi_isadma.h
@@ -48,11 +48,11 @@ struct comedi_isadma_desc {
  */
 struct comedi_isadma {
 	struct device *dev;
-	struct comedi_isadma_desc *desc;
 	int n_desc;
 	int cur_dma;
 	unsigned int chan;
 	unsigned int chan2;
+	struct comedi_isadma_desc desc[] __counted_by(n_desc);
 };
 
 #if IS_ENABLED(CONFIG_ISA_DMA_API)
-- 
2.53.0

