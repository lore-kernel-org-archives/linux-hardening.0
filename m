Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61B3F411A;
	Tue, 14 Jul 2026 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016507; cv=none; b=SR2VyGBwijPtFweTt3AgSxZVP2DlFMNIbbJzDRnhWXXaH0XdblXlQuoOJwiQsAjIY5Qes6Igof1MylM1advojx3i5AfIZa83dZ/bvnPRlRkYt1elyiRiSq+kiMTHCPV3S0pkpqtbliyJFNeiagq3Rqi5UsQVw87BYqpvTXFxTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016507; c=relaxed/simple;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHPteuny6swf6TVJmSfseWMqt2QsPP8n8ujnghnyK98gpTvFhFizL6OVsV9mGEfdpsH9IdqWxQB5GlCoxI1wGyUxVkdmNBr61umSI0WxdxYrPDCdMX8uvFIVB5HS5okmP7TvWAdgTBfXrp2SZmIxcL+QmZNvyJPUN3wt8il7YX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnC1ZLES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnC1ZLES"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B12A6C2BCFC;
	Tue, 14 Jul 2026 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784016506;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nnC1ZLESWNi63lydbDRZQ1+5qfzZfhKDf2ksDGlimDIKrZiWdCdyJaJhtZf/BwIUq
	 ptj/KW1Ms42Lgu8g7oeiXwYORYe6xWPAmsPivBQtre+1aLVlPiKI6Uja+oUJXyrxWr
	 CCKpkEjiCR78XHjlZUMPTTZJ1mqFnaiEP5AQi/8nMJ1JmXZp0Qj/bC27lHZI6PIW2f
	 jz+dMW5hdGWqvKWA32yG0ipXT2oKgl3SG82+hZPljMqZBE8Rc+u1yirYl/E6QbJHbZ
	 CWCjFdLT70dfnD91Z/Q25cYJCxh3BEDbjZT93CA/fMyNh9tJWspN8m30JeJf6v3+o5
	 m29MPK5kqAsvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5BC44509;
	Tue, 14 Jul 2026 08:08:26 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 14 Jul 2026 08:08:24 +0000
Subject: [PATCH v11 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-amlogic-dma-v11-3-de79c2394282@amlogic.com>
References: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
In-Reply-To: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784016504; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9xq7fFe8x3ZtUEb/et7K+dc4J+CzRRN9hABeSR7Mhcs=;
 b=GQGbDVtN0DJ3QCFuGL8tehM4hRIkFg3vDtt3FA82rPj/nWqzFSNgaqc0Sf5bexu8ulxhVlVmx
 MgmXhIUAcaiAVSiySyfyU0na9KSRSnmZiHh1QdZLxhrj4ZqphETw9DW
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add Amlogic DMA controller entry to MAINTAINERS to clarify
the maintainers.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e7b2d9e9c24..b4ef8d3f52cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1307,6 +1307,13 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 F:	drivers/perf/amlogic/
 F:	include/soc/amlogic/
 
+AMLOGIC DMA DRIVER
+M:	Xianwei Zhao <xianwei.zhao@amlogic.com>
+L:	linux-amlogic@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
+F:	drivers/dma/amlogic-dma.c
+
 AMLOGIC ISP DRIVER
 M:	Keke Li <keke.li@amlogic.com>
 L:	linux-media@vger.kernel.org

-- 
2.52.0


