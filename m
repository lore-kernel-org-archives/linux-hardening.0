Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158ACEADA
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733276303; cv=none; b=o3DU0zXeaNdFGHs3or2XDNkkEYUL2hMk2b8eJcCkTS/expO2aUj0eU9hFol6eldupbZXlIpEdGYioDPE8Q4ASlInYX7TXklCm5b8hkBMhHT0Yb46wbcVsxDbGMzPyaVqjyKeanophNBdnnERGTdTaK0aquS1Tn/No2aU1nmNbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733276303; c=relaxed/simple;
	bh=oUyXKjaZqd6IcY+J38/Kzb9pVSJg6bdQfDMeVWDwsdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P2sq2cFCDbeRrEP9962A2Ptot9qgKEJ6R7kQ+m7Rag65h8OWb1OMV4PmkuIZrvaSElXfSmqZbcEgw0/Chl2ygetA7FG1p5xrLeMQxL0gJNhWiMj70zWPJQOE2ba1p4zWdc6i574TT9SZcdqtwP/OLy7QcxIyqnOPORSHkcfrAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y30TC1Xt3zPq1w;
	Wed,  4 Dec 2024 09:35:27 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id DCE73180104;
	Wed,  4 Dec 2024 09:38:16 +0800 (CST)
Received: from [10.174.177.186] (10.174.177.186) by
 kwepemg500008.china.huawei.com (7.202.181.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Dec 2024 09:38:16 +0800
Message-ID: <8462ee54-790a-f6fa-2145-f4b32ec9c4bd@huawei.com>
Date: Wed, 4 Dec 2024 09:38:15 +0800
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
To: Matthew Wilcox <willy@infradead.org>, Uladzislau Rezki <urezki@gmail.com>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, <gustavoars@kernel.org>,
	<akpm@linux-foundation.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <keescook@chromium.org>
References: <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
 <Z077_8rNvTGrCb8L@pc636> <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com> <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com> <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com> <Z08TlFqWVWs47g9z@pc636>
 <Z09VwuhfQbbro-gA@pc638.lan> <Z09icnP7QuaLg4Qv@casper.infradead.org>
From: zuoze <zuoze1@huawei.com>
In-Reply-To: <Z09icnP7QuaLg4Qv@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)



在 2024/12/4 3:56, Matthew Wilcox 写道:
> On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:
> 
> I think there are a few other things we can try here.
> 
> First, if the copy is small (and I still don't have an answer to that
> ...), we can skip the vmalloc lookup if the copy doesn't cross a page
> boundary.
> 

large data packet.

> Second, we could try storing this in a maple tree rather than an rbtree.
> That gives us RCU protected lookups rather than under a spinlock.
> 
> It might even be worth going to a rwlock first, in case the problem is
> that there's severe lock contention.
> 
> But I've asked for data on spinlock contention and not received an
> answer on that either, so I don't know what to suggest.

Thank you very much for your suggestions. We will check the spinlock
contention in the future.

> 
> Anyway, NACK to the original patch; that's just a horrible idea.
> 
