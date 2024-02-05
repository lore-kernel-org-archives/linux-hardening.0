Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C4125CD
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123821; cv=none; b=JKNS2P5kxglk3tvzM1N5owPHbR6Xjo5LtyM20cGNKg/2ZnS5MTke9JdVKNwyw538hdtEqMeeoDpAOO3EHPaJv6CQLKpMKYrTA8lWHFtDXD1Kn2xnrHjBxdzZmn7BmfgMggK31y0T8zWoTwOvvfUquDWGIu+HF0xUodX7kgEYuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123821; c=relaxed/simple;
	bh=U0IaqYEgUxaoMI0fBY1yJtEGvGyAUmEfSrUJjZ33FhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nGP5wDtwvLdVn2FL4P/2ZeEm+TDFsNK6bq70oAXeCc57iZcbsaD1LZPO8IpX6kICjrrXaChOlQyJjFzobl4/G4tEwbnVZNENHT5U7Bjcpvs/qPzjTShDFgCY24m9AK1H/S7tSknYJElczJfrsLil2bcQURwq3ZrKAN4j9shM12U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LfMl7mV0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LfMl7mV0"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2969da3e5a7so525602a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 01:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707123818; x=1707728618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mp3IqjV4mL2aPdf1tPNFMiYIaoCwoYk+bStjGqy3K98=;
        b=LfMl7mV05OXLy6hdSSBGa9rHKUK/jsAX8o5IfHQCl1mdEtKDbm6Z5T3jVVJghz5dbJ
         +CriSBVvWW32W3arj2BnUeMTs5jBSS45N9M5oad/bOrG3V3jMe2EGbbc/Sdhz5f+XrEG
         ShelNW7TGkjJMhuhvHxsxLqWJViCklR00nN6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123818; x=1707728618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mp3IqjV4mL2aPdf1tPNFMiYIaoCwoYk+bStjGqy3K98=;
        b=RfrzdOCBr+/Z75ap7MYsQGweNo2JWJGst2MPRJxAHhBDIMWJvAA+bLEIdDyinmAfKn
         hjAhDCQoKYnnjjlltktR+75es7bCu2Mpjot/dmADUuZKs8M+nU+VojHvd72pwZ+YRYcr
         uQCrfJeCS3L7VgyQ+EGh9QnI4kahK2lp1AR78I97ZmphPdk3v/MYTGKKOwkdi862ZI8O
         walC8IKDw8ruqVKq9kQD3TqcIdaXC6ftKWvwrPIgCyeOxwkhUJIatPgBTGGDI0A5RD0C
         StjLzelgy/hhtlKeCxtWvcip+NvuArYUXSd+O2tZfRp3uY/PSAJ4Csn+2XUp9CaWcmbP
         T9ew==
X-Gm-Message-State: AOJu0YzzZ1d9vJLeWGjIJKROnyP2ioVO1kBnsGoI0wsJAbixHQfCKqOE
	2ZH50y2qcTT68TWWcoGcwpYZTpgD+miPk9zt0P8WYFuTWdFV1laDul5qwDU7AQ==
X-Google-Smtp-Source: AGHT+IFOv5sPhrdJJ3lg+vSR7bYP8rOWkFv6Ser6cZ9b6tmfqhaP5SyA0Q3Ijd/MMfpoJ5FObzPGTA==
X-Received: by 2002:a17:90a:b396:b0:293:ed23:c2da with SMTP id e22-20020a17090ab39600b00293ed23c2damr11932866pjr.31.1707123818477;
        Mon, 05 Feb 2024 01:03:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUq9BeWx1VsVS673oyYEwknMfep8C7cQ3JgH5JRfz2kue0NgAm6Ezy6xS+aPAzwHzBIfOvYupY+YZG4TU2fH6u0kOMtkwYhn9OUb6R2IcCXs1FgVW9F19ZiEZSpXoGqfFGjFt5Sja07XbhobA27GwasIa2kjhZhlHl2zDKLANllLbPrqbpQV5haY2lwjL0G2SksHjrUBDFrJRgj6l/2vDrVEHDXd0HN6G1rMiAbOQI=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020a17090a8d0b00b00296b50bb21asm145311pjo.27.2024.02.05.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:03:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] ubsan: Silence W=1 warnings in self-test
Date: Mon,  5 Feb 2024 01:03:33 -0800
Message-Id: <20240205090323.it.453-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=keescook@chromium.org;
 h=from:subject:message-id; bh=U0IaqYEgUxaoMI0fBY1yJtEGvGyAUmEfSrUJjZ33FhA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwKRliQJ3Zrj4Gq/zti8TCPet94FjB/Zy9OG7l
 x66V+/rIbWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcCkZQAKCRCJcvTf3G3A
 JjSgD/9lepgY25jHskT5SrVcPjJLGvkdPADYl6m4jH2xPgQDdn6CSFODj8EWE5GmvpcOVMJgwC6
 7jBV4u6voWcafB/4ANNf+bNgP+8EVId4RaGpxmP3NqGhVF4fstE6F2WdpdKdEfcVBoYKC4JrrxC
 CyxsVPhvzOOxjiUVPi29gpOw+DJ8Lak4MTF4GGb6UO7RqcW7xvWY6nmekydhfZog2Gg52Orl65q
 nrcUa0Gyn931e+soRLtInewzTR+nHwTrXHu6S/mQtqGh3+L5qxEPzjs/02+LBNSxH1Jm9cj2jWF
 xElVm8Bg4JY4jmMqErpWNhde0lL2VnZmEEk5kUp3qhEoXknvT+j+36gihOlLS2kz6PAoFX9Ejoc
 Ry1EFw5tQnArOVi+P4I2ykYbm6warowICK7N1POFwG0h4liJcjYdt/PuHZE6GRrqZlvabZIk3l5
 XxcDJZ4vRdIMs4+HyrMI9ucsvgqER2zSpjFrrowoHX+Uum2zrlLTeKDNfs6b+5gyn2WFx4Rudt4
 D9GvS1zUOt69boYoUR3nKDQBzlxFon520tI+qJgPQP13AYafZyVTAq4T6Cndf1lh/v79wZlG2NI
 jqpW/1XbdMw2wxFLNI5N5E/ybq5bUy9LGjrXv+I9ov+KKidB5mAc8ee0ulimvA6qOIRYZ2ujySl
 4U4UVfi GEUKzg2A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Silence a handful of W=1 warnings in the UBSan selftest, which set
variables without using them. For example:

   lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
     101 |         int val1 = 10;
         |             ^

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401310423.XpCIk6KO-lkp@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - add additional "volatile" annotations for potential future proofing (marco)
v1: https://lore.kernel.org/all/20240202094550.work.205-kees@kernel.org/
---
 lib/Makefile     | 1 +
 lib/test_ubsan.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..bc36a5c167db 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
 obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
+CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 2062be1f2e80..f4ee2484d4b5 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -23,8 +23,8 @@ static void test_ubsan_divrem_overflow(void)
 static void test_ubsan_shift_out_of_bounds(void)
 {
 	volatile int neg = -1, wrap = 4;
-	int val1 = 10;
-	int val2 = INT_MAX;
+	volatile int val1 = 10;
+	volatile int val2 = INT_MAX;
 
 	UBSAN_TEST(CONFIG_UBSAN_SHIFT, "negative exponent");
 	val1 <<= neg;
-- 
2.34.1

