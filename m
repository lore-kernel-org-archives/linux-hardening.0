Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE42E6116
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463121; cv=none; b=UA82DlWnZb++nM0/RYE0nsqKlloZMB7V9RBhAWdKQTFy9A82NunRVjNGEBMOweMLD/cwfVp5PnmAnorhZpypiQDEPioexZRrglhbU+ZCJTmdtniQEcwdL7LeyU+dqyGX509KpNjAu5YrUN628MRdjbotb1066kfRQdAvg3+WYXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463121; c=relaxed/simple;
	bh=vnFHcqH8IDVtsBE+Gqq+qvfqnPUS/7yK6vgR180USfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lNbnpBjDWEMT8V6nmnO8lg8J6y7ZRDs5tKuy5tNyfFDm/CpS1gnPUUUP00ZAQHZhQxbJyKW0tWdK362o6rom1tQUp9SNEey6I9f6/mI0lnuq942D7o4YTDfvzvkUQK70lKX5mIl3fJKJT5KDby1Fcn9MBRTPg33ulXQ1i3J8N70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv8pfmxn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv8pfmxn"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46ed4f66256so507315f8f.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jun 2026 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782463117; x=1783067917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=knUtWGfRpywQ0S6NVky1uviDI0wg0VlA10MLXXuY7Ac=;
        b=Yv8pfmxnOY82baWnmeWS6qk9u7Bc59QeoqgKLWM460/vMtGLvZk3hstUE0d+GFQo7E
         7lMzzyDgw1q5CulfiUFNHnP47hO/xaRPklKqEPBO5Xv4qpdAPRJ4Vw5UeylvtJ0cIYQw
         AnU8ZivcdAE+0r6JV8yrZcRxgKW2z2DE5NKmCEfkouD4Ed8SmpRV/aN0Xl8aFCzFjRC+
         ocxL58YmCXh+GG+ungw38kmNO+flHsP1KwL++ViDPP5pGr6iwYB8YWqCFxHQ+0NXk8nd
         D/GYt6wyu6/KibDDVB83auJmfPUuA16uE0QEwcMp9dec78akxuAVK++RlfhKDhJYnOl0
         4Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463117; x=1783067917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knUtWGfRpywQ0S6NVky1uviDI0wg0VlA10MLXXuY7Ac=;
        b=IBxo3d2Ed8JaZDEZdVMAKVYynriNWMnfuZphR/Jr2VGMc7JMM5+ktSD4Tul4Uh7Y0h
         ChcuvThsSmzKpKMslGB921fc+XWUzle4moeJicr3LjXM2Jd2u0pt9eYtInqgV6DYD3h2
         /2BmeFavPwAZS7fuGAen3LaDMfReU2DRvRjcoWCjxDc3O57LYe+uA6UONzjeChX8ImF1
         pxAQrvMrQpcei7m68ByTgzwLC+TVJ0kZ1LHhr4+zkXvBK4ojEEteCe0oEOkbXDeb6L3I
         Dyq/FUgm5QV3oGmUTsTHHnrCIKFijAFpqLAJ5D8jGHvvagPftEpk9Non5uNl65Nh8N02
         rBvg==
X-Forwarded-Encrypted: i=1; AHgh+RorYu528t4v7ZXgHa7q0bk5CHIJkRDtRaLcKdJ7iufhPR0fVtv5JbT2VT4VTG3KT5SZTEdZdO0kbxTgSe0+kjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/cA0pRrH+3TndWCGQh8MKn/G3F6TPzJBHWCs/CAyVZf1DHPgK
	PJAxDbECX+BmA+Cxt1dupcri3gcD5CdGr6ujsdl13tksY5waJuwJnmG9
X-Gm-Gg: AfdE7cm1aGMDLQGpSki1taYgkfErnok2IZNNXtD3e0sLorvk2fn7mrYbzunIQ5LFWBg
	wh1fZEjjJOyFFE6F8xTIscIfzPdjZCL5/q/UD64FFdIUm9KlgrT+XdQbEY3jipfUW0m1TiKj1Wp
	4+x3kmN4M3rNJ7gb6DYYq5auXCcLhKur5UUHqjFf4ptYCpiQ5ZjFKK7CUYVCJkI8S/luYPUWsXz
	uU7O5b/ridGem8kkmR3RU5Kg1UH2jvVg9DMsZHHMhifYzgLPtaB5UQGQFPEYxfoM0q4IKDS54si
	aeXYgPmdNSZerasOMBpJQKoZrqQxfcfKwvN556KCvMSTHe7MkIpP0xJzJkMVyRGedc8ck3+1EsX
	KZaYKvHkT8+b51DjhVHOB3/bgtA3VHpJUWotQWe2AIxXvIYgvOSL69roRHzF6iYpk7FzNjCloQI
	uiSDXxqrE8/eSaTtC6cMWZvjyzWO35ya+qAwQGu5ZNaLct7uRRjp2Q8nVkXXJSaoN5QhBUsw==
X-Received: by 2002:a05:6000:24c2:b0:46d:654:d1f1 with SMTP id ffacd0b85a97d-46dc1a91830mr10182515f8f.21.1782463117309;
        Fri, 26 Jun 2026 01:38:37 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee0189esm23876057f8f.9.2026.06.26.01.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:38:36 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Thompson <danielt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH v2 next] drivers/misc/kgdbts: Replace strlen() strcpy() pair with strscpy()
Date: Fri, 26 Jun 2026 09:38:21 +0100
Message-Id: <20260626083821.2981-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the result of strscpy() for the options overflow check,
if too long delete the config string.
Use two argument strscpy(config, kmessage) to ensure no overflow.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

v2: Note that an overlong config string gets deleted.

This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/misc/kgdbts.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
index 9d3218330f0a..2c8f10b8ac74 100644
--- a/drivers/misc/kgdbts.c
+++ b/drivers/misc/kgdbts.c
@@ -1069,11 +1069,10 @@ static void kgdbts_run_tests(void)
 
 static int __init kgdbts_option_setup(char *opt)
 {
-	if (strlen(opt) >= MAX_CONFIG_LEN) {
+	if (strscpy(config, opt) < 0) {
+		config[0] = 0;
 		printk(KERN_ERR "kgdbts: config string too long\n");
-		return 1;
 	}
-	strcpy(config, opt);
 	return 1;
 }
 
@@ -1144,7 +1143,7 @@ static int param_set_kgdbts_var(const char *kmessage,
 
 	/* Only copy in the string if the init function has not run yet */
 	if (configured < 0) {
-		strcpy(config, kmessage);
+		strscpy(config, kmessage);
 		return 0;
 	}
 
@@ -1153,7 +1152,7 @@ static int param_set_kgdbts_var(const char *kmessage,
 		return -EBUSY;
 	}
 
-	strcpy(config, kmessage);
+	strscpy(config, kmessage);
 	/* Chop out \n char as a result of echo */
 	if (len && config[len - 1] == '\n')
 		config[len - 1] = '\0';
-- 
2.39.5

