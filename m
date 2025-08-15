Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EC2E2DFD
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293933; cv=none; b=gILVS1v0/p+BlUdHr0B2nkemEmjeeK3ExQeWBw5sh2UiycvMu/XjYa0RlHC+SHci56uiXmviOP2Oor6MbWNQttyBncjdu8xlWcfTk00cjfu+9hKQBakhcGPgl3VWjc3sq5xI4Eve+4dNtxjA/mE1kFI22/ov3Y794Er0BtannuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293933; c=relaxed/simple;
	bh=m+SFyPZPdNLkEeh/Z9y98jQI5VDRudwIYZP3ks+Y9tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnTsw5XsV5wjdQJUOdv68VvDR+UqAivNnFIBXQxXfQ8csqJRC1Vjsg10tdMtlbEDCnpS+pFZEQ8meF4fatgVrTos2Cnf/GArCOuffvb7qowsq+fS0ZOKAsXsr8qetjOz5B/4uapJ+qh6kNzRKI7KNTKUCxipDCn732Ifm1l8NXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hx9iEQMT; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hx9iEQMT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755293918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Odl8SZESVhrHQmKkgQviMOnzxHTYvfzH2nuPTA/Ub7M=;
	b=Hx9iEQMTdLY8qQIghpT5o5Jto0B4N35X9rsIoqJLHmKviAyFctNdcqLDyuw61P0+jwJjTl
	WIm76CO0Sxlb1zY0qK+IgVWvIa3fKnEdKbCP0Yasg9ccU8svlcGy2I1gWxotis4b6n6cT+
	FL44FGofAyctU/aP8n5zDAGEyqsEF7w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kcsan: test: Replace deprecated strcpy() with strscpy()
Date: Fri, 15 Aug 2025 23:37:44 +0200
Message-ID: <20250815213742.321911-3-thorsten.blum@linux.dev>
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
 kernel/kcsan/kcsan_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 49ab81faaed9..ea1cb4c8a894 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -125,7 +125,7 @@ static void probe_console(void *ignore, const char *buf, size_t len)
 				goto out;
 
 			/* No second line of interest. */
-			strcpy(observed.lines[nlines++], "<none>");
+			strscpy(observed.lines[nlines++], "<none>");
 		}
 	}
 
@@ -231,7 +231,7 @@ static bool __report_matches(const struct expect_report *r)
 
 			if (!r->access[1].fn) {
 				/* Dummy string if no second access is available. */
-				strcpy(cur, "<none>");
+				strscpy(expect[2], "<none>");
 				break;
 			}
 		}
-- 
2.50.1

