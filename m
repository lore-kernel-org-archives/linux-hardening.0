Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C23ED12A;
	Fri,  8 May 2026 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251374; cv=none; b=E3/fyZfAuS0SUULjlLvlqb2CslWGtOpGO1fsAvS2WKdOqiiIziqsPBBxWwNpcVnQyTpW2sS12tccdUuF/j70lcBzwMTYX2v05J5onli6KsNGdJjHh1DlSGItXyBCX44qWFASRpC4NvuZAxPKry16sm0QUO1fRbH1wS0Da5o1Z/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251374; c=relaxed/simple;
	bh=gyTIyYto7tzKXHDd6kMNK0OhSiLeThERn6mhwt9FF3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndtrdZaDbPUiE9l6bfqvHcf+dQb6QYVR9+mKk94F25t5FsnRg8KUFjJ+j3//eSdGDAkbfiGm4DZgtmwO+p5MLUBN//v+ftmmNodFypJo57aHsdJ/i1ovnjZ8GuEQ6PTMhBAzICW/6ZmK6GfLZGDCmSDEs9XQeHx56gxQl3TVNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfhgSZiC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kd/8eig3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfhgSZiC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kd/8eig3"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778251372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81MPp/cPmY31f4oil6TsY2E5xHh8dQK79p3Ch11N/PI=;
	b=vfhgSZiCZi0GULsQBjuOZxGx7VZZW+2K1xRRZ9Wrehfsz958B3cDMUfgy52z+QXr7c4v7v
	QBSa3FLZAMveG6F/8819BdgueVUVEtyw5+zSVG6BoaUt0SQHLjIpsPU42qKawCUzhPAR3x
	rEgWmFp+Rpto89fRF5+PLBxVmJLWWoKphEKH8vtGSlAfsJdmN8+XJ/EtxCntZYn4/yCX3/
	JbfveMiKO6Kh+w02i7jwGsxqNmoZCn+wrnToRNqR6Nz//cwUo4kHQGpOqtDsgDs8oyf//p
	fGHKsVOfolmE+XEQpmmMYH5djbQzZIHQlXwii2svYvhId2yBebvYZ9lKKYpYbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778251372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81MPp/cPmY31f4oil6TsY2E5xHh8dQK79p3Ch11N/PI=;
	b=Kd/8eig3QYkQ/+RelaacDc4SOX7exZhk8eD+91IHQ5IqaE2CI58nkia2XQhHeyGYCSYG1k
	RVSdacbkdbmpqJBA==
Date: Fri, 08 May 2026 16:42:47 +0200
Subject: [PATCH v4 4/5] arm64: dts: broadcom: bcm2712: add
 raspberrypi,bcm2712-firmware compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-rpi-otp-driver-v4-4-cf8d725d8821@linutronix.de>
References: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
In-Reply-To: <20260508-rpi-otp-driver-v4-0-cf8d725d8821@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778251369; l=1152;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=gyTIyYto7tzKXHDd6kMNK0OhSiLeThERn6mhwt9FF3w=;
 b=XnMQTKXSNyFtzEfMdOy4cZ5OMhxyyHp8g4rtPATiw58N1+t/QJgcqRZTlpGzHgvYsf5fPIv4g
 YhHgTXzLPzXDVT0Yev8Ye0wQnUF/xQBGrBj0rLcB2tIVXMdOcLHKnvu
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The Raspberry Pi 5 (BCM2712) firmware exposes additional features such
as the additional OTP register region called 'private OTP'.

Add the raspberrypi,bcm2712-firmware compatible to allow drivers to
distinguish this hardware variant while keeping
raspberrypi,bcm2835-firmware as a fallback for backward compatibility
with existing drivers.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
index b7a6bc34ae1a..4aa8ec7601b8 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-base.dtsi
@@ -46,7 +46,9 @@ power_button: power-button {
 
 	firmware {
 		firmware: rpi-firmware {
-			compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
+			compatible = "raspberrypi,bcm2712-firmware",
+				     "raspberrypi,bcm2835-firmware",
+				     "simple-mfd";
 
 			mboxes = <&mailbox>;
 

-- 
2.47.3

