Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240C4CE69E;
	Mon,  5 Oct 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215844; cv=none; b=secQY/Kcq60VVpKQHajMbXQM6Y321F1go2CCH8UMR5dbkkby4zo1YORznMEmIDKYHeFML3SGKHl39kFlTuSXyP30+C++XHvU66pTD7NJ7xuVm8JX75RpsRXb0Eda4qbFugg4RLW/oRkdlGXwoY1T8c9f/FzdUN0kB3/qc06BlOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215844; c=relaxed/simple;
	bh=QMqRTQphegL+YGqZELWHP3PitTraEh7YCZhUt0ueL+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN+UqVZ9fTFOySyhlE40Nejwc2TFhQpIdSJPJbnnsxwxk//AwWxDd/CGOvh8rGRfArTetmeCUj0EDM2re8Ne00y3u4RQacF9kPPz2gf9wjX9JjC+jU0YziX+5ukzG14AVxmnEWGtszC1HOY5I27cHoC1aJStUTxjeDG2uaL55f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzoDJ0Gj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzoDJ0Gj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6891F008A2;
	Mon,  5 Oct 2026 15:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215839;
	bh=sf8U9e/P/Ck4Sty1kLYW5Wh5J9iqRhQrRMwhuEB4BRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GzoDJ0GjAM3eRzHs8BIN+4iEUm/L0zKHa4gLtaRR5+K9eQc2N9kAVn7BkxyJQJ0Cp
	 C1tV9tncXEdAWc0o8xDhhLY7O7qbldHb7aH7F3Sb8FHYqjr1DudTRjoFYVedSzt/l7
	 BzT7LLQxbgq1FI2F/ZlVBJE7cI5hbWqVPuJSGJ33sSUTo7wirqqepxIe+sBSFl9Cof
	 yCoG9Mh+qkzYzRxEzNtYNyrTz3gGqRxWgT0UMljYwt5yqpgFq9RsKw7FIXLkx7sWNl
	 SxlalYI6iepxEcxWxHZJJ1IF3MGYU04IVDMGZcXcRgTZSdLzSe6MjozBJ1fvXcSgsd
	 HvlCKS/eSSifg==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Thorsten Blum <blum@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 10/12] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Mon,  5 Oct 2026 08:57:00 -0700
Message-ID: <20261005155708.1471260-10-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005155653.late.426-kees@kernel.org>
References: <20261005155653.late.426-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=kees@kernel.org; h=from:subject; bh=QMqRTQphegL+YGqZELWHP3PitTraEh7YCZhUt0ueL+o=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmHT5w11+xnnFjoOtf9nqOb5moGvykW0TM+H39+WzL3R N82pxebOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACbiaMPwV8g17Ur1+dBdb//M ZeeQzuq3sZy7v+botN2rYnZslCwXr2X4nxr+XqntQN9iTWPjbQnPu3mDeTcz5S/7Hizor/XtV04 8HwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

perf_stats_show() and flags_show() build their output with a seq_buf
and return seq_buf_used(), which may include the trailing NUL byte
when the seq_buf has overflowed. Use seq_buf_strlen() instead. As
suggested in review, use it as well for flags_show()'s check whether
any flag was printed.

Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
16.2.0:
arch/powerpc/platforms/pseries/papr_scm.o

Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 75da96c08cdd..5c3bf06bb59b 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
 
 free_stats:
 	kfree(stats);
-	return rc ? rc : (ssize_t)seq_buf_used(&s);
+	return rc ?: (ssize_t)seq_buf_strlen(&s);
 }
 static DEVICE_ATTR_ADMIN_RO(perf_stats);
 
@@ -1147,10 +1147,10 @@ static ssize_t flags_show(struct device *dev,
 	if (health & PAPR_PMEM_SCRUBBED_AND_LOCKED)
 		seq_buf_printf(&s, "scrubbed locked ");
 
-	if (seq_buf_used(&s))
+	if (seq_buf_strlen(&s))
 		seq_buf_printf(&s, "\n");
 
-	return seq_buf_used(&s);
+	return seq_buf_strlen(&s);
 }
 DEVICE_ATTR_RO(flags);
 
-- 
2.55.0

