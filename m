Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5A1624C5
	for <linux-hardening@vger.kernel.org>; Sat, 23 May 2026 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779499090; cv=none; b=NcsUrQRzHW8OXbcd0aVdDVj6jbStf2brBqH5OL3+xajGVhFGbxfOX2cycr3TbYdOV6AyhYvUt0yitK3j97b1feFb0njYY9yQuXn5BL7V2/rg7PKx0RHutGz6eh/0+sWlzPP2MhoJlHt8RIKdfsiNzmn89jH4eXKc3nH/d0Zymw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779499090; c=relaxed/simple;
	bh=EE1tcyn1jHAVW4AZjBS03dCHEHJ6qNChOXmFcU9svNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdKbSuYAX0i+Zav9sug1vjnB0dJAbrLGfFX6P/oS1AQiAuJSVxQHf1QVETp9iE+j0vOPpR+OuiMuBys2Yl1L57wxOeVo+PiEmVYn1cPCAJyyXMWj9FLL4p3prJ3v6WVhdSXP5+dJeHBEmFFPHuopHR+VbCs3TW2PzHQPht6I80U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTLozvtq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTLozvtq"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85067c9ccdso1542963a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 22 May 2026 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779499088; x=1780103888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=czoVXPIPzuLk/t99nJVJxuYO5649Md10TI8uUG61Ujo=;
        b=RTLozvtqAU/umcF9Bh5ENqOZMh5IiAXx2RG7i/mZq0qnLSdMWLIVE3ODHBWosAu4m0
         eBLIJGA5ITR2tZ++tNIMc8pb+V0oakGx4uIx4sgN+Ncni9PYXZJfstTtqAcJ38c8W17b
         gHiLIj1I0i68UkWnygJZuGWw6WyX9rxMNirD6BYNeOZDX4Fk/VDsVr5RGeEAqTdR2EbS
         mR3oeWkxKIpxkxMlcBBZ8TzAtytmMPFYQ/csqOEuh5R+63IOZNtIfMqu0Q9vjLBstpCq
         TALYC8uz6pgCKY+t0Udqa13HU2XuG1KuvE71uMQ7xK5U39EOO1kdoqjScyVY0wqTcx7j
         GOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779499088; x=1780103888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czoVXPIPzuLk/t99nJVJxuYO5649Md10TI8uUG61Ujo=;
        b=AlMIB9Fx4D4e60brXqBGUgQv4XHVO7PEx+sVwm8Rov8Mb8tCOWLx1aOxAiADIrRlzF
         dB5a/CLSIAy9VGxkEL81TK17+8teTCJVzZAq363iBhnBiV7pq594vzrgs+vE/2iv91VT
         D/jY13HvNvXxRkq6cbMmjvZdr8lnV9uUGtgstBxQVgrSyifiFf271C5tEegJuCZXd974
         ZhcflV4M2SeiLDAkC4XoVoyRozaEiuU6WwCamlrtcxuZrAVHEUfZgFCsEi3b3rxsf8Vf
         HGo5gU18hoBGjANVh4euyJuIoQymFnlDbmAei4P18c41zsXT48X2wtPrsYr0TfymDfej
         P5wg==
X-Forwarded-Encrypted: i=1; AFNElJ+2Svn+foG1YR2KAhBQgnoIUvsTntJ0d3ghfqzyVfkVTk/zxJAwGS3+COVoJ28PXJzkekzN2vlIaIHgHUH+mtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnt9YP2yuPQB8HXROeEuWwzb/dU/5tDon3+XU5c/th31GDnmjm
	gQCM8QWV+GkJV57DO4KmZpMO+2q6MpMbdgWw29pT69jPZBN30Pconofx
X-Gm-Gg: Acq92OGay1d2gsxI8WAXRpoy5rcovy47I64f6BEZtJp8FiHAOVgoM80PlOn5LfGWxe4
	N8keAaM48VZLdnG506RKdcnhWKNMZBIfM4CArhgeD1iCTmftkzKq4XkrRdcbTxAmFEnNxN4DlXt
	Z+7Tm5+q4F6AFs79/XL5nPDRzz+CDfjdr0nICiH8vwK5i8/onIufk3Xu8RoiA7Utm2LrRyTBZk1
	LadKfstjG7WrE9vCoxO8jk5WZQLYRflgjpEWl0dVhmQO75goPdRr3/Z6/nxpUPpcCmvJI9UImo7
	YIK+OTRXHJeNnxoWym4fOdkZvsxYGzz4nKYQGhfDPQ0QFnPcSazq8/jYD2VrY9UVLbnYMizLsKZ
	3rpDZubm2+OyFJq0yl0+WBeWsBFvQIVMlVs9h1KE0eLpjkLC7lhLQLPqApadam0JNs5XJ5CzFon
	B25gCW6i303Uxwbv0qdSZKCI9gt5awPjerjDkotSV8STu5ft7yxZecI104lFXC/1Bk7f0hz4Pj2
	LMX1BBG0Ubc9zdvBU5+4h+BwbJX+vooG04r1gJamzwYKQ==
X-Received: by 2002:a05:6a21:594:b0:3aa:f9cb:d438 with SMTP id adf61e73a8af0-3b328cbfcaemr5718353637.21.1779499087982;
        Fri, 22 May 2026 18:18:07 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fb00b6sm3774034b3a.40.2026.05.22.18.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:18:07 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] ASoC: aw88395: use struct_size() and __counted_by() for aw_container
Date: Fri, 22 May 2026 18:17:49 -0700
Message-ID: <20260523011749.101555-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware container allocations passed cont->size + sizeof(int) to
kzalloc(), which was wrong: the struct contains an int len followed by a
u8 data[] flexible array. It ended up being the same as the struct's
size is only the int member but still wrong.

Use the modern struct_size helper for this.

Add __counted_by for extra runtime analysis.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 sound/soc/codecs/aw88081.c                | 12 ++++++++----
 sound/soc/codecs/aw88261.c                | 11 +++++++----
 sound/soc/codecs/aw88395/aw88395.c        | 11 +++++++----
 sound/soc/codecs/aw88395/aw88395_device.h |  2 +-
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
index a5ba177a48df..d5e886a8f106 100644
--- a/sound/soc/codecs/aw88081.c
+++ b/sound/soc/codecs/aw88081.c
@@ -1137,6 +1137,7 @@ static int aw88081_dev_init(struct aw88081 *aw88081, struct aw_container *aw_cfg
 static int aw88081_request_firmware_file(struct aw88081 *aw88081)
 {
 	const struct firmware *cont = NULL;
+	struct aw_container *aw_cfg;
 	int ret;
 
 	aw88081->aw_pa->fw_status = AW88081_DEV_FW_FAILED;
@@ -1148,13 +1149,16 @@ static int aw88081_request_firmware_file(struct aw88081 *aw88081)
 	dev_dbg(aw88081->aw_pa->dev, "loaded %s - size: %zu\n",
 			AW88081_ACF_FILE, cont ? cont->size : 0);
 
-	aw88081->aw_cfg = devm_kzalloc(aw88081->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
-	if (!aw88081->aw_cfg) {
+	aw_cfg = devm_kzalloc(aw88081->aw_pa->dev, struct_size(aw_cfg, data, cont->size), GFP_KERNEL);
+	if (!aw_cfg) {
 		release_firmware(cont);
 		return -ENOMEM;
 	}
-	aw88081->aw_cfg->len = (int)cont->size;
-	memcpy(aw88081->aw_cfg->data, cont->data, cont->size);
+	aw_cfg->len = (int)cont->size;
+	memcpy(aw_cfg->data, cont->data, cont->size);
+
+	aw88081->aw_cfg = aw_cfg;
+
 	release_firmware(cont);
 
 	ret = aw88395_dev_load_acf_check(aw88081->aw_pa, aw88081->aw_cfg);
diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 50521dd2ebb1..02e5cb8fc909 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -1094,6 +1094,7 @@ static int aw88261_dev_init(struct aw88261 *aw88261, struct aw_container *aw_cfg
 static int aw88261_request_firmware_file(struct aw88261 *aw88261)
 {
 	const struct firmware *cont = NULL;
+	struct aw_container *aw_cfg;
 	const char *fw_name;
 	int ret;
 
@@ -1111,15 +1112,17 @@ static int aw88261_request_firmware_file(struct aw88261 *aw88261)
 	dev_info(aw88261->aw_pa->dev, "loaded %s - size: %zu\n",
 			fw_name, cont ? cont->size : 0);
 
-	aw88261->aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
-	if (!aw88261->aw_cfg) {
+	aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, struct_size(aw_cfg, data, cont->size), GFP_KERNEL);
+	if (!aw_cfg) {
 		release_firmware(cont);
 		return -ENOMEM;
 	}
-	aw88261->aw_cfg->len = (int)cont->size;
-	memcpy(aw88261->aw_cfg->data, cont->data, cont->size);
+	aw_cfg->len = (int)cont->size;
+	memcpy(aw_cfg->data, cont->data, cont->size);
 	release_firmware(cont);
 
+	aw88261->aw_cfg = aw_cfg;
+
 	ret = aw88395_dev_load_acf_check(aw88261->aw_pa, aw88261->aw_cfg);
 	if (ret) {
 		dev_err(aw88261->aw_pa->dev, "load [%s] failed !", fw_name);
diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index 982d54f2f8a3..ee0e8bd8c54c 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -462,6 +462,7 @@ static void aw88395_hw_reset(struct aw88395 *aw88395)
 static int aw88395_request_firmware_file(struct aw88395 *aw88395)
 {
 	const struct firmware *cont = NULL;
+	struct aw_container *aw_cfg;
 	int ret;
 
 	aw88395->aw_pa->fw_status = AW88395_DEV_FW_FAILED;
@@ -475,15 +476,17 @@ static int aw88395_request_firmware_file(struct aw88395 *aw88395)
 	dev_info(aw88395->aw_pa->dev, "loaded %s - size: %zu\n",
 			AW88395_ACF_FILE, cont ? cont->size : 0);
 
-	aw88395->aw_cfg = devm_kzalloc(aw88395->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
-	if (!aw88395->aw_cfg) {
+	aw_cfg = devm_kzalloc(aw88395->aw_pa->dev, struct_size(aw_cfg, data, cont->size), GFP_KERNEL);
+	if (!aw_cfg) {
 		release_firmware(cont);
 		return -ENOMEM;
 	}
-	aw88395->aw_cfg->len = (int)cont->size;
-	memcpy(aw88395->aw_cfg->data, cont->data, cont->size);
+	aw_cfg->len = (int)cont->size;
+	memcpy(aw_cfg->data, cont->data, cont->size);
 	release_firmware(cont);
 
+	aw88395->aw_cfg = aw_cfg;
+
 	ret = aw88395_dev_load_acf_check(aw88395->aw_pa, aw88395->aw_cfg);
 	if (ret < 0) {
 		dev_err(aw88395->aw_pa->dev, "Load [%s] failed ....!", AW88395_ACF_FILE);
diff --git a/sound/soc/codecs/aw88395/aw88395_device.h b/sound/soc/codecs/aw88395/aw88395_device.h
index 3626f222899d..7b74eeb84c43 100644
--- a/sound/soc/codecs/aw88395/aw88395_device.h
+++ b/sound/soc/codecs/aw88395/aw88395_device.h
@@ -152,7 +152,7 @@ struct aw_cali_desc {
 
 struct aw_container {
 	int len;
-	u8 data[];
+	u8 data[] __counted_by(len);
 };
 
 struct aw_device {
-- 
2.54.0

