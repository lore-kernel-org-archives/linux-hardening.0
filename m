Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB856264A73
	for <linux-hardening@vger.kernel.org>; Mon, 21 Apr 2025 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238534; cv=none; b=u67prggr6yfT0U5OY4lvPyD25U8N67sH4AeHCbV0I+VodqVxflrcLVdwSwuMpOcwccpZqEm2CwQvxH4dT9ssbXYxkTUelxIiLnamCgMCv58gr75qq1caOguarcJeTtbXWSN1dLzlkY9v9sMgTTu1Hj3TNTxJe0YZoR75QfVQgOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238534; c=relaxed/simple;
	bh=GZ4EAJ6Hr/EOxOC+zB3KAgeRnUiGHQV35R+BS6pG7pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ql4AewCKbKbTmST4p/0E3KPmKkdBoRZMIEPnYFnDuN8QjFKWKNItc5BpGJsFAoSWdGnGmBrD9nCHYUorSFPVW8B2+kroQchSwRGgjHQNmi9Qf22toRAAO5u4txIWgYDYcEdwF7v9eKKZtQTL0BARyblNv3KgdIENuSewYubJXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MKC2q2Q7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MKC2q2Q7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745238530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IxqkS7lt69bHaMltk5gXyQH9LvD91wxpy08FtaUvczY=;
	b=MKC2q2Q7Bb0B+cCkXxkXX0Fv0vs72j4GnSKdWHbh34NAG84FoV1nSMfsjzSYkhTlcltZRc
	sr9k+ZM6Ue/A7X7FfeSb0CZEeWU07d3xBLPFayfPxr8QfRCwDVE14S9Wr5ttuf2FJSkAVW
	PN/+SP3KRJ6WlB3kU9My6Oxq/R3PpLQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Kees Cook <kees@kernel.org>,
	Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-hardening@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: mm: Replace strcpy() with strscpy() in hardware_proc_show()
Date: Mon, 21 Apr 2025 14:28:37 +0200
Message-ID: <20250421122839.363619-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/m68k/kernel/setup_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 0fba32552836..c7e8de0d34bb 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -484,7 +484,7 @@ static int hardware_proc_show(struct seq_file *m, void *v)
 	if (mach_get_model)
 		mach_get_model(model);
 	else
-		strcpy(model, "Unknown m68k");
+		strscpy(model, "Unknown m68k");
 
 	seq_printf(m, "Model:\t\t%s\n", model);
 	for (mem = 0, i = 0; i < m68k_num_memory; i++)
-- 
2.49.0

