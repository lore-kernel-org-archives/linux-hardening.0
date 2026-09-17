Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFC31AA87
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604616; cv=none; b=FulKKEi4/XsoSSZEITR90G6uvBM/Ofn18pFRqYyJxKq/DEwbi0dyGAzoISj1sYQlD58+0MOHp4oUV6zRlx1q7LOk5rmEX2+64LL9tdCTobZwYUsAzqbJXOdVtWuUG766rWFF70a2IFU+1UB+2hsP8BKhpv5vhyih0s83Gm7RV5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604616; c=relaxed/simple;
	bh=QpDdcSnidsU2zeT85ZzQmT7vYMazwTC5RAWGMIhrVIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Szk5i73jvBneAdwPAtaLzC12TzCIpUNDc2s/apC5rJALOqHw+/36aSbkekyyTNBmLwnIT1YKkJlSkGJmJjA1SmmKZNjBL/eqlMgBdJC2CbDPc6ZbvL5qKryxEkIubYtZ4pexUkn+GXhfPvEPKfh3POOwSyNAtCiDouLEmLH2gXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6JycS3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6JycS3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCB1F008A2;
	Thu, 17 Sep 2026 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604613;
	bh=McaKO0yHOxz0y4KcMiZNfILTWJHJOqO2DVoFelFO74s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k6JycS3of59rxdBiglixB5HNPd6Dn5sh6zdLBA0Xh36pf/UBbkl5Jj9dmgGswxBxJ
	 WnCNiCLj6IXDccT/fv9yOgekTIpVqSP+aZDJiGVTJCuXhDOp1NWY4HfVOHb7CeukNN
	 GpVQks5mFfFESbXc+hEaLf5Gq2ysKEHS+ZgNc6JfsLflpz+tm6XDQqQ/W3SPsHpi1C
	 BsV8ASpurk7btY1td0fXbBWGXIM4kKSt3hbA5N1V43x1CkFCWOhLljdqvbpTRF38C4
	 eLii2d0P06xYKOkM1NL5zO533NPhayV98Qub2ZtOdmjZWRWOWdOsAaFIlLPTLiLOPO
	 /20AVW4FNymdw==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Thorsten Blum <blum@kernel.org>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 6/7] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Wed, 16 Sep 2026 17:23:18 -0700
Message-Id: <20260917002333.2306346-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917002312.i.923-kees@kernel.org>
References: <20260917002312.i.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=kees@kernel.org; h=from:subject; bh=QpDdcSnidsU2zeT85ZzQmT7vYMazwTC5RAWGMIhrVIY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmrjb7xzWJ+eWth43WfdTVuE3LK7j29oPS8L/2ATsD8X 11HnVKPdpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzEgZGRYQmToYjh5TNi1p8v Lo5aUbhrcnqf9ePdj0ISGJdm8/p+/s7wz3bxHJ33y6XabPcZNZqWmF+9M/nBPZ7SDRc3n4yav+7 3QjYA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.1.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <blum@kernel.org>
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..6c87c8b4de8e 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ? rc : (ssize_t)seq_buf_strlen(&s);
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

