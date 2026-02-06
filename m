Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2B313E2F;
	Fri,  6 Feb 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368565; cv=none; b=rwyoh4oClE2ClfKYGA/VZH4TsF2JaQe2CMsQO9f+cGt6oX/4nzVg5ZIqO2MLJwbQW4UYv1zDbD5Ua8ve808S0rEbpQjUV30DpF7Ly3SmqSD3PGhOd+fr3wvevRCRZrIEjVXNSbpnEUNp0iwARMWmjvGF5HFFdv2dVlzIOg9OITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368565; c=relaxed/simple;
	bh=jrh61Q19wLzhUZ6sxEiPQLIX67ExYX9Ua4Vm7hOPgu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MNRK+BBsq0EWtCfv1qfOUCihJV54KUvzFs2H56+E2LqfOJ6Qprm4i9+qJeuocKn0v12qYITEes7aI5korxiWSYJovuR2zgs87TVQa0ZrmzE7hwPUi5VleHHa3pSO0oAY7M6kAJRh+waGBx0TA3ayqB1gKDV/V/LUjYmhIXxCR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI91vMUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI91vMUb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52E1AC116C6;
	Fri,  6 Feb 2026 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770368565;
	bh=jrh61Q19wLzhUZ6sxEiPQLIX67ExYX9Ua4Vm7hOPgu0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uI91vMUb69MbqcTz7+5oZkTC7rQOa2uR5KQOL9AuNXREqmTROXZTHY63frc96PBRc
	 /spxiWbCyj9EwizMKBs2JHELrKyhfUyuvWkpo+8r2UKUV90THuDphsKe7Wm42oFzzD
	 0VW3AWSFn+l/TRLO5DNNtsSAD+lGtvZUp7jgSzR4iSaad4p5yQMJtkY5AGQBrbwXQb
	 6aKmNS5SEexsGWU7pItvVZYMIr1VfDjBxArDfzp5KOZGFIS+MW1eKcTUbJnz03DlKO
	 rd04gpzpTWcbT5OQAw8Bqk0eX4jb1vd8PudLxjb9W5Z1N7zxfLIQivPWxBOhRoMte4
	 xh9R40PgONd2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33129EB28FA;
	Fri,  6 Feb 2026 09:02:45 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/3] Add Amlogic general DMA
Date: Fri, 06 Feb 2026 09:02:31 +0000
Message-Id: <20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeuhWkC/1WMwQ6DIBAFf8VwLo2swNae+h9NDwS2SlLFQEPaG
 P+9aOrB47yXmZklip4Su1Yzi5R98mEs0JwqZnszdsS9K8ygBiVAKG6GV+i85W4wHFuJ6JR1oCU
 rxhTp6T9b7f4o3Pv0DvG7xbNY172jD50seM0JLi0ppFYbvP3fsw0DW0sZdlvXAvBoQ7GlAuUaQ
 IfSHe1lWX68yXz15gAAAA==
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770368563; l=1514;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=jrh61Q19wLzhUZ6sxEiPQLIX67ExYX9Ua4Vm7hOPgu0=;
 b=DKJiuMJk8Bl6zffHlSwK/VcLZjWMje/yyrkDq1sbzyxzUlYkov/hf+Gdw7UD3973aKSy2/mWy
 B7/mudaXVmZB4UBcl5W6mlvyD2HFRIhUDzX8cum2x8GE50VK2ulqODL
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Adjust the format of binding according to Frank's suggestion.
- Some code format modified according to Frank's suggestion.
- Support one prep_sg and one submit, drop multi prep_sg and one submit.
- Keep pre state when resume from pause status.
- Link to v2: https://lore.kernel.org/r/20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com

Changes in v2:
- Introduce what the DMA is used for in the A9 SoC.
- Some minor modifications were made according to Krzysztof's suggestions.
- Some modifications were made according to Neil's suggestions.
- Fix a build error.
- Link to v1: https://lore.kernel.org/r/20251216-amlogic-dma-v1-0-e289e57e96a7@amlogic.com

---
Xianwei Zhao (3):
      dt-bindings: dma: Add Amlogic A9 SoC DMA
      dma: amlogic: Add general DMA driver for A9
      MAINTAINERS: Add an entry for Amlogic DMA driver

 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    |  66 +++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 561 +++++++++++++++++++++
 5 files changed, 644 insertions(+)
---
base-commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


