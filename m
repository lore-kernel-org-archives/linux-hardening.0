Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D93101B6
	for <linux-hardening@vger.kernel.org>; Thu, 21 May 2026 01:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327996; cv=none; b=CHGE9rsR/6LhAQLCGZ1LmkNGUcchH12MsXd7FLpMnd6v9oOj4lBRv4DO9YZLb07OZF/taYT31CyrYxx+Pn2G2QEnwt1PPqFLkYJrME06ySohnBCDy0rnvcEChblx/iiUbuq1jO2s0U84ilNU9ouo2xXnIN0O1dN4AjdgLLuQVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327996; c=relaxed/simple;
	bh=K1oLwk3RTb4DmrtSS1Kd+fkh9y8M6HVo8S/ImeLc6e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0/J+1cSbDLTVPuQBpSFJkVfUajYHmaGs+GMPoyzO+u2Mo3tu5ChCW0Z/q+ew7JCujtzBC/lWFg8+m7DwV7AARJgBrHcnBHsm6Mlmp8XN6E7kfoCTSyOSb1g/Gb63ATQgkJibfe7TOBMn2fi45dKswfJEU0OcgadftsQPuagS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpy5/Zed; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpy5/Zed"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7cfc382d896so20936477b3.3
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779327987; x=1779932787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSOZPwggBd/tZaFmjqTfCM6sLL5sYIwg3J4tTfp4kIg=;
        b=kpy5/ZedTgdZuR3lB0USPng3wrpgkfLdCCC4EJMoFzaBrs3ZFhdezS8jMXR57qa912
         azZG9wFMOGxzKWsmVaJXK7BrqJwYCTAEM3jHnLaM2I1wyCdQ2tw2MBRhylzK7HWiC8kP
         Zk6npQiX15570gVgpbRYLnaCbd9wx0soeAQvWI32XkIZcvoB62EBpWCuJuM6GGxkdG8w
         UdA/A9ZTE33z2FtAS5X9QfT25VUCGVwbkGzvB0gjq08yuyvTtr4AOETOaHD0uFrduaZ3
         QTTsr1xoPQ3PTqAyeRnNLPGcOwdLKbPNeoGHwVXEMQ9Th0P2AwPKO6Lxnvk5gN0NNqHR
         wRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779327987; x=1779932787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSOZPwggBd/tZaFmjqTfCM6sLL5sYIwg3J4tTfp4kIg=;
        b=W3KoauFtDzSreEO8O3FcMXvjkHvoW+Q6RoWuT+8U21lzwbN3JJLQ25Wbcle8h+DCIV
         n9EgNJctCCAfXZbrULT23IOQ+NVxTOAubFmWJlg4lmZjXTa8L9M8qsqB4HWIz5Eyiai5
         8S5DHrl/Z5U5xxkwG3sXCH0+HeSnAvY85izwxrRacmxHrAzWFez8z8IvtchsfA2YrBYo
         X9pTsWlIlZGLIsxI+JVf6ZgrfhY1oK+iwGP53utjyfvSVTHu44xaMOOOwZRIz0bQ4sYk
         tL9HIeaKDGMt2Qrmi6mkGa0FiyE+gp7gKEOi3rYZq0+1LgKPxX2Kwsjt0Q369xfBp0rk
         PYrA==
X-Forwarded-Encrypted: i=1; AFNElJ8yD5FiIrezFaxAMOC+MtR7JzaPmch9DsPpa9S2rH/O9N3m3CVcwpmCFIUhdS7heiJvmCAsRRvLxQSWJgYP9yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLHTobfZ/NDH4nJ/NQQL+tKe4ztU+h2zKGssWoREQ+hNtZo3q
	ynbi/x9Q2skh2Tmz1h5xekryas4pGAdv5RdbipB0guGJw68jgvS5NAO9
X-Gm-Gg: Acq92OE/TilEZSuyh3H4fFsunP1rUagvsImAZNv4kP2CLN4y8tOyLi8Sq3C6JSfpLZN
	y773f1A6ngAbLjNSyO1G0mFIJFG6+G6CeEQZUnhMghPpVEMUeQXkI1CuqAL6FeDMWoqMSb/o7ZH
	0X8FNI3p6yOz1RxOBhriFea7k2glUOaNdlxcZNyg9jQuqU1YAMIASrFGogoaaDD+JMZcu1ukQ+l
	lQ1Gnoax2D6ochEH6SM9zPsZRai42UK8J+RADfXoGmGgFjYG73Y1oSLWHJW3Y5g8g88pnnDMkut
	KG7Ix+pqiZE8ZzaHk+5Lkrk1VBDmnuiaH4y27o1glqwSPrjpbq9mb1RPcXUYTaX1YoiRi+kF7Vl
	EL//vpi40TTcDRr3m+tJdCdj9agv/anpVPJlOMe//69w0p2QAkEVrgV86lI2MkPBeilcvgKKQTa
	OuVoxnU2HRpVpGl7Vnb4n1my9YUmOH2bTPiTKaWJ5Wy7gfe4+/40Ricazh6a4ElSs5tTxPANWGt
	TciHPu+zeHLOHc1ehN/RtrX9E4LZWqX3iw=
X-Received: by 2002:a05:690c:4b0c:b0:7bf:ff7:ea72 with SMTP id 00721157ae682-7d20d020f3dmr10604927b3.34.1779327986944;
        Wed, 20 May 2026 18:46:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cd0bfdc094sm56652417b3.32.2026.05.20.18.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:46:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] platform/x86/intel/tpmi/plr: allocate die_info with plr
Date: Wed, 20 May 2026 18:46:08 -0700
Message-ID: <20260521014608.1356671-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocations slightly.

Add __counted_by for extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Rebase.
 drivers/platform/x86/intel/plr_tpmi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel/plr_tpmi.c b/drivers/platform/x86/intel/plr_tpmi.c
index 8faecc311038..66220fadf670 100644
--- a/drivers/platform/x86/intel/plr_tpmi.c
+++ b/drivers/platform/x86/intel/plr_tpmi.c
@@ -58,11 +58,11 @@ struct tpmi_plr_die {
 
 struct tpmi_plr {
 	struct dentry *dbgfs_dir;
-	struct tpmi_plr_die *die_info;
 	int num_dies;
 	struct auxiliary_device *auxdev;
 	struct notifier_block nb;
 	struct mutex lock;	/* Protect access to dbgfs_dir */
+	struct tpmi_plr_die die_info[] __counted_by(num_dies);
 };
 
 static const char * const plr_coarse_reasons[] = {
@@ -305,7 +305,7 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 	if (!num_resources)
 		return -EINVAL;
 
-	plr = devm_kzalloc(&auxdev->dev, sizeof(*plr), GFP_KERNEL);
+	plr = devm_kzalloc(&auxdev->dev, struct_size(plr, die_info, num_resources), GFP_KERNEL);
 	if (!plr)
 		return -ENOMEM;
 
@@ -315,13 +315,6 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 
 	intel_plr_register_notifier(&plr->nb);
 
-	plr->die_info = devm_kcalloc(&auxdev->dev, num_resources, sizeof(*plr->die_info),
-				     GFP_KERNEL);
-	if (!plr->die_info) {
-		err = -ENOMEM;
-		goto err_notify;
-	}
-
 	plr->num_dies = num_resources;
 	plr->dbgfs_dir = debugfs_create_dir("plr", dentry);
 	plr->auxdev = auxdev;
@@ -361,7 +354,6 @@ static int intel_plr_probe(struct auxiliary_device *auxdev, const struct auxilia
 
 err:
 	debugfs_remove_recursive(plr->dbgfs_dir);
-err_notify:
 	intel_plr_unregister_notifier(&plr->nb);
 
 	return err;
-- 
2.54.0

