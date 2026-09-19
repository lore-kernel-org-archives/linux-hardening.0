Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C302EB84E;
	Sat, 19 Sep 2026 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777642; cv=none; b=EDC6LUWETZLqlUKoBWOz7bfhPQlKvgZvxRtFLBeoB0dwqqBe2wRkStg/AHXEzKz4rUOwG07a9x+r5Zcu+uGWKgEwTjaVXq6MePYJx1uBMl0AC54QbEXs65GK+RyoAnIr8vozAxXRTvjtK5Gm0gi5y4aM3MyYnFNv6ScCLh/4iOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777642; c=relaxed/simple;
	bh=bM8pfQZ+WNZUIhOsBdyOBh8XaXJCdRjSK82ONfe5d+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAj34yjakwo549UTjng/uOUn7YopElTMmvmQ0eVSHDIq5iv02Rcx8ZZSHMSUwuj3B1UA34vZSxHe6TirNgXRE8Dk+yfVzJLkzR21yOBaR4E6wYYkodAf/boAR9fVaLGMbJWBSn5f1eG5RlKMgdUsZQEqrypva+5g2VqLHDpywWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNPJ9uuR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNPJ9uuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC581F008A3;
	Sat, 19 Sep 2026 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777634;
	bh=ftDDqlFj8bU4K3fZAI2KjolyAI1cAmHP/993JbsJZpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNPJ9uuRW7nHkAe0zYCwlX2SunjF2FSmGpgZdg1DSUad6q05ouhfyh5UiNpDupU63
	 3vo8uZexVw01RHe/7NfbrnrfMzfFQb1VHrk+I39LUsK+Cd8zR46JHcPR7VM8Mxfm4C
	 2OrUgqs7MqHrrf65btj9O1uonyEhtrQthpoOL39X+xWcdvk+rAqB7mw8Bsy7YhQ7Nt
	 viBoT/KJCfByM4CqQkiRfCCgPlVjVPm6VH6akheW5Qk5YGpjc4OqmlIV07IJ1ujzBw
	 WqqIC3/dJpdB4rnusCfV7E6L15lu4xOI12IFKX8WlMefIUOoKyYWe/ZeZnRBfonxRQ
	 4b4s40OiOBPgA==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 7/9] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Fri, 18 Sep 2026 17:27:05 -0700
Message-Id: <20260919002714.4060307-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919002658.stay.929-kees@kernel.org>
References: <20260919002658.stay.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=kees@kernel.org; h=from:subject; bh=bM8pfQZ+WNZUIhOsBdyOBh8XaXJCdRjSK82ONfe5d+M=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrr91q4EzZaveH25A94nRu1Y5jMxliT9oIzu2cXTjz9 JlPP39rd5SyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEyEo42R4ediE7YbL1Y3Lbw4 OeOHcKbwygMm7Svur7ikccVfnLFgrhEjw5R7kbH2bSXNa2cXqrzpX6b/OYTvoNXjS17vJQrMFc0 mcAEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.1.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Thorsten Blum <blum@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..b03cfd8528f5 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: (ssize_t)seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
 	if (seq_buf_used(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.34.1

