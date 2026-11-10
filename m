Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327860;
	b=UgptxMnjS3nyV3jsHrwLTQnQ7DQjZ/redJEDj4Vwcx4sLcINNW+EyuulSgkiU9Il2rAJ
	 SQid501NL9so6qpgJpuVJTzDF0A/NiwmnogtBeCPziiovLqa32K3TjWgbk0V2HWI3Vfoz
	 x2/nt5fSdkU6FTA4Qo2/fnVxDYS/yzpv+bJPWaDSLLPVoTNVbh/yRdvLFcEAKeAxrDHxn
	 1ShKDd0uC4tJJEHxkjzmqt9OQ2onKx4b2Uo7uAPsi5/uEwkcW6uNDFEn89vWAyb88N//q
	 P6dFyFJxB5N/vykNa0GS3A8BICmoHEd+3okXAyzbAjS+UOfs5m+dpS6GXUz7nC7pTpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327860;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=d2oDzKcUbG8d5nm7TXIf/I44F6wZkxpoytZsidHrK9zjxB7dyaD+Re/7tPG8RJdH0UuC
	 GjegrDepW3yhzAg8RXW/Akr5oRmq8A4guJUdla35hJ5ey8iw4a8Cte3UKRQN6zz4eJ+wR
	 sUisvzPJmko9tP5CiOJrTYDv5hQSAafUMM94dB+41NV2AqL5vAw+tcdB5qZextZ5Fb3nw
	 TGxbu22TWdL5KkD8Cxjt8KfYMgFr3THktbomgwlhTW8TO2u+zK4Wv0AcrX1paIXFtUG5L
	 O2Yy5rJGL0GO3EbTbykieoTNACRIruxTslmbutlEcvQZG8JnL5etWHIPw7HnEBBd5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BaOueLaw;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hkc9BqP4;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78AA606A33B;
	Tue, 10 Nov 2026 16:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A78AA606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BaOueLaw;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hkc9BqP4
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794327858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=BaOueLawTDZ4wPhTmU6MiX5pvFgj7VjMXSgsKhsD9OXIKCCMPGGzIPz3F4sPDbafDcpEEc
	W1+JXoGzUHeLKG+SFWQQElZ6BziI9M9ovci+bVuI3jumTEjDdbtfETcnLeUArBZ8CreMkP
	NI7iC4q3xAEmS8HtNbZ5XnjLQV7u0Lou09nfyc3tLXPOzZyrazQwn2mW3LLlDYvws4xzli
	m+d+Z8ExP/TtGm7keHEy3gQTwTikrzLBe97F77ot2N8u4QeOk5EoxEpP9/U78TdqjbrCbu
	FHjZAubBMo86v0G/H1GxQyynCw3iBfLhf3hzP5Pu1miuNPcnH98eygDjOIbjVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794327858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=hkc9BqP4kTTXGI1cHcyeZEJurxu1NMFiHOedeIT8o/Wg2ZSJBOP1rCZsLUr1+d9tpPfHjd
	kfJ6mI7sObX/+/Bw==
Date: Tue, 10 Nov 2026 17:24:03 +0100
Subject: [PATCH v7 02/11] nvmem: core: Enforce stride and alignment checks
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
Message-Id: <20261110-rpi-otp-driver-v7-2-2345d0ee65f0@linutronix.de>
References: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
In-Reply-To: <20261110-rpi-otp-driver-v7-0-2345d0ee65f0@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794327856; l=1407;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=sGhuitAXl4CJ9+ca/zc+cLRMyNRzuEDqHymnYStad9o=;
 b=rZHeW8vmAkVN5GRNnLQAj5wqKfTdMFEOy6dFKvS+mV5enpB5uB2G+90g5+KxBc3MJPPxgLlVX
 T1GYltmnugdAcXMmKoKKJ2TORF4mDk2GmY6JycIjed328tNQ1Hv0jI6
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

