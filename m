Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731F201032;
	Fri, 14 Mar 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963133; cv=none; b=sH86jOCfQNgte5tcgmGd8snHkcXUsrLgSnrSPlvywm0Wj0IA4LXFkQWioKCOZpWbm9VDz3KG5zZ7ugc9uajfoMVm4j34XI7LpUHQHhmVvPT/Ec8UjdTY911qn2af2YhMHZdmYrgC3bylT2a7RO/wtbwJswaqdK64b/wwZeoPqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963133; c=relaxed/simple;
	bh=HJCET7mgulLHspf8Gs5iMvlePcTNhhZdDgqmCsIb31g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qzJrGwDrFieEtkm1AR1Rsxt63OPIJoVINPr3V5uJrNVY9OyYt4Th0a5dOE1ovPaPyGu2J76Fz2c2iQiw4KgO0TNj6VOmWUC48lC0Swt/9tkSp9mhxrdiooMeeaTCTLIvqgBMI635M8w3cajZhiWai+G9afc4yKyxdixSCb4d6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=SJWo0IRt; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="SJWo0IRt"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZDn6j4Kn6z9t1F;
	Fri, 14 Mar 2025 15:38:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741963117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbP/x9WUX07vvJ4O8R+Y29AUaRRBKVspNcjX165mDgw=;
	b=SJWo0IRtWizU4CfG2vojgF5L3kf3R5YbjsOfWreH7iUT2cDJtFK03zctqnR7TnPV0bPHH1
	X46MMMeepwjYG9Q+7QSpXv9rwH+XidRVblTNs2fqxYUBDP66qjBucSgnF/uk4serwx7Jlt
	RumIe5M6C9orIX4ZsgXTx7r3iA1BSz5BCbBubMO+NpsMPWDWlQe2OPRju6Y0sQL63nvOmB
	TteuiIyZp1Fc6e3J/l8lUcODCgMnpdtxlbDlivk+MRcuocq82Y8AZzesTKmcmqIOdCyC+c
	ZUjuR35zkqQ4+S3hYcmGsWV54JNL2BTiEIEyNfhxP1aEyEZCyXkHMeDT2IqKQw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 10:38:22 -0400
Subject: [PATCH 2/4] ASoC: Intel: ssm4567: move devm_kzalloc(..., size * n,
 ...) to devm_kcalloc
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sound-avs-kcalloc-v1-2-985f2734c020@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=HJCET7mgulLHspf8Gs5iMvlePcTNhhZdDgqmCsIb31g=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGK3hUNUNQYnBYaUVaZ3o3Kzh0b2R2Tk9qZGFibVV0CmE3dVZ3bDJVdERsME51ZGVD
 OWVPVWhZR01TNEdXVEZGbHY4NXlta1BOV2NvN1B6cjBnUXpoNVVKWkFnREY2Y0EKVEVUckxzTi9
 qdzBtbTR1TTUrV2VLTDlvRWFRVXJmcHJqZmNMYldlaEpoMGVxdzNNL1ZLUEdmNm55T1F0ZVYvMQ
 pNdEpNOWFLN3lhRTE4NnM5YXVZRS9QWGN2VVAweFUzSlNWNDhBSXdqU3FNPQo9R2RBZgotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

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

