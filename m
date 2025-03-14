Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EA3202988;
	Fri, 14 Mar 2025 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963133; cv=none; b=dKmPOAUuMZkdjjQSLcYnWgempyKqWymnyVwZga7H82WziovPr7jFz89vi6aarrM1bACu15o3z7oiTCs+Zb5ktmF3adXo2/aNkijNdRzIRr6KpEgMytmU5pfvVK4cc13SxxuAbSPA+kgy+AEcZ17l4+UhYHzjGh44U7PT0s9v++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963133; c=relaxed/simple;
	bh=omVwGwH+tvai1xWEI2/VPAx6grba7+WPfxfB6hPpCok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gH3/pYe7k4hT9kdKrNm00vKKlyQaLT1lNAhwLoxCJh4ImCzORxiqTC8wZcyJCqKGVRg8eSWgg1W0pzFA9Xtm4HwTihjn2JFu3zYNvqM1TqLwzg3mrOUIs2jImoLEhpzFIajMImyUjrTBHfkaFMG1klcVX9/BrUHJA7zEKTHaBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=kT3EnxgA; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="kT3EnxgA"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZDn6n4VbXz9scL;
	Fri, 14 Mar 2025 15:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741963121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yl6oKjE2VPFEN1ImI40/0DFO/bK2RZZ4SFwIfhRzkX8=;
	b=kT3EnxgAy4hGUd0isbaVaSLESqzhlDddxebZVLD3LohYQFxAKISB9nG/6sAyN4zX6EQ9NZ
	tth7TJSjLyUifn1mXad59IzLDdcxonQue1b5TsMYqgU/nvX1p6yeitsd4KCazP1awugRPT
	i4ibzHgLO0hMl0LDKW5C6iM6x/SlzyRikqfL7xdVNiXG+2MPRrwQ1rd+ojUSB3Hf/FpL18
	xjEqoMBe3yaEqCK3LwhlMKPbWGJCgKvETfJAVAImdAkMOxorDVbnrC84+xka5da/Gzs+Eg
	SHsxlfCq4KSTfAtyQabMwHC8u3OtCBUsE/qKDZz5lipULYRF9OwQHF7qJ9ADVQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 10:38:23 -0400
Subject: [PATCH 3/4] ASoC: Intel: max98373: move devm_kzalloc(..., size *
 n, ...) to devm_kcalloc
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sound-avs-kcalloc-v1-3-985f2734c020@ethancedwards.com>
References: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
In-Reply-To: <20250314-sound-avs-kcalloc-v1-0-985f2734c020@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=omVwGwH+tvai1xWEI2/VPAx6grba7+WPfxfB6hPpCok=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGK3hUNWpFWW1UMGlIMy8zQTl6ODhKQ1huS3pYK3QrCkh2cythZHVDd3duaXBlb3k2
 MDA3U2xrWXhMZ1laTVVVV2Y3bktLYzkxSnloc1BPdlN4UE1IRllta0NFTVhKd0MKTUJFbFBvYi9
 1ZXpwR3h5RmY4MjF0TnJ2M25yckd1TzlIZkUxU1o0MzVwYW1QZiswYkFhbkN5TkRqLzYyM0sxeQ
 p2N2I4eUZzUzdzelllWHhoZDR6djB0M1h1aVkzemRkN1VxUERBUURldDB4dgo9S2hCSwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

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

