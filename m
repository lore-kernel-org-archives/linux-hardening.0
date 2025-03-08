Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A63610D;
	Sat,  8 Mar 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397516; cv=none; b=X/lRetHKKyvy3tRiJmaSu5V3eSUE4LRkR8tp+mD0KxVhB1zVbqTRpsonCK+z54foqgRZ4P1+7W5tefTHi2iKi8iep9V0G4s282Ue9BkLtvuJP43ASh8w9dVsPO9cAFwEwIv+P1T/++LmP81jWcDIzeZteRz1z/7jKU9SiIi3K2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397516; c=relaxed/simple;
	bh=s0gSucCzyF9njSxjHj2VS9eZrKr9VOiZivhKMf16jXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td5pYsAgehRkAM2rSDTejBrsWnvF68kGuMGOrSEgx60AeIDVifONBje+PWHhWbKtT1bFg6zYrVmES1HBI75NaNv/CUHDI6OcuIaltcDw7Ld3ARvfYoC3adkP65wUXAkn4RjfTAg+WaSLNnTuSBHy/8nB2gA5UsSMQmDvIhxw+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Qr4QXGai; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Qr4QXGai"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3B83125D3A;
	Sat,  8 Mar 2025 02:31:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWamNI8Y73uc; Sat,  8 Mar 2025 02:31:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1741397511; bh=s0gSucCzyF9njSxjHj2VS9eZrKr9VOiZivhKMf16jXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qr4QXGai8li6EDsPx4gOJ+Gujjhm3QhHb5TbSht3Pwg6gfBWCTjexUBgnkkuyA3vC
	 834O60vqbcKbnG2fly8G42pJssL/1a3LAr3erkemFzO8n4DtcIB618GujjksbtMPty
	 +tQLOaPa18dlFTQKqEUEc9oLi8f8SwZv9yYpjQ/CWojOXNf682syhMhrFlzKlCSbLs
	 CE3VE83a/BSv8J+Wk3DPYjSBK81UPpv/n8eiV0MP2xeS16d2PIkq/l7v5d+iwNz+yZ
	 y0cDz9NWNhFClh08xxzD0T1Kraw7fBzyU8vdt09OtKNYS2+8HpEx/ooZtfsu0gpdVU
	 Xc4e/dYdRZvLQ==
From: Gabriel Gonzales <semfault@disroot.org>
To: 
Cc: Gabriel Gonzales <semfault@disroot.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom: Add Xiaomi Redmi Note 8
Date: Sat,  8 Mar 2025 09:30:11 +0800
Message-ID: <20250308013019.10321-2-semfault@disroot.org>
In-Reply-To: <20250308013019.10321-1-semfault@disroot.org>
References: <20250304043742.9252-1-semfault@disroot.org>
 <20250308013019.10321-1-semfault@disroot.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Xiaomi Redmi Note 8 (codenamed ginkgo),
which is based off the SM6125 SoC.

Signed-off-by: Gabriel Gonzales <semfault@disroot.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 618a87693..52f7b217b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1020,6 +1020,7 @@ properties:
       - items:
           - enum:
               - sony,pdx201
+              - xiaomi,ginkgo
               - xiaomi,laurel-sprout
           - const: qcom,sm6125
 
-- 
2.48.1

