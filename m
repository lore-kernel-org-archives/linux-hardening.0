Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811622B8B0
	for <linux-hardening@vger.kernel.org>; Fri, 14 Nov 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763123301; cv=none; b=UsuqYNJlmafAjnyKqzoKJJpSNks1+3i7yd4tSsDMoKTvlB3ThmXPJgiir3OT78z2ty54roDjJyBhT2gWgUA5F5airhB5wKZxm2T4u9ASC4/VfK9TOZHIscUSccybH/T5r/vLi2BR4LPI2Wq2VDLAoK4QNYGw4K79Ynk6+ztlyNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763123301; c=relaxed/simple;
	bh=PR6HjPZSbpEAkkkS9BuFc72FX7xER0pZm2scy9v1yIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=toti1pX3Aip29Nl2hogHq0KtKtjdpf/01QJ9C7teXtGa4QX8xTuzf9s7Q+WE+NsYBcsfgZxMyLxm0IdoG1FMOjI9L0xnNiVHr1NVyVeSrpreCSfOeSHrsp9vkt+l2QvzHAul+JgqdjboGIFf0j4umxFx4V4vVnt1fwOznkzP8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uVurzR0Z; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uVurzR0Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763123287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RdL7Rr6+GpoRXuStVpO2nBEgteQ17vSc4I0tNzl1dtY=;
	b=uVurzR0Zyzzdcf2Ddk7ozPDT68/+PGYCXKcajAeurYZ4NQ9oLOShYUuld60bR5mBPrVLqz
	ucwi7wyBNTEM3mM3sANq992URJdeNa5n6rL2/m4wks9KoFIPOeXIfuAU74ZC7WEUoYag+J
	jgrih/nTJtP1EUT3iw8mb8jrJG18CpA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] unwind deferred: Annotate struct unwind_cache with __counted_by
Date: Fri, 14 Nov 2025 13:27:47 +0100
Message-ID: <20251114122748.222833-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'entries' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/unwind_deferred_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 33b62ac25c86..d4b67f0116f3 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -5,7 +5,7 @@
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
-	unsigned long		entries[];
+	unsigned long		entries[] __counted_by(nr_entries);
 };
 
 /*
-- 
2.51.1

