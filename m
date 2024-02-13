Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFC629E7
	for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707862265; cv=none; b=JCF/B6P6ynNwxP9gw68AmSdzo2P9kGubUfK1vlfc7JOH6aG9awZiZ/XUFtveORhlW/YwpUxoB76fKX0cydSOTAHt7hmEH8urV2fgGD+TzWazn9cmKVkdLDNopbC2lToASN+3cNwTtQAAnO8YN6kv+3rde4W7UYjU5REk2vN5xg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707862265; c=relaxed/simple;
	bh=gk9Sm9RrNWP7qFVWwHlEux51dUehEpnRcBtAM29pgs4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pS3MPwNf3V7WSltzTMYlvHQ1w+JWai5kdnbO3fylOSLsH9nzgw/lHgmsH2sd3yuLZLNKB+ALiky5TD6B9nLIuTfkhfNgvXHkxYd2wYZVa5daWEc3WsAIDCumd+O683L6D+lLxFy0/Y30yGLmrgwTzpd8RtpdXeZbyfArXP51ZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L6j3IBWe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L6j3IBWe"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d953fa3286so37981975ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 14:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707862262; x=1708467062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/l7cYejTBwG/ZbXfVuNOUK+p83wyeqabIOdAUG0DV4=;
        b=L6j3IBWef2o6ehNBNeBtrHiATS/+L4t2oXT0QZo3mDE0j6FGufyPLphJC3RAvJWuhD
         6gjgAFNq3eTJV8tC+Dgtu+jKjVwQU8pbGa9lOcBewVPo7vunEbV9MG7/S/qwzx2/2UTb
         A7lpTW6H0Smmrz4guT9sAWiwm/8qPipmTpXrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707862262; x=1708467062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/l7cYejTBwG/ZbXfVuNOUK+p83wyeqabIOdAUG0DV4=;
        b=oLlC/2TskW4uZPnvap0juRGcjzVBGsoyzMbvQbjYpepiczrcEEhYgJzKemKZFrqshU
         eP/QJI3n3moS8KPrWcNYuF2rPd/RrjrMUh7WKM2km+f4omRpYgZ0UD4nTYq+GWl3OI3C
         h2QSzEeLUHwIO+v0J2gzGZhcLlyYGjw14GbVvNimVovZpkXK65y4pVztP4vP384E3Kgp
         DHswmeFxGsGxkGSr17eGBL90QAZ9vET2YLtA5EzuTDePU5W9HaICwqb9Hzh1bdBb5nkX
         3LLWXwhxXyxQkLku3PXvWMHDSadDOB4KoYPhjFNdIWoCXwinNnDYgNQMh7/FXGCVwSPq
         5ohQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/n0HMsjxNvsuEKN5PjbrqGwl3Dlr0xZeEat3GtCg+q+eIDOjI9FWQItn073/oVaj6VoknpjMRUnE7lX5xCFCBZb8wXDPkYNw6JWFVIBMt
X-Gm-Message-State: AOJu0Yz6sm55JOKOuKlNfsrSjwh1+AvskJ4rll1NGG7pnWypMDz8v+06
	FP/C12aUtECpMMljR1tF6ZkC+6tB+IhYaG3SMXscH7/B4lcSCMnVoXak4yOXqQ==
X-Google-Smtp-Source: AGHT+IGscCU141CmwJ2WYvkJl7vsKDQXUtAWyU4SDUKZc2g1xeH1JVOVpz19E/aw39LMpLEKmeO4fw==
X-Received: by 2002:a17:903:280b:b0:1d9:a4ec:c5b2 with SMTP id kp11-20020a170903280b00b001d9a4ecc5b2mr775828plb.48.1707862262652;
        Tue, 13 Feb 2024 14:11:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtoxK5uvAlsQt2axOXVYoFte05bc2pnd1mWStQ74cxgrpyY7px//7+H1hDsFtVk4D4PiphUeDXk/DmNqffhGRz9g/4wIj3lsU4f8eqVRGIkYfP5wWMybFBecEMONYfIVdn1VlZIJ+/Fhl2eUSaaUStMU0TisdvdRpPo159ASIR64ymwCvionKnMl3yIAep+On4dWq2sRY2CxfIgkgniuXW8jBWGloPXopzP7RwVoATJQToHDvfIzBGqltODSzuPtkr/0mv2iNROiLD2Ba6VuYUZcnGsqZjJnBuODvG24B6MV3Nqy6WbYUGfZXmDoLtVuibWaD7d+49wg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b001d7222d8caasm2508776plg.50.2024.02.13.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:11:01 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v6 0/3] overflow: Introduce wrapping helpers
Date: Tue, 13 Feb 2024 14:10:56 -0800
Message-Id: <20240213220844.it.345-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=keescook@chromium.org;
 h=from:subject:message-id; bh=gk9Sm9RrNWP7qFVWwHlEux51dUehEpnRcBtAM29pgs4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBly+jzxdRJEY5FqMROusW/9i6Wzp3o1ypZVJb7h
 YkSj1ZNhcSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcvo8wAKCRCJcvTf3G3A
 JgH/D/4vgtaPXk0KWcLTLiJHtP/4BVDnRMBnnjHRKPNZJTzFtr0xrvrvitXfOBUYmJ+Lx8HifKS
 He4LRsgMd/CYZOK9jKUwcXvby63qMhJBK1w1KIdbJ4Lw2BV92OSMkNSkGNsqA9uqEOVc05tlF2Z
 wQ9JpNsGUqMZUHXYMZrBXJbGMq3/E56iNAuokPIw77Ikofdl5wDgajp/nCUAEYUSoqW5sAnetJE
 stN6XyFY8TnPeBcSO7fWb9T28zKzLBcqpyBPM1u1U6w7F7l69XxwjifGQ8bfcQ7Bmge84Dz8smA
 JvURngdGXHC2hlHLEOxCuDWxgSAbEwDQDJwivzItmmLU6SG4qkNzOG5bc4ZgGyrzMiyqf8H008A
 4r6h+woAQSQhuYNOWPGdZxHHO7r0bLdc2nfBIvKZ6JIxDy3P+9kynO3prHF7r/1KS2FiqxrFEJn
 QvEdsGBfjlqtG/5KMYy5owi91NA1jyRxlBTVnceQmxxdx1nwBqxtqtQK8OU51t2sK3TQ0lo7Z/X
 WPTxXk9O0LAJOkPoQvoC4HqMQrMJxYWA5bu2y2Ov4HsRExZL8qdWHIRQcniKlCZWwlC8MlEur8g
 u3DlvtXpA9lk4vLzGpf6di0u1AZq+pDdj/bFqGjqJcV+v0Z9+IkJKq94fDgXRL9SRpLvt3//7+u
 gVDUv70 hieHnvTg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

v6: rename wrapping_inc/dec to wraping_assign_add/sub (andy)
v5: https://lore.kernel.org/all/20240207152317.do.560-kees@kernel.org/
v4: https://lore.kernel.org/all/20240206102354.make.081-kees@kernel.org/
v3: https://lore.kernel.org/all/20240205090854.make.507-kees@kernel.org/
v2: https://lore.kernel.org/all/20240130220218.it.154-kees@kernel.org/
v1: https://lore.kernel.org/all/20240129182845.work.694-kees@kernel.org/

Hi,

In preparation for gaining instrumentation for signed[1], unsigned[2], and
pointer[3] wrap-around, expand the overflow header to include wrap-around
helpers that can be used to annotate arithmetic where wrapped calculations
are expected (e.g. atomics).

After spending time getting the unsigned integer wrap-around sanitizer
running warning-free on a basic x86_64 boot[4], I think the add/sub/mul
helpers first argument being the output type makes the most sense (as
suggested by Rasmus).

-Kees

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/overflow/enable-unsigned-sanitizer [4]

Kees Cook (3):
  overflow: Adjust check_*_overflow() kern-doc to reflect results
  overflow: Introduce wrapping_add(), wrapping_sub(), and wrapping_mul()
  overflow: Introduce wrapping_assign_add() and wrapping_assign_sub()

 include/linux/overflow.h | 98 +++++++++++++++++++++++++++++++++++-----
 lib/overflow_kunit.c     | 67 +++++++++++++++++++++++++--
 2 files changed, 149 insertions(+), 16 deletions(-)

-- 
2.34.1

