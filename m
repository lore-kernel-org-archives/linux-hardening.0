Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823854;
	b=v13Mnsm5fl7Ai9L183M9R06751Bg+zBR8aU2DqTUvBBeoPBOO1sHKpfh+xwq9azyliHP
	 HlJAN1quNYH0lpoq5kWzIjaAgUrA7rcfY/HivtfSRxny4QqmV37yK7E/wkRpWDPZ1IZIW
	 q6MlJl8+UQAdMUV4fKKVz7cXpAUW0HzdCOxrjmkFQsYqzWo8P1xZRjqQrixQN5IVlHOuh
	 fbbwYzPG8pEe0DfxMv0849UUhPQhNvlGm9fHEv7+uaVYxHxy7hBdJan349yj77pOV9mGu
	 5yGZHNXs/P1f6IVGGOCsFDsnkJHuYoguVM5QZ19+mbuYMs3JDF7hq1sx9RuQFAeR1/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823854;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=siH0lvu5A0RHHpkq33VuQ1iDuAMApZeuPfM/RqFa21gRPm4HTqb22egH07sz4JMtKDFr
	 NjeGHdkwlUBeMg/QJG2KOLZQ50gVa/0Lf8oo5ojped1qUMpZPKqI/e68QPmv5h3KJ6Z3d
	 XodwqUXjHvsR4+nCBqJhLNV3fL1XkPyYoxLXHrWX+0YjyKpKTKYLWUlLK2gs4d4WceMdD
	 WwWaVZzVMK4u678mcC449QfT96eaBP+Xx7UTo//khEOrQ29cpv+ItEkuCDOQb43ytwRL2
	 +s9qG1GZsV/oTWd8nnBLCZv0+EFb+i5iY+krMorzLKIYqLKRi4a+JecygDSCm59X2Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BCe4guTV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ICBd+Vxd;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC7606A887;
	Mon, 16 Nov 2026 10:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CC7606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=BCe4guTV;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ICBd+Vxd
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794823852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=BCe4guTVSt3O6qevUnIQA4ygvroAY0UOEiHEX4+XQRc6Dys2eoZpRAwxvbOO+YXHbGtT9R
	fncPG0A9eMGIufV5mrw8fzLDlW1ZyovNcdgpjONAqiH4dQsAVO3wCTJcIdFYWPVWtWSm3b
	cK6j78USiFDvOi8y0ZbWWInXXpL354ZY4WPREF5y4zCDeDtbVuPHmYwwDZWrzDFRc5r8Sm
	DR2t8srPYSnuhEVK3iY9fAe3zOwEM3DRU825M01BbFrL77lzFFIy7olLh7KfxFle9SmGst
	Fj8MRLUA9WM7PLO6Xntl9Dg2tbbPaE+PZJ+7fjDLHQA0Wfv7bS2zXJtBVbg0Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794823852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr/x5IlnZq4eIBfp/lJaUR2Ue53H914EWTxEd+hd3Uw=;
	b=ICBd+VxdGaXjMEUAotxM73h93Q86Sw1zU8ao7E2nsm7DlCAJld7y7wCvJEAB6Fz5SI5/1L
	wQ3xlQAZkLkiWYDg==
Date: Mon, 16 Nov 2026 11:10:27 +0100
Subject: [PATCH v10 03/12] nvmem: core: Enforce stride and alignment checks
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
Message-Id: <20261116-rpi-otp-driver-v10-3-15302dcfd5e1@linutronix.de>
References: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
In-Reply-To: <20261116-rpi-otp-driver-v10-0-15302dcfd5e1@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823848; l=1407;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=sGhuitAXl4CJ9+ca/zc+cLRMyNRzuEDqHymnYStad9o=;
 b=LM7RYQYPTLhVq5GNOWLtM91F4ZWSVqsbkV/IQXHxWEa2Sgz8YLpbLjrtyoOvk5IZGcuh+F5GC
 Sb2Mqbzn7+vATuVuUjkXoZWnWHL1qEvXOAqCZalPVbttcep/tVdOeQ5
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

