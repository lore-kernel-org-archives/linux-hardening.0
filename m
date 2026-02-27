Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A35332625;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176857; cv=none; b=gRxEPp8Po++7rpXdKyJQAKT9E2AxiaXykIQ/6Lejz1MNq6MYtTioYDqtmxlii24mGA0rbJz6FJtycEjKV35dY/9I2gf7XiCpk4+aCrTw1zNlDSRvNFPj8jmRbDJxkmuCMWunBYhWW2g1uQjIwok1GTeXnxHqvcWVVsIfcsBXPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176857; c=relaxed/simple;
	bh=kdSXp5Qbia4qiLAhNtnkaEIWENtU3D2yrCCRDU+8y4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjUbNR4N6O+GIeGlcw76Y7nBZqHUwtVDWr7jSJJz1OjKNCknwpPb1/Gs3Ons7GJcbJLUNs3Zckn7jcOsvJnNzNLhfRB3HcUnjHW5ZwSzWYDLN4lfl8pU4ssLVGW/KL+W70zM5+5kzZwkNJPqRc5ZfeL1Q9DhkNxEhzKLqkDbqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpfnVC/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpfnVC/O"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E4B6C4AF0D;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772176857;
	bh=kdSXp5Qbia4qiLAhNtnkaEIWENtU3D2yrCCRDU+8y4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IpfnVC/ONAAGCmpShdxkuI7UNVQIXbZ7XIrEq0xOndDfEJZbygjZG1tbqCiRHCEb2
	 EIoa6KBM+CHyizgeC4sWhRcVHIC38rfCqdbsHP4dKWIHIXIkeIxSjqBLt7C7++PXTK
	 Rv3d7cHZWQEZhwdGpc/d2rsUmRJyKCewkv4s/SLQrcov3/9V7zg1uP8KVnIrTF4Ubp
	 rIj0Sr2mJ0OrtRkw2P2N2IFuxgJIdeSGrd6u6bzHW/Q9hjAV/tILenHccMgXCJdStG
	 QoOWXeZBjDXTpE+gQQz+HtGEgF7e2ymQ6iIWkZbDELUf9mcXdwEZkJNznJ/8fnd4CC
	 LQmhjxzsYKYuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116BEFD5309;
	Fri, 27 Feb 2026 07:20:57 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 27 Feb 2026 07:20:55 +0000
Subject: [PATCH v4 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-amlogic-dma-v4-3-f25e4614e9b7@amlogic.com>
References: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
In-Reply-To: <20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772176854; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=3ILqFEE9mmDp095lkKeN49I2hs9aNRjaPs7y2SEtITs=;
 b=ZbNvi1H6dX2dRUHx2fdcEhQktkEhlIj//tcfjDKNaTVr5Iuvk7s0K+5auXK4jondqkMXVs5CJ
 vyP1LLQYdI1D6W2XGSkear099oQPRZCFSGq698NjzuWVHFitForzNxb
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
index 55af015174a5..e9c52dfba2df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1316,6 +1316,13 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
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


