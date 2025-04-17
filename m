Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD84A926
	for <linux-hardening@vger.kernel.org>; Thu, 17 Apr 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917693; cv=none; b=karAoFhDyfXXF86+CC5rv1LI1mdCN7bBhCAh4huu8AuNG+fvlsRPKnXJpehcHar0GPz7HsEUWvSRJnPsFL3j3E4fNp8wZM07uJrI/0Q5Wfxn5WBKAwyj8cAZc+5+czgpCPEgwMBOK2j9t2DpZV/LYsb7t7oxpwgqBc6E0mLvdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917693; c=relaxed/simple;
	bh=QEDo5h9HZXac5uo5Oxegl4cZxwuq6drwyTIoNXKUOW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGgbfyRHR5fxOj2uWByCfu5jeXvKhNgSK8OSBOw0+TslmIxyoQ3pKNPCcttTtoZ4soHqCiZASwBfe/gSAxQQCOzBKLdJ5CVRmRhU5/oz1q5ob8sqS57VTSE0hb9RbYKO75SC9R5KCtJeSJ9d10lx77eo6x+HypJmoRpS2Mt0q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWHZHfaI; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWHZHfaI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744917688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m4nhPsAXq16l8mLZ2dp76RiRIb0Pdz76My5DfrqpHO0=;
	b=BWHZHfaIMXwcSms3RZgM9SPl7nhvp3t7K6eG02JK+9YkLr2+/ItWbAzB3ynV+FZHTybERv
	3N4fflNbIglkt5lFr/q1x3rg9cZvH3uxTNiiRnwKGKOeph3OJ1yA6VgdKs4U6WCWQVMtYd
	/iWO2wvuK2ZqMKPknR8fIhmY6NMf5sk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smp: Replace deprecated strcpy() with strscpy()
Date: Thu, 17 Apr 2025 21:20:52 +0200
Message-ID: <20250417192054.69663-2-thorsten.blum@linux.dev>
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
 arch/alpha/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index ed06367ece57..56155b988b9c 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -262,7 +262,7 @@ recv_secondary_console_msg(void)
 
 		cnt = cpu->ipc_buffer[0] >> 32;
 		if (cnt <= 0 || cnt >= 80)
-			strcpy(buf, "<<< BOGUS MSG >>>");
+			strscpy(buf, "<<< BOGUS MSG >>>");
 		else {
 			cp1 = (char *) &cpu->ipc_buffer[1];
 			cp2 = buf;
-- 
2.49.0

