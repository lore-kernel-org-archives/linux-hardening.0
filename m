Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C95BE5E
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304079; cv=none; b=JF/J5LXt8TJGo9MmuukISkI1ENBnv3Z+GMn4+zWI9h5pM675Ar0CTij5y6q45y5PVRjPtpu2OUZ6Yncwm7I5E3PNLcRZZBloQlsUcih1LdMhg9TaKErRqNlpLnDoBlt/QlnSbty249wmoY21pMx/SPAWM2Hbhkca7fblggmJOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304079; c=relaxed/simple;
	bh=ZJzp5djUS4uTNDp9oxKN8NCzAjfpdU6KqlQH5RsjSVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RYw5PQSO+PKuDRyQDsmrQUaR7K3jY8P1+UR8r1bV9axgBCIWpf5qIinuPVsgN7eWR+MycspKXzy1T97rtDAcAgs0rL7VzjGyCu75MX1y9RkhgfSeK1ofirC+yzUmVMp3nkTJdOtmPksJSEUurCzFRzY1WEg2EiHeGW3uWhO7qfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y3BlF2yLXz1V5SG;
	Wed,  4 Dec 2024 17:18:17 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id CDA3514011D;
	Wed,  4 Dec 2024 17:21:13 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 17:21:12 +0800
Message-ID: <2dae287b-c645-3773-4f99-fd44902ae589@huawei.com>
Date: Wed, 4 Dec 2024 17:21:12 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass the
 vmalloc check.
To: Uladzislau Rezki <urezki@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
CC: <gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<keescook@chromium.org>
References: <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com> <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com> <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com> <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan> <Z09icnP7QuaLg4Qv@casper.infradead.org>
 <Z1ALDmybeJfpIqge@pc636>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <Z1ALDmybeJfpIqge@pc636>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2024/12/4 15:55, Uladzislau Rezki 写道:
> On Tue, Dec 03, 2024 at 07:56:34PM +0000, Matthew Wilcox wrote:
>> On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:
>>
>> I think there are a few other things we can try here.
>>
>> First, if the copy is small (and I still don't have an answer to that
>> ...), we can skip the vmalloc lookup if the copy doesn't cross a page
>> boundary.
>>
>> Second, we could try storing this in a maple tree rather than an rbtree.
>> That gives us RCU protected lookups rather than under a spinlock.
>>
>> It might even be worth going to a rwlock first, in case the problem is
>> that there's severe lock contention.
>>
>> But I've asked for data on spinlock contention and not received an
>> answer on that either, so I don't know what to suggest.
>>
> I think, it is not about contention. It is about the extra "attached
> load" when a data is heavily copied force and back. On each copy path
> you need to do a scan. Maple tree is not that something can help here :)
> 
> Indeed, no contention data. Zuoze, please share this if you can.

We have enabled perf lock contention and are currently debugging the
environment. We will share the results as soon as we have them.

> 
> --
> Uladzislau Rezki
