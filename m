Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09B036C0D0
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567150; cv=none; b=fZSwPpHbtq2EZlU5h5bZ+eQCSCBeW8RyP4MHhXm25MOk5SJ4afKxjprrf988U00CAxP3n3qOVML+NQKjNsKF/flo1MOUi/XQ51M6PyzjJUqL2iOL0VYksnNDVlAzPkqyX48lA3QWIl7xnGN0QcJVnuw3+YNWZmEmFog19U1E9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567150; c=relaxed/simple;
	bh=oxMJ7nEx298nSQNAUvIm+RfzZDeUkq7JnffHAGnHY2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJNLIvBo2cp/ljCuWZ3Ore97r2Rq2ggYIkYeMp+uqiUOB5XQpHFPVfoZMl4KhpS0s5iDTs+AVv7COqwtTPVaPkeqC9jBMS2oDIO3hcEmNP9gW48S6DWDwP1LgejrmK4i1RmRQPz49Z4zBPJNFfveiy8yDdlJFrflaL2L5e0QRJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsCbIJad; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsCbIJad"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32a5494dso4138953f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567141; x=1764171941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERGSngcgAQCpMTKH+vT5ZfmIUQiWuwubvJ1CKsgHOkU=;
        b=FsCbIJadiUYCr6ejMirqwdULle+dFIB303mznY92UxGov8aRpXM1+QZ0YZAJZUD4WL
         dEklnlMCpvxXLYdxfYsOMAAtdJ7Y89yogdYrFJamQiRz30daYx5LMFbN32HWiJubddSV
         yKSmzvQbxm0kZ9/kKiXGX8ElkghkgmgldHj7ofdE/8tU2HEt33UbAYAY1F3di2i4/P0U
         23nzNwXa9vf8tpAXj4yyp7i95O+QXZpgrtz3n/IVl1PCKWqIBOzKJ876OYZYt+aiyuMe
         u+98CAqWIInRKYI88txn1aq/8lAHBVFah13SAXvoapuq9p6LywhU7eCXy7B7xaClvy7C
         x/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567141; x=1764171941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERGSngcgAQCpMTKH+vT5ZfmIUQiWuwubvJ1CKsgHOkU=;
        b=tP1kLwAIJCvhbtCQGennsDDN5r/62gZ+n8hsm53heCGyR2Z6kXgLEdeo+EbspAahJJ
         iemBWGXPxKrPS9Rhaf6HBjkSenR53dPODJVzUhOukiJX39P1xjkNGrAoD/ZYnqvQRtpA
         AuEYKOzbdafVaiFo2jgrAWrTcpXSfKc3J4juoeL8RdW7JRmXRMH2pWWwa+8har/dR2mA
         1xmIxjFCDScvgWS0HjWyVi58I06/+iYFrD/QRGuuz6CQS5hN66o+QdutGgd/R82142ys
         /3gwbMsxb7zTQfx6toyOgzpjEqURqpx/U9jTLUgrzolA9Kzh3aEIi5+6b2y7oiW78sGw
         zzUg==
X-Forwarded-Encrypted: i=1; AJvYcCVpQNcaTcz9hCCdSVoxsat/KxPYBCr//deBeD5K6K/BmC0plRrAKN9Q2N5MNeGsFUDj8+j7gY7SUxnA0REjYTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoBTGx/tuT3hYiMPPLnK0jwxAq7qpYye7r6MXXemEddpKN5LX3
	RGNdddaIAdrUGnxhaA7MTixwzmzo7kyd5DpvShv2xiA+Qyp+7QhMRePOqkbVe2jtpHI=
X-Gm-Gg: ASbGncv26REQyqQpkjzM0sKZ1iAK4d+Vacgg84oAHv3gSn3xQlR/VOxmgQ30jwWn4Fd
	MtJuqtrbohR676ef+hR9tOcVHd16u1hNbLUVjcGaMC65YzjK93ZfKmYWp55iX84S715d1s/Uiph
	zgGwEiJoQ0VjVLvH6B2nyo2T3Ht+txZYIHhvv8iOgmiXoYFjWu89YIA2Bnhv28aTrup5q4eeozb
	IQ3fQfvCAMLEm0y4pw1NyeZJCbIGIAQcTbU2YjiDvMSBC0mczyHXFf8NEwQ8o2s88tawhyA1YrF
	hmH3g9KKob6MAIFaP90NPytRBW+EXPtB/z0OdP37kFN5CRTFxjdHuQNDvmsNtEftu4QQBmLu5p8
	uDw10AMk8e5F+B22aUyuB8OPJ7Bi5ojrRuGZkLffeiS8RHLfM9R9ICnGk3woM5wygEZfJHqP6Zh
	UprtPU7+eylCEGIBBXBYDtmFhRUzhb0A==
X-Google-Smtp-Source: AGHT+IGbRbXBdWPtS8s2pezZSC/ny/HyWuyG8gk1o+dQWRtSU7DtMYRlEtgHBlikDrn4myL+c90Kfw==
X-Received: by 2002:a05:6000:2410:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42cb1f9e99amr2655929f8f.30.1763567141134;
        Wed, 19 Nov 2025 07:45:41 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:40 -0800 (PST)
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
Subject: [PATCH 14/26] panic: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:15 +0200
Message-ID: <20251119154427.1033475-15-eugen.hristev@linaro.org>
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
 - tainted_mask
 - taint_flags

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 24cc3eec1805..e99539e18054 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/seq_buf.h>
 #include <linux/sys_info.h>
+#include <linux/meminspect.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -56,6 +57,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = IS_ENABLED(CONFIG_PANIC_ON_OOPS);
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+MEMINSPECT_SIMPLE_ENTRY(tainted_mask);
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -662,6 +664,8 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
+MEMINSPECT_SIMPLE_ENTRY(taint_flags);
+
 #undef TAINT_FLAG
 
 static void print_tainted_seq(struct seq_buf *s, bool verbose)
-- 
2.43.0

