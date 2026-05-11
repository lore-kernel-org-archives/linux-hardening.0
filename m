Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E30352C2B
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541213; cv=none; b=ea9gcOcAGJmhH3Nd157PRlW/JWcglIwowTH/MgQtEWl11ULDGiiahvMsU5b/w5ocECnYwgOvGHEOr/QyjPwTRNbcK3FWpKv8MVzT+xEqhPYE+O1nBwqbl9yXCijwRWuW1buztdTfGRAXEIJzf2PxdOR3C5quIpbsTNnR9qfVM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541213; c=relaxed/simple;
	bh=lyut248ohL8lMiQjhMEr4em5gqDx1XiavnPgwudBiiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6vyFG2NcKG3bJWqm8H8zDkUTwzosW2GurhEgZtunssGepo4C4NXhVJizm/M/zodno+TzDsgvP0WmGFvRqqau0u9mgUvo7nI5naqAh6VgrJi8/xQAfrj6GPyYMf7Ds1wtWWiIf0oYoN6fWs7XVq2EcdONgtOkMQJ/mKlmZMWRfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRrwrcnK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRrwrcnK"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36643b96b99so3069519a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778541211; x=1779146011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFgRqIfPnwsr89P7tCB0q0/8N2KZaaQUIqXtzxlp1YE=;
        b=WRrwrcnKO3PCPK/MKwI7Ku0rHvDItL7Mdtv0aHQi1Zn2UFIc/aUX3zGsr6G6qePixX
         3hPio+d5cVPjYhh5UskHCbUdMEXUeg5x1qT6msMzeFOl7HIJEHCVjmD1FBeJFBrMJw/X
         6+JMtHf7ltkUMt4NQhQ0fyEF2UG/OvnH2uQ9NmG9qTwMHpjPkRx5DlJSHEwuAQqJ5axF
         5nzusuddMw1E4OwgXZzQtyWjLxbGUm3+MtfhJ77jAeiULkucvnDscZYFvAq7Mz56rLMF
         eO5EyEdwRfckgsFyupL+LzEzNYYVnty1ViAe0yEX50GVymAtoNMOg6uIEV3GnXl1ys87
         DlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778541211; x=1779146011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFgRqIfPnwsr89P7tCB0q0/8N2KZaaQUIqXtzxlp1YE=;
        b=sGAQbzGgkC4oEkXyxaGdDTReD8piNpniIxgXA0ijpmH7OAlM5GNwz1SLd5LO3zEX/U
         TsfSaQ72xHz7YNtfuEQQv1GxIPkOxRPkfc19PO0FpeyI2kYqxXcdYNv1Ea5Cx5/oKCvR
         vICGq3cAB4pUP1kAYHUtDWjHyG5GsURIww88rzDpp7qhIFmwHKEoJApp/MUDnZdsFXIH
         tXzPSjtiqGd8RpSX8VfkkGONTjlU9jyX/ksOJMuJV5mwd2K5m0e4OMSNHSjPZpBhvsFd
         HFGZ/JRAKNjbXTt0rUXowzEbuth4k0BBx+pL3l8s/aYcdd+w/Gkh8MEztzB8xAhF+Q2W
         ytQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2rY6YSC0vuEb5aczNqDg86VStVaunV7S1AgLIu6TciEbyO7DkhhHyO7EnSx/qyKMLDjzB503ABh6INOUx+UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtpcTi6eJl3Hsk/5LE4bt/LmBB1CxPqqHPFPUPIja2lNzaZLd
	gW4qHw7nT/mKkDWK5E2LhlN39/fkchtoZyK7LZsTi5/mMe8L/eCfoENO
X-Gm-Gg: Acq92OGWVSF2azdf5F0DWkQyz01ATTT2CicDqqwOC8nJPlLk5sVJ6DaKIRk/Aw+Ih2i
	3HJuzsSDDbdgAN1DxsU8bmGvwsX4NxbN1W+ZL/dp//UE4Hv7ro96lcw4ejOut8vQIGz6SnFdXEh
	fDAq/V7QIyEhmdEUzxCbvG1lnhmtlec717LwA7XylpwCZLV1A3otvZuVKGNLTcZ+L3iIJWYpSDH
	zxyN3eo2jD+HzhDJYxi0cAJXeKXghaRfRJuepmZdL45HOBmmdY4bD3zD1FUa54A95cfBveld0hH
	945pTgJmEG3bT3ghhdVB7JdA58A7TTWpl69DMWacXEh/4vBUXvnBeJGTgR6FN04s++3fFZIpniE
	WdvfhuwGsOW6PdSJ+v9LTvxWTFWhvyU60LXI9L++HY7MME4gROjE7bGQhAybEEOzn/4vhoZP/JE
	Mho3RnX6S7flb0AsSSoTJ++uL7GvqmGc4cwKNq2nP88s/UFU7QH7PgjsAOPk48wcQDDgESMSFRM
	JnWNYSqHdpYxai+KY3W9NRvh/nbfXZbSVLKGuH2BW2LBw==
X-Received: by 2002:a17:90b:578d:b0:35f:b5df:450 with SMTP id 98e67ed59e1d1-365ac2807f0mr26507247a91.19.1778541211167;
        Mon, 11 May 2026 16:13:31 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623f7bcsm8839486a91.4.2026.05.11.16.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 16:13:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ASoC: pcm6240: Use flexible array for config blocks
Date: Mon, 11 May 2026 16:13:13 -0700
Message-ID: <20260511231313.31929-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the per-config block pointer table in the config allocation
instead of allocating it separately.

This ties the table to the config object lifetime and removes the
extra allocation and free path.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 sound/soc/codecs/pcm6240.c | 36 +++++++++++++++---------------------
 sound/soc/codecs/pcm6240.h |  2 +-
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 78b21fbfad50..667596fc1781 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -1230,15 +1230,11 @@ static struct pcmdevice_config_info *pcmdevice_add_config(void *ctxt,
 	int *status)
 {
 	struct pcmdevice_priv *pcm_dev = (struct pcmdevice_priv *)ctxt;
-	struct pcmdevice_config_info *cfg_info;
+	struct pcmdevice_config_info *cfg_info = NULL;
 	struct pcmdevice_block_data **bk_da;
+	char cfg_name[64] = {};
 	unsigned int config_offset = 0, i;
-
-	cfg_info = kzalloc_obj(struct pcmdevice_config_info);
-	if (!cfg_info) {
-		*status = -ENOMEM;
-		goto out;
-	}
+	unsigned int nblocks;
 
 	if (pcm_dev->regbin.fw_hdr.binary_version_num >= 0x105) {
 		if (config_offset + 64 > (int)config_size) {
@@ -1247,7 +1243,7 @@ static struct pcmdevice_config_info *pcmdevice_add_config(void *ctxt,
 				"%s: cfg_name out of boundary\n", __func__);
 			goto out;
 		}
-		memcpy(cfg_info->cfg_name, &config_data[config_offset], 64);
+		memcpy(cfg_name, &config_data[config_offset], 64);
 		config_offset += 64;
 	}
 
@@ -1257,16 +1253,17 @@ static struct pcmdevice_config_info *pcmdevice_add_config(void *ctxt,
 			__func__);
 		goto out;
 	}
-	cfg_info->nblocks =
-		get_unaligned_be32(&config_data[config_offset]);
+	nblocks = get_unaligned_be32(&config_data[config_offset]);
 	config_offset += 4;
 
-	bk_da = cfg_info->blk_data = kzalloc_objs(struct pcmdevice_block_data *,
-						  cfg_info->nblocks);
-	if (!bk_da) {
+	cfg_info = kzalloc_flex(*cfg_info, blk_data, nblocks);
+	if (!cfg_info) {
 		*status = -ENOMEM;
 		goto out;
 	}
+	cfg_info->nblocks = nblocks;
+	memcpy(cfg_info->cfg_name, cfg_name, sizeof(cfg_info->cfg_name));
+	bk_da = cfg_info->blk_data;
 	cfg_info->real_nblocks = 0;
 	for (i = 0; i < cfg_info->nblocks; i++) {
 		if (config_offset + 12 > config_size) {
@@ -1449,14 +1446,11 @@ static void pcmdevice_config_info_remove(void *ctxt)
 	for (i = 0; i < regbin->ncfgs; i++) {
 		if (!cfg_info[i])
 			continue;
-		if (cfg_info[i]->blk_data) {
-			for (j = 0; j < (int)cfg_info[i]->real_nblocks; j++) {
-				if (!cfg_info[i]->blk_data[j])
-					continue;
-				kfree(cfg_info[i]->blk_data[j]->regdata);
-				kfree(cfg_info[i]->blk_data[j]);
-			}
-			kfree(cfg_info[i]->blk_data);
+		for (j = 0; j < (int)cfg_info[i]->real_nblocks; j++) {
+			if (!cfg_info[i]->blk_data[j])
+				continue;
+			kfree(cfg_info[i]->blk_data[j]->regdata);
+			kfree(cfg_info[i]->blk_data[j]);
 		}
 		kfree(cfg_info[i]);
 	}
diff --git a/sound/soc/codecs/pcm6240.h b/sound/soc/codecs/pcm6240.h
index 2d8f9e798139..e27afd33910c 100644
--- a/sound/soc/codecs/pcm6240.h
+++ b/sound/soc/codecs/pcm6240.h
@@ -199,7 +199,7 @@ struct pcmdevice_config_info {
 	unsigned int nblocks;
 	unsigned int real_nblocks;
 	unsigned char active_dev;
-	struct pcmdevice_block_data **blk_data;
+	struct pcmdevice_block_data *blk_data[] __counted_by(nblocks);
 };
 
 struct pcmdevice_regbin {
-- 
2.54.0

