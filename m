Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D123A58F;
	Mon, 26 Jan 2026 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769445406; cv=none; b=W7GvGpdh33ogfT9sabaYmS7pVuSjKjxoNRtcEj09X+JSFd2L87tZkwvszI6TIMh6650JAvRuYCB3cdajygcyVdIUVfVDVEe874lsVPZsvqtPAvnuZ2bxsLN2H1RSpQiPdLUODBTajCCVGUAtoqqWKofdAWXuYQti/86unm2KjdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769445406; c=relaxed/simple;
	bh=0xWVmOcjF37rBFAWRMgC4bqIHyBH/tIBXGmQGUtVn4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYpzEbSzF/SjpmWnk3H7o51g/5SOJfH624+UJ0F1AmRzY/y5mfvh//uTcbgxuSWPu5if5yQnhCUAQX6wdhxj7+vYgb/n52M1iq5FL2oMQnGlzAv7qDkw3W2cm6BarOhIw2N+BKdonfrEp0G7tUhyN/VnhJS2Zo+DRk52a6qIc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Tr2Sl0+i; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Yp8Z7ddI; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Tr2Sl0+i";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Yp8Z7ddI"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1769445297; bh=Iks06YVh9H1/3R0Wj6bUu3J
	sg4b/0IzK/VTKur/sG6Q=; b=Tr2Sl0+i4miZDc8f6TDbZ1MId9lcCYsFtMp6dm14/aLf/3VbsC
	ZyTKVlmxtRP7G7V1sIZ1vup8KmK5o6I74PK83zs2TuZyXBhXN57e9tGWdWDTlzYhtnIgBIE5PTO
	v8cQ6Gaz1P7izXTZF7nBcRuBdpRDADudD+oigtkhcGFcWmjWs5LufgQrDVW0c2bNzzwMFWPw4KU
	e2cuAIYqylQ0aCVaybwj43SH/xHU0VnY76V+d3hGK5UZtFFblMiJbf5+o82Kigbd1VqmpU/SmGA
	fH4xHDNzoiNnExze+q/j7eutzc9z0bnj4mlO24uPDuJP7c6ocGZl6wvmGn8xCW4yLgg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1769445297; bh=Iks06YVh9H1/3R0Wj6bUu3J
	sg4b/0IzK/VTKur/sG6Q=; b=Yp8Z7ddILzrqMDzLhLmIMXVMuLxpU+V6LeV/pAUKq3+Zls7B69
	UkE5dmE1FsmGcLs5wRk5D60C7Bz+deqlqmCQ==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Mon, 26 Jan 2026 17:34:54 +0100
Subject: [PATCH v3 4/7] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Remove
 extcon
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260126-xiaomi-willow-v3-4-aad7b106c311@mainlining.org>
References: <20260126-xiaomi-willow-v3-0-aad7b106c311@mainlining.org>
In-Reply-To: <20260126-xiaomi-willow-v3-0-aad7b106c311@mainlining.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Gabriel Gonzales <semfault@disroot.org>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Biswapriyo Nath <nathbappai@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux@mainlining.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769445293; l=1174;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=0xWVmOcjF37rBFAWRMgC4bqIHyBH/tIBXGmQGUtVn4w=;
 b=UntMFzWRcWZvR7Aq4fNf5K8dJaZMhtPZldvbUiQTz1ORZ01MrqmXkx+iiKJ+7tNaJPCQbfwxl
 qyRtortx2fCAQXvL4CIyp/7LH4PEaFdky3mdXqPcOyrF54V2T+HIuuf
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

GPIO pin 102 is related to DisplayPort what is not supported
by this device and it is also disabled at downstream,
remove the unnecessary extcon-usb node.

Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
index 8497f0cbf819..caeb7c74873d 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
@@ -77,11 +77,6 @@ ramoops@61600000 {
 		};
 	};
 
-	extcon_usb: extcon-usb {
-		compatible = "linux,extcon-usb-gpio";
-		id-gpios = <&tlmm 102 GPIO_ACTIVE_HIGH>;
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -304,7 +299,3 @@ &tlmm {
 &usb3 {
 	status = "okay";
 };
-
-&usb3_dwc3 {
-	extcon = <&extcon_usb>;
-};

-- 
2.52.0

