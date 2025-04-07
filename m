Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF4C253F21
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031751; cv=none; b=MmlDB1hrtzrIM333HOLIm9RAoijRGHReZsBclL6QNkvRX12bP9hmj6rt+iEdEbpXvU1SpB2C257Z3qbWxYg89dhdxBiATjQBr+mMUdrNQvrjEEM6c01EWSpX7vNKCsQaXVCBzL09reE4pt50kPC/vxfLceQAK2Z85BzECk9gP2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031751; c=relaxed/simple;
	bh=GHNtTngkS1/wEEJahVgx/TmOQbOiuDZCZjQORypgLVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/cCSwcu7Fw3Q3Dph30X+ovhqFMAoTuide9pYmNsCrPxHaybheoEXr0hMlnuvjjrLXMAG3rYYy5USp9F/ZPKWE6rpHsiX3uzm7os6n15Ic/VzAoaInsTTVEwpDpvUgmc0yzAY8EGNNNoP5mXVdlFdQU/DfAcICwvQzGmLD3jbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ufZH2mgr; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ufZH2mgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=vtDqL/q0KP2hj02Cs2anspKNhY3dgQE5PgTeatZ2yk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=ufZH2mgrRcm/IK/h6lJ+iw597k5Kf14MSbvwkj/7auewPXQOQx7IoYImQOSZabTnA
	 g6YvD6YPzZp45SNK9EQ2F6efiIq9+h4SuEpNn6uwmnPKc/Jf3FW+YOxnqZy+WyOsKw
	 mf1vfch4Z1ZRy3VmLI+oMHAYzfD1oapI2RpqhIFwKrze1Cow203CsbLZ3nwQuWYB/p
	 g65Fy5nRQL+aIIQ08w5Dn0oBKp9spBqTq2yctgLzV4HJj0z29fCWVuGPKAi8LBEvNY
	 CRh1hRlZZD3pFD648BxWKrslCHf5ECJvjrCRIdXhV2knpU4Xey4Gr7c6EHgL6oewMv
	 oirDMRvF7bLfQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 38FE22010320;
	Mon,  7 Apr 2025 13:15:43 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 07 Apr 2025 21:15:04 +0800
Subject: [PATCH 1/2] lib/string: Improve strstarts() performance
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-imp_str_perf-v1-1-ed95d52964a4@quicinc.com>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
In-Reply-To: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 9MdJPuTmMJHKkAxInAZpou0XkpHhLgq1
X-Proofpoint-ORIG-GUID: 9MdJPuTmMJHKkAxInAZpou0XkpHhLgq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=703 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070093
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

strstarts() is frequently invoked to test if a string has another string
as prefix, but its performance is degraded by the strlen() loop contained.

Improve its performance by eliminating the strlen() loop.

Link: https://lore.kernel.org/all/20250113234643.GA3631169-robh@kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
---
 include/linux/string.h | 10 +---------
 lib/string.c           | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 01621ad0f598ccdfae819b1a5058607e79d8a751..e5f7defa277572719e1dbfdd264f3de6ef8544f1 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -345,15 +345,7 @@ extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *ppos,
 
 int ptr_to_hashval(const void *ptr, unsigned long *hashval_out);
 
-/**
- * strstarts - does @str start with @prefix?
- * @str: string to examine
- * @prefix: prefix to look for.
- */
-static inline bool strstarts(const char *str, const char *prefix)
-{
-	return strncmp(str, prefix, strlen(prefix)) == 0;
-}
+bool strstarts(const char *str, const char *prefix);
 
 size_t memweight(const void *ptr, size_t bytes);
 
diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d259e43dfb63d76c2bd57ef74e2fd1..ea52c8509328358e436766b1186a82419d45089d 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -285,6 +285,28 @@ int strcmp(const char *cs, const char *ct)
 EXPORT_SYMBOL(strcmp);
 #endif
 
+/**
+ * strstarts - does @str start with @prefix?
+ * @str: string to examine
+ * @prefix: prefix to look for.
+ */
+bool strstarts(const char *str, const char *prefix)
+{
+	unsigned char c1, c2;
+
+	do {
+		c1 = *str++;
+		c2 = *prefix++;
+
+		if (c1 != c2)
+			return c2 == '\0';
+
+	} while (c2 != '\0');
+
+	return true;
+}
+EXPORT_SYMBOL(strstarts);
+
 #ifndef __HAVE_ARCH_STRNCMP
 /**
  * strncmp - Compare two length-limited strings

-- 
2.34.1

