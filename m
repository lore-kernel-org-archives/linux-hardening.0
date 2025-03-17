Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17C721D3DF;
	Mon, 17 Mar 2025 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214144; cv=none; b=ETIcKxC+Iv2aqI+w+ac/GsnXktX0hclBjly0AmuQP/K7EjfW6E+4g4Wo38NbYVC9a4gRmA+HZyhouI6cxTm5NobDOOoG3SCO36b9ZJlvOqyHLv/ItMkYVt2c+5vqeICml1ZqX9gyLC/Wc7kX8qzYVm7/UvBTktHZ6LG/KiZQ/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214144; c=relaxed/simple;
	bh=eAkDFbzVdNVyTi7DUJge+6/7wcN1f+Qj0Cj6lduJCXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bK8kvRnH2AvE8Qfko1hWZ8nv2wemFOpO3qqfv5bQi39z2H3iotc5cYaQ3pIxBDbo7+Ft4Z1BSPZvAjK7MEumfyKdNeiir3aXkjTgVXDQ+K7e7Bga3uxIhsfh5V3DI9PQNnMqypsZXsiGU7ZFBczEtpH72IH5Ph7rYsO8afa6AYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=TaTVKYhl; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="TaTVKYhl"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZGYxw54HXz9sc4;
	Mon, 17 Mar 2025 13:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742214132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeiO5E1BKLORJkqniB4tdZ1D9m/ct4HqBQPCts46txE=;
	b=TaTVKYhla/4Rx3SePQJrhSLVtsGqm1dr6WrSv6QtCpFWvPtqoZErgqc7SHUkdj53bDWeob
	lQ/GCLoz3F6AE1TVG9rsQoq0tjJWj/i1OuGJtQrQ1yk6qu3kr97PsRmjERtbIs+VIcWjSz
	iq+v6BUgmFBEea2YFuc4/vBc9CdMsglrW3gV36wdxKzThK0sdI5gmmwpHVLQVn/iD3wASg
	Sax1k6nJzkK7nRJNtICA5mcUovPW3l1l2UFrJPCJN1u9vj91ffijwM/VfxHe1lBQzCKXZx
	8rgAH9LZWYQbJ8bFW5wis3RkQ33LO33K+iMLJ8iY50NHJT6oOjTXPCvv2mTYEw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 17 Mar 2025 08:21:56 -0400
Subject: [PATCH v2 1/4] ASoC: Intel: avs: Replace devm_kzalloc() with
 devm_kcalloc()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-sound-avs-kcalloc-v2-1-20e2a132b18f@ethancedwards.com>
References: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
In-Reply-To: <20250317-sound-avs-kcalloc-v2-0-20e2a132b18f@ethancedwards.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: gustavoars@kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=eAkDFbzVdNVyTi7DUJge+6/7wcN1f+Qj0Cj6lduJCXA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOOFFmcG5xZmpQK1h0T01iUFpYOHNzc1dGS1huaXlZCjRwcHVlbUsrNVZHRnlTK1cz
 bExvS0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VRc1pSait
 DbVh2MjhBVWJ5M1R0VldSb1R0d3l0cWRGamZNaTlnTmpyeFpvcmNrczJqbmZJYi9GVzdyaTQyNw
 p2NGNiWkdoYzYrQ3M4KzBQMnZZcllicG9tcnFXMmM1TG4yNXpBZ0FZYjB0NAo9Vks4MgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Open coded arithmetic in allocator arguments is discouraged [1]. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 sound/soc/intel/avs/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index 4bfbcb5a5ae8aff5a981389e61afb3c72b07b15c..dac463390da135d7972808cb55e1c2866dd736c7 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -1380,7 +1380,7 @@ int avs_i2s_platform_register(struct avs_dev *adev, const char *name, unsigned l
 		for_each_set_bit(i, &port_mask, ssp_count)
 			cpu_count += hweight_long(tdms[i]);
 
-	cpus = devm_kzalloc(adev->dev, sizeof(*cpus) * cpu_count, GFP_KERNEL);
+	cpus = devm_kcalloc(adev->dev, cpu_count, sizeof(*cpus), GFP_KERNEL);
 	if (!cpus)
 		return -ENOMEM;
 

-- 
2.48.1

