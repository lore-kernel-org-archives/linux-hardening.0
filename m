Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4C448393
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457572; cv=none; b=TaHN5adsRzxxfritAXPnree8qzg17HK789vv3lzLIquIDAfdht/K0otEYMdbIAjJOmqQ3xNBpzznwPtV+St0g/B9GMADJjYxqIaBB7X/s2r1tvt/pyWPQkWrh+CqKn+nHZFULgLqGdF5Ouf7gxx2V6DeWItJpaUfQ34q7sv2bt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457572; c=relaxed/simple;
	bh=TaCmrurOP6eiSThHEAhj0hS/qDuy18I8xMkgu8ZEriI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2iJ2S171dmxs5PzQFALC2ewXFQHC17Pwi5UuP0ZeNsY1Wyh69TsaIUs9Bti0SE0pnZeMjWq37TtIjCzswqTrkT4OUWrEwQTSnaZKWPpU65mNh4wY/BLxfBUDNcqQNZZ/X0Rmtl6k9aNrEBdciS7tQfbQv924qI4s+VQ28c0fHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCoZkRgv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCoZkRgv"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4980dc26022so33094025e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786457569; x=1787062369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ah0y0gDveI06pCiQf0Bv3vLT+VZq6BOea0NjGFqGqkY=;
        b=VCoZkRgvC0JaViWUUr7N3sphR5tdb76kTdzSdtKLvZsR+U8T/uOHobnsNRNLsIKzP0
         uQNSH9tq2mBsJNI7nAzTT6GzmX021iqfbjaW4mNGbW8Eap41P/FJAIozeAgreUjerNK6
         Zma8+nWb6pntXWWENzBKNkFAVDP55lRv7yOcXrsOU6sK1wWP+3nXiRlhcjs8fzg0R3qs
         i8TY3vq02NA3WclC1SkDIHFtmFYamcSG6V7y7gHqPSz+oezImVm11KDy0GXcpxdZxsI9
         DW9T3885MW4N+1E6oXtE2HoOSstgLgvYMImN1L1pKT34ruICxz5dbi0GcKdy9WvXM2m9
         qY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786457569; x=1787062369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ah0y0gDveI06pCiQf0Bv3vLT+VZq6BOea0NjGFqGqkY=;
        b=DQCMib53OPBeJi2V3oUZgBsy36MNDwEVoqnXWlXHxxZAKnitFxgRJWbzsyhyul+kwP
         6C0qSqtSUoXdq80NiDwHWkP/bt7Kmn9CfYf/5FdrPM+QfIpjRdPS2AyBC9GMfqxitY5f
         /VyInHzw9cBicPSBE+eC/XqG/vvVWJpiCfAAPktnHHVUVI7Wab9Rbj6HBQbaVNc/4NlV
         HYVQMpAp3w0+sGg1tfMjUYbrQfB0K9Bncq/PBoQKCnTlLhRZA5Bgdue6I0YDtEqnQ9V6
         8MdbT1fPJVQob2IqHZm4Tecmn7OLy382h5NQkNtrV9+jTq1O0Z2DlGAa6hIrEzZANQxm
         v3Pg==
X-Forwarded-Encrypted: i=1; AHgh+RrEHv+UfW19sYyejmoxe72sQwiTPS/0AmBVC8A34ZuAAKCruNPnGeGdHOsu5MhTc6J3gDcUt/+QL9lHcpoampA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UadSszMy+A/BU5J8BMOADMVF9fea9Jx4Q7tdTnkJ1CgdDtIq
	RyYcfaSQA4vUpi7fIjC+04j9bbjEkJwTYjCf59mS8SFQD9TnGVbqxfOb
X-Gm-Gg: AR+sD11YYelTwmo+H4q5s9TMw4ioKjaFvGbl1PLQLlIWEYCXGxt6z8cV/UfqGoUGw9O
	X0NtgkzFLjJv6A+/9f1IBwkd+/RAkBjzMm6fBNXeD53ZTd8jbLALabfZizB0IlfDDc/GqZDbJ0A
	4ehuewLku1sG/rC8QUpsijvBR1AVfkxkn7/Q4Ma9JbHDkjLGLer1efWT6tEgehfu7HzhEVAifS+
	thbDHr1SI2y1Ka0/rI5DWw4qI8BcM7xsgC5yOO0GBAZdNYdxxyCymOIgQDL5N/iie9itPNMH10B
	xNNE7BZVNhgyD63sVrnAJq8wT3h4fOkaI51LvZakgtUODmH+Jt/IVY+ohcg3qzXRRg+c0y0E+JK
	h/V+vS9JLey2zzC48frYUa1g7sE7FEFkHIXV2G3CEOA3YO6kw9fXZyTSnSb/ZCamP7Z1HbLXnYL
	EZ96vz3VAGzJHaCcuPT0bmvXHw1bUjgoyGM2TV42ADynhU3bfT3bO+GwSnHLozlXWRhOsuJ92mH
	1fGY/tpr8rw2cj4JNYowb5PdPHenZqiPMu5S96cbw9uCTRUavr719rYp3GhuPxWdMNqrAZZxp/s
	66v3A0rsLpGJ/lNANa0vrGSE0WyDOPu3fqd5915Ve2+pC1EoWu0bpsswb7U3Lpl/v+khTA==
X-Received: by 2002:a05:600c:3103:b0:495:737a:7afe with SMTP id 5b1f17b1804b1-4997846c317mr57654805e9.15.1786457568853;
        Tue, 11 Aug 2026 07:12:48 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4814a5be29fsm4464099f8f.12.2026.08.11.07.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 07:12:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 2/3] slab: check for ZERO_SIZE_PTR by exact match
Date: Tue, 11 Aug 2026 16:12:39 +0200
Message-Id: <20260811141240.62519-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260811141240.62519-1-kmehltretter@gmail.com>
References: <20260811141240.62519-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZERO_OR_NULL_PTR() returns true for every value less than or equal to
ZERO_SIZE_PTR. With the sentinel raised to ARCH_KMALLOC_MINALIGN, up
to 128 on some architectures, the helper matches additional values
that are neither NULL nor the sentinel.

Compare explicitly against NULL and ZERO_SIZE_PTR. Store the argument
in an unsigned long temporary to support both pointer and integer
address arguments while evaluating it only once.

This also changes check_bogus_address() in hardened usercopy: nonzero
addresses below ZERO_SIZE_PTR no longer cause its null-address abort.

Apart from hardened usercopy, direct in-tree users apply the helper
to allocation results or explicit sentinel values.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/slab.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3e012cc4f001e..023e10ab77f8d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -270,8 +270,12 @@ enum _slab_flag_bits {
 #define ZERO_SIZE_PTR ((void *)(ARCH_KMALLOC_MINALIGN > 16 ? \
 				ARCH_KMALLOC_MINALIGN : 16))
 
-#define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
-				(unsigned long)ZERO_SIZE_PTR)
+#define ZERO_OR_NULL_PTR(x)						\
+({									\
+	unsigned long __zon_ptr = (unsigned long)(x);			\
+	__zon_ptr == 0 ||						\
+	__zon_ptr == (unsigned long)ZERO_SIZE_PTR;			\
+})
 
 #include <linux/kasan.h>
 
-- 
2.53.0

