Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FD193427
	for <linux-hardening@vger.kernel.org>; Thu,  5 Sep 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527834; cv=none; b=G2HoSA2Vn4ARsBzVDtohk8SugC4s6kOZnqKpYQbi2mVu0vV2FFACYP3wlW6mT20521cgTyFwoqQnoNVLSSiz5ESzV23fZt4O17m9uk27AHQ1LKKtTFzALOqBdKC8of9L3IUtGpPEGCcdzXv7WVzgSkP2dxLp85jjK0WZ0B899Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527834; c=relaxed/simple;
	bh=ktqgnQkfZMfL3COplmqlqtLPXKFVfMiQEVjmGEyzA38=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SDeaZ27qsRjCUzhC83lm7WklxBaum3uY+YrBAY8/wUxCqIm6H1PtOha9dmlScBczl4Qi7sHeUacKXMTpITcS0eQzDZcxsHJPSDsik13/NdOsdSBBrpxXKEhmn0giEGbvGV8j1dMW2uoGj6ds0M6WNB97zTCi5cLxVz6NORVh/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wztsd0sJxz20mwc;
	Thu,  5 Sep 2024 17:12:05 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AD6B1400DC;
	Thu,  5 Sep 2024 17:17:03 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 5 Sep
 2024 17:17:03 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <lihongbo22@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH -next v2 0/2] Introduce several opposite string choice helpers
Date: Thu, 5 Sep 2024 17:25:38 +0800
Message-ID: <20240905092540.2962122-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Similar to the exists helper: str_enable_disable/
str_enabled_disabled/str_on_off/str_yes_no helpers, we can
add the opposite helpers. That's str_disable_enable,
str_disabled_enabled, str_off_on and str_no_yes.

There are more than 10 cases currently (expect
str_disable_enable now has 3 use cases) exist in the code
can be replaced with these helper.

Changes in v2:
  - Remove the use cases and only keep the added helpers.
  - Add comments to explaing the use of string choices' helpers
    as suggested by Andy.

v1: https://lore.kernel.org/netdev/20240831095840.4173362-1-lihongbo22@huawei.com/

Hongbo Li (2):
  lib/string_choices: Introduce several opposite string choice helpers
  lib/string_choices: Add some comments to make more clear for string
    choices helpers.

 include/linux/string_choices.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.34.1

