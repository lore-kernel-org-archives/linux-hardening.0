Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B34201039;
	Fri, 14 Mar 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963121; cv=none; b=V+iHlW58sWSRcQ9Sv1me5JQ8tfHvsGNzQvzxfbtJTB/g69kx/0/zjjZ728k+vMaR6qW5+6E9Bl0qMbCO0vAXbVvxf6IPlcVB1v989fN2x6TSCbMbBSFVh609APi454Tk6w+XPqdqMmL5jlqBjA8/duzxO6OV0hqDf5qchgtzsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963121; c=relaxed/simple;
	bh=4WckUOYyQY/RdQok8aGOoPfgvFFYolrTAwyfbyQDbIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KSDlXIOKYtms6RMmasuR5vbsBqsPFi/6EV8VxIdKRECLifLs2s7OelnK+o+V0d276N1FO8JoFT55rL3MTy2frcpndEFnWL1aDDxWM+7D6oSy7Fl9JoD0tpCK+gRnAz6dg0zOmj4C2EElDrUWsWjyL+1fO6lLRhD+9HnofHEQPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=KPGmkaiC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="KPGmkaiC"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZDn6d4FTxz9sjc;
	Fri, 14 Mar 2025 15:38:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741963113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vrlHEmXLbXdlgx3WU/q+bI3S8gXBs468bcs9JBOUOTw=;
	b=KPGmkaiCOtq5AcadpoDge8cGrWXC0a1VvcNoYE8BAF9/kYeggqpeSm5MpzoWh4P62TylFz
	yfcJ9Lcwfe4iYqFe/R620oBHTxD0RasdpAluAJScahaUPZNI3bpfVFlmYLiIeqQcQAsHIb
	/JvW71uyJVpOtIau4eatLqgQBZrqKgEs92vbwZo5cY91qHu55k83CYWM4JEkd7J5Ckj6hC
	4kS5/EIXx4hsyeAVWeh2TwgMotujkHmWeW6UfCF03lbx1a0S5zKTB8KWsZq6mD7bxCWABs
	C25WTXw+EWsT6Dt5FLX7zJdTDBL/sBXPoFbPXXazmARCMQGpNC4ZJHNZK3Mjfw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 10:38:21 -0400
Subject: [PATCH 1/4] ASoC: Intel: avs: move devm_kzalloc(..., size * n,
 ...) to devm_kcalloc
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sound-avs-kcalloc-v1-1-985f2734c020@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=4WckUOYyQY/RdQok8aGOoPfgvFFYolrTAwyfbyQDbIA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGK3hUd2dKdmVXMnoyYlBqVGxIVDhadDg3VDJxNGdYCkwzYThlbmlqZ2Q5RnppdGEw
 bzBkSlN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKbU1pYlhJWi9
 lbnhicHUyMlhIKzJUYmhGd0h5U3NndmpoMDFIZit0WisvNlYyeDRVdVB5dk5jTTNqVFVUcnI5bg
 pORlphdktGMHZmM3ZlMWRzeW45TVllenBFZnlaNW1URStKQVBBTzRPVEVrPQo9Umd5KwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

Open coded arithmetic in allocator arguments is discouraged. Helper
functions like kcalloc or, in this case, devm_kcalloc are preferred.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments

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

