Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC3768EC
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393603; cv=none; b=nD+ocvNXoG91kIqW6RPN6zbwDubm3lA+q40oiuslwQLaPT+3j+3zXx4qCRqYemQNz4FBx6Sy4A8l6UYSNe9heVn/FDbtjDuMf+XCKZQlhIN6ztSav2gFsyht5gMbHrkBLxsHJQEEaJ+fhDWnv8aw+8WnEAOmLNjWn8A+jQLR04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393603; c=relaxed/simple;
	bh=KkS3iVrbJGkrIxSCFMOfpi9Sk6Id+leWnKVm2C9RaFA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vc65omnO24bMR5kfHiZhl2EGtGxXYJs80Nbv/8luSNPaXwt6Jj+TfloTKTHGiCsKgFQ2HKcXScmoTFnCZpEX5YGacBvop5M7ZUhpV4VloDMLHFwTVB4oCTqFAr6SZzKccPPFmizrBqVQvM3AZxLikpbCeXWuqD//Go+5vtkSBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqqSv4V1fzhXZT;
	Fri, 23 Aug 2024 14:11:11 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 07524180087;
	Fri, 23 Aug 2024 14:13:13 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 14:13:12 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>
CC: <lihongbo22@huawei.com>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next 0/2] Add str_true_false()/str_false_true() helper
Date: Fri, 23 Aug 2024 14:20:44 +0800
Message-ID: <20240823062046.3323694-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Add str_true_false()/str_false_true() helper to "true" or "false"
string literal. And we found more than 10 cases currently exist
in the tree. So these helpers can be used for these cases.

Hongbo Li (2):
  lib/string_choices: Add str_true_false() helper
  lib/string_choices: Add wrapper for str_false_true()

 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.34.1

