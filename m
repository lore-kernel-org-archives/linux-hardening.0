Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF21E5B93;
	Tue, 22 Apr 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347818; cv=none; b=hNoUiyyrd+urgsAu8W5VMVMt+AQy6IXCqZwKTtebxqH4C92OktEMTNejtAsRtN9bXRJgIF62AIzgThiuyuljfRlFOdGQAAAZYYky3+VjpLrJ+JH8uGTotk6txaEsqx4giuuIK+dbeGvX8vBLJNeO2d2/nA2qHmip9efUJoKhwKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347818; c=relaxed/simple;
	bh=A4sO/18hIGjg9K1tGmFo8LxqPuyukzVcZVbzcjXtRhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3CeU9jMbjWyn7EGqMVZ187LNcHpbyjDzQU+dzGQ2ke/4nLR/cITr3rVF036903pKQm24H2o6JHD03XZdErfGCdn3cZCGaJXyYdNVUAfoDYBMER4/DH1gg7MkO4Y6G9TEpisY//64wQYoLbFzuvMAlA9SqhzPCubBeJ6xugrIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QEp5Cziq; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QEp5Cziq"
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7Igzu5oOQXKsE7Ih2uGtfj; Tue, 22 Apr 2025 20:50:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745347807;
	bh=S9Ycz3uF+XpWMAYTXkteVNEOxwIekKxbOCFlC0Tad3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=QEp5CziqpDekxPanV0xZmXw9JxlXGxulEa8w40PKTbNiK08ebxVFNMb32MQNYS2Lb
	 xmdmZUGPnjCrV3xlmpuQaMGW9VCmaATGOVJXgvqtdVzYFnZRBkG1Y1GInSPArcEF3Z
	 Xw3N4EZVkG1R+lmTAR5DmxdnsMLpMsEdzfzGtZ6dEqZVdoQxeFBLFeQvBCfqsRWOkS
	 +FOQsHiLPTUris2bkXptt+5zU6lUA0jZbQIYSO2NfALnnSbbKKYmgO9K/bmo/5qrpq
	 YFKDjlhohzapY6lzcXCnKtsOc0ysEOSoJ7uU/F8EmYfnwsPtcZFv7yVeniiBqzsPeR
	 1UKKTt69eOsPg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 22 Apr 2025 20:50:07 +0200
X-ME-IP: 90.11.132.44
Message-ID: <501ea9b1-017b-4517-8de4-7056803e7127@wanadoo.fr>
Date: Tue, 22 Apr 2025 20:50:01 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/damon/sysfs-schemes: using kmalloc_array() and
 size_add()
To: SeongJae Park <sj@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Su Hui <suhui@nfschina.com>, akpm@linux-foundation.org,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
References: <adbc06d8-1a6c-4279-9596-d743505d64dd@stanley.mountain>
 <20250422182331.59651-1-sj@kernel.org>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250422182331.59651-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/04/2025 à 20:23, SeongJae Park a écrit :
> On Tue, 22 Apr 2025 13:44:39 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
>> On Tue, Apr 22, 2025 at 01:38:05PM +0300, Dan Carpenter wrote:
>>> On Mon, Apr 21, 2025 at 02:24:24PM +0800, Su Hui wrote:
>>>> It's safer to using kmalloc_array() and size_add() because it can
>>>> prevent possible overflow problem.
>>>>
>>>> Signed-off-by: Su Hui <suhui@nfschina.com>
> [...]
>>>> --- a/mm/damon/sysfs-schemes.c
>>>> +++ b/mm/damon/sysfs-schemes.c
>>>> @@ -465,7 +465,8 @@ static ssize_t memcg_path_store(struct kobject *kobj,
>>>>   {
>>>>   	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
>>>>   			struct damon_sysfs_scheme_filter, kobj);
>>>> -	char *path = kmalloc(sizeof(*path) * (count + 1), GFP_KERNEL);
>>>> +	char *path = kmalloc_array(size_add(count, 1), sizeof(*path),
>>>> +				   GFP_KERNEL);
>>>
>>> Count is clamped in rw_verify_area().
>>>
>>> Smatch does a kind of ugly hack to handle rw_verify_area() which is that
>>> it says neither the count nor the pos can be more than 1G.  And obviously
>>> files which are larger than 2GB exist but pretending they don't silences
>>> all these integer overflow warnings.
>>>
>>
>> Actually rw_verify_area() ensures that "pos + count" can't overflow.  But
>> here we are multiplying.  Fortunately, we are multiplying by 1 so that's
>> safe and also count can't be larger than PAGE_SIZE here which is safe as
>> well.
> 
> Thank you for adding these details, Dan.  I understand the size_add() change
> can make warnings slience, though it is not really fixing a real bug.  So I
> believe there is no action item to make a change to this patch.  Maybe making
> the commit message more clarified can be helpful, though?
> 
> Please let me know if I'm misunderstanding your point and/or you want some
> changes.

As sizeof(*path) = 1, maybe, just change it to:
	char *path = kmalloc(count + 1, GFP_KERNEL);

CJ
> 
> 
> Thanks,
> SJ
> 
>>
>> regards,
>> dan carpenter
> 
> 

