Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48835AC0A;
	Mon,  9 Mar 2026 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038036; cv=none; b=VdaxESx0GsfAnQIN8P1dAknRaAjNymoKNf91Au30ZGBb2Vesb2ZBPSzryo/l0y9ZKI7ROsp6wQgZhvLvH48WLsQPNJNh/LaG8lSZAaQpR4IWb3QFzwi2wDJfZ6AHM9laWvAArtL7UETnY7l9ox6DFzORmYI4O/IkgpDfyLMj0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038036; c=relaxed/simple;
	bh=kdSXp5Qbia4qiLAhNtnkaEIWENtU3D2yrCCRDU+8y4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdQQyaHlOG1UPfdxQvWpwBj53HeNZi0uVoMJBzT8zoa8J8Gw1AV0qJKLURdnoIyodmxSWo3m8SRjoZz+Jj+aTkc1xJthUGtx5bP69c7Dh3WNo8l/QMl1niMe1jvRkG/tCS3SzAFYKjC4tt8XjCHEAUU64vMeYA5QdAiXHAR8CSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABFdHHwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABFdHHwo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 574EBC2BCAF;
	Mon,  9 Mar 2026 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773038036;
	bh=kdSXp5Qbia4qiLAhNtnkaEIWENtU3D2yrCCRDU+8y4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ABFdHHwoxTuS5hm4CnFs8z3xh7X/sm24v41Ttjqi5KiY6Mn1BF6Nh5OcGFL28iVhI
	 h/gwHs+xA3zDS+VX1XEISmQCoKnz9zhI6zb0iw2rf2QaLsj9LpmDYvrtcDKGmAOJQ1
	 XHzWKUBPJRxr2vewlcuB8A622V1ZDo/dBBF9u98ooi6LUX+hNZ1aIxnBJoX0uddb9B
	 FPJJOJIh32wRWgpW+T2Ir8so7BbcewFMgc737GN3C+CUiEh3c03B107vU9QrTsJhov
	 mVh1oTKLPcINXwfUHko0wV1LNBaQh+RducdP5G81iGA5njN6KO+o1V5uwpNaHfxbXd
	 o1GC9oMSCT0XA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A89CEF36E0;
	Mon,  9 Mar 2026 06:33:56 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 09 Mar 2026 06:33:54 +0000
Subject: [PATCH v6 3/3] MAINTAINERS: Add an entry for Amlogic DMA driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-amlogic-dma-v6-3-63349d23bd4b@amlogic.com>
References: <20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com>
In-Reply-To: <20260309-amlogic-dma-v6-0-63349d23bd4b@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773038034; l=791;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=3ILqFEE9mmDp095lkKeN49I2hs9aNRjaPs7y2SEtITs=;
 b=dpp+q4WX0hQqa+7YFFEA+AwJwuICD2ECPr919QZfbaonE4AGi/uNsfvHyuJYnUDPQEV2FG8uc
 JoL1CGU0GnABlUWm8WwjuuF1+6N9NXFT9UgLnFMK69KW/IYnBp+wNIW
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


