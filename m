Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8E32252C
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689845; cv=none; b=OlMEr2uS+2zViLq91CODuYLXBbYjsuMvvaIA8hptStk6t/POPeY2/2k906EmR4k5h7UOe7zvhWAXXzyA0sWTq032iveEequ8hEslzX5auB3w4C4hosiC7MCdUxwFoKUQAEtzWrprUlpXfHTJKtXwFuswbVYgzK2CGdEHgGFVVEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689845; c=relaxed/simple;
	bh=6AaRzfJC4rwBpQMEKbO3OuuO8jZlJG6Q3ebKObOQ6ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBlBEDnTT2VY2YyQJpuALW5uxNpCkZUwV/dc7hCwIHpGsnMdJVo0z6o+CgDbBAdldvuj37ergO1xA6FNZ57ig0Dm8yed6zt97YTBvQcRm9x2nRhp8dEYEMrDmKDJfToIGbtOM+bJVuFHQoYAJUPwIeRzGsjBcFRpIzuqB6eEQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAEbFTKE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAEbFTKE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603b60cbso18644987b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689842; x=1758294642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGwNZTJUDbb42i0I/DCBOpee9BSl0Ek2gmsDPeJY6Qk=;
        b=QAEbFTKE3Is1fpN4DN352x4/uB/fuDeyg8Xhor65IPIkwk0uDjgCQ6Jh2BYx/AUUod
         IeiEckAQTr5gy9kRRfDPj4lGzKnQkeqqGzlUcwj+oYonAfewd2XF4ogfR0xVk/OPy9C9
         LT7VwTO/Hjy/zj12qr0uZvdfyDnKbBcVMr6e16LVaDQXKbTRVn4bo8cpbVWFABid7tal
         Z38O30igG7fjNVVZjfWLpqSfCp4BiUwK0lX8sTxbecKmUdfZzFE+gm8f0YAthKTVlsXL
         fAqvi8tPKPs5u2+qlxNSyZlz9K4y6cZ/D3hlx2tT9AUjf0QMHYRwEeB5oepeHFRa+N7p
         dR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689842; x=1758294642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGwNZTJUDbb42i0I/DCBOpee9BSl0Ek2gmsDPeJY6Qk=;
        b=DU4kwHUHRcLEAqja4yZMqmMU48xNa35edNX3ssmHl7v6Yq0F0Z+qoNoGg0iNTxnRX+
         vxlYo/j4wo0TkeOuJoG67Us/axvezXjjOvltYHdwXqGnjqKhbvqOv9yDWayBwMPyiHP+
         ev5CdmA28QiQB8zb7Svu495Q49WT4OlO5BSM+4Cb75xXluEVs53465Fzfe8vShpkhBWW
         CQFh0j8sisdm6kvZZos+qlSCUyXe2RsMGRJSdPv9XPGZeBUTcII1cOBg/ADPZGWUKmya
         ZuR2+ZVebpzjTJgT0O3PC7sP4EbaZdkDCeqCAnOsW6tt3J0Df0MVMDjheGu21P4NKy4+
         n7/g==
X-Forwarded-Encrypted: i=1; AJvYcCUzfyASgwYwjYw7MkKzlA2ODIO8O9WAXyxFRtowdHRHL/jjkMwiXKYVm/uGZfB7OAA9EQ8QSY4yR/crktAzMUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykHrxQ7VQXqyehayH3U7HJMna96J5lPiwEXYYdcloTzf/W5Zw
	Yb3FqCyUJvB2cz6D1Fi+8MqCnnzmn3VHaVv1YsrNEuao2lG4XT6GpSjh7AAkruAvIR0=
X-Gm-Gg: ASbGnctiMOtm4AFtIqQyW1ccmOn9PkTqkrEc8WSq0vrbmjaHON6rBluBMrfiSeO38E5
	zLu+xtpd5K5XQGSweNtZr1FjvdlJU5RFWsqNAGCbuPii/s3WGNTkWUXGwqy8jxy9bMbthwKhrsd
	9DTXUTQqVByh/O+fAMa+Ruvz2oHkQ9mYLdfOmaK66pm1eNlWUcPT1vZJDGVHlTUjRke6iwGL2hC
	OVayavDrQLCPhV1LHYpVw2haf/p66OOcjOGAGViu3yJhmCgKRe+Rk1LJO6iNEw+c/IXkZISpBXR
	haLcUj7NcS0uelNczxHvrVD7p9ofWEI1zmU5j8Gsoe61VVJT3xCZU+tbxLtRQvihzgguygIHtMG
	HcEl+ckbmNgGHqgoH87SlYFYBaOyDz6szVnfr9V/Xunmo
X-Google-Smtp-Source: AGHT+IGd4PoJfw4tH37hzUk6PYKHbfiAkto5gdK9xgc2f3TOFApwMRiD1EpUFg4A8D8xg0pKJaYxEg==
X-Received: by 2002:a05:690c:f93:b0:71f:efa8:5881 with SMTP id 00721157ae682-730652db42amr34340137b3.30.1757689841832;
        Fri, 12 Sep 2025 08:10:41 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:41 -0700 (PDT)
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
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 10/16] panic: Have tainted_mask as non-static
Date: Fri, 12 Sep 2025 18:08:49 +0300
Message-ID: <20250912150855.2901211-11-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tainted_mask is required for debugging the kernel, and needs to be
accessible for kmemdump into vmcoreinfo.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/panic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index d9c7cd09aeb9..048c33dab98a 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -54,7 +54,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 #endif /* CONFIG_SMP */
 
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
-static unsigned long tainted_mask =
+unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
 static int pause_on_oops;
 static int pause_on_oops_flag;
-- 
2.43.0

