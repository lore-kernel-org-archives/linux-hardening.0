Received: from pv50p00im-ztdg10021801.me.com (pv50p00im-ztdg10021801.me.com [17.58.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD271253B7C
	for <linux-hardening@vger.kernel.org>; Mon,  7 Apr 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031758; cv=none; b=iTPKQtWjvMuMMHkwLNUxMeBo+HduMjNivC1yWAJCHHrxEcYEbnowhSt0+oBIK9L8aJVSmmchmnP51h1RBFaRqJwkJmner2LyfXDoL/O/t7o7mFa3Tws2wcv2zTUCoK+WwVNJqd6+PQ0NfkHjHDtHrGV/8NZdIPMSj6lFzda4NMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031758; c=relaxed/simple;
	bh=XrX/Z+AOhfXmEUSaVhxUD9cmEn5LGPbbovm8Fw8fiFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhztfXHCqoOu2N2t/t9A8KJx1OnBMhnHmlJoF7ksxFHUBuSJCtOJgRIfI4B85PazCzbjDP5SGCWiOCEWzenbzYxHHMvlwL7Y5kljVynYrzWlGy3zXP7mqgFk/N4XwoAmEYKZIph0ub9n198vY+spGfWFaJVc4BOFvFy+3VDgDqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0Nlrh5hF; arc=none smtp.client-ip=17.58.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0Nlrh5hF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oFXzI48UtHlC5gVTKT4LJShhvIch9BxoEqw0fKpqk/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=0Nlrh5hF70k5PHoBhb2eYeJt2px45N3je3kaQ5F9mridzEOH8j118rRFE2nc7gwPD
	 q4AkEcyfwcwsKPFP38IAXj1W2rhT5FI2OiSqKZRgI0X0R7XLpUfHnfBeGW4fjH9P45
	 BUsw9JfeFwstjvf3YJZOzM/e6YK+DKtFfVVul5HE+kSPAjPqW0NPVbx7+jcy8//YhR
	 oqunN5O2b/XfOM60659TwJWmjWxqFfDYKI0rPUBf48Ylmd/yleeZsDLrYZm0wBDzx8
	 aJvxfh0OtA8fg1DohpJ7MfaO3KMDLoN9DZv+HUsd7Dwp7rzRpMpszus7fjODqMdu0d
	 STFU4pgWYJhYA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021801.me.com (Postfix) with ESMTPSA id 69C4420103AB;
	Mon,  7 Apr 2025 13:15:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 07 Apr 2025 21:15:05 +0800
Subject: [PATCH 2/2] lib/string: Improve str_has_prefix() performance
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-imp_str_perf-v1-2-ed95d52964a4@quicinc.com>
References: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
In-Reply-To: <20250407-imp_str_perf-v1-0-ed95d52964a4@quicinc.com>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 2pNzYH1mkE44dWijZpEUiyG1UerlZF5X
X-Proofpoint-ORIG-GUID: 2pNzYH1mkE44dWijZpEUiyG1UerlZF5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=843 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504070093
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

str_has_prefix() is frequently invoked to return length of the prefix
string if a string has another string as prefix, but its performance
is degraded by the strlen() loop contained.

Improve its performance by eliminating the strlen() loop.

Link: https://lore.kernel.org/all/20250113234643.GA3631169-robh@kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
---
 include/linux/string.h | 21 +--------------------
 lib/string.c           | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index e5f7defa277572719e1dbfdd264f3de6ef8544f1..394b76666ece0924c50264aaca39784d5630a2fe 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -533,25 +533,6 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
 	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
 })
 
-/**
- * str_has_prefix - Test if a string has a given prefix
- * @str: The string to test
- * @prefix: The string to see if @str starts with
- *
- * A common way to test a prefix of a string is to do:
- *  strncmp(str, prefix, sizeof(prefix) - 1)
- *
- * But this can lead to bugs due to typos, or if prefix is a pointer
- * and not a constant. Instead use str_has_prefix().
- *
- * Returns:
- * * strlen(@prefix) if @str starts with @prefix
- * * 0 if @str does not start with @prefix
- */
-static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
-{
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) == 0 ? len : 0;
-}
+size_t str_has_prefix(const char *str, const char *prefix);
 
 #endif /* _LINUX_STRING_H_ */
diff --git a/lib/string.c b/lib/string.c
index ea52c8509328358e436766b1186a82419d45089d..17f1a070b190debc3eaeff6d1ae45b55bae69b29 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -332,6 +332,39 @@ int strncmp(const char *cs, const char *ct, size_t count)
 EXPORT_SYMBOL(strncmp);
 #endif
 
+/**
+ * str_has_prefix - Test if a string has a given prefix
+ * @str: The string to test
+ * @prefix: The string to see if @str starts with
+ *
+ * A common way to test a prefix of a string is to do:
+ *  strncmp(str, prefix, sizeof(prefix) - 1)
+ *
+ * But this can lead to bugs due to typos, or if prefix is a pointer
+ * and not a constant. Instead use str_has_prefix().
+ *
+ * Returns:
+ * * strlen(@prefix) if @str starts with @prefix
+ * * 0 if @str does not start with @prefix
+ */
+size_t str_has_prefix(const char *str, const char *prefix)
+{
+	const char *p = prefix;
+	unsigned char c1, c2;
+
+	do {
+		c1 = *str++;
+		c2 = *p++;
+
+		if (c1 != c2)
+			return c2 == '\0' ? p - 1 - prefix : 0;
+
+	} while (c2 != '\0');
+
+	return p - 1 - prefix;
+}
+EXPORT_SYMBOL(str_has_prefix);
+
 #ifndef __HAVE_ARCH_STRCHR
 /**
  * strchr - Find the first occurrence of a character in a string

-- 
2.34.1

