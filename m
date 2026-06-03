Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E63E5A0E
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456101; cv=none; b=CnBmb2+mURgi9Xa1i3FzEX9SaHEJW3FiAWw0/I4V7yKp6uqmzR4GCU6DuTwWtjuO411FjLHQqv0h4i04WNTzPaGO5OMI+rKpUvDFVg4RDyfgvHNWpbMQOFZDIe6r6tklSKPq55TIwI+f+ZgZpmgsPetDBa9LE6d4WORjzzLk6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456101; c=relaxed/simple;
	bh=xkKW8ssF61j3wciQU5I5OgNSDBxKhZtUrbfTMBdFQsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDynhfdOtCD7SPN9dLHdyJdta8wlHYP9WzhSJ9kc4s9gyCbW7Cko58M0kJrukBOrBf2IiH4wI8V2FOBNjzPrBVYX7XGB6WD7y5ioDtMCAjyKPLKkugx0vXM5sBLjdolr5+S+iGkA4D86RayYdPZhYQc6X4PMSosUlwlo8nrM1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBVBkwcU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBVBkwcU"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36baec934b6so109810a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456099; x=1781060899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzSNw5MqtTwHbrXr4I82ADeuVf15/M6YUefhoKAdT3o=;
        b=JBVBkwcU1sDDCJ6T7Gxl5OcOCO7ZiWgLQfnKaCbbSIwaGOZaF9MM/zNzeRmWiBmwpa
         s1dP6fpaZC4OO+DBM+w5LgCoQm82MjqYpqUDLWaWwp2u9Qk8wDDf3M9194NN8+RRYkgQ
         TVeTwcAOjC3/45DBxO8/bsTDqbX84tBpxy8/AmAR5D/xopR6yCUknSnIZicycnASy6TF
         NBwwOhJB6VfCIc08KtDJrpBZ/IX9nbiOBF/DADvUg5OxJGvYzke+MANA5OyajQiOdqnu
         Cxj61UDr16hYeV0FOaR2tn7FUY5N78Q2vS6Ycl5HxRbwvdDHVtfZJrbrby+TnsjIkS+S
         48EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456099; x=1781060899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzSNw5MqtTwHbrXr4I82ADeuVf15/M6YUefhoKAdT3o=;
        b=PGh8unswQEt7VJe/+pwWyM/sA68rXtHOsQWg1G7oKpWCCAQsMyT5Zbod/nzMkBaGrj
         dV86k89LkXKlU+bofQV2QbwG4ysWEgHtUer3U++rDkDCvyxrPdhZ9+EA+T5xORzt/aa8
         6usz8+3Et+IhQft1uEMN0thp4VWwL6TPTX8U0LtFf1ZIL/8r/s2VilCgTQTKyHng89JP
         vollXUPKWQ4LOlDXTjbFAFQnOoqN3oiu4MDzsrcKAz0x1iM5+c6ulkJ7akdMUSo0E2S6
         b9Ovt8GXDoDN3pNfMv/lqCjnMlTtI2jYMHNDzoffYQK6uiAJBWri9DT+RI2IkKdQqOOY
         PKBg==
X-Forwarded-Encrypted: i=1; AFNElJ9+biStTFhngnuzSkRv65reNxjSdYwrr/1CS4YvGelPzPqFUQek2vrAccsArP9CYCOjgmLYrYOfU3gn6/51fHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqFLQN6YsToptod3UzQEKlh0YxN+wM0bp96GgeiKx3LSm5zgd
	hrL4ACYPInU2XKUZ5jP2bZkKpVuKG4wQEA5m/of9+NtDyqsvIaGnXY6e
X-Gm-Gg: Acq92OESi3C9yksDnt0KpbnLIfw9jMq/fvfTpJlusxOwl+0cTpPsrBQCtVkeWsMRPfg
	1RvLvOAZVVqyAFuGHNluL/MK/DP32yyM+zlswNc8pK7HG8cYrIxPo2AVlJIvlV2o4uVM3KRxgcc
	icLBiUiHZ7SZWPeYH3CQdSCZo7V032vXBysxaWX0Ei2w3JsJuD4jyPI0oTMiIGfGsgtBtWFQHyP
	rja2huWaM89EqAPEXpI9PAjaLRvgKZPXvE9CXBidsiOJ7FApL6HVJ17ndn6GxA3iTEOGZXPMYAC
	eoqiBIWtyjoZGGrKnDRkwxd0XpIxp2rO01fCdmpl/oJq5MIC73Wf9pBgpm4eY2Taeeqziqm8wI9
	PzmTXDw8Zmwo9QnKeroDnh6CnmtNRh19N1qaEkqtuYKndslV12xa4GxNUIs+4tuPQh54aNmR9KB
	GEiNybAOek/DYZiaLCQVhR88nrmPKlXbU7fndFmJFUVET+7sWTFH4AjZXDOB9NaSWBH4LRI5xKa
	DaI/0VsZ/n6m9AaBGBDH+WsxgqLR7p8snc9/3qup/1hBw==
X-Received: by 2002:a17:90b:3d44:b0:36d:630a:c4e4 with SMTP id 98e67ed59e1d1-36e385786f9mr967492a91.3.1780456099427;
        Tue, 02 Jun 2026 20:08:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 4/8] dmaengine: ti: omap-dma: stop channels during teardown
Date: Tue,  2 Jun 2026 20:07:50 -0700
Message-ID: <20260603030754.288757-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_dma_free() removes channels and frees their storage without
first stopping an active transfer. A channel may have moved the
active descriptor out of the virt-dma lists into c->desc, so freeing
only the list state can leave hardware running against descriptor
memory that is about to disappear.

Terminate each channel before removing it, then drain the virt-dma
resource lists before freeing the channel structure.

Fixes: 7bedaa553760 ("dmaengine: add OMAP DMA engine driver")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 0ad8da8b35f8..cef4e3a38b04 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1521,8 +1521,10 @@ static void omap_dma_free(struct omap_dmadev *od)
 		struct omap_chan *c = list_first_entry(&od->ddev.channels,
 			struct omap_chan, vc.chan.device_node);
 
+		omap_dma_terminate_all(&c->vc.chan);
 		list_del(&c->vc.chan.device_node);
 		tasklet_kill(&c->vc.task);
+		vchan_free_chan_resources(&c->vc);
 		kfree(c);
 	}
 }
-- 
2.54.0

