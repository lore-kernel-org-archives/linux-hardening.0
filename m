Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD401118
	for <linux-hardening@vger.kernel.org>; Wed, 27 Sep 2023 05:37:09 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81710C2
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 22:37:07 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c0dd156e5so214903427b3.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 22:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695793027; x=1696397827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQjpvsz8B6fWGFRS892bByH0/TfLx87GHgF3C9zLecE=;
        b=r8u2u8aUVw4N37UsmIXh1E9gbopc+mFYZC5VAqhp7WzGbub79chi3JA5deBD0vC/+u
         nqCkF4PSOEQKBvpkkFgVp0EBZEmp/2J2BV5Mnz0S/pluU7CAurBKUVhhhukCp73xFiik
         TExlJYTBlK9dGnBsnCOvkkuY9CB7YMTHmbs3gtrbN/rsbu/SHlskKKJZGT0/qB82dIIz
         rZ7TucWHpvCeXgLyi+BafsfLYqQi19dFI2HEZdcrEHN0u2vjsX9h3280/iUlBsxcNQ8J
         cIHcplL0NJpgirBgYC3LalFGcu6pCAwvB4R7W/mRdUL8v2VM1wr0NQ8zLrQzgLnkkprT
         phmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695793027; x=1696397827;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQjpvsz8B6fWGFRS892bByH0/TfLx87GHgF3C9zLecE=;
        b=aOCHeS3uLpaGqgEdOZffgtUbZQDO2VzL5zWW7bjBNrXJ+pgCKspBI/Azk5ghO0v0P2
         3X/olkTN0ooeBFZ3zWMlFMvvJzlEIaPBUUBqX8zUpxA+RfozKCvhf22QXYXwZe9WR5DS
         7EoV0eUc5YS8kieEH1Dpl45PXI7OoDlATNE5ovSKzU/kIktie1dAZE1I5zvkZxrg6yZp
         2vUfiJ+LLrhNoLCI3IBJASc67RN4M+MOTOIVsIrLV/boXrj12z5fKqWH6BxfXNKDgNAw
         qnc0DNcWtbJkdI8SX2j4lvtG6+eptVMVGqIaxQxGsSW6HzpO5f+4d3KFCnwCNhrJuQoq
         2jHA==
X-Gm-Message-State: AOJu0YzcaU5L0L17BHGvFjZgpuwvUHvnWykyezxoQKkxiLxKUJHV75zQ
	vnu1izU4HQIeSPJub4jOa2ylpgi/v/kdfrdM2w==
X-Google-Smtp-Source: AGHT+IF2eTEQrA0AUAFSM3JAhkULrL3njtW9SQSuwZCDD1tPWpemdoG+Uf54B2wD+F5KHhTY4D/ysfwkHPl6cGxMCg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4293:0:b0:d81:7617:a397 with SMTP
 id p141-20020a254293000000b00d817617a397mr10857yba.9.1695793027117; Tue, 26
 Sep 2023 22:37:07 -0700 (PDT)
Date: Wed, 27 Sep 2023 05:37:06 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIG/E2UC/x2NwQrCMBAFf6Xs2YUYKTH+iojY5Gn30DTsllIp/
 XeDx4FhZieDCoxu3U6KVUzm0uB86iiNr/IBS25M3vmLiz6wLVpS/XJWWaHGk1hioOo8NXV5XuN YYRsnHlxE7nsXhpCp9ariLdv/dX8cxw+rCT1JewAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695793026; l=2217;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=YmUsybfVQe5zWGf5jAxBKfMLPjPHkISPd1MoaRXDQM0=; b=NnPpHhicfwRq3aw0g0ffOiYeu9GpDcJMkqekY6y7VMB3EAjMVg8b06HE/BZGpYy5L/gyLcJUP
 aMjUtWcfbOrCSXGxoVEFAkSnAjny2kZpdesatoBbkprjuWZXvxOIMzT
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-v1-1-08e3d45b8c05@google.com>
Subject: [PATCH] eeprom: idt_89hpesx: replace open-coded kmemdup_nul
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A malloc + strncpy + manual NUL_termination is just kmemdup_nul. Let's use
this interface as it is less error-prone and more readable.

Also drop `csraddr_len` as it is just used in a single place and we can
just do the arithmetic in-line.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/misc/eeprom/idt_89hpesx.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 1d1f30b5c426..d807d08e2614 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -905,7 +905,7 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 {
 	struct idt_89hpesx_dev *pdev = filep->private_data;
 	char *colon_ch, *csraddr_str, *csrval_str;
-	int ret, csraddr_len;
+	int ret;
 	u32 csraddr, csrval;
 	char *buf;
 
@@ -927,21 +927,16 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
 	 * no new CSR value
 	 */
 	if (colon_ch != NULL) {
-		csraddr_len = colon_ch - buf;
-		csraddr_str =
-			kmalloc(csraddr_len + 1, GFP_KERNEL);
+		/* Copy the register address to the substring buffer */
+		csraddr_str = kmemdup_nul(buf, colon_ch - buf, GFP_KERNEL);
 		if (csraddr_str == NULL) {
 			ret = -ENOMEM;
 			goto free_buf;
 		}
-		/* Copy the register address to the substring buffer */
-		strncpy(csraddr_str, buf, csraddr_len);
-		csraddr_str[csraddr_len] = '\0';
 		/* Register value must follow the colon */
 		csrval_str = colon_ch + 1;
 	} else /* if (str_colon == NULL) */ {
 		csraddr_str = (char *)buf; /* Just to shut warning up */
-		csraddr_len = strnlen(csraddr_str, count);
 		csrval_str = NULL;
 	}
 

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-b09ed5507b7d

Best regards,
--
Justin Stitt <justinstitt@google.com>

