Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767503A4F53;
	Thu,  5 Feb 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285933; cv=none; b=a53G9IIB2nSwZg15y24wq010KZ+z5tLpzrdVRQv/dbpxSLlcp7RWi9Qz3L1dlFZFcvb+spVosh4BCB1UG4miaNa51tQnmaxEEp9hGa9wz1wBA8jvvT8c79GiouOrt89nPuaHPNFXeZ97f+5uHe79m4OAQlxAmt+rWKb80tYpWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285933; c=relaxed/simple;
	bh=CDZnJdl+iIJikVsP1GMe3AmASOfylEwnVv1gl1UdFwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FsDeSLfxnZxoczclKPApk8ZjPPDQkDoennJS6EZXNuVapDmSY0xFOsJOmluUq1PepH5R0iNmYJHR26USxDjv+JOpzfSSTS0ARUt/7OY30vLJu5S+vZJq5qpwh2auSYebz73D3nbHuUCxf+FP4cHBgwIz8tC8zg31pTC2x4OZkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KErAzQSu; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KErAzQSu"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+0bnrjD1Vt8hf7jyTJXY+6HGtA8bkKy60Hegi1EeXzE=;
	b=KErAzQSuu70Kg2tunAhFZO3MBpPC7k3h5KGOAK7Yth1CwoXzqszVQ/V27rlWwZjlEuJIUlQhx
	CKQQDOlzJUQN+kjKkoOLhfLv55oAw9AARbsQL1EQcQ71tK+rikghI2bJ+0r3wYKiEWTDYlmzRSj
	qGRAkW3QKz6zi0Nss37jJuQ=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f6CQz5HsSzcZym;
	Thu,  5 Feb 2026 18:00:59 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 2777840561;
	Thu,  5 Feb 2026 18:05:24 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Feb 2026 18:05:23 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [PATCH 1/2] string: move __compiletime_strlen() to string.h
Date: Thu, 5 Feb 2026 18:05:16 +0800
Message-ID: <20260205100517.292858-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Move __compiletime_strlen() to string.h, so that others can use.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 include/linux/fortify-string.h | 15 ---------------
 include/linux/string.h         | 15 +++++++++++++++
 lib/tests/fortify_kunit.c      |  3 ++-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 171982e53c9a..c181dac26353 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -58,21 +58,6 @@ void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
 
-#define __compiletime_strlen(p)					\
-({								\
-	char *__p = (char *)(p);				\
-	size_t __ret = SIZE_MAX;				\
-	const size_t __p_size = __member_size(p);		\
-	if (__p_size != SIZE_MAX &&				\
-	    __builtin_constant_p(*__p)) {			\
-		size_t __p_len = __p_size - 1;			\
-		if (__builtin_constant_p(__p[__p_len]) &&	\
-		    __p[__p_len] == '\0')			\
-			__ret = __builtin_strlen(__p);		\
-	}							\
-	__ret;							\
-})
-
 #if defined(__SANITIZE_ADDRESS__)
 
 #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG_GENERIC_ENTRY)
diff --git a/include/linux/string.h b/include/linux/string.h
index 1b564c36d721..fbae7d99bb6f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -19,6 +19,21 @@ extern void *memdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *vmemdup_user(const void __user *, size_t) __realloc_size(2);
 extern void *memdup_user_nul(const void __user *, size_t);
 
+#define __compiletime_strlen(p)					\
+({								\
+	char *__p = (char *)(p);				\
+	size_t __ret = SIZE_MAX;				\
+	const size_t __p_size = __member_size(p);		\
+	if (__p_size != SIZE_MAX &&				\
+	    __builtin_constant_p(*__p)) {			\
+		size_t __p_len = __p_size - 1;			\
+		if (__builtin_constant_p(__p[__p_len]) &&	\
+		    __p[__p_len] == '\0')			\
+			__ret = __builtin_strlen(__p);		\
+	}							\
+	__ret;							\
+})
+
 /**
  * memdup_array_user - duplicate array from user space
  * @src: source address in user space
diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index fc9c76f026d6..86181e3bd994 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -49,7 +49,8 @@ void fortify_add_kunit_error(int write);
 #include <linux/vmalloc.h>
 
 /* Handle being built without CONFIG_FORTIFY_SOURCE */
-#ifndef __compiletime_strlen
+#if defined(__NO_FORTIFY) || !defined(__OPTIMIZE__) || !defined(CONFIG_FORTIFY_SOURCE)
+# undef __compiletime_strlen
 # define __compiletime_strlen __builtin_strlen
 #endif
 
-- 
2.51.0

