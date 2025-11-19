Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870C2F656A
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567125; cv=none; b=KMzh3PUYQsoggO8IazdrQ4N4BCmSmIhWzIxmBoBQt04j+mhJardN8Gbux0nH7D7SNgIehkotEPglDXV3bzVFXsZO844eVFIhJHjzJDuaKtsit2OtojkW05D1BCHd/xdyACone+kV8OcMrqX4xTjKTS9rA8FghOSBpVWB8J6yLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567125; c=relaxed/simple;
	bh=u6+tt3XawPHF2h0PehB6Hh7l1nZTQ0AU8uD6w2tCd9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efaSZsw03M7QJYG4o+ZECnrsfbyBUVpBKgY+2pX+TBNihyowJbfghoBxDtmKVhuUdOkH4XDhK9TLLJyxoq+aLCA0WcXbNK3hWjFdA7Y5xMOfzLetO+E2dZbSxowIlNv1j4t67Ij+FohZ6LReupQizYOfFrYUvwQ5DYzm5Hs6IXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5pyMbCL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5pyMbCL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3b29153fso3747587f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567120; x=1764171920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgUegTKLQ5c0JCFFEcjPGQkSMjLGl3oe1WVgssxW3WQ=;
        b=S5pyMbCLkC+99Hx1gcI70qTu4rEHdL33Myi9JVWNml9rEIK8AWQfKJChpsnOS0UXSD
         xT/grITh57yDq5oiBWFs9gcA/vwkvJvSVf3fFbGjJew9lJHf/W54qPdFGXHI27RSZ4As
         7wtTkt42jRzrr0w4QQR4QBSzJv4PWWykiLymHhJNfnm6CDzJ1dLWtfC3uBB9XM3mU1cK
         FOQ3ib967M/9a3nhOC8EWr6flSDFk6rCgVV1g9lIsY3rurcRSu3uOB6VQWjXNzku79Lo
         2U28dsxwUkHJs6xhLfM/kz7nq1RnfFvGWiLU3ZHW4hdsQr3pf70KGHr6ddavAO0o5uqe
         rwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567120; x=1764171920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IgUegTKLQ5c0JCFFEcjPGQkSMjLGl3oe1WVgssxW3WQ=;
        b=XBTEt2obdNJ7B2DOnq69bkK1LGMmUA/GAweTo2x24KiDK+AbGE7bIGJFQIGojHmwPf
         VfOlFfxHkC739zaqV9jYcPrKTorDqUZtlXDmDcR20IKBj/f31Ii+CCwnRHIgZwVldnaX
         o2K44FS54ijDE34v3qsAkoYJmFtz9H1jfFc7Ev0kb+A4zuSNueMg4lsvs4oUnmpKJiuf
         P9kzncYV1apaIeaWW+akf+IcSovjYQGvkGTcuqyqqenCjNv/uQT3ZkwEYWLPj2smVj7n
         Rj+hv0K+KHMsr+bWTt9NBxPnvxFriTXWsxB1xo8DjNbBk/26td4pXbvwOS04euKvykBZ
         2tiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ecGMDSUhOXMuOtcFjwE0GdS+2VQkCA5YAYZLZqcI9ndCx3zvLq5CnZK75oBkVxSIuxADfVwcmWRfC68atls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWytGexk/2syytgjN1wvw9BbrGucs8DWg0Eb9qUyeLKHfhb2iw
	0+llJtGvrOVbTXOZH2Xk6mDdHpobTm1bmx6/HLULj5nY9aMr+TKAIytcsprhR2xkWJULlFKrR56
	Gz1IcwbPLog==
X-Gm-Gg: ASbGncu5fhoid5MKbCmke3pFiu4CqNSE5QkJhWjuCUJ4LjT5QAoGALAs6QvDHVReTsy
	Fal/Qmo8yCowf+egJzK0ZIPWU86M1qqd+eihXxfLs4MUACj3UT79xHYC2C//wXmsM0PazAR6JZU
	Nb2Q6TuBV5t33hvJOMM1eZtDKmsn2U+ha/kaySQXqGAfVCutc7KK9aEx7A5KsEgJ217l4uvADO2
	Lq8m7yH9eyOywctnr9imtPhGaqnoYD+/5lwRb/4mDCqZSPcGcsjwJd+hdCtThtqzlnmAQkrtSrw
	y+/qmOWqnF/yICCQj1cJBRfpZMjvmga5WsRFRoCdq30BgrBfBukrsPkYZ3wwmFcf/GlOA9lJuyV
	5umfxrlxh5qyn598yUAjOEPsqoUEBCNq7LAO8ZIF5Voi40B6q788VwtI2M/IucJYSiWeXGmkU/G
	ZjbKdyWiRJ2pZzEYCS5FVGukxls7+/FylnlvM18O2L
X-Google-Smtp-Source: AGHT+IE38LHRCo1rRgXHbp1dPmtNTHQzc/1FY0jCSEqGBXN/4naA4QLiTpPfAdRH3ooZXhi3gOLsPg==
X-Received: by 2002:a05:6000:2087:b0:42b:3ab7:b8b8 with SMTP id ffacd0b85a97d-42cb1f5d859mr3485815f8f.25.1763567120163;
        Wed, 19 Nov 2025 07:45:20 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:19 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 02/26] init/version: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:03 +0200
Message-ID: <20251119154427.1033475-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into inspection table:
 - init_uts_ns
 - linux_banner

Information on these variables is stored into dedicated meminspect section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 init/version-timestamp.c | 3 +++
 init/version.c           | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index d071835121c2..6f920d0e1169 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/meminspect.h>
 
 struct uts_namespace init_uts_ns = {
 	.ns.ns_type = ns_common_type(&init_uts_ns),
@@ -29,3 +30,5 @@ struct uts_namespace init_uts_ns = {
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+
+MEMINSPECT_SIMPLE_ENTRY(linux_banner);
diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..eeb139236562 100644
--- a/init/version.c
+++ b/init/version.c
@@ -16,6 +16,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/proc_ns.h>
+#include <linux/meminspect.h>
 
 static int __init early_hostname(char *arg)
 {
@@ -51,4 +52,6 @@ const char linux_banner[] __weak;
 
 #include "version-timestamp.c"
 
+MEMINSPECT_SIMPLE_ENTRY(init_uts_ns);
+
 EXPORT_SYMBOL_GPL(init_uts_ns);
-- 
2.43.0

