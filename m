Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1507238159
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492274; cv=none; b=qp6YLVN3C4E7FZipTD8SOCyfrRg6lOMN9XTzrM8R0sNaOnj6553NSiGEm90OcEpvaFd4N4bQRC91JvhEnKOQdEEdCCRf+VFCh4uGWmPRZwJb2DXuKNmo5MQApr9sg/o5NqjAQgSo/Oappn3Wr9xhRRq4tOJ1I2lyDcF1MzHs2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492274; c=relaxed/simple;
	bh=jQfNAZzZ4dda+HzpCv0yCuQI7I25AxD4tAt/W/mftOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKqnKkterbReTIRJntDepvECHSujVI+1Y/FAt/dFitnNt+0kcJMvEp1Wndrw7pREFXt61ef36u2btBLOtg3EO9SbL1pFQQkTj+soLnXJys9vraMxtq7DVZTRoDJ7YXfEgXSCmeQWVBYv6bXW+zzUH57mPl1D3oAJOtE3u8pjY5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLlVGEJQ; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLlVGEJQ"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271195d2a7so1184459c88.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492272; x=1775097072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBcJSzFuctU+GfEBiYZvWLtMmVeo006YejPME9qEv9c=;
        b=cLlVGEJQaDqEna6V66S6gjHvuerZfPes7FPEfzX+hWVG1SUD2/ixCFxXR2cZHxBcNG
         9kxUM9pw2lDBaSIbXNWJrQZkywe3OkXNBYlzx1puDpks+xTreldg7mBP0iLYFbpzyCsF
         kiXhJqjzBsYVxPEfPA+qf3/VJTaTKgqCB0hR+2fzCxXL8vJIGoW/HMuygFbyJucVlnxy
         Y2OZG+EyMHS+knvJ8DdN0ooAvcBdJ88QaVp656VFAdvV7OZWGKSfziZ5bBu7w9e16BDE
         t5/ZKg//zdBf9koa0w7aoYVch5LMHh7hBRSKO9FrwQBsePkg72+dlqZQbfFbFkbyTQVC
         bUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492272; x=1775097072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBcJSzFuctU+GfEBiYZvWLtMmVeo006YejPME9qEv9c=;
        b=EwgHGsUNqFYvjRCfpjUBjSBLlQlzTnkF5B0cl1FF0845xWWCipnSCFawZk0AD2n7Ex
         A17PSM23ophMuHqctMhX+JDTqUxpAAu1iPAoKLaUZhGM825HReVCFpAnOm+uJbGfPT+l
         IrwxR2e6ckeDzX6AGpBaBKyayH0sMbZmc1Yc/iqB7fSOvF6Ud5XvBkYypHdgke2uoDvk
         qqZDIkRwqDPn50lXDzO761uFDUr4LzaWzFkulsrbRtLYH8FqK0B+FKCiGz7u+1ewRbZ3
         evk/jVm5LjzgoFIyiTdJUZZD7/Qh+uxr6CG7GpAlyh0dRKYpI8lZQY+0xR6MxQnwxW+4
         Ij8g==
X-Forwarded-Encrypted: i=1; AJvYcCWvazNSxZ3foEfxRNShXwnCvtgIhV4qEKkRygKaYFAJ/vCNoy+W68upQdpGG9lpURqQjRqcutGlBBlWY5PnJJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh1qsIER4mFwX8g1ClXwwrFCshl9Ezj4ZCJxnr4zfuoRzsqDd8
	hlhXEoTm4PPNXrHp2wMHCbUc/cXs7Dm7qz3AjFyzB+tEorSLAXoNNthX
X-Gm-Gg: ATEYQzx8Ce+Kyc8U5AiMWh9o5YXkaf1Y8WU2RQfQ5UPyo/GsvWmx9VpvZj3dUNBHd3l
	75K3YxYZ0dOJ7NVijCq4iWW7P34SsH1agr6RmyBZCZXpdxZTzNhKcmli21eppVfbZuDseJKWZrg
	IW+KnZKbCCbkHPYOUeyR+4O8LIPVIpWq9XdE9CkSLwx42utVq4v4bmd5/Yb+7Ludy3hmyZWrvCF
	kl8AiJFSQpVT9/XeeVdTX3bmKChOfgJI+V5y1jm6a1U823pmYHS6X+xa8RhhElg3XWyssbAKKsP
	CR+pSnIOe65lAA0JbvOeSlE1IA363vuXc7ZC+WE9v30gjPGUWZ+KpNDOREho9/A/KP4mkfdhNq0
	B4prUZG6bIsI/rHosVFyogCFGdeY6PnITqCpPhZFMQawpagbmTWRrB0ULKyqpJM1Csht/GQT3II
	UnCMZ08BwHvb87AepIB4P/BTUwqqxi2r0PVVaaA69e1YIGNf153TSeLsc=
X-Received: by 2002:a05:7022:ec86:b0:119:e569:f277 with SMTP id a92af1059eb24-12a96eeafbfmr3092480c88.32.1774492271674;
        Wed, 25 Mar 2026 19:31:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa6e5beb2sm2181796c88.1.2026.03.25.19.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:31:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ASoC: SOF: topology: use kzalloc_flex
Date: Wed, 25 Mar 2026 19:30:53 -0700
Message-ID: <20260326023053.53493-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify allocation by using a flexible array member.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 sound/soc/sof/sof-audio.h |  2 +-
 sound/soc/sof/topology.c  | 14 ++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 80b11625915d..138e5fcc2dd0 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -411,11 +411,11 @@ struct snd_sof_dai_link {
 	struct snd_sof_tuple *tuples;
 	int num_tuples;
 	struct snd_soc_dai_link *link;
-	struct snd_soc_tplg_hw_config *hw_configs;
 	int num_hw_configs;
 	int default_hw_cfg_id;
 	int type;
 	struct list_head list;
+	struct snd_soc_tplg_hw_config hw_configs[] __counted_by(num_hw_configs);
 };
 
 /* ASoC SOF DAPM widget */
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 63d637db7053..413003e86f6c 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1908,18 +1908,12 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 		return -EINVAL;
 	}
 
-	slink = kzalloc_obj(*slink);
+	slink = kzalloc_flex(*slink, hw_configs, le32_to_cpu(cfg->num_hw_configs));
 	if (!slink)
 		return -ENOMEM;
 
 	slink->num_hw_configs = le32_to_cpu(cfg->num_hw_configs);
-	slink->hw_configs = kmemdup_array(cfg->hw_config,
-					  slink->num_hw_configs, sizeof(*slink->hw_configs),
-					  GFP_KERNEL);
-	if (!slink->hw_configs) {
-		kfree(slink);
-		return -ENOMEM;
-	}
+	memcpy(slink->hw_configs, cfg->hw_config, le32_to_cpu(cfg->num_hw_configs) * sizeof(*slink->hw_configs));
 
 	slink->default_hw_cfg_id = le32_to_cpu(cfg->default_hw_config_id);
 	slink->link = link;
@@ -1932,7 +1926,6 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 			       private->array, le32_to_cpu(private->size));
 	if (ret < 0) {
 		dev_err(scomp->dev, "Failed tp parse common DAI link tokens\n");
-		kfree(slink->hw_configs);
 		kfree(slink);
 		return ret;
 	}
@@ -2003,7 +1996,6 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 	/* allocate memory for tuples array */
 	slink->tuples = kzalloc_objs(*slink->tuples, num_tuples);
 	if (!slink->tuples) {
-		kfree(slink->hw_configs);
 		kfree(slink);
 		return -ENOMEM;
 	}
@@ -2061,7 +2053,6 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 
 err:
 	kfree(slink->tuples);
-	kfree(slink->hw_configs);
 	kfree(slink);
 
 	return ret;
@@ -2078,7 +2069,6 @@ static int sof_link_unload(struct snd_soc_component *scomp, struct snd_soc_dobj
 
 	kfree(slink->tuples);
 	list_del(&slink->list);
-	kfree(slink->hw_configs);
 	kfree(slink);
 	dobj->private = NULL;
 
-- 
2.53.0

