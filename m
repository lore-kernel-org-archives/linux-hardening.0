Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B7E1386BC
	for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026527; cv=none; b=FHivq6uYbOxax3oeA3cWLx8etzYLpoUJX2b4riNm53BzCXsgmPG9wQz/xRkeJPw7CNTilLxzSz47TYCJQufKznlbJM7NulpyV5OzjyK1SUh+hti/Lbmzu7meaw0RuaSM73TAiNHywvgLg//wmHbTrexP7pnZD2co3tHGTENdVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026527; c=relaxed/simple;
	bh=A5PjOGMPXIrdqCLXYAaU3KmDy3tgFDmnsiE7yKFkflo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLq/pT52UaV8qzTD1Dvaf5zeTNgf+vRI0A7sTcqfTtlM2iWq/7J/BlicXPpDboLFqwNCIk8YWK2gXfSjnaCgCFSipoMCwa4uc9JYhM65xcCQ2WYhh4aK98Rx7p92egc/n3pReXqHhI5lRqMoffQtmjV2CJ/g+wpe0h39Vb34TmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cAtzLz1Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cAtzLz1Q"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1044691b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 15 Feb 2024 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708026525; x=1708631325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QIYw7eSbWLV7XoUbQKHEdm790KcZl0MNKg+/VA8SNvQ=;
        b=cAtzLz1QnqsETTFd67zjJoXhNUQc0Tx2YeipAMbezBs45EEg+KlqRyuBJV/c8pyLn1
         6whPDV+zCF5g13af5WtjC0OAaC0vEOUfzoM1+HeSbs/JhTONqFLF4MivgsE0GqC7AKzv
         vCbPXht+i0MfaC9Cu2x5EUofrTrnVaN9H74GM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026525; x=1708631325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIYw7eSbWLV7XoUbQKHEdm790KcZl0MNKg+/VA8SNvQ=;
        b=e6CXwhYI9hkWzGWuMCBXbgxZ8+LIvziw5ipI6WQ3K1EVNNHnTE9G871IQ6Udjq3DKL
         VgONok+Z+0wVU45Gl2/hCo7sfCX8rmPge82IZzTkoUpAXPgXeuLGVGlR90pUNh7A9gpT
         zOrj0CfaiVT4vTd2hJoY5SQRvQXtYAlXRAIOp5Ckw7BhHcFY9jcBLUv3VVcFZj0En3KY
         3VPjZZskfk6E5HjpbsBIjSd/q4ZcTeX6difDtfS3lIHeYyjgXaHWQu9o5hOXSce6/NhK
         3gvxVTrMq08Ih2qSnh/65P6/geYiduNLQdm7oWcW69D2bH+8mP3PJYm7R4NikWsIYKy3
         7X1w==
X-Forwarded-Encrypted: i=1; AJvYcCX9/X7kKVAFDyz0PbXc8D9Gpgy57vGk6cPv59nnF7s9Tt5G7XLlISzUsBcZCDQP6xzmD71SqLTL/+aIVgU4ztkz2IFpkfz+vSb486oNOUr6
X-Gm-Message-State: AOJu0YztsEkCnUCldcwrLuAl+YXvq9aNnmuUGsbtfnEa/H96WAHmbiO2
	AdbB5zzjPquE/dk0SZ+wCfeUY+jIgPVSaoF24otSxpyE77AENsTW0Nu8YQajPw==
X-Google-Smtp-Source: AGHT+IEM+StosCqZ55sygRnsnsOd8RG91kej8rW/CYhQnz564dOpCtuBK4/olP1fc7zPiVUQ1amuwg==
X-Received: by 2002:a05:6a00:cd1:b0:6e0:540e:bf43 with SMTP id b17-20020a056a000cd100b006e0540ebf43mr3746595pfv.33.1708026524790;
        Thu, 15 Feb 2024 11:48:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb6-20020a056a002d8600b006e06b8548c3sm1716126pfb.139.2024.02.15.11.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:48:44 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] cocci: Add rules to find str_plural() replacements
Date: Thu, 15 Feb 2024 11:48:38 -0800
Message-Id: <20240215194834.it.509-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=keescook@chromium.org;
 h=from:subject:message-id; bh=A5PjOGMPXIrdqCLXYAaU3KmDy3tgFDmnsiE7yKFkflo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzmqV+0wutn9XyekUmyiDf5ZhU6fAehM/QsZ3A
 6Ynpnw+na+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc5qlQAKCRCJcvTf3G3A
 JqZXD/4puC6/Pv7aBKVlPmGek/tSw3eiITHz9KDqi4WWlX3vQqItXAQeju8KfX9dY1a0ahQP91u
 Rc7URV4jgOwyP8AWCvYKhgdVRL2NmKVYyzUuNm2O/599sTf5BqQdGkMHyAig/6GCb8SE2ZVs0E/
 7/2TIwUR4QkGnaS5hE6KMPCG5ai+2YWsNR8hXj4G/5YAMlGG71i/1xhu1A+8TyAAY6zHaQI3kRQ
 RbOf+1OGpnP8/PZtyGqvdsc1FgcEY0AeZ3i0zIlPKrPcpqiV2cJDf+APwO7cZkmeGGNaGpvs59b
 vUy65MOpZPsaa4Jehgw4OM5bO43Q6qjSSc1F85B9FIH/eUqs+aoT99WNZUzNVTXQevXhmjOobE8
 oVXcvqZG1hTp6q1xzSR2nK9qh8ddAniyED9xviF+U5x1M6+f3Y+de9b7tTPymr2aes3JBOp7qST
 5dSXbDhJ7VTRKmdYgQPdRc1ZswTprEB003W7km5oJwXQQJKw2EDTwTiTfsMJazs2c/jHpdL8AA8
 9/gUWv/qO7JcmpnmYZhLj6Yh2MqtbaFePZwPr4zkfqClxF+qjub6zLf104ugFgN7yzNWjgBCORX
 KVMeq8/ieRKOPl3suLvgefRMKEDUQn8lMrDceiDLIX4Y8r7v7A9QICq3rAaSYpqDZRDqF6/6O1S
 FqcHgwm 3KrGcs+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add rules for finding places where str_plural() can be used. This
currently finds:
 54 files changed, 62 insertions(+), 61 deletions(-)

Co-developed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://lore.kernel.org/all/fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
---
 MAINTAINERS                                 |  1 +
 scripts/coccinelle/api/string_choices.cocci | 41 +++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 scripts/coccinelle/api/string_choices.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index d0df728734c1..216d02a3fed5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8979,6 +8979,7 @@ F:	lib/string.c
 F:	lib/string_helpers.c
 F:	lib/test-string_helpers.c
 F:	lib/test_string.c
+F:	scripts/coccinelle/api/string_choices.cocci
 
 GENERIC UIO DRIVER FOR PCI DEVICES
 M:	"Michael S. Tsirkin" <mst@redhat.com>
diff --git a/scripts/coccinelle/api/string_choices.cocci b/scripts/coccinelle/api/string_choices.cocci
new file mode 100644
index 000000000000..a71966c0494e
--- /dev/null
+++ b/scripts/coccinelle/api/string_choices.cocci
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Find places to use string_choices.h's various helpers.
+//
+// Confidence: Medium
+// Options: --no-includes --include-headers
+virtual patch
+virtual context
+virtual report
+
+@str_plural depends on patch@
+expression E;
+@@
+(
+-	((E == 1) ? "" : "s")
++	str_plural(E)
+|
+-	((E != 1) ? "s" : "")
++	str_plural(E)
+|
+-	((E > 1) ? "s" : "")
++	str_plural(E)
+)
+
+@str_plural_r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*	((E@P == 1) ? "" : "s")
+|
+*	((E@P != 1) ? "s" : "")
+|
+*	((E@P > 1) ? "s" : "")
+)
+
+@script:python depends on report@
+p << str_plural_r.P;
+e << str_plural_r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
-- 
2.34.1

