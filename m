Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61C2239585;
	Mon, 17 Mar 2025 12:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214157; cv=none; b=oMuspCT4Beqi8s0KMIG+KbLDyTRGATIgpoEDE/i9k5RnFyfutxHmh8lAu0cy0b6qQMS9Xod6UxMfBSqN5puGaID2siafhB9dCHWPqKyojZzW8lkEUsKlUV8qrtOCta6ZuMmEdahBBDxdMvfqbo0BOsi2jmLVVJbxxcB7cQX2FnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214157; c=relaxed/simple;
	bh=sgJ8WHaGe/IErPtRWMMls41PTsOV2UPY/AB9uIXYiL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNb3JZF9qJX+oNV38t/wC/T4sC+rcTeFX1Ed3ni+HSJt2RhzFgqty4yjJPIEJVwo6zoF70LkaoNWa2+7aYPkD8IAxQibfuf+HzksHff+h6LdIjT7au/9sFq7MuAHUJRoeiZnzeDZGo6DHljukA+rod9LZ4L3DYqVXiHu72gB98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=t2sm5KsN; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="t2sm5KsN"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZGYyB1XTFz9sbM;
	Mon, 17 Mar 2025 13:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742214146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQfdqmNxlAlYuoJlVTJLGTsLsjUUCGEhcK/xX2ENAk8=;
	b=t2sm5KsNxvZMLxkLgBA04kKNSXYr8axPjasEeWsgWeOZXeB/FeXMb8KJrUdFQbzy1j9P9e
	ItSOJi2QDPnyx31mxkTVJRciQN7+BD7X1giriGAcjpD5a88N4Cksm8UdDecapnbQ45lb+t
	WOCdnUu0/OSNG+yNbmm8YH8p7XGBT0Ma9d2Y1OMdc/fQ9wHPblc2bJzmqE+3O+JTbe7KeN
	shz8ApOG4vbCeqsY3CS92NYSZt9Bp62n2Q2E4KrPYYS0bTHB1qoNa5H6tz/q9tyS7/m1vS
	cLgZYZYqKQZ+P2JdhiMfJzJ4TiYtFCC6iDEgiypJglzceg+98q/FkG8losFszA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 17 Mar 2025 08:21:59 -0400
Subject: [PATCH v2 4/4] ASoC: Intel: avs: max98927: Replace devm_kzalloc()
 with devm_kcalloc()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-sound-avs-kcalloc-v2-4-20e2a132b18f@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=sgJ8WHaGe/IErPtRWMMls41PTsOV2UPY/AB9uIXYiL8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOOFFmcG03bEgvWGlUOXVic2QyeGpPYlJsM1Y5U25XCk9lVDJYRWpHU2NBaVpxcmx5
 eHNkcFN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKbUVqaVVvWi9
 Oc3JIdWs3eGZ1Y3VYbWJmb2ZFbytkK0VGZjlPL1YzQ0llN2V2cGZCOEwrSUZTUERMNm1nTjJ6cQ
 pMNjdySFhmYnI3UXFMbzYzWFByTjNuTDdHWmZ2M0hvbTQzeVZDd0RydDB4cQo9UlIzWAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZGYyB1XTFz9sbM

Open coded arithmetic in allocator arguments is discouraged [1]. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 sound/soc/intel/avs/boards/max98927.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/max98927.c b/sound/soc/intel/avs/boards/max98927.c
index e8e5d1c717cd398aeca506bf7d20b5819d8dd1a2..e4ce553bf1d6432b4c11ce44857d969ca6b54c83 100644
--- a/sound/soc/intel/avs/boards/max98927.c
+++ b/sound/soc/intel/avs/boards/max98927.c
@@ -108,7 +108,7 @@ static int avs_create_dai_link(struct device *dev, const char *platform_name, in
 	dl->name = devm_kasprintf(dev, GFP_KERNEL,
 				  AVS_STRING_FMT("SSP", "-Codec", ssp_port, tdm_slot));
 	dl->cpus = devm_kzalloc(dev, sizeof(*dl->cpus), GFP_KERNEL);
-	dl->codecs = devm_kzalloc(dev, sizeof(*dl->codecs) * 2, GFP_KERNEL);
+	dl->codecs = devm_kcalloc(dev, 2, sizeof(*dl->codecs), GFP_KERNEL);
 	if (!dl->name || !dl->cpus || !dl->codecs)
 		return -ENOMEM;
 

-- 
2.48.1

