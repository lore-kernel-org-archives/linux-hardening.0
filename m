Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4724C33ED;
	Wed, 30 Sep 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812375; cv=none; b=lHEOoN2ypWar8iX2PQw74zEu2EEoqmtdfEKnBJOx497gmayJ3zIxLlgrbwPDUtHZXmPrdxQOMcDaQJktWL1HJBT/f/scy6154/03oAUX1g/krQpyoUaXMwjDK6YHPlqMUeTGLdugdCsM5eVTV9E4GJqiD6afTj6zwFiiFeGi8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812375; c=relaxed/simple;
	bh=qTdDoPd0Ksi1U8I5fG05y9W5Ggvnl1eHPIzcw+f38s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyCd6sKnJOwXDraohM/bnq9JGQhPp5X/Z9/piiL1YebHQa9Q/69+HppJ3892lCZh3KmO7/sew+927Kc+WUdOWQfmQucD1FTlqj6JEErBR5NXa0tX3wPLgODXO9IkzlcajA82SE+AIT6JnP/HcVZ73x35Mx0BE5urcSu/wKm6emw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXjDpTIS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXjDpTIS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E16C1F0089F;
	Wed, 30 Sep 2026 23:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812371;
	bh=fnir0UfbY9fTB7q6F0wLenGmJSxBViPfzZ07mhGO01w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lXjDpTIS/H2BjiV8CVHN1bPjTNueAWwdoQwFipOwHT8LRX87hfM9F9uaeJ5UwArQW
	 C9J0+6DC3/UoPFelLQO8dATeVAf8Hk8uy7d6WKfhjWDv7pwDvc5UcAORFbChNCIV3M
	 yLCbKfRR2DPtlQPfGH/hIG9fdDQ2bKIkEyEzajnDh/TNGVynCweaA8m8XS4HKcAZs6
	 4M8ZqNP2bsesmBdu9q6+GWxI7a3EAnQNdD3rXDFbiOhqRtxzCEVIG822lPKI4kT5QD
	 I8tgRRNE1tHDilVLLCHhdnBk9tdE/twrHO9qQ7LL7Ac0W92WubhEOI5jo6OZ+n6NH+
	 a48MorAppU7Xg==
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
	Steven Rostedt <rostedt@goodmis.org>,
	nikitash.mariiaw@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 09/11] powerpc/papr_scm: Return the string length from the sysfs show functions
Date: Wed, 30 Sep 2026 16:52:37 -0700
Message-Id: <20260930235247.157921-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930235231.out.387-kees@kernel.org>
References: <20260930235231.out.387-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=kees@kernel.org; h=from:subject; bh=qTdDoPd0Ksi1U8I5fG05y9W5Ggvnl1eHPIzcw+f38s8=; b=owGbwMvMwCVmps19z/KJym7G02pJDFl7FxxjdhP1OyM2dz9nNEdZap913693nZret7Q/3l+f/ I9h2T/XjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImcPMfwh7M0ZHFBXuPsrx+d 73puX5b2renq9ofVZ/7I6UYZHWKVM2H4zaLZLc3ulXfkSmUdj1F02qtVD2ZvO7dvwtVr23meGXc JsAIA
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

