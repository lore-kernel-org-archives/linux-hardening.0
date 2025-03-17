Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F623A58B;
	Mon, 17 Mar 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214148; cv=none; b=n59gmYk/GEoPstYyRu17BHCqM8yBUjyToUB90W8n+Z5wdqFO6PzTPBjxpiohiaZoJ6uB5/dVdNQ8ww/QGO/99UmYnkWSUw3Fc1K7Vi4rc5FYk7+RXkdUMw7R+3M7AiIheq54MdsQoUNZCEt778Q4b9G6/pMXXIqvra09EePiE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214148; c=relaxed/simple;
	bh=nBzwUNeRJWp5YNRZV+skPkvDjE0mdhAHAX98cQJUHC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7YYfLkwtnXJY2WjJXXCGnwkQ/JAHkXnKpPqbnfi2I3QthyIBnX/SuX7L+C4vWXE8gICERAB6SO+hlXRIBbAGvB79cLFWg5z6lcrd4djObRLoGf58e3NF0X5dhN3jGro3rZ9AIaZlPSFQNgLeyed0C9bLQwhdB2di0OIgSFgdMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=U0Udz3EP; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="U0Udz3EP"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZGYy12J1Cz9tRr;
	Mon, 17 Mar 2025 13:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742214137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lu0bS+hk05nB2rHAH5OpFQAb7M6qRJkcoGJ72x9VhMc=;
	b=U0Udz3EPlwi1MqWCDbkXh+0mt5AsZnyTggtV2C6tIxstHpLM6OlfLIECD9erINSTE09CCm
	Mvw5FajBinEApZ1bunwUkzmMngwJvSwKl1TPR7d1bX3sEvD7xXRrKs6gKKp7mSiDG6mDDX
	SpoRDWaP34mE4WT0oesKEasnEFNvdIrpcdD1TGI5GLXX7J+8XgpojYA5hr45tqTTGYxWGy
	C8LDnoPXJ0xNx/OPzHeNtIkiEgAHmS0H39qiJj7OHWU6EFypSK+PiTfuUTCFmOi4eXcylj
	1OfK04pgK/xtk9sKUkp0SUOuVtyKJWxXdoTnVgh6pgMJqhOJAH1Z2pioyeBM8g==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 17 Mar 2025 08:21:57 -0400
Subject: [PATCH v2 2/4] ASoC: Intel: avs: ssm4567: Replace devm_kzalloc()
 with devm_kcalloc()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-sound-avs-kcalloc-v2-2-20e2a132b18f@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=nBzwUNeRJWp5YNRZV+skPkvDjE0mdhAHAX98cQJUHC0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOOFFmdWx6WkZIWnJFNmZMNm9xeTkyTFgzRkdsUDlJCjN0Ty9XLzJqL2YxbnYyTDNI
 MHZ1S0dWaEVPTmlrQlZUWlBtZm81ejJVSE9Hd3M2L0xrMHdjMWlaUUlZd2NIRUsKd0VTcWVoa1p
 lbklqeGQvSi81TzlJSkFUMXJUTjUrVHFHczY2dzQzem1UYTNSai9obGJrU3dmRGZiL0c5Q05lbg
 pPc2RQU0t6L3U2aG5tOFdMZWV2bW1NL1hkbGtaZlZRMys4aEpOZ0NLd2xBNgo9V2t3ZAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Open coded arithmetic in allocator arguments is discouraged [1]. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 sound/soc/intel/avs/boards/ssm4567.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/ssm4567.c b/sound/soc/intel/avs/boards/ssm4567.c
index c9d89bfe7178cd6acba0797c56e56462d7c41d8d..7667790d52739b98b97d2bc9fc9496da82affef1 100644
--- a/sound/soc/intel/avs/boards/ssm4567.c
+++ b/sound/soc/intel/avs/boards/ssm4567.c
@@ -97,7 +97,7 @@ static int avs_create_dai_link(struct device *dev, const char *platform_name, in
 	dl->name = devm_kasprintf(dev, GFP_KERNEL,
 				  AVS_STRING_FMT("SSP", "-Codec", ssp_port, tdm_slot));
 	dl->cpus = devm_kzalloc(dev, sizeof(*dl->cpus), GFP_KERNEL);
-	dl->codecs = devm_kzalloc(dev, sizeof(*dl->codecs) * 2, GFP_KERNEL);
+	dl->codecs = devm_kcalloc(dev, 2, sizeof(*dl->codecs), GFP_KERNEL);
 	if (!dl->name || !dl->cpus || !dl->codecs)
 		return -ENOMEM;
 

-- 
2.48.1

