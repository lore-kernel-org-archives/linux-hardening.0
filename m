Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783C437457;
	Thu,  3 Sep 2026 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421114; cv=none; b=JPjSHBeyOJVRcMp1aBTxhrXgFgWlwe9In1YGM9nJkENZEJ1E2/AeJZPDEDRnjYw1S4VNq3dA2aDRuvhuepykBSQO753eG1j7IlIUszWKjgrQ0+bttpUsG6cZVqjp4UEEf87SSk3E7VDhxWhmgr4FHJAv1WDCIZ9jy0CKnnIeyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421114; c=relaxed/simple;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8x676hth5ISUeQ9NIuEhtPHWkjPDFeIsm09YI+PU7SQvY89WY97QCAS2t2k4oUIiwnyhb3k9PvSkL696pusKTOcSLimllH5dM0zsu8Y8XLn4yCljU47wul7PHNEJVIXfDJUL/ytFhJwQsamANpLa9q0ODT5yl5J7KFid/KeYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q538lbYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q538lbYM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DED9AC2BCFF;
	Thu,  3 Sep 2026 07:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788421113;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q538lbYMTTPrnheczeSona+XWJylCJHfafHxKrTAs6wn6r963AeuVg2LObxwoWLPi
	 G3RuF3VZrDdJxRgfArvgTOh2bFZ7MfVTYMPogyIrMcEN88bNCFRqxdoYEJAHocrsfH
	 JnzZ6HAjPtzBB4H4yZ3aXGBOvIjhuQGztMZZFUkzQOWTEBIHXNpnWlLTJjNjcsMSDo
	 2mU55UyAESQmwPyRckQvS4yOPyYMcUNUDr1w1ov/f+2X34CtgDWAKog32/Nu0bUCvU
	 pZWKl46BYPaH9kCOIlEiy1MlXB9iPChS1kb2ZDeGajtfSrnnc7SFnN/kVeGPh04EA5
	 7Xqd0eB5sJYCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45CAC624DB;
	Thu,  3 Sep 2026 07:38:33 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 03 Sep 2026 07:38:30 +0000
Subject: [PATCH v12 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-amlogic-dma-v12-3-f769bc344056@amlogic.com>
References: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
In-Reply-To: <20260903-amlogic-dma-v12-0-f769bc344056@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788421111; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9xq7fFe8x3ZtUEb/et7K+dc4J+CzRRN9hABeSR7Mhcs=;
 b=ES5hG1QHitnj//S1zRt9r6Ao+jjztMG7eGTlhBv2rhpNdy5sPM+uEQr+E50PWKdWIW+UshcLx
 kntKVGGN5M6Bw4bjdZF5FYH9Hx5axWyzbQDXKrgxcbycpC+RR4XVbLn
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


