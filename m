Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9335E18FDDF
	for <linux-hardening@vger.kernel.org>; Sun, 22 Dec 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734906779; cv=none; b=ORykyxSkN2VLV4IzkAxisF50MmuqQnRYHGWkV14bDbmZCVrL8PGNh/DbAPuiZ1KcmlmLl3879eLAusVTqHe5Eol0vdeN8Ycu8fj+eraS510smNiTj8XRS8Ad5QeKrFC83CzbAiyZeLVRBhBq+3OEQmTc2SnXR/O41U1mLFxQcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734906779; c=relaxed/simple;
	bh=L9QN9w5SFZlxZWMp+27IJwitcUIdUPRMqX8VaYZHI0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XEU0Y1Ai1LFH9lWHyc5dlDJU8WBcRCfZ7cznEMrXeHDpfEtVsAyuJTGPlYjkXoOeS0H2urF+h3Sqvf2O8mtxuIXN+EMpGfvhnmuCPnrLydQO2InnJ+EU0ohAwpeZ7pnLvLvm0TG7HsTSgN+dQ2ClQeaK4MSONgozk6oxjV97ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XyY/YWKv; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XyY/YWKv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734906771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4FQINZUP9TqF/cudm6/G6TRFdMmsNU9C0V5i0Y1TbUc=;
	b=XyY/YWKvmRM1V0rBzXmLPeDQjKDlf/ifN14cbjyKB0HVINVAPC3VniqYlTPwoUQ025Bmux
	nhPoBTRs9cuG30b3ghaoo8ZnmGKi/VBnElD14T/4NjqIYxQ+M/7aGqadBcB7CkegI735nS
	7s1pGEYStMprVxLLUeaaU2U7Em/VSto=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] stackleak: Use str_enabled_disabled() helper in stack_erasing_sysctl()
Date: Sun, 22 Dec 2024 23:31:57 +0100
Message-ID: <20241222223157.135164-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/stackleak.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 39fd620a7db6..0f4804f28c61 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -15,6 +15,7 @@
 
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/jump_label.h>
+#include <linux/string_choices.h>
 #include <linux/sysctl.h>
 #include <linux/init.h>
 
@@ -41,7 +42,7 @@ static int stack_erasing_sysctl(const struct ctl_table *table, int write,
 		static_branch_enable(&stack_erasing_bypass);
 
 	pr_warn("stackleak: kernel stack erasing is %s\n",
-					state ? "enabled" : "disabled");
+					str_enabled_disabled(state));
 	return ret;
 }
 static struct ctl_table stackleak_sysctls[] = {
-- 
2.47.1

