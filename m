Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7C193427
	for <linux-hardening@vger.kernel.org>; Thu,  5 Sep 2024 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527830; cv=none; b=XfDc/1EhzzUqu1lH06K6b3xRyg9+DX8oQZETWYrJHpH4/1Vv4CNUMyXqp5w0iQ7E970V4GEnyFkXpSwLPFJw1SH/aNXlpXeXwzI5by0PLl+Mci95q7SG8cP3CY2QYE2hac8Ks6KVPiiVQYVW/mZbiXYeFvk+8TZ0adGXCCEPXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527830; c=relaxed/simple;
	bh=nWmsa+eytdV7zeHgCZ7Qtr0llha2FDjimKZrJQbIy+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz/A+DoRiY5LvRT/5Eg39n2xNzHZoO2C+E/cWep2/AHDJVc5vYtG3q+Lq7UurA22ppEkAVTM9QzzpETifxGKgun/e7aEZaUKn+FtqZi6xBMMfzqND5uZ7eTgj8FtGCryYA3ud31b5BckD0H+KG2acE1BP3i6awUeYXHdpvPfQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wztyz2t9Gz1j5bV;
	Thu,  5 Sep 2024 17:16:43 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id BEDA5180041;
	Thu,  5 Sep 2024 17:17:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 5 Sep
 2024 17:17:04 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <lihongbo22@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH -next v2 2/2] lib/string_choices: Add some comments to make more clear for string choices helpers.
Date: Thu, 5 Sep 2024 17:25:40 +0800
Message-ID: <20240905092540.2962122-3-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905092540.2962122-1-lihongbo22@huawei.com>
References: <20240905092540.2962122-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add some comments to explain why we should use string_choices helpers.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/linux/string_choices.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index c2134eeda1fd..5a89261d3918 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -2,6 +2,19 @@
 #ifndef _LINUX_STRING_CHOICES_H_
 #define _LINUX_STRING_CHOICES_H_
 
+/*
+ * Here provide a series of helpers in the str_$TRUE_$FALSE format (you can
+ * also expand some helpers as needed), where $TRUE and $FALSE are their
+ * corresponding literal strings. These helpers can be used in the printing
+ * and also in other places where constant strings are required. Using these
+ * helpers offers the following benefits:
+ *  1) Reducing the hardcoding of strings, which makes the code more elegant
+ *     through these simple literal-meaning helpers.
+ *  2) Unifying the output, which prevents the same string from being printed
+ *     in various forms, such as enable/disable, enabled/disabled, en/dis.
+ *  3) Deduping by the linker, which results in a smaller binary file.
+ */
+
 #include <linux/types.h>
 
 static inline const char *str_enable_disable(bool v)
-- 
2.34.1

