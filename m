Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B180C09
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 06:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393605; cv=none; b=UScGOjzK+WoXTj7LnjFGaiKiaWEnYD9g0U1sryHMKcP93jKN15fFK9Ly3CY7EvyaVKhZybytRMjTlSeKpuC1EKwfwWsVJsgNX4mW73kryUCiEY7l5rr0TnPSckPrch4VHK/XNmKOM4zZGgJKR9+1YbzAVFuwiS6JP3cTiIwsVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393605; c=relaxed/simple;
	bh=WjDBsigCCcP9S6Yhdk5Gu6NGO/HMqeYksqHbI10BQ9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvWsD7QYrLOndYL+fr81QeRkD1x03g0WLc088Ui+eLA8t9e+V/eDsZreBAFKO/T1da892QWOh4bPdrWy8J8G3Wk7dOHTbYbzGbHanN04MLffzt6W7kohUuW+jGJP0DnUFE+aHQw6k6x3zJOhyLVnCsG1bmOzcLmcczzc/P0A37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqqT460vBz1xvpp;
	Fri, 23 Aug 2024 14:11:20 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 30F5A14013B;
	Fri, 23 Aug 2024 14:13:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:13:15 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>
CC: <lihongbo22@huawei.com>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next 2/2] lib/string_choices: Add wrapper for str_false_true()
Date: Fri, 23 Aug 2024 14:20:46 +0800
Message-ID: <20240823062046.3323694-3-lihongbo22@huawei.com>
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

There are many "false" : "true" format in the kernel tree,
so we add str_false_true() as well.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/linux/string_choices.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 7c74497caf2b..ebcc56b28ede 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -52,6 +52,7 @@ static inline const char *str_true_false(bool v)
 {
 	return v ? "true" : "false";
 }
+#define str_false_true(v)		str_true_false(!(v))
 
 /**
  * str_plural - Return the simple pluralization based on English counts
-- 
2.34.1

