Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3F41C65
	for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974935; cv=none; b=b9eBIRHJwa7C+NFCTwxpKCz9w4HSfqR4BystQIS/yvnpXdLiPpBrIFI9HvODoQIhKEozDr2yjwdB7nhqNfKDp5yowpRkFXyMkDEFcPxsW0TXp7tyNOeIFfkfTgeNP3Oh4njTCokFxEKY3GHf60K0KjOhqX9CddaB955OLOEN4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974935; c=relaxed/simple;
	bh=V7XSTOhNvjEuLafgGT0fgGD4qu2T4mLPqEmu44WjLQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jnk+7Fi3ftYs6XQnpQZlCTZiUMhmm5iNRRS1dG5sPmZCfsx7N9rnRVrPXKjFoP/mhdwr2FIMznx77uxAjL06OsZIkwjE3a+Au7uTB5bJNYKE6i9xxROThH9BoSkE8VHvh16Q1BSZ+o5tnv4gw2m4pz4U5Qql2OFK2th/UeE7ndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHUUy3ZP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHUUy3ZP"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so6459317b3.0
        for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710974933; x=1711579733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cuJsz9UlwEA6zdfjk+8N140o8FRIcxJ5QLG1a0ozWdY=;
        b=WHUUy3ZPEKlcPGbCtgfMhAV3BUXSEsHrJPuiSMZ2VCOJzLGZ7RSo1AtgfZkZiJxMf7
         6zicp3IdB8tX0jnvQXW5fIZZUZKyf90FTzrXfARVAM4AJep1R4+W2BpH/nRziDzW9tSQ
         1xcpi75Q+PuSkD8E31Cstb5UcOE7hPvYEXyvb5G7iMJ9VaxTOz3pdg9DMCm6Ueo6upuq
         zuzxXbb/Oltd3gsonrm/t5/xZekyratvSNbDbDxTx+hH14MVAspNvnXMTZKyuvnLx+lF
         zJc8Bpt2aFSBnC1SvBQs+lE8bzRJC1BBDQwhBBJkVHb5HikR8qY40OJOL8IKBjwYYEFN
         cLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974933; x=1711579733;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuJsz9UlwEA6zdfjk+8N140o8FRIcxJ5QLG1a0ozWdY=;
        b=HlGHC/LY4dkDELnJNItGv1PXTP3f3FX/cU/D/4Fpn5Y9lZFCfEdHOg9GOBXt/AUC8x
         f6D3L6zD/cbTqwh4O8492ya99fcqqx1sVJnNZZ0xRF6WQHwXE2H7R0jKTCiDZU/eQkaJ
         PJadkfdLpVr5HXWbO000Pcvh59bXevGHf4I/d9HW3vhlye7vJD66W8xw+rL8mKdrMsMv
         HD9Qz/beknF7NLqS4A90cy0Ypq42YO0+wWWydfg68EAlN8NUVlWyM/O5MDC6HsDggetp
         8W50co8rl80LJEtftXu7+Y32j3HtbMlxoMhrv8MvgcxvEPOaSPYH+762xSzVjIvi9qs0
         qrCg==
X-Forwarded-Encrypted: i=1; AJvYcCUc57VCRXAgcL/BYiF30jBPX4UXgaWW8ITgoIrXlkvuq0SY3we6n6ks7oqYFlBsfmuMF6ccfCveh233XhNU9jmDTPAHJItrVw29KtBxDv8B
X-Gm-Message-State: AOJu0YwklIzQEIJP+TbRZlAFsr/mM02oxqJSO+2gExqxzR/Du+/moMnq
	olrEYOZLqU9MwKOyLylVKcNcgU/wafAJ5APzrEkT0tWcEH85mXHpXYuZfZaNPwxDqFI1eVlMO7K
	jMsNlayoM3qEzndTUp7sWjw==
X-Google-Smtp-Source: AGHT+IEAdJhJ6XWsfWFvKxMRCTCL0rFzhCdAiYFkka5BbblT+BLyG2u8I3I/0FokOi0qCRO5wy/EMOMrrIZr/UuKig==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:91d7:0:b0:60d:6e32:2f70 with SMTP
 id i206-20020a8191d7000000b0060d6e322f70mr3604527ywg.0.1710974932857; Wed, 20
 Mar 2024 15:48:52 -0700 (PDT)
Date: Wed, 20 Mar 2024 22:48:50 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANJn+2UC/x3NwQqDMAyA4VeRnBeoVgT3KuJhbVINjCqJlg3x3
 Vd2/C7/f4GxChs8mwuUi5hsuaJ9NBDXV14Yhaqhc13vfDuiHZrj/kVSKayGRYg3TIG4YLI3kpx VGDEMo/ND5OBTDzW3Kyf5/FfTfN8/1lDuSHoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710974932; l=1938;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=V7XSTOhNvjEuLafgGT0fgGD4qu2T4mLPqEmu44WjLQA=; b=igy7d94UFbUM0TkUAgMVJDxriGbnH+DPKvEXXYKfS+CKktomyiqlyOLzVVQxq4ZffMDfFel3O
 h2XGTp+4Dh/Asd4C5wNyBMFsacdao+pZNwmAm8/6HIhl+l027RuOSV+
X-Mailer: b4 0.12.3
Message-ID: <20240320-strncpy-drivers-video-fbdev-fsl-diu-fb-c-v1-1-3cd3c012fa8c@google.com>
Subject: [PATCH] video: fbdev: fsl-diu-fb: replace deprecated strncpy with strscpy_pad
From: Justin Stitt <justinstitt@google.com>
To: Timur Tabi <timur@kernel.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A better alternative is strscpy() as it guarantees NUL-termination on
the destination buffer.

Since we are eventually copying over to userspace, let's ensure we
NUL-pad the destination buffer by using the pad variant of strscpy.
- core/fb_chrdev.c:
234 |	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));

Furthermore, we can use the new 2-argument variants of strscpy() and
strscpy_pad() introduced by Commit e6584c3964f2f ("string: Allow
2-argument strscpy()") to simplify the syntax even more.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index 0191141657fd..ea37a60da10c 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -787,7 +787,7 @@ static void set_fix(struct fb_info *info)
 	struct fb_var_screeninfo *var = &info->var;
 	struct mfb_info *mfbi = info->par;
 
-	strncpy(fix->id, mfbi->id, sizeof(fix->id));
+	strscpy_pad(fix->id, mfbi->id);
 	fix->line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	fix->type = FB_TYPE_PACKED_PIXELS;
 	fix->accel = FB_ACCEL_NONE;

---
base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
change-id: 20240319-strncpy-drivers-video-fbdev-fsl-diu-fb-c-b69036ceb3f4

Best regards,
--
Justin Stitt <justinstitt@google.com>

