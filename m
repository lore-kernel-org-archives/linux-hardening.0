Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E34306B3B
	for <linux-hardening@vger.kernel.org>; Thu, 26 Mar 2026 02:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774493145; cv=none; b=aICBWGa1TGGCfrqrT6MgkQBpvPnTwt4Kf9qu3D3+fadW5wQbbZoyM9AwFkld3FzwFH9rJPjE4UEDxyWgJnAH3Q5lRZm+FsimzVe4dwJUk1aaEvZGjcjm5RiA6wpA6Z3G8fxzf+9jf2ywwAfqkfUPVfEK7uFCx/BGctqOYW8KRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774493145; c=relaxed/simple;
	bh=ih37SNi06IoAHf7qsL4oAH1Ny2YjjprNP3j+rRR/V+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpI/ZcsnZhLBFtUCzlAy6m4yDFNmfhDocp73b2r6E2Pgw6eyQYDLGsRA+ea3T3aOBf9SsIPmR8/G+iYH9hncUl4Pl4b1TWUWC/2qd/9glQffoQXraxsoMtuSzUdP2yKM1rD8mgFWJTtmXJxYprpESjTr1OvwzY1C8FZFhRXOUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFQJ0TZ3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFQJ0TZ3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso293619a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 19:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774493143; x=1775097943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvhCQDk3ciCMOwVqf6gs4VS8DOqJPXMl1prNHK+3NPU=;
        b=CFQJ0TZ3UVhLOV1T+rUBpo8wRR+QsUr6r0O5ZFvynEOpszbqWUfweRi6YDtf6lQDJa
         wxC/S5m67yMJVQ+vFjDX0l+iuBqrIcLc2HlJj8rlmFsIjN75L03s9ODksVl3+WLXqf81
         wh9Py6ZCA4ZwxvVq04gdFCMNZP1sBexJaq2I1BjS4d4xP5D4mJHYaCl48/GMxKhL7GHw
         exUBZoj7ZbLdxJJmYLZrUhzKBgnnG4Qo00L39uXTcvApSazWBJxO3D5B6UU4nxu0rPVq
         N9xjL8X+PqfGKChjVyvGiN2oJ+7g6SLkkPgP8y4cimIMnqkF6DTaQD/+bWLe8a+yIntB
         SCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774493143; x=1775097943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvhCQDk3ciCMOwVqf6gs4VS8DOqJPXMl1prNHK+3NPU=;
        b=a8vQQXcHegbkAGiDLSaQH/CzuEZ8Na80+RDYQy8UteSMBFhcMP7GW/9nfU+QS2R7kO
         0ak9YAoU0JPROIfA+GOOFqaGFZASGlY1hiF5tIApSxo0iBmGryYwWPmiaBLn2MCNnAc5
         stDMJcxGJPYIwfqw8A1MwAn1JnnChxJ9qixEQM8P8kVsLUlsLTN1OI5Pmde6+UgAJU3c
         VHPEQIZpXiubyKvJUQ7Yw6Qxmqgh9uBudEWBIn2itCP1iTPNJVNUpEmm0fdrnkdizbew
         nUXb94Aw7egoucGf9Y7UsGHGvHoPxwavtwNzG14kGJjv9G+aVmWQg2DibcakU0llpL7A
         XABA==
X-Forwarded-Encrypted: i=1; AJvYcCW0qv14/5l2yzEY6/uCAy4VJefESumbyEovMgAGBfEogm71i0g+Oh0wskVb3n2f+tIX61WHi+R0+CsKt1eXzGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSbbhUbAUHQ4KihXzc3qLW4z2eXdRM+qGy0H2w1mrejLSOBdh
	3gw+ihgoWwzIDeVzH0ayMBgfBQa/CZHmtrs+tBWslLRUEjY6y/kblscL
X-Gm-Gg: ATEYQzxkETcyrVGTSmIgpYqs8Wz82F2LsURKcdjHXEFSSjcRMPW0+oBRLfnfnowVOjv
	DTNQEzVTl+aFJLmANfqDoEYz4JvwCD/X7zhcqFXWDHOTRljGknAsq325xMnQMRMlcK8UwyxQQd+
	Zmbvs1TmiYIFFBT/+BVtUvhVaAWJZTpuhv9apAJU2vm4W8asc95GXHbVyxNHYXUFN5xqGWscG90
	JZ7PWiiNYM6rUm4JT5xwSjkUeQQAnGaAg/A53s7D1ZgX0o8/udgpyJ3LSImme6CKQuDLqErHy51
	vCz6gTBf7G64G1SHuwhzU56r5t7la9/owb5xnEZO50MVmy/lBIRgDYLkN3qawJlcwzfWQoK3wLT
	Rys6AtJBNWubxy+imX+d/Y26ooeHPhlGtsF4uBne2+wEvPXPAMda5LPGaQKvKimGgBx8C8DIlHW
	0ZITSXxg+EUd7JQrQCBS0wQxbQG08VcGN2nCSxpyFwXQWSpfDX/mK3Jlo=
X-Received: by 2002:a17:903:1b24:b0:2ae:a928:f544 with SMTP id d9443c01a7336-2b0b0b0dc2fmr60929495ad.45.1774493142883;
        Wed, 25 Mar 2026 19:45:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e6cfsm12986025ad.39.2026.03.25.19.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:45:42 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: Kenneth Chan <kenneth.t.chan@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] platform/x86: panasonic-laptop: simplify allocation of sinf
Date: Wed, 25 Mar 2026 19:45:25 -0700
Message-ID: <20260326024525.63258-1-rosenp@gmail.com>
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
 v2: Rebased.
 drivers/platform/x86/panasonic-laptop.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 1337f7c49805..2fe8ff0d32a8 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -246,11 +246,11 @@ struct pcc_acpi {
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
@@ -1003,21 +1003,15 @@ static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
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
@@ -1025,7 +1019,7 @@ static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 	result = acpi_pcc_init_input(pcc);
 	if (result) {
 		pr_err("Error installing keyinput handler\n");
-		goto out_sinf;
+		goto out_hotkey;
 	}

 	if (!acpi_pcc_retrieve_biosdata(pcc)) {
@@ -1106,10 +1100,8 @@ static int acpi_pcc_hotkey_probe(struct platform_device *pdev)
 	backlight_device_unregister(pcc->backlight);
 out_input:
 	input_unregister_device(pcc->input_dev);
-out_sinf:
-	device->driver_data = NULL;
-	kfree(pcc->sinf);
 out_hotkey:
+	device->driver_data = NULL;
 	kfree(pcc);

 	return result;
@@ -1139,7 +1131,6 @@ static void acpi_pcc_hotkey_remove(struct platform_device *pdev)

 	device->driver_data = NULL;

-	kfree(pcc->sinf);
 	kfree(pcc);
 }

--
2.53.0

