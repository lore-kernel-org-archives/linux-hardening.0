Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E01EE01A
	for <linux-hardening@vger.kernel.org>; Wed, 15 Apr 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256041; cv=none; b=Nov9ZFlgAWJl1ruR4PvmdIjJiViU3JoK/RnNJ/i20r8RGFzBanw05d64gXyVxvKxISjHLWIMCjRG2bVDohcp+T3FRDDAjm06d1q/koPB5PGvoq49XWPJYBeAGo3K+OSrjiI425RpOhG3YfiVRWoDtDn9p0/PF6NXBEoJBMhP3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256041; c=relaxed/simple;
	bh=gvWdeqYfuE0o5UuzO+zhDGvHZkaCYd7sCCjVokwjPv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6JquBznXIN1o0WmIYs3egiBJliqTNLYCA7R8uoHuSRqBIBUkC+Ue14N7nltjCEM8txDNTX39nFpRGYk1yRe1Z7CvJBV7qUtrYvsVhIYrKeyaMWVEtbU+5tkkOLrxmH2RYtpAWo3Fg8a3YXKtEh933Iz+BTBUPQWxq5E7RVDft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oSE4dIc0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSE4dIc0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776256038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8j772GBiBiVxmCFzcGpAKexXXDss5L33t/aa3/E51uA=;
	b=oSE4dIc0x8VoBP2fCYuIx8DkXZeSGImV1rHwmcMSlToXsy2d1c1ejZFP7Nklj7v0xaM5+d
	JLjmLh0p29LFSF5GOPZQPIAr+NccWmTJ9/Zqm67aoX/bq194EMxMumZhjHgmU5hc6nHbQQ
	oECv/WLz+dx6HbQyGY/p4HqPAYNl56A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lib/string_helpers: annotate struct strarray with __counted_by_ptr
Date: Wed, 15 Apr 2026 14:25:45 +0200
Message-ID: <20260415122542.370926-6-thorsten.blum@linux.dev>
In-Reply-To: <20260415122542.370926-4-thorsten.blum@linux.dev>
References: <20260415122542.370926-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=thorsten.blum@linux.dev; h=from:subject; bh=gvWdeqYfuE0o5UuzO+zhDGvHZkaCYd7sCCjVokwjPv4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn3m880qZhMvHdROel+0R77SXJ11Vzaap62guolPqYVk 25Oj+PqKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIk8FGL4HzvVqkj53s3vE48G 6T3YP/vYZBs7l5CK281zj3Af7Luwx5zhf7x/3v6Fcr1ffzGmin/uygpxnGN91z3pzLVrt/h5Kha cYgAA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by_ptr() compiler attribute to 'array' to improve
bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 6a8db441b6fd..98d6ed0eaab7 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -805,7 +805,7 @@ void kfree_strarray(char **array, size_t n)
 EXPORT_SYMBOL_GPL(kfree_strarray);
 
 struct strarray {
-	char **array;
+	char **array __counted_by_ptr(n);
 	size_t n;
 };
 
@@ -824,13 +824,13 @@ char **devm_kasprintf_strarray(struct device *dev, const char *prefix, size_t n)
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
+	ptr->n = n;
 	ptr->array = kasprintf_strarray(GFP_KERNEL, prefix, n);
 	if (!ptr->array) {
 		devres_free(ptr);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	ptr->n = n;
 	devres_add(dev, ptr);
 
 	return ptr->array;
