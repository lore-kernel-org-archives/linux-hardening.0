Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCD55C3E
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 06:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393600; cv=none; b=mKB8w5s0jAAV//FT6GvElmw37EIKoTMFjeY09suNZIDneU8Kl1ACPFCHokJhgaph8sc10kqSX07jK4BOQ+WWVgo4WpSZSgXDuZl9dOe7QxrOmWbMQ/UBm3QUciTfXFE8JuRPkHFRPBI1k1wzHqozXSdvcWey50hhDSTm71OV5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393600; c=relaxed/simple;
	bh=Yx2F3EhWEFClDaFErl0xyAgVMqTWkjWYhcZHDi/MihA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0sJJ0/T8VjNlxS9kZ73mLa/MZ385iG/mcQUrRXEUFV2l3kQSYKU9CnOgki0wDNzIM1sYpRgOXtNJEpHK2Y2J6fX8VrZmoCu34tpx3jKiKBm3eHR1GRVnKVroOGTXzLcVzz5WZ+faQUNFjVpaypUlYF6w9dhYZP+cPJnkcdkto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqqVq2ry8zyR13;
	Fri, 23 Aug 2024 14:12:51 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B3B3180106;
	Fri, 23 Aug 2024 14:13:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:13:15 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>
CC: <lihongbo22@huawei.com>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next 1/2] lib/string_choices: Add str_true_false() helper
Date: Fri, 23 Aug 2024 14:20:45 +0800
Message-ID: <20240823062046.3323694-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823062046.3323694-1-lihongbo22@huawei.com>
References: <20240823062046.3323694-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Add str_true_false() helper to return "true" or "false"
string literal.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/linux/string_choices.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 1320bcdcb89c..7c74497caf2b 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -48,6 +48,11 @@ static inline const char *str_up_down(bool v)
 }
 #define str_down_up(v)		str_up_down(!(v))
 
+static inline const char *str_true_false(bool v)
+{
+	return v ? "true" : "false";
+}
+
 /**
  * str_plural - Return the simple pluralization based on English counts
  * @num: Number used for deciding pluralization
-- 
2.34.1

