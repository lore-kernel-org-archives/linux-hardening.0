Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDAC4A15
	for <linux-hardening@vger.kernel.org>; Sat, 24 Aug 2024 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724482941; cv=none; b=cT2rtsnTCHGM647Ml9lku93CLU9kCKXppqAja3RsuR/4u5ujYJT3kvHrlBoT0jI/RWodMjNLyUdnk86AO2wDrjv94C6u75zUSi8WmxIDUFHevFclwSWRu/jXzJJdt9PeCTze10qwK4pXkqpsEL/Zfr8g1WbGjumtUHFWy3lRuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724482941; c=relaxed/simple;
	bh=+RvRieAZhWMo9zErESPDisXiQ0HSOM/F4G9aYiwdT2k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U+g1N2uH24tjRustF7jMfCOTQZdMgE3/qh2yxz288gizZTl0Kk/iTrx5RO3LGJdk/U6EGmOU90eWNXFAFHjxyd4xN9gYHvOHDaF5/JDrPe9eknXcVItl+I9nwWguBHQuVh++eum/SW2l3vABfdntkXg527Bc91NBOMMjl3hisd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WrSRm1ZnQzQqNR;
	Sat, 24 Aug 2024 14:57:24 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6ED5218007C;
	Sat, 24 Aug 2024 15:02:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 15:02:09 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <gregkh@linuxfoundation.org>
CC: <lihongbo22@huawei.com>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next v2] lib/string_choices: Add str_true_false()/str_false_true() helper
Date: Sat, 24 Aug 2024 15:09:50 +0800
Message-ID: <20240824070950.2014859-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add str_true_false()/str_false_true() helper to return "true" or
"false" string literal.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

---
v2:
  - Squash into a single patch as Andy Shevchenko' suggesstion.

v1:
  - https://lore.kernel.org/all/1deb2bc4-0cd1-41a0-9434-65c02eef77ed@huawei.com/T/
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 1320bcdcb89c..ebcc56b28ede 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -48,6 +48,12 @@ static inline const char *str_up_down(bool v)
 }
 #define str_down_up(v)		str_up_down(!(v))
 
+static inline const char *str_true_false(bool v)
+{
+	return v ? "true" : "false";
+}
+#define str_false_true(v)		str_true_false(!(v))
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.34.1

