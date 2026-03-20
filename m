Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EA1E98E3
	for <linux-hardening@vger.kernel.org>; Fri, 20 Mar 2026 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967788; cv=none; b=ZMycpMe4Hiobz8yddeypNcYvLx3rkiliZfgpbJg5J2PxCtgR+DsVA2KnDp8u4cJZFGA5+t3li4KrsECMAiYkXz6QveVdkKAGBCWIanWJKgouGmjoolxQ9qMcpDHmaCAFhZxehZrUcz2g5F22+B71uvfvoWtQ8pitwLezLicMD4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967788; c=relaxed/simple;
	bh=aj+amzHykz0VP8Omkgv4PdojHt+uGLfiOHMytOe5yJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qzKIvINDl+tdsiMqm1oKTgIEStbJh5KtrLM1K6oPH1qupHLh4f+1JRFQcGnjNfTr1g7XcZ3/V66xM641+EAJWI3d+OeYLVYElGYSPV3A/Vm1hegDy+WZCJCJFl3bncQ/bq4GmQkX07rn6qKTAs+urDJpWXSAWtiO/HpN5hdm9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBGJqv5S; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBGJqv5S"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so18692175ad.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Mar 2026 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773967786; x=1774572586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IpBmk5APBUS2BhHlK8KMNZh8R0vKiaeWox7A/MEW/zg=;
        b=YBGJqv5Ss08VGKNl6/PqnSL9fts+KjEqoZJ3BW44RhBpm6HD0hEVdu37PKeN894VwM
         E46q+pqCEuoISqRD0DwhoHcApkb9K/kO6uCYRmGOMzKIhiD3mXsF/SRXBJm39ub/B5qR
         rZcPPT7jnADzDohlENu0P3K12Vae45vpUMHx0GlgjdY2I6Bt0OtTNK9NCim/9TU8G9/z
         yc9svMbqGpOp6B5GHzw9ybA+XWheAZErLS56oDLPm9zYZ+ku4n7hpTLKbkKXPCS6q4Wh
         2pgYRhbKRRfJnr75wJNJZlzzc8vpHJLwo4eb6YHfVPcqeQh0YgJa0jHGiW10ZCmJuyZh
         /5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967786; x=1774572586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpBmk5APBUS2BhHlK8KMNZh8R0vKiaeWox7A/MEW/zg=;
        b=II44c0bhKZajqd0U9jKI0ybEv6F8EvFS2Lx2XLLEJYImCrwsjtRDU64SJ43nIGNYY6
         7fvTN3YH3m2sllR6BcKF7ZBW9JYeukmMigpzU846tSrvOhLHGeB0t3jBDR5o7I8Pvlll
         sozjb0PD+XpY0DOuAC2EB15vpGiqVeJESdFmZ6+7A/oRUyfW1LVYYlpKvUjkhcaMgjIv
         rbvsZxfERk/0lx5FqVNAfnM8j9MC1Aoz4elmWHmJSeSkdbUREYqOS3cYngnuZLSdLPAC
         3rmgHGi0cOYvlTmWF1t/0QbS2HIqQESqUjoVtJGSTohF2ZRUSbE1GNtFPNwANyJzbWpB
         thQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUXlMBMb3UIwIFvYmRL68PdboIPSKFAmSZPQF2QB0fr/74oGJlfImSdXaCVWWkx+62kIx3C04MsAiC3KUz8/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz71JYx5G7uKQsmqhQA9tnMhMgpkIYd3Dis6Ed3dre6nxGSfa3H
	+CsJrPehr9Mrhtpww5tM1t/pbZsHPxWzGziyConiqXWj2oF95jym+ypc
X-Gm-Gg: ATEYQzwoe19U31rPiJ1Rkg2p1sqpeukwGZDl6T5Ozq9FdrFx5kiU3UpJCHdIlPRBgFw
	q4Z/l2xWmEgcl9AA6p+fvepLwFumXpISquSUh3usrrki6H+p6dV2HB8JHzlrX6SBtjNlTDjEOs+
	/RTjvhT1XVcRBhQD8bOEreB80Jtne3Hcg72SkWug8ucQ84Yvcop8FzbvTt7LdozVdTieo8dNFcT
	AbBBrWdSTFRk3wKoCiUBOdD8fzMLIKwg1Pp0yrSqXu9q+uU3znaNcW32jFl/qh0j4Jb/doo89vK
	/GapiEYQRLj9XtmlPNEoOi+zBbVQ7p5xY/BSXRp6t9Un2QWPTwm8CpG8W4ulG83LruffTOYzTB8
	i5CGPDeJmJdMup0c59fe5wu2fPU+m24y6kVuHENRz3QsGAASjWFkcqIZxLbySHwKN/TyFCfHvi6
	Uf2a5XDLkHwYfCONTowoLc8gbqLnFWu4etljD64HMG7HzlPQiaju8idqY=
X-Received: by 2002:a17:903:124e:b0:2b0:5a4c:726b with SMTP id d9443c01a7336-2b0827ca665mr9999575ad.40.1773967786258;
        Thu, 19 Mar 2026 17:49:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm4299265ad.25.2026.03.19.17.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:49:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Kenneth Chan <kenneth.t.chan@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] platform/x86: panasonic-laptop: simplify allocation of sinf
Date: Thu, 19 Mar 2026 17:49:28 -0700
Message-ID: <20260320004928.29914-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change to a flexible array member to allocate once instead of twice.

Allows using __counted_by for extra runtime analysis. Move the counting
variable assignment to right after allocation as required by
__counted_by.

Remove + 1 to allocation. It's already done in the previous line.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/platform/x86/panasonic-laptop.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d923ddaa4849..4d663fffbcc8 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -248,11 +248,11 @@ struct pcc_acpi {
 	int			ac_brightness;
 	int			dc_brightness;
 	int			current_brightness;
-	u32			*sinf;
 	struct acpi_device	*device;
 	struct input_dev	*input_dev;
 	struct backlight_device	*backlight;
 	struct platform_device	*platform;
+	u32			sinf[] __counted_by(num_sifr);
 };
 
 /*
@@ -1017,21 +1017,15 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	 */
 	num_sifr++;
 
-	pcc = kzalloc_obj(struct pcc_acpi);
+	pcc = kzalloc_flex(*pcc, sinf, num_sifr);
 	if (!pcc) {
 		pr_err("Couldn't allocate mem for pcc");
 		return -ENOMEM;
 	}
 
-	pcc->sinf = kcalloc(num_sifr + 1, sizeof(u32), GFP_KERNEL);
-	if (!pcc->sinf) {
-		result = -ENOMEM;
-		goto out_hotkey;
-	}
-
+	pcc->num_sifr = num_sifr;
 	pcc->device = device;
 	pcc->handle = device->handle;
-	pcc->num_sifr = num_sifr;
 	device->driver_data = pcc;
 	strscpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_PCC_CLASS);
@@ -1039,7 +1033,7 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	result = acpi_pcc_init_input(pcc);
 	if (result) {
 		pr_err("Error installing keyinput handler\n");
-		goto out_sinf;
+		goto out_hotkey;
 	}
 
 	if (!acpi_pcc_retrieve_biosdata(pcc)) {
@@ -1111,8 +1105,6 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	backlight_device_unregister(pcc->backlight);
 out_input:
 	input_unregister_device(pcc->input_dev);
-out_sinf:
-	kfree(pcc->sinf);
 out_hotkey:
 	kfree(pcc);
 
@@ -1140,7 +1132,6 @@ static void acpi_pcc_hotkey_remove(struct acpi_device *device)
 
 	input_unregister_device(pcc->input_dev);
 
-	kfree(pcc->sinf);
 	kfree(pcc);
 }
 
-- 
2.53.0

