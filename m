Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9662E1734
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365397; cv=none; b=uX6yFJU5IvYIQl+YMlyxlECRGvnkd828Das36J9c9nQRUQULQMQN8jn5xuCAsivmtOMJRkq5k9C75evymEM4mYN8UZpuZKlSJQz7Vyv/l9gol1vY+5D0I1i/LnXpfdW+6oFxPrvDkFpHOqeGfzBfm61jQflKyQnBiEB1NS4WVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365397; c=relaxed/simple;
	bh=YrGjiFMH/zlkC3aj1afXt5OiVcA/uj0LuVvyhAgKIeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG0V0I8moZcIvYGFutY9DbFzZO4Za747Uf7vQ9WeOi74UmdlBPs9z47FUK8t3oI4mNLA2w1ovzcDNSrBmbby1b5COQlZe0x8LJwtet3AKdXaZ+aoeqp3H2iFy0vk7gQ7mUIiTMlJaWwULTcyA8hRvMhvjZAtiD9Xd79tdFGIEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hL+cbu6y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL+cbu6y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561607166aso7021875e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365391; x=1753970191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFMrD7tjY0571sMCF+ur1VmM8eA36pvQygKXmIz05uw=;
        b=hL+cbu6yP6EjGyJww08MbKFjb+YHPqZ7YRN2X+iaJQSFXXSoejFtRUQUISGeGk3bnT
         l4Mf3gBSOeQVUcf3zkL0cuXVrR7T6m6I5BZmiqKv0e63ju/1voNOkmgIC5khxZFfZqcp
         6kMDmBdL5IZuYb0WxFzgvRnu3IMyj+HXD2LjI44tjwIJoOS/cZ8FclMf9WupAvrKNtza
         Mlx4V53ttJVOdBW+tWvRS2uZhgZ0UsJpdg+juC7/+pzmSFpUq2azjNcvDQmjqA0NuGng
         w7rYBsSgNtZJISnIcSBRNSMSguYIQCYYRDLA25r1LhK5sR2dkhetmsbw9M++vwI5m0vi
         syMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365391; x=1753970191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFMrD7tjY0571sMCF+ur1VmM8eA36pvQygKXmIz05uw=;
        b=ahRff1KpJk3damgD8zuF+s5O+H7njFR/3EWLzmJOx47HqeQdPIYWOuly6Uoqqa1Ew0
         mA4OsXY82+BvA0yDAmCxnezJ66L5sNFbhouuMjn3Y/c2liQ4rqCwxkLHv7CtiOCwbIDw
         sqY+krlvCF9n6sOiyxFmYxWr3fKU1rAyYCy2IUQR0XIPj1NBDsYrGiE5J4BJcLwVqkC4
         ftqINQLmtsqXzX9f6y5WNJePQ0hZZ3IfoCJ/JC9sqKXQ2bb0XV5MsCEoZ0JeahMSYCQm
         aN7J/1rLcCjQWJDd5j5FZ2Gmyv+LDj7xxSG6ZxzWpKqs6DQoAPMBed6tkHlomcbpegcR
         MwHw==
X-Forwarded-Encrypted: i=1; AJvYcCWmGBKpJ3k8kB8JCuCYDm/9HCPyOD/T50U9XcMrL8ICiu8/o4Dgfh/ShaGXxD6t3ioDbqxtHVwrex+qS94BZRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8bmC00KU4hgwlBcftu2KSVzN2AyA9eNLSNu1e5WPj4kG/2eZ
	QcmU37LZ/NqlclwQ6FBBeFoTtbVjVAHR1uI7tQESkQozTeQInsZCtF0CcfRBuVPahE4=
X-Gm-Gg: ASbGncv5/1JxzBefeC+8oc5wQaRssa61x+CC047ExTQzPBDVqMur8bWRf066CQ3kbyj
	z4+Z0CZ/7q1oH5xdXz/ss4+cwDbTxmHrMPLpZpOUYZG2h+KqFwPsmodIe7kHUmdWPy+dfmW0N/c
	icgqeaK0j8JafZEb0s2fL1rBUVjxCTRq/CF7NfL7ELwR1Hj7iVkaHqud2NWNCdX+v9ttlHsmN+u
	aedhjLLGKSiWMuKmj2kEZcDbkZJ14VLMZ4itVrBXhNsFQNRRFLwDSxxZgBlYJWDNeFZTQLxVxBB
	kyRbOzhx8Ef1hguFx/W3y7zUcyc0Ruk4ma1ftChFjAWl0UGPpNckg95CLcwuhtQ/rK5iZLLSYMs
	AJZTEOzwTAMwtqw4Qjps3wo2ybaVYOVjkNtjPQAU7U3stDY/GAVj4ng8MPrP6gB9VRTNukf42As
	UaszoIeqQ3XOVHs8VnjXUmwpk=
X-Google-Smtp-Source: AGHT+IHYV/rdyT8foqBo51VlSPNSFrqLVd1yTjWzm4T+7ubMqxXGaXLoYsD4QdIBTbjTZBYyuCKPkw==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr72372095e9.30.1753365391122;
        Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 10/29] panic: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:53 +0300
Message-ID: <20250724135512.518487-11-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - tainted_mask
 - taint_flags

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ccee04378d2e..fb561a2fdb59 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <linux/kmemdump.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -56,6 +57,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+KMEMDUMP_VAR_CORE(tainted_mask, sizeof(tainted_mask));
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -601,6 +603,8 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
+KMEMDUMP_VAR_CORE(taint_flags, sizeof(taint_flags));
+
 #undef TAINT_FLAG
 
 static void print_tainted_seq(struct seq_buf *s, bool verbose)
-- 
2.43.0

