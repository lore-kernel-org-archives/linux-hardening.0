Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315433EAFD
	for <linux-hardening@vger.kernel.org>; Fri, 29 Aug 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488217; cv=none; b=rsu0l6M+ZXfFT9g/nCrjnWH6QclbsJYIHZZVCxWukuQD8rFQwJHSMuJLhSwbZb8Q1+DE1dAa5o4vSE1dNnf31fR6kvGyBdCy1/PzxMQBOhWtAfrmYrm+4UB1rZBxCY3w1rAHi4PAqOoXF+kwrxcfgEa39U+P4Yb/HL45X7VAilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488217; c=relaxed/simple;
	bh=QRdPNgeyaIgdTw6jQJ4kM8OK3qz1U6FHkebbbsS7fMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbMvMRn14luOGlbE1PtzgxMs9ay00ncmIRFf057q82fDOo+N3g0LmsFr2qR1GfhOCbQB0GafZKApdmGm1q5a3z/m7togGU8fHb5j9G1RgZJVlEGxK6g907tnn5jLqgIwmlrZghRkFTYbVVs4UfpJJPJBsdZhNh6BJrjouLvo8OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BrZxGCzu; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BrZxGCzu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756488207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KoQb4JXCjmXn2LaDQKdgBAQEw0MrpvzxxZIIngHNvYs=;
	b=BrZxGCzuADoIhVSo3ybx1XSD6u9O6gUDxvtxg75PmV3ZgEx7QeKCg9VzdYYmPv7Ij9O0FT
	MYWqfXzVsKaNzlGg8c4Hm1Zh6BfTx0zVNYL2ooSxDOU5ZSQM3A1YFCbUuT+Yk2SSVd/tez
	mzgLxm5yDA2/q4xJJul4ar/2XP6VC5I=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sched/debug: Replace deprecated strcpy() with strscpy()
Date: Fri, 29 Aug 2025 19:22:51 +0200
Message-ID: <20250829172250.55835-2-thorsten.blum@linux.dev>
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
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f..bf76980e2334 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -719,7 +719,7 @@ static void task_group_path(struct task_group *tg, char *path, int plen)
 		char buf[128];						\
 		char *bufend = buf + sizeof(buf) - 3;			\
 		task_group_path(tg, buf, bufend - buf);			\
-		strcpy(bufend - 1, "...");				\
+		strscpy(bufend - 1, "...", 4);				\
 		SEQ_printf(m, fmt, buf);				\
 	}								\
 }
-- 
2.51.0

