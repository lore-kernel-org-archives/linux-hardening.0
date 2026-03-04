Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4337B417;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772604856; cv=none; b=Whcw+iWayC4nhWJrSAonU+j82dD5zSdcoFxzEPJIAta4NNPZXHGCdTLLt37PEveexHSmMPGYEr3mZqme8cR+GTivQg6pWEL3e8RN8vCMDky50LrL7pBEtr8InDV+o8WTtVZEJMKTJJJ+E/zFUbGFWDmLS9vtMNS2G7u9SxWNODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772604856; c=relaxed/simple;
	bh=kdSXp5Qbia4qiLAhNtnkaEIWENtU3D2yrCCRDU+8y4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUOsYXEKkrY2H5P35EQJ3wxwEQX1ALytOZnfMIJd95PtIjcqKHIQqOfXU5lsKzrI7ssu7D5RqjGroI9kHa5hS9bgW41tBQ7mOHw4HDkHxYnY5oPMdwXIONB/OajAqLCNtXwOqsJGj1nx9UHS1noZWYRyhaJYI2Ja1RzYywB+eHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9oIytMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9oIytMD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC737C2BCB0;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772604856;
	bh=kdSXp5Qbia4qiLAhNtnkaEIWENtU3D2yrCCRDU+8y4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I9oIytMDC1vx3uKpQOcBU45ds2ZOOHOxNPVn4tKV3/8OSxgedSZ/6i92PU8L5HScF
	 9MvXIuF0BTfW9qDcOp1sNeQCDZSjBoFdfwlFKQYkkPLOnT7yqlXJpbueco6Up5s2/y
	 p8hh/I9P+PXo5zF3hZYUDEjQZgnwi7mS/gXvsro4qeUEIwyvrV0AEZJ9zI8EeeTSfZ
	 dp5tJIYISN2DlhApogL/DkRsv6hXwYp8RJOvUf9a0kTrxF17ikOy3MFU5oTVERypj3
	 zW8lxwC8ZyoNcUKxhivZVLTk0ySa3lx7LdTFqq9ijmQVdYOkQO6/p7rR52ojnbAmm7
	 ovfp5eEbqbWqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15ABEDEC15;
	Wed,  4 Mar 2026 06:14:16 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 04 Mar 2026 06:14:14 +0000
Subject: [PATCH v5 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-amlogic-dma-v5-3-aa453d14fd43@amlogic.com>
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
In-Reply-To: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772604853; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=3ILqFEE9mmDp095lkKeN49I2hs9aNRjaPs7y2SEtITs=;
 b=9USpP0n2vyKSR5Z5zHbVHWWUmK2A2p7Let4R9fnXZAezGITc++N1pXoFvcMlDUAjCTSoBm8s2
 ctANXVN1tv/CfTdMg2qDB1OiGzK7T56TIxFLGxUt40EQ0YiPopgKnIA
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


