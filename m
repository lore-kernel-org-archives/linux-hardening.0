Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9021EB21
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417367; cv=none; b=FCoYjWotAOlJFdVcg0qMHCkKaE75SI9OgQ0dPT7ooa/DGA4k+/p7WIJTzfmENt3rGHqWab8kJsHGSqk7OYMkO3BqeuMebmaOHIvMSp6QNrNLEZ4O006FLYFfHXefUMFgT+hxqMic2dUvS50PfP3P5fiP8+/WoyJz7panMn0N73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417367; c=relaxed/simple;
	bh=3YxohURSvbQFm26h+LmWfZwPz9UrQzcbDIR/yccu0Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OJYify7+0ncl5X/dvpRAlDXjoRTpp5V6X55W/hbeBM+14mAJSSW9li5Mxywmv9lJ+JTnM4bYwBSLXEIAlFtDsxMPIUTSSM+a2ZmFbH2OZKzRqD2cnALK7d3JatRZCoverQy80CkX+1UOi4fTVXIpnptLZnarEKdymBozjpjeQbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wz61M6V08z20nKH;
	Wed,  4 Sep 2024 10:31:03 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A9B21A016C;
	Wed,  4 Sep 2024 10:36:00 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 10:36:00 +0800
Message-ID: <1c8dbb13-e7c1-4031-8c85-a5a676eb8fd4@huawei.com>
Date: Wed, 4 Sep 2024 10:36:00 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] coccinelle: Add rules to find
 str_true_false/str_false_true replacements
Content-Language: en-US
To: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>
CC: <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
References: <20240829112455.232263-1-lihongbo22@huawei.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240829112455.232263-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/29 19:24, Hongbo Li wrote:
> After str_true_false()/str_false_true() has been introduced
> in the tree, we can add rules for finding places where
> str_true_false()/str_false_true() can be used.
> 
> Hongbo Li (2):
>    coccinelle: Add rules to find str_true_false() replacements
>    coccinelle: Add rules to find str_false_true() replacements
> 

I found that there are still a few function rules that are not complete, 
such as str_on_off, str_enable_disable, str_yes_no. How about adding 
these rules as well?

Thanks,
Hongbo

>   scripts/coccinelle/api/string_choices.cocci | 46 +++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
