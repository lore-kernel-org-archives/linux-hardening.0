Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB6190057
	for <linux-hardening@vger.kernel.org>; Wed,  5 Mar 2025 02:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141054; cv=none; b=IhkfWaLc4v77Jc8FZE3ozE5Jbq24QH9VBi1UJ3TdD9mNwtmbPsQSludKO7FVAPpY6mSj64Xb+9ZG35SpukuV7orPakahjW9U5C1KzGKxvA6CDxW0FnHiCmC6qo2VWUrC4Rqk1T7SWThz1z4chlm3ezhBgjiUehGVz6Ikh60loeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141054; c=relaxed/simple;
	bh=ML+ucgaM1zLS4gZ6mZ2KqV9AZU93TB/vBQnHE0rNQZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBuTm/MJ9zlyjYW58zydlPcBJnFtAOcmXbWoy3Qdw7jM81Xi9viFfdklzJN5MdecHgK68KB3KNxMRiaikuTf5yiSnHpC+SwF3SsouL7Af6tZf4CLvSfEzui5cK/VkVHt0MoyGCnPSTBUodkYjclE2X/KS50CZ6NSv2zYvx3JlOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PU8dIdgL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PU8dIdgL"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so974376a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 04 Mar 2025 18:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741141051; x=1741745851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9Nf9XNBMQ1NmHLDzzCeL0iA/og6eQYJ7zp4LTTGbqQ=;
        b=PU8dIdgLWMy28Gr0lDRmhvShPlTfvBkQsMo9FYlZv1lZ2v2kTufPhfyKvpfmK09Dpn
         yWKCdji0MhcCaVeXGfp8Mk1h1k+b98NABFzzft+82W3G/yNLNYfDaxaJxLi+l+OGTAhA
         pG/irDIpNqeeaYxQiqvg6U4CbpQgv2ZUELX9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741141051; x=1741745851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9Nf9XNBMQ1NmHLDzzCeL0iA/og6eQYJ7zp4LTTGbqQ=;
        b=OaUBjAOXhogsJhBpc+JOGDaH3XnxpG1c3kzwDcFh14uEc16EGFKlbfRKAicCK0z5/G
         2435kMV1p2AwqMvEYDaXkIvcX/Tg/P/ccJymVFaQ1trtSgyOV+6djZK3ssrUMcsMwA2C
         3AQQBpB+472iktUyiNb8ZkqirEJXSKXMuXuF58QoD0IagsRlef8eE37w9NXo5SAhsjU0
         o02u9TSewbCzRpXfC2pZ3FykCOvIcbt8pm968QawGQprq8dA6okXIvbwLGuD9yvufhcR
         GA/gvfJ8Hi//7U4gusm8UthEerqVFoM9YnZ06MUPzj4bMdCWKxzitfqCevA9f4a0warS
         Q3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFIylxh5/fuy8V9e6mj0WhwWGpEOPxjirhOQKcLEowun6CTYmN3j+L3QZK2y38IvoBnlGtprUHuHS4z4+J8pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyArG5Lcta9v5VoYJ8uw7/X4m6Yk3w4hyhFh0Nb2I8RcRdBAYZH
	vZs/rjFp2IEib5DpGq7OUUh48ec4CHMi4vAHpxfMr3jUte/W0g/CFOap+R1bdw==
X-Gm-Gg: ASbGncuBvugEe7SwcWUSISpt8JG92EiEgbf+L8uX/BUk6BV8epoaIrR1F60fBwh+62W
	9ag3Hx5Qg3EcG6sXkLkypjGFp8McPqqqIRdQFxZiOeVeWCnm8C6E6cMkyGhmgSAbJMtuWpfktmn
	E5ZJXrgSPiBZ3JoNSffpCZIgLyCbxeseW3Gn7hk8sCDDtuLiYm4ScziedVnUEQDKEhb3NuzVLXa
	O4qQplKg7qq0+JhnD60ssuzf74HkhZDXDQTtTseWCmcuAQA7eG8TD/o5rKrtsD6riTj22YcYBPn
	Qc+y7iDfguiABVZMQXK38TgB3fa38yORtC873bIpTPZbfGE8VJ5ZoFvxUy5DtFO4NomBM8GXLUF
	i
X-Google-Smtp-Source: AGHT+IGXOInOt+Os5+KEs9jkrygME+p8EJ7lyp4fBieT6azksEXHSkiN9x/wGTG7JxavxNz91t/jFg==
X-Received: by 2002:a05:6402:34c2:b0:5de:a752:3c6a with SMTP id 4fb4d7f45d1cf-5e59f47072dmr442395a12.6.1741141050866;
        Tue, 04 Mar 2025 18:17:30 -0800 (PST)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a55besm8891211a12.72.2025.03.04.18.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 18:17:29 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v9 6/7] mseal sysmap: update mseal.rst
Date: Wed,  5 Mar 2025 02:17:10 +0000
Message-ID: <20250305021711.3867874-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250305021711.3867874-1-jeffxu@google.com>
References: <20250305021711.3867874-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Update memory sealing documentation to include details about system
mappings.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 Documentation/userspace-api/mseal.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
index 41102f74c5e2..56aee46a9307 100644
--- a/Documentation/userspace-api/mseal.rst
+++ b/Documentation/userspace-api/mseal.rst
@@ -130,6 +130,26 @@ Use cases
 
 - Chrome browser: protect some security sensitive data structures.
 
+- System mappings:
+  The system mappings are created by the kernel and includes vdso, vvar,
+  vvar_vclock, vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
+
+  Those system mappings are readonly only or execute only, memory sealing can
+  protect them from ever changing to writable or unmmap/remapped as different
+  attributes. This is useful to mitigate memory corruption issues where a
+  corrupted pointer is passed to a memory management system.
+
+  If supported by an architecture (CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS),
+  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
+  architecture.
+
+  The following architectures currently support this feature: x86-64 and arm64.
+
+  WARNING: This feature breaks programs which rely on relocating
+  or unmapping system mappings. Known broken software at the time
+  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
+  this config can't be enabled universally.
+
 When not to use mseal
 =====================
 Applications can apply sealing to any virtual memory region from userspace,
-- 
2.48.1.711.g2feabab25a-goog

