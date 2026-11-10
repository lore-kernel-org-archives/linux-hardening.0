Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328453;
	b=AFU+gUHvH5QbXCR4G5w9W4oX7X/V5rfSFQ5cr7OGdXmvSNkTYUFN56koAqtB9ixf9cbi
	 VPfZ/DLJo6S9xgwTvA8vZXRt3UBJ+b+2X2FyIcyRoe9hSq5BkS+yS+wU0EJTQ7jhiRI2q
	 6iE5PERuzPMNIDh0rcnVO2Vcrifwat8FO+CsXR+Ih3Hh3ywCnPSX5rvNJlRA0ir7JButw
	 XWM7bUmFvj5SmZVctvTat26wYuYKUONwb4q2gREo5d44U17nT6FR/78u7ElC105OMKqeb
	 MsO9uouFZLjAXW/ys42gPYk61KpAlkpmEIDtxHMrglZx2VWrR2vTFff0CY6A8D4O9kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328453;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=lbGlH6LyQNP5sc50UtJwj95tLc8lFqCBSHifJVLBLsmtfK4xktsRx2njnJYGWK81Tvx2
	 JgyAc6OzGGKFtNLJCmr/tnCoUl+MzXHITdEZIWGtma7MftNKmC4hUbCDdzXqdGVbnhZen
	 guwDMXox4uEorNkwwl2XtrOhTX9LHK/T9diuPPGRTK0T7Lyl+YNbAKR71XKnEuarbZYk2
	 X0N5H9g5RJdpSiUL37Caojn4AsXlxsUDwkufkLN/Tx9qI8yrXF8s6Iy38axfCWaSwSsIa
	 4A2ovur3vL9naPwdjhSw0VOzkN64DZ0iK2jgQnTy+ek88of7q4+PRoWMNHqg+zyHz8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=E+So8ZNc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ees8fCyG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A82606A20F;
	Tue, 10 Nov 2026 16:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57A82606A20F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=E+So8ZNc;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Ees8fCyG
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794328450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=E+So8ZNcgf+elvtMsO/0RgAl+eGb/8WXXA2I+3n3yd5DtjpbiWPTiuz3ng3P8G52we+99/
	V565cNbTYzQ9OUW/Y/Wec/gtrWBCKUtt9KePOb8tsjyNJaC1HLR8ELUH0rMbbqn3BoKxui
	QnPryiIA+7aVdK/xAyjRRYnbih0T2V9cIvL8wWYcRpKboE5jK4LUEnswIV9Ee7RItY37qd
	nXGRmw1azJ/LW/crDiu4l6srtvxsuCpnAQwe95pW7yY04BUo+Mn8zbZY07mE0tp9WzA71U
	DWAPsuA91abt5ANtX5O1qSMJ2JpVmVuCjQSzgLVn8QdzPIpzGTevv5w+oLbqmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794328450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=Ees8fCyGZOIGewaaR+aG3eE1+t225iV9Bwd/7wnATtTLOfrW7qJHznNByddbDi/D8tpUSN
	JF5uYoycB6Jvw+AQ==
Date: Tue, 10 Nov 2026 17:34:02 +0100
Subject: [PATCH v8 03/12] nvmem: core: Enforce stride and alignment checks
 for nvmem_device functions
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-rpi-otp-driver-v8-3-797e0577d414@linutronix.de>
References: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v8-0-797e0577d414@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794328449; l=1407;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=sGhuitAXl4CJ9+ca/zc+cLRMyNRzuEDqHymnYStad9o=;
 b=aMCAcNsL2pUU94GEr3AtbJY12UrT1onyq+zukWfkCjUdFnPrwNb+1zuTTI5AmHW9gAM+5SPNR
 E46ydHIMtZ0DJOrAtjBuOnNkJqT8Qus6eX9XnWyuqgadSVv0SyA6sZx
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The stride and word_size attributes in the nvmem_config struct are
currently only used when reading/writing through sysfs functions
bin_attr_nvmem_read/bin_attr_nvmem_write and in the nvmem_cell api.
Reads and writes with nvmem_device_write/nvmem_device_read still allow
unaligned access.

Add a check to these functions to enforce word_size and stride_length
aligned reads and writes.

Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/nvmem/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d976c0d6603ba..f16c7b7cd2b0f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2072,6 +2072,12 @@ int nvmem_device_read(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
+	if (!IS_ALIGNED(offset, nvmem->stride))
+		return -EINVAL;
+
+	if (!IS_ALIGNED(bytes, nvmem->word_size))
+		return -EINVAL;
+
 	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
 
 	if (rc)
@@ -2100,6 +2106,12 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 	if (!nvmem)
 		return -EINVAL;
 
+	if (!IS_ALIGNED(offset, nvmem->stride))
+		return -EINVAL;
+
+	if (!IS_ALIGNED(bytes, nvmem->word_size))
+		return -EINVAL;
+
 	rc = nvmem_reg_write(nvmem, offset, buf, bytes);
 
 	if (rc)

-- 
2.47.3

