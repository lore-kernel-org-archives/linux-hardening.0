Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482731AF3B
	for <linux-hardening@vger.kernel.org>; Mon, 22 Sep 2025 21:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575149; cv=none; b=mJIFx/hBhA65BmF4Yf7ndI/rvr0IyVNNyiO9XQx549ezmC7ch2xGvV7rBk4cXQoEVmswMZtLEmuMjcDoPtMZxY3R3cJTsSakXLuPJTRJ7OggYQc1DUhgt36G7qjqIXUfG+6aH0GrZXkPJwEJVVwKs6kgEfheKCrXO3JxsEQAlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575149; c=relaxed/simple;
	bh=ym12jfxvpZrKqi1e8HBvx3s69F4LJyvx6W/A4E5u+Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Me/m0FPwSW+GuxDT7AnXdGzcEKPjRESzCDOhRVsHreW2AMS30/lylXuLj0TSBnSK7CzRFNGBsnrUl2ublkXihD0kEDHyBNd2lG0HTA00cljTLkrL7U1Ex0GHy4LQf1q9fRGf90aE6Jtkib7Rv49PaTn0J2S1kaTKm+h+ZjYZ5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jg1YGrDO; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jg1YGrDO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x39DcwDEOpUr4+fWk8Oeko+PXOBj+YgR+7cgbJSgLdQ=;
	b=jg1YGrDO5dUE4H6HK/1oBTvIX9epmOVLYQ0Z87/VLnbOfFKIJYQNeRcMtKllHfdMlb0N8X
	X5IJbco5DRJsDViV4FzX/NcfVAvUY8Xn0i8f7ksOq0wbGRaKHu7XMpFG3JPBqHYweHFM5/
	92KelNPqJ/ZvrpKNY6s5QgFtZeo0opQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] sparc: Replace deprecated strcpy with strscpy in handle_nextprop_quirks
Date: Mon, 22 Sep 2025 23:03:57 +0200
Message-ID: <20250922210408.1723452-8-thorsten.blum@linux.dev>
In-Reply-To: <20250922210408.1723452-1-thorsten.blum@linux.dev>
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/prom_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index c9ec70888a39..d258fd10db01 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -120,11 +120,14 @@ EXPORT_SYMBOL(of_find_in_proplist);
  */
 static int __init handle_nextprop_quirks(char *buf, const char *name)
 {
-	if (!name || strlen(name) == 0)
+	size_t name_len;
+
+	name_len = name ? strlen(name) : 0;
+	if (name_len == 0)
 		return -1;
 
 #ifdef CONFIG_SPARC32
-	strcpy(buf, name);
+	strscpy(buf, name, name_len + 1);
 #endif
 	return 0;
 }
-- 
2.51.0

