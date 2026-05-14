Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96D38B7D6
	for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800828; cv=none; b=GXogRHAzhJjEyH1zHSq9MpggXNar7fPcc/G3kl3PgneuAqAIYK1jRzFwr0XGRGSE3MeDDaocLZ/CERhM4O5YJ+g9QoviXca/j1EVRurc+XUM7MU9pYlhbFaFpUp8D7fngBsAPKM6HWugmEHNiUIFJW2g74SeekrBvGNB1PgLp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800828; c=relaxed/simple;
	bh=lyut248ohL8lMiQjhMEr4em5gqDx1XiavnPgwudBiiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUTQVyZ3mfio8a/2H7oU7U6HzQ5c7qAQXNQkMqLKgT0buigZgoOnfci5jT4vEY3qA7+qYMugC30cPL55ErRIuXnWhfL/b2V7EmcnMSBll1TlhU/pxGqXcB3RhBNPqZoaRvxdZV39TfrPiZsuuDdtcDx8laDZp+ZNsLrv/WXEDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOMtaX+r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOMtaX+r"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-367c26471f5so4638908a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778800825; x=1779405625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFgRqIfPnwsr89P7tCB0q0/8N2KZaaQUIqXtzxlp1YE=;
        b=LOMtaX+r99GzxbZkXZDATIWSr95WSwIL7uerQ+rHs/pehMd0TYHK5K1TgAc+MgyRvh
         /5W1any1YdnlQi/ZLIS1exo4ajbLgUqrxwTYZbnA5XyRTjitwc8IzAlDvmTyADTdOxRM
         8HLuH8HNBF1xP6WJlfav8z1OoJB+bM6bA1tf9wpSnhnvzMUUIkvQpOyPDsUyJH8x09Ah
         DNlVIS0eUpA04Zmq8cNeab2yPIZrKcROJU5D+JNKGPR66dBNbr/JshO5H3/kS4DyohlB
         4FEHDKA/PWe1Q8DYcMEsLYCg7bFdpTfyRsYl36JaPdq9yumamGGof5N3Hjla4rR735KL
         V8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778800825; x=1779405625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFgRqIfPnwsr89P7tCB0q0/8N2KZaaQUIqXtzxlp1YE=;
        b=N1dDGE7A0+GlJDrpa9fGX4X2Jd0XBOHcfa4/XC0DjsHHD7YPI8MvhKvKrHjECrrpi9
         OYxawbz+Gb1cVIUnoizlv4U7dDgdAvVbq18iMzRhlobdhfdDIeQNFHBKUGMadZ0Z7dmD
         +/PZaXEunjFWOQZ0b5eNR8WIN7aH8k9C5atugrZ3Pm2gpUQ5rg2d+2xxEBL+UgCS4Qxm
         +hEJuGvMs0dRB70wOYSjYh7tTd2dcvokINpsNFD1dQARjw+JDaDRII4NfzfbISzB5WBQ
         zfK8HuxgQ7v2myS3nBEkITtd6IhoA/YNkvjX9O5TtlonokZbJPfA5iYEhGy7C6DgycTH
         06ug==
X-Forwarded-Encrypted: i=1; AFNElJ8lSarMDCS0tpC2BAeT2ATnJvYT6rA/c0MCVM7Dk/lPdeeAlxcTpsFbdrDs4S5YCgNMZEu2wHVFsqKx91uf+n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdIdzfB6MARcVQa/oQs0tLHhZpOhjb0jOUcwJ2sbZo9BVanMyF
	zXX+xiOuDso4HTImWLOlcAWhZ11HNkXrdGWeKLWV/dtOj/oN498oa6Ev
X-Gm-Gg: Acq92OFUWSAIGu8qTMOhvoipv6BbEP52xi43DU5COsk/yEjiZ9RlCJCwpewdmgOfHYk
	RXogr7NKS3rLLubzA64IDjW+Cc9jk6lYIzSobfnaDVzLndFO/mXwMiFnk8LbP3dcgsHARsu1QLc
	O2QAoYWqfmY5/nYrAFsZhFTJPQJgIcg++T0Mtjv1zZO1mgJ5MLPf1E70FB+Ga7//Cj1yO24PQ+k
	Gh3uTBTAg3xIikS/iHieczdRcCwQc+RNLnFeC+WFGKV893DZTub8rp7Dl33D7iTpkwGl3uhoyfk
	Bt5xrGtCrW3H/VWI2cZEKJv7bBjlEhKKMwsyvqWQN3wUA9f5M0MkE0hoF3RxifUgKSfGQhdwfFy
	klF8/n//TJt2JtrEW8ln54GJwtDHeMUpZlCBoxHVAaqDQDe+QiNYw0V3QSHB5XElx6yhSyj7pxl
	7qCEBZYJxPw/+DXMIX1ssxaZzLs75puT90uDkW9sxB/MT9mrpsbJ7aRZimbVTFZ0xiocu9nMsGS
	2NzM3q2/vz0rlrdh7UN90xStaDBqMuvAvbEFgzflbS/nA==
X-Received: by 2002:a17:90b:48ca:b0:359:d54:846f with SMTP id 98e67ed59e1d1-369519c103emr1358006a91.7.1778800825008;
        Thu, 14 May 2026 16:20:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951434f55sm721589a91.9.2026.05.14.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 16:20:24 -0700 (PDT)
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
Date: Thu, 14 May 2026 16:20:07 -0700
Message-ID: <20260514232007.13260-1-rosenp@gmail.com>
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

