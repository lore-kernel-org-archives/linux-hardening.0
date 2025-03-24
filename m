Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67914261392
	for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829348; cv=none; b=jL0RL0nHxPQPfAvcu5IPKqHA+uTUx5gXLaRVg3ZFx+TxFv2RnpKm/AGo/doWp09SJBLZIKhFfBbQLuuSfUyDE4Q2Xu7GDQQQXk3lV2EiTalVw6wTXRIeDDL0zqXcp5+5p6HcJDVkYU6bGbbMAstkHvFZ4rx1QB24cXcCK3DI0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829348; c=relaxed/simple;
	bh=R9p4HopsfUp3wpovdf/h1JN6c0xM35xOI/JSZ+P4yMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEWWEtizEWUMrX2Sm1QbgnPDS30Dm0vu0dx1iSIdAfFxW7SZiEuI6ki/U8ul+lytYLB/eKMcU99Q7Ixw4i9dWFTcdYBrI7uwDj/8UV+Papn+/723CsqiDMqNy2yQQWD/YEXtm8uz401YWCeYvdVSyG35uYQT7kAc9OnQAX4rWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CoS+TXhR; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CoS+TXhR"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e68e0290a2so812355a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742829343; x=1743434143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7obI0LNNDPiSwITZnRWtGg2CX+MRFMK+Uou8aGQuCw4=;
        b=CoS+TXhRdzkF91p/nlsHD0+DUaTaZ5Kw1vVWprtUYA0eEX9bnS9QoIpga+w/60Cc+u
         +zYFW4VlaAApSuKRq7MBij9TWWGHOteyiTAOoYeS2NdGvlXw9wRgJYTnd3940cdxaK9Q
         HV15jSynuDUfShtCSZViuWEVIvdCubhYtPIng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829343; x=1743434143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7obI0LNNDPiSwITZnRWtGg2CX+MRFMK+Uou8aGQuCw4=;
        b=HPe58PfL5WXbmo32x8OIyGNMgC/vQndqo0kiWXY85iq78a/Pe7hOzcUxYzDaPxeYg8
         ivtECaKOMjmb3Fr/EeN6RuMWRsdtfBYtMxIZNJWcOVWm4NXT8XDaOz6zeIUDn/PI6Tq6
         8J31HAMOfk8KUC2+XHKkpQNiwXLiA0FsHdFlfy0v/0tmHbJppVMKGj2AgCYD2uExwYD4
         y/XMvYS47E0yHrg3s54pCIEq4Ddj+zgF6scB9oZAbGi19wGq0w1gyftWGROzk1w3Ak7u
         iM1DAeIEk2rRun0ZdtE/ytuYaD7A6NYcpMVDv7RZARNCBwyxm3iqFuVln+tmaxWOfDsF
         zE/w==
X-Forwarded-Encrypted: i=1; AJvYcCUCDsRU3bA/cjkyMLtcqV6GEKoVF0w1k79kLdU+TpUeRMPKAwCXbEl8NLbQgHVeFZGI0x6UIHJrVO9ydLO723Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNXhfKbOst+MdrnSrNm2gAFxRl57bmFSrWyekibJIT6YZpkaDY
	jfPaJCsptkN9+G2qC1YwBlJQSydON2mQvTB2ZdbY3W7GmsZPGE04GGGtNpb5kw==
X-Gm-Gg: ASbGncupFbHoHgAy+ft/5fo1nbyjti3SBEzeQsjWnV31bdGpsYbNDUBEcFY6CA6FZGK
	hTneOsbwhVjWBJrcxkxjkASBT97Z4f18VZMr+Ianq4feSjNW/nfS3j+7RCZYHyyZDelwf0gTJz6
	JYnG14+joTeL7ZTbmk4+E+E1icRp4z3fcOecPDLPcoranIFfQn74kSss7wo/kTIKSVpAycsSwa7
	XDbCSZA1DpNWkZc69KWy140qDE3G5TRLghvtWc8bpMEPl6pA2tIwzm1AiuB/pslx9sLCjzA5wth
	LDr/c07jQZkFPGWv4/V5Hrw3D3RIEynr0pHo/fruGFn7TmOTG7sVXxIWu4kDnksGlLlqNtFmIGV
	V/FQesJ/A5xQ=
X-Google-Smtp-Source: AGHT+IF6vjRW4hwldbWDEgvxc9zWWSrLi5hTa/SgxyA9/Gh5lCSQxVCvgMmxMlKBxhqC0vvdkUQkQw==
X-Received: by 2002:a17:907:7212:b0:ac2:6d40:1307 with SMTP id a640c23a62f3a-ac3f267549emr507917166b.13.1742829342589;
        Mon, 24 Mar 2025 08:15:42 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d39basm689698466b.44.2025.03.24.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:15:42 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	edumazet@google.com,
	geert@linux-m68k.org,
	gor@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	m-malladi@ti.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 1/1] mseal sysmap: add arch-support txt
Date: Mon, 24 Mar 2025 15:15:37 +0000
Message-ID: <20250324151537.1106542-2-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250324151537.1106542-1-jeffxu@google.com>
References: <20250324151537.1106542-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

N/A: the arch is 32bits only and mseal is not supported in 32 bits,
     therefore N/A (until mseal is available in 32 bits kernel).

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
new file mode 100644
index 000000000000..c6cab9760d57
--- /dev/null
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -0,0 +1,30 @@
+#
+# Feature name:          mseal-system-mappings
+#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+#         description:   arch supports mseal system mappings
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: |  N/A |
+    |         arm: |  N/A |
+    |       arm64: |  ok  |
+    |        csky: |  N/A |
+    |     hexagon: |  N/A |
+    |   loongarch: | TODO |
+    |        m68k: |  N/A |
+    |  microblaze: |  N/A |
+    |        mips: | TODO |
+    |       nios2: |  N/A |
+    |    openrisc: |  N/A |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: |  N/A |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: |  N/A |
+    -----------------------
-- 
2.49.0.395.g12beb8f557-goog

