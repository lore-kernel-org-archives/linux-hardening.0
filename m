Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97E3C73F6;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452378; cv=none; b=oWhtGPHs3Q67y7vClpTKqv9cD3UjnEwYDll3CArbCeg3yXb0ak0bVSko03hFtTZ3D7x3aCa7+t5IY3DzgDNNA96MFrtejfmiFwnuo9g2onK9Tiozi+qwsA9vfVtp4Yj/CMncfUfjubhfytkfGaHYt3f0SROAuEtGxCDzs/b42OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452378; c=relaxed/simple;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lTPoB4LPfbHTLAgd33gvv7uUIu4sEOdC6I4LHlcxrAnUV58WQk/6Vq2SHW+StF2Rc4xgzzt6oZvuQPFa1HmPds3KzJuuOHhB91x9QE1pcYP/ptpiGSJjq0sUX4MolkRzGd19rx4J/q90fp6C+6uMGJKDZCwE5PcwjFOZh0cHy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoIy7SYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoIy7SYy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32941C2BCF5;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782452378;
	bh=NcdLhXrPcWFclpxrmSESajR2JcjuoXQBKnYxQjejsnA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EoIy7SYy7TReY3J5YTlR5jYja/iaG6Mwaa6QZXu1CFAdXb4vEg2TaHbSJ3IBtqBCC
	 gwaNnvVH85nNf96sHNsNC87t6jp3+uSPna/9TJH++1305eBEdWF4RwNn8YSEA9iZRW
	 FhDy3SZrDG8ppHtwX2ubS7YxsxEJM4NA1l9fsedEucnh/HxeUPAkBjxdrbGkd5qMxh
	 XXdvY+MDkLBwPB8ZzHtnZHST2nfCmKPtYSARWpcfGhJpg1k06LzFc15HY6L7ooO7va
	 PMYU88/QvJ24NixEBzzwzX3FxRWNXXNwnWaKVeoOYnvsJYXKiLnnahs2UEqUwY3EJg
	 eZJXLP++IWp5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B29BCD4F26;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 26 Jun 2026 05:39:35 +0000
Subject: [PATCH v9 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-amlogic-dma-v9-3-558d672c4a95@amlogic.com>
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
In-Reply-To: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782452375; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9xq7fFe8x3ZtUEb/et7K+dc4J+CzRRN9hABeSR7Mhcs=;
 b=jnBSFaFUL3etwpsY/Wr6LF3PZiABq7WhroaraCMNyOV14BGIg8jl7jhw3OfsroNWKdJGehgAK
 GUqr4CA/iYzAF7n2XRN+Oe3W37jM9/4hgu9K2nXNC847qsaqeUE/oFY
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


