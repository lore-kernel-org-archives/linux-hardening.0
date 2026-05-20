Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA93EA958;
	Wed, 20 May 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287284; cv=none; b=Ppb60JLB9KWNv7L+CKvL0H3/j56d/ErqjrGXk8rGY8luib/RzaCsggfMu1Mn/mQRdQ5HAhhlkP+BkNHuKiuzaMIVP/R2VUJh8qCFH98llBDAflDbyVhPl9Of3iNBzPTYUunUZCsj7o2r5fOJbc6EQYL5CS4vgiNsOfuvhrLl5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287284; c=relaxed/simple;
	bh=1lpYj5pFLwL7UBmIPyOk1IxVfJCvdzB+umU9I4v0Q0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFt6onFL885GhDwiqfsEm5/AosGDg+RsG8X9W/Sd/5VdoHJgkssj7owL/z2cu+HxT12VnTShJdo0AeXjVcLXplXWQHfKxh1nNM3LGhPFDGE7ECnHqR1gwOxiAHwM7b2w/GSK15a4Mda4xZ2nOqk8+LYeLJbz/GvF3dz2pjremoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ww8hfLdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6DVFKli; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ww8hfLdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6DVFKli"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779287279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=om+KGVXb1v83gsKZbVoHyS3YW/veq0SaXYYsGEnL8tE=;
	b=Ww8hfLdg1WrnrWSZ0GSDdRKcsGO0FjkmzA68x8417AphntwNQ95/Ic0A7e7BD28qxOUQ7u
	USNfyHSDD18+2C2YhkUefphFm2qV3ctOessGUK3SaBgrt+rFWCEQXs0ZHzf2bBjDQkD9YG
	Tba4lZLBg7J6DpXACIT+3RLGn+CEIsYtHoYdVZDEr8tu4qYZbbbzFlvclluZWVH7P1bPDL
	66wNjrreKbmlxcKcmvKBiUPZQoy7ireSpkmzmzqyw6zwn8Pctabkp9FnpGkmnTs0VjyM7s
	q5mytU5tsXNaphP5Noegyt1ELHiPdVTmK/ldR9zZjf1vVpe9maDZO2RPSIAOWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779287279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=om+KGVXb1v83gsKZbVoHyS3YW/veq0SaXYYsGEnL8tE=;
	b=p6DVFKliYYsgAURxBpaRYT7Hk5ua4GDGSRDqPXhpWcVsyOM9qh4PYu0ulWL2k8CsUp/hrv
	a23MVIQltojjbCAg==
Date: Wed, 20 May 2026 16:27:54 +0200
Subject: [PATCH v5 2/8] nvmem: core: Enforce stride and alignment checks
 for nvmem_device functions
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rpi-otp-driver-v5-2-b26e5908eeac@linutronix.de>
References: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
In-Reply-To: <20260520-rpi-otp-driver-v5-0-b26e5908eeac@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Srinivas Kandagatla <srini@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287277; l=1341;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=1lpYj5pFLwL7UBmIPyOk1IxVfJCvdzB+umU9I4v0Q0I=;
 b=sTbqCOrVZ0mMIXlIVQA+XvK13l3B8jyW2pPgQhTSJCm8e9jmGMtZl7stobEtbbPVN1Qw9PhdU
 fK6ydnW4bwvDm+bUkWqPoZ+Em/CHqTufAuxDmzVvqPGS4pFT1qDpaHv
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The stride and word_size attributes in the nvmem_config struct are
currently only used when reading/writing through sysfs functions
bin_attr_nvmem_read/bin_attr_nvmem_write and in the nvmem_cell api.
Reads and writes with nvmem_device_write/nvmem_device_read still allow
unaligned access.

Add a check to these functions to enforce word_size and stride_length
aligned reads and writes.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/nvmem/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02..6b313f63d07ef 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2068,6 +2068,12 @@ int nvmem_device_read(struct nvmem_device *nvmem,
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
@@ -2096,6 +2102,12 @@ int nvmem_device_write(struct nvmem_device *nvmem,
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

