Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3AE146A97
	for <linux-hardening@vger.kernel.org>; Wed,  4 Sep 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435746; cv=none; b=vE6Kc/FjWKM4pA6HWBLAgEmeLFRlQEtT+xz899bVj0/sQC1saRHPyqJrN9MlrgWRJP6r+oMSUg3K35dJCfz+BDPJ3TSAEVUM9z4c6Ch/4jVm9IoaQ04XnxxQVbVKlqAJI42LGNaC4XWT4BsxKVS+WJKy9hxDUNWCdGxwhGIi84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435746; c=relaxed/simple;
	bh=gSXYlgNNLWCDKHClQerj3c+lGh8d8v7kQMto5z12hGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UCeAZzGex73XD4UnqgheTAPfvZXdrkoDjlglh/7eVlkLsw32aj0OTQHB0HhlkL3qzb+VlaqB1cAVYnieuZIvIHRQ87Zu1UD3+V4PG7q+EbRbM/VBejiZ4KdGO9ogCZ71hN8rb90NKC1SmWOp4dz2mMpZJcJ8f/VzIFVsWg9RqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WzDvQ2F52z13S81;
	Wed,  4 Sep 2024 15:41:22 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 88006180087;
	Wed,  4 Sep 2024 15:42:19 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 15:42:19 +0800
Message-ID: <1b9c1d9d-b9c1-4583-83dc-a331b56b85f9@huawei.com>
Date: Wed, 4 Sep 2024 15:42:18 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] coccinelle: Add rules to find
 str_true_false/str_false_true replacements
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: <kees@kernel.org>, <andy@kernel.org>, <Julia.Lawall@inria.fr>,
	<nicolas.palix@imag.fr>, <linux-hardening@vger.kernel.org>, <cocci@inria.fr>
References: <20240829112455.232263-1-lihongbo22@huawei.com>
 <1c8dbb13-e7c1-4031-8c85-a5a676eb8fd4@huawei.com>
 <CAHp75VcEhn8gv_aGGsTF_FkhqStqSWcR_rUr+BwtQ5305g=cnA@mail.gmail.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CAHp75VcEhn8gv_aGGsTF_FkhqStqSWcR_rUr+BwtQ5305g=cnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/4 15:37, Andy Shevchenko wrote:
> On Wed, Sep 4, 2024 at 5:36 AM Hongbo Li <lihongbo22@huawei.com> wrote:
>> On 2024/8/29 19:24, Hongbo Li wrote:
> 
> ...
> 
>> I found that there are still a few function rules that are not complete,
>> such as str_on_off, str_enable_disable, str_yes_no. How about adding
>> these rules as well?
> 
> Why not?
> 
Fine. I'll add these rules in v2

Thanks,
Hongbo
