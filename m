Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746517740
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930218; cv=none; b=Cvi8OAaA0QfxetmxU3/9ApdTpdmncKhap+j2IYiu/st+dnVP/fMBQQAI2nnlkpUWjnpiPCvrievoL+BSel6B5xmWP8az3vjev1HOgXXNAnYcB/fuCHTuDCo+r9hDo0t8alDEfRmcb/RvBhwIAIBrjF1qx5NbW7+/bzNNWNnIL3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930218; c=relaxed/simple;
	bh=EM+yiisJGf3VPuCnbr7yXuKVJ1iXoKZUTDTufFXpP7A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mqfr/OaEELH1LFoS7jripQWMN5sAJt5FZw1Frr6yM6+WKWAoW3SHfGhuwuh1I31kRXhzFSX9eW7Gjze+JPIslHT7GtD8yMyExnpEkezwLKFNCIcZRWTAmnvLktTASKbl8rT0MgxFxUfg6vaVss9PthfGVYiLZlAJjjn8OcVqH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wvdyc3nxcz2DbZs;
	Thu, 29 Aug 2024 19:16:40 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2368F180042;
	Thu, 29 Aug 2024 19:16:53 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 19:16:52 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>,
	<lihongbo22@huawei.com>
Subject: [PATCH -next 0/2] coccinelle: Add rules to find str_true_false/str_false_true replacements
Date: Thu, 29 Aug 2024 19:24:53 +0800
Message-ID: <20240829112455.232263-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)

After str_true_false()/str_false_true() has been introduced
in the tree, we can add rules for finding places where
str_true_false()/str_false_true() can be used.

Hongbo Li (2):
  coccinelle: Add rules to find str_true_false() replacements
  coccinelle: Add rules to find str_false_true() replacements

 scripts/coccinelle/api/string_choices.cocci | 46 +++++++++++++++++++++
 1 file changed, 46 insertions(+)

-- 
2.34.1

