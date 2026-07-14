Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5923F0AA0;
	Tue, 14 Jul 2026 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016507; cv=none; b=porR1LlZSZIcQ8eQuar2spy31tUQfmFO2UHQ/A3IOFRdKSQqU2aZO8oZULf1LsSg7j1Ur3aQPghlgK5AlNTBXeuE2vxJwbUcOBAa+BYlkiJ7sskobxMqLWzCGgUt5PIFKcugOTBFXhgwvpBsYWCaE3V72FaTfoEHLhEHlmKoBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016507; c=relaxed/simple;
	bh=0kjoSrXOirxQ0MVKjWZxUdN6zn6jSvd2UsDyLLOSTKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cCn1cdAh+FyF1cDQOX7/DLO1OODzu2H6a0cKzhKSju7TCWxbEjj/xmU0Tkked0qf+nm24vhvQ9eITRjRJJJ3X1jsOhA1S7PyqsoZhaT9/vBfUMx1eBig1rioV6cykKt85KmLoKTJnsHc9LZh69t6lF4ZBTEj1DIXceGI6pwpbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+dX6Hqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+dX6Hqh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81F2EC2BCB8;
	Tue, 14 Jul 2026 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784016506;
	bh=0kjoSrXOirxQ0MVKjWZxUdN6zn6jSvd2UsDyLLOSTKY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=c+dX6HqhUwhngfZ4+sMn7dVXK1FHgUFGUQ0CStdLJ03U1c/3lXKo3ZkyB2/jLQ0Ly
	 mbZIDyRdBiEiZZAq3efkyYgvhck0WMx9GxC0TcnQmXw+YmGITZAePUkt16ipkkyUR8
	 JdpaleeEB37af24RWBCpI3N1G7KflSWddQkvZJlwLAveeRcJcpQDDW5ZnwsToJGV3b
	 45dEl7kjIeXq5hYEwOch6Xtrdn0OmRY6bH+O47T7j7DRN9icVmrSpTOZpFR5D6Nl8i
	 Velo7ehpcf6dNH2zv/bZvn4TSdkdBsso1rZkKRzh/H2NlK+fqKCgEWhGPlGlUSighi
	 wlfRFKvaY4CEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE3CC43458;
	Tue, 14 Jul 2026 08:08:26 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v11 0/3] Add Amlogic general DMA
Date: Tue, 14 Jul 2026 08:08:21 +0000
Message-Id: <20260714-amlogic-dma-v11-0-de79c2394282@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHXuVWoC/23SwWrDMAwG4FcpPi/DkiU73mnvMXZwbKU1rE1JR
 tgoffc5ZSVN0qNkvl9C+KIG6bMM6m13Ub2MecjdqRQALzsVD+G0lyqn0lCokQGBq3D86vY5Vuk
 YKufJucQxoSVVxLmXNv/c4j4+S33Iw3fX/97SR5i69xy7yBmh0pVg7YWdeBvc+//ra+yOakoa8
 a6tBnRLjUUTIyeDLjlKW21mjXo12xTNtm18y14S4lbTg17PpqJbZCELJL55sjnP2mhaai46BGK
 TgNpEZqvto/ZLbYu2xpBPaJpEzVa7B42r2W7avG48iIDHCFtdz5oRlrouurYxYhRPQE+u5mdtc
 XVzP92c62QdRgqetxr0zB3o1XfR0+4tJQlSGyerq1+v1z9EjZRL2QIAAA==
X-Change-ID: 20251215-amlogic-dma-79477d5cd264
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784016504; l=3316;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=0kjoSrXOirxQ0MVKjWZxUdN6zn6jSvd2UsDyLLOSTKY=;
 b=Xld4fv2TycWoKv/SsuPG0Ut3FXf8fJv2FfpxgqVXdvbeyTw/TAH5FQDe3cg2VdNpFn11ZsqZi
 go72iYBVPvgATwpeO2j4eGxfMLhZ5nC/xIrB4W9uDliPQmI72WZcpQM
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add DMA driver and bindigns for the Amlogic SoCs.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v11:
- MAX_DMA_LEN 4-byte align, and return real status when get, and lockless error print.
- Link to v10: https://lore.kernel.org/r/20260710-amlogic-dma-v10-0-ff4deae837e7@amlogic.com

Changes in v10:
- Free dma memory in workqueue.
- Deal with zero len sg (not consume sg_link),and reset status to DMA_COMPLETE when terminal channel.
- Add desc for #dma-cells in dt-bindings.
- Link to v9: https://lore.kernel.org/r/20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com

Changes in v9:
- Use each transmission request sg_link mem instead of the loop mem get.
- Fix some hidden issues which reviewed by ai robot.
- Link to v8: https://lore.kernel.org/r/20260521-amlogic-dma-v8-0-86cc2ce94142@amlogic.com

Changes in v8:
- Use kzalloc instead of kmalloc.
- Initialize the temporary variable and fix a spelling mistake.
- Link to v7: https://lore.kernel.org/r/20260324-amlogic-dma-v7-0-f8b91ee192c1@amlogic.com

Changes in v7:
- Take use vchan to support mltiple txns.
- Link to v6: https://lore.kernel.org/r/20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com

Changes in v6:
- Some minor modifications according to Frank's suggestion.
- Link to v5: https://lore.kernel.org/r/20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com

Changes in v5:
- Rename head file and rename macro definition.
- Rename the subject in [2/3] from "dma" to "dmaengine".
- Link to v4: https://lore.kernel.org/r/20260227-amlogic-dma-v4-0-f25e4614e9b7@amlogic.com

Changes in v4:
- Support split transfer when data len > MAX_LEN.
- When a module fails or exits, perform de-initialization.
- Some other minor modifications.
- Link to v3: https://lore.kernel.org/r/20260206-amlogic-dma-v3-0-56fb9f59ed22@amlogic.com

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
      dmaengine: amlogic: Add general DMA driver for A9
      MAINTAINERS: Add an entry for Amlogic DMA driver

 .../devicetree/bindings/dma/amlogic,a9-dma.yaml    |  68 ++
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |  10 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/amlogic-dma.c                          | 726 +++++++++++++++++++++
 include/dt-bindings/dma/amlogic,a9-dma.h           |   8 +
 6 files changed, 820 insertions(+)
---
base-commit: f53b2c30a192b35064be2584df7a800a8e6ac710
change-id: 20251215-amlogic-dma-79477d5cd264

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


