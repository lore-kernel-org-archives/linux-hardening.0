Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07923958B;
	Mon, 17 Mar 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214147; cv=none; b=XTCOs3bjJwBxcGrXYlyI403lSG7x4iibkrmuDr0up0qPJFwyPZImeksCeKUmAsXlfifCfrD7s7II+n0ZdOu9Xhmn/DvV0PWMCq6DQyP1xoLKi2zFX8Mj4sYjWNIMFPlMcUq1uScG3lhhd6a0+vKAImnrl3RWn1trSo6LQ1k60hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214147; c=relaxed/simple;
	bh=39zMcV0evS9psPxjOhf44n5dx6EBrLz4LgfZq0SSclw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kv+qRMpdak4PppL9klgWOGyqQ0ZFXnckRa5qDcB2un2qx5440GofI2Psmn3zpoX9FdxtVwNohZVRalah+o7/Mt7abLLbqJiwxmXgP0HYBenruLZSjRFY7wNfVOE8DZdocDVX/I5N05IETwQ2tHx4Js0zqSYEXXcaDKF1emTNr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=O0tcUvdJ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="O0tcUvdJ"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZGYy55L5lz9scY;
	Mon, 17 Mar 2025 13:22:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742214141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XlaXGgZRU2vFQqsZoLTJLTHYYtNNxvsF9OJuPE45t8=;
	b=O0tcUvdJiZuw7FRGL+cgYerQm53JKV9VbPquOGVPhyHcUZnUfTKb7pUa3e3UTW8nefoixd
	Z/DmqmiJ7OEtg9gtVnj2OQ8Qaj79ZH+MT9PTPyXv4aQONtAeqfN3jfqJrhXjzzAdhJQmL0
	NA2/M/06HwEMzCAy6g3JHKZ5+fdQQTT2yPDZZ4oJOLHJuev53cWmEP2ysWN0xwGjUY+/a1
	tCtiuhfIbs7aaTHPYuFl4gBk0OOcJlX+iH5Z2OsHjgAJZx/HtDGyM2TcfRKBqVyJTgs4TQ
	jqHVowksIn4ZrOpJwQ+CvQpBqvR7NF3+YXeg1GApuZZSGL+p7gSSFR+MaVZ0Ew==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 17 Mar 2025 08:21:58 -0400
Subject: [PATCH v2 3/4] ASoC: Intel: avs: max98373: Replace devm_kzalloc()
 with devm_kcalloc()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-sound-avs-kcalloc-v2-3-20e2a132b18f@ethancedwards.com>
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
 bh=39zMcV0evS9psPxjOhf44n5dx6EBrLz4LgfZq0SSclw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOOFFmcWxsRWYrcld2Nmx4allKYWZsM0w5eFRZdG1lCk1TZ21IN3gwOXhzWFoxaVJD
 RnRIS1F1REdCZURySmdpeS84YzViU0htak1VZHY1MWFZS1p3OG9FTW9TQmkxTUEKSnBKNW0rRi9
 3R2VuME9Bb0hXdWVob2JkVWlXUzJzOS92NUJiOU1WNCt1Zk5mT3c3cnU3Y3dzaHdnUDNmRGQvcA
 pIWk1TVFNmTVg5N05hbm9nOTd4N3lESm1yeWp6TUE1eEpuRVdBRVQyU0FRPQo9dWVvSAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Open coded arithmetic in allocator arguments is discouraged [1]. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 sound/soc/intel/avs/boards/max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/max98373.c b/sound/soc/intel/avs/boards/max98373.c
index 6f25e66344b7a4b46d6598619b6b1362cad8c39e..970f82bf4ce8920b1965a0b81e8623ab5bf91ef1 100644
--- a/sound/soc/intel/avs/boards/max98373.c
+++ b/sound/soc/intel/avs/boards/max98373.c
@@ -111,7 +111,7 @@ static int avs_create_dai_link(struct device *dev, const char *platform_name, in
 	dl->name = devm_kasprintf(dev, GFP_KERNEL,
 				  AVS_STRING_FMT("SSP", "-Codec", ssp_port, tdm_slot));
 	dl->cpus = devm_kzalloc(dev, sizeof(*dl->cpus), GFP_KERNEL);
-	dl->codecs = devm_kzalloc(dev, sizeof(*dl->codecs) * 2, GFP_KERNEL);
+	dl->codecs = devm_kcalloc(dev, 2, sizeof(*dl->codecs), GFP_KERNEL);
 	if (!dl->name || !dl->cpus || !dl->codecs)
 		return -ENOMEM;
 

-- 
2.48.1

