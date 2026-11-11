Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381821;
	b=lmKtNlAqHIEOeyCy+N/KU7mOhmyInSIkQOARGjbUp7N2oBAJBDrINt4j2oYk837dhcch
	 qAd+gX7cuoiLfBfxtEnhUfO6ye+0vfAvaKISVa9Wx2/N7Prwmb6gV05AVv1F1N+cGfjnp
	 fspn1N7O4WEqkQSDvNkbmy2RsHFgsDvRC0uaG0AMB3CWSDrBVGiztoSpHSsut6IqR3xlm
	 U+sIbXckMKyPFMurvWYlDRP+CfhNs635MksJiLYaizVd7LXhxJzbuCQpyaLtkaj14NaRY
	 KJ/zA52C8xWJBkz7r9uJMOVtkhL4/bHBKv/z4D1f5MirRfUXubFydmueYaKOwCNpMgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381821;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=VJ6bit427o6IZdJhXI0cvxzq/ujUctePfda5/qInmRiqn+1IJoZWRbY/E1rQ1GJvVaam
	 pdcsUVJQkjt2bFChTWeoJ/8QRQmRhnyKRhX1OI4cYorzXkAYVucfYPW1p6p0ss+8Q6GTp
	 kX7phrqzMQJ3awQCtxHXNombSyuBURq7pjpl0b06trASXUKCfMYAGTxVqMKss1ZX5oeAQ
	 go+KX+BvmVIpyIWtHDHtBryautLlAmCcdn4/zQE9AwYRzNoBm1K5fY7TRTMNZ73R99V0x
	 G77isTt/1gYpbWTCRUNdIye249ziMx3zZ5bsebrHPWgf2v56jhRWSHTAvKTRBcKx86g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LVoerOQP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RJh2vvPq;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0B606A331;
	Wed, 11 Nov 2026 07:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DE0B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=LVoerOQP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RJh2vvPq
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=LVoerOQP36JUDHhcMVmneUmwX7148NimPssaiXom7CxBW5rG8bK4eEGFXMUDBJb7d3I6sH
	TA1CuU6A708yU858rc17pURIYChU7GBpFbtQnBCtkbKJmblll5bWKbQqMMJB5ck7xZgRzn
	ySwUyeIBwU2X7uX/Cc940+D0O2NdFVtjD5qGvivJrpr5BCBAKHblC2g1B9HQvA9RrQlF/U
	ijeNLeZoUH9zPjoYOosCWzICUDGQQqhOpcb6iLSE69n7tCR09XpCrMLV3F1Tl7eij1AhA9
	diX9l+WlNO86SBfHHRFwSSA8/V/wcIWZrMMEkXqRu+XUhPSODi/HzscNJI5bmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794381813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=RJh2vvPq2+b30BXvyONySfq+J18H+aVkhRguYvIWOB12NPv3pHsN53BqSYApR8Yh1j9vxx
	kx0g9Ts6QzYyRmCg==
Date: Wed, 11 Nov 2026 08:23:25 +0100
Subject: [PATCH v9 03/12] nvmem: core: Enforce stride and alignment checks
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
Message-Id: <20261111-rpi-otp-driver-v9-3-0a7292a7a5b4@linutronix.de>
References: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
In-Reply-To: <20261111-rpi-otp-driver-v9-0-0a7292a7a5b4@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794381812; l=1407;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=sGhuitAXl4CJ9+ca/zc+cLRMyNRzuEDqHymnYStad9o=;
 b=o4dpJ+v3zmyKdUV/3Wi8d/b8tq+2KR8Ww7oc3P2TTNSgO6tcZVhUGOdy8byGu9udA3RNl0BrY
 j9P2Juf7BnbARTOIPprdICrVDCJR6RTTevX3DFfWqjJaXjvplzee+u2
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

