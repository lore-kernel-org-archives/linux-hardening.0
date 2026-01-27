Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CB30AD10;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484479; cv=none; b=FyDBghTM9RNgKqbN+u7BWadhVEOLztHGdo+tnszXaIOKqNsePYj2gCh+DfsPoffRCR0npDYeTXalBkzevl+6oOuE5YsWMplzu41Wq4toJ8/AADKPzstOnitKAiZ5OoE5pnXKH0Tjfeo4QzrQAaiRmy9/mZaVHyBVsqJNCiJh5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484479; c=relaxed/simple;
	bh=EDernAL12A1n+hBwQmDnp+GejoVHgA1r/zF1Ns85j5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hO15gbjBLCZ1MVfI1EDXEv07VcAgZ8ZrYEd4FQYgeNyMBbPePV9c9VCqSJ04MKYcHOpJ5mgk65U+AtSHduZV/4saLzlY/AYggpudVqa9+OhPYwILiccBWXmqk6X2AlraTZlG5AzXmZgTy0OwdGJ+xY03PS0E66oxQT7QDacLVs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DknKqfiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DknKqfiU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61158C2BCB0;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769484479;
	bh=EDernAL12A1n+hBwQmDnp+GejoVHgA1r/zF1Ns85j5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DknKqfiU85HkBJ/K7RKbgggtlb8AGROqYxL0CwgTZh/InnkAFg6jTSWtU1ceQj002
	 t+70O5Ie4yMI6EKOkJHZcG4kPQ79pYzaMdFxtMc5tE8I7UmUxFfTJ/wpS8HOCYpQ+i
	 rQBIqmJT03mR2D8MF6sAkj0hq88zMtc+yRsXD8LgU2m1GtCJSG5miFodF3bsVUJxKX
	 Tfnoe9tsReT882O2Tx9zdn6E1/CNPDyya+6YdO2j7Nv86+Xm6Bbm15Je7uys9Gh130
	 Uve0b5soeyKqFJIQiSeXClM97wmDtlz6A5nAFX7mFlhT1ARRmAYeH23Y/yukUSr7KM
	 O2cZes+CQiG6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57363D25930;
	Tue, 27 Jan 2026 03:27:59 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Tue, 27 Jan 2026 03:27:54 +0000
Subject: [PATCH v2 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-amlogic-dma-v2-3-4525d327d74d@amlogic.com>
References: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
In-Reply-To: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769484477; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=bfzmsANkUP7tvKv82qbR7mHmRjOKAGovJZX8tW/lzN0=;
 b=IiWEkWAYw6ouDz4BxbCO0eKHnk38kMZHv5bZfgvwF8RoWcrqkoiQDodYY+MpLVa6b3Skj8pZQ
 jQ1i48ANME+DexD03EdNLHTb66UHluw0dI5SNog85A5syV/RkkKkofT
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
index 5b11839cba9d..9b471d580b32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1305,6 +1305,13 @@ F:	Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
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


