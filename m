Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C02857D1
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356425; cv=none; b=LG1URdgwiMNuK6BGW9vaoskm/vZ3852j84mmwb0U2udwcCqfRp14aBOFxWGW0e+iC0VSJ6ZL8Abhhdi/TmxjHcLw0m3imrw6qAn+glLPytV+vFDI/oCS795bKfXrmS59GcWI8UKkkUZjJiTH2BMlWgryP+r0JDPTvSEBOpiXYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356425; c=relaxed/simple;
	bh=iOidn7l9NBNpeJnxah+wYGgaGQgm9n4v7YKZnNqAmSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXgaWoM315E2rhQ9cllg4RcikdUJKlj4TgmoFlpmsFsfa55liBoRFamdw+JVesyQIAINHlw3yFqRAOeG1MMW22wZTBTqGWwCs/FedoREjD4513Tie5WHMfMQg4/dOYSc1lauf9rsFwUPwQwqldAKofANC++WhWzS0ECawNFqKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=DhVNVtVq; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="DhVNVtVq"
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id 36Umuf4LFiuzS38muuvoCk; Fri, 11 Apr 2025 07:26:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 38mtuwIMnq3CN38mtuVN86; Fri, 11 Apr 2025 07:26:55 +0000
X-Authority-Analysis: v=2.4 cv=VpfoAP2n c=1 sm=1 tr=0 ts=67f8c43f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10
 a=0jM7oEE7EF-Y5LCAcXEA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l/zosEz8AhTGxiuaGjJlq1yFgsiJbd3WrDaBZ/z6su0=; b=DhVNVtVq885OUFdIbXryphjU0c
	4/ZrblqXNy1b9xM2mKc6AzzrEpOyO469J0QIe+7J85BPST3IDVMtd3hAk9WN6O7KZqO9TJcDwWWXm
	kKrreeDDQw2eO7jQvtxtnpLayd9m0uLC2xtv6wBMSR1R2pt6/w8tgOeNcOT3ZdETx4x9+DfVn4e0F
	fFZwHNvH1yQ1/VKjS0vzdbdAx1dsRLOZFdWlgG1IBciDmDlNw1Z/PoeK0SYrwuuDXwAuI+VWQ4+ip
	O3P2fvJlmFScdSFp6aj+uq7eIlYRPA5EurB5dG+MaL5MMsia379ug/dQAi2FP2NpSs5cDGWNC7i+w
	XTLDsyIg==;
Received: from [201.172.174.147] (port=33292 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u38ms-00000002ADY-286a;
	Fri, 11 Apr 2025 02:26:54 -0500
Message-ID: <25518061-7b9d-4a43-be53-c5aee80c0f1d@embeddedor.com>
Date: Fri, 11 Apr 2025 01:26:15 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: chan: Avoid
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z-67Hm9uHEJs0RGw@kspp> <202504071227.E8484EB@keescook>
 <d8e63b8a-7a2c-46dc-a15c-9399044a23ee@embeddedor.com>
 <202504071336.0C708FCAB8@keescook>
 <a6dccb66-3f97-443f-85e5-fe089cd93a5e@embeddedor.com>
 <202504081637.D17F824CE@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202504081637.D17F824CE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u38ms-00000002ADY-286a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.147]:33292
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLhYUEgXpE/PKrWbMrZ+ayTfysPsy7do5mvQAtU8ymcEPCgDhY8HXWbNmxsRUNMi2oeuDdeJVfTngmBSzUPvworOjulFAQMGZqiFEw7MJNrx5oWWhyGD
 PP3dqCVgdq2K2e08eXXIU02bobKmJ+FjTQmrduf1g3Doaeh9onynq3o7texvmT6/dz9r7ufWEFqOzg94s2MJFENR2lJvaebKVoOs3KC/eeiMxSd5IjP5k+UL



On 08/04/25 17:40, Kees Cook wrote:
> On Mon, Apr 07, 2025 at 05:35:47PM -0600, Gustavo A. R. Silva wrote:
>> [..]
>>
>>>>>> -	struct {
>>>>>> -		struct nvif_chan_v0 chan;
>>>>>> -		char name[TASK_COMM_LEN+16];
>>>>>> -	} args;
>>>>>> +	DEFINE_RAW_FLEX(struct nvif_chan_v0, args, name, TASK_COMM_LEN + 16);
>>>>>>     	struct nvif_device *device = &cli->device;
>>>>>>     	struct nouveau_channel *chan;
>>>>>>     	const u64 plength = 0x10000;
>>>>>> @@ -298,28 +295,28 @@ nouveau_channel_ctor(struct nouveau_cli *cli, bool priv, u64 runm,
>>>>>>     		return ret;
>>>>>>     	/* create channel object */
>>>>>> -	args.chan.version = 0;
>>>>>> -	args.chan.namelen = sizeof(args.name);
>>>>>> -	args.chan.runlist = __ffs64(runm);
>>>>>> -	args.chan.runq = 0;
>>>>>> -	args.chan.priv = priv;
>>>>>> -	args.chan.devm = BIT(0);
>>>>>> +	args->version = 0;
>>>>>> +	args->namelen = __struct_size(args) - sizeof(*args);
>>>>>
>>>>> Does __struct_size(args->name) work here (and later)?
>>>>
>>>> Why not?
>>>
>>> Uhm, I'm genuinely curious. I *think* it will work, but because it's
>>> within the struct, not outside of it, I'm unclear if it'll DTRT for
>>> finding the size (since __builtin_object_size() can be touchy).
>>>
>>>> I mean, this should be equivalent to `TASK_COMM_LEN+16`, I could
>>>> use the latter if people prefer it (see my comments below).
>>>
>>> Right, it should be the same. I think __struct_size(args->name) would be
>>> much more readable ... if it works. :)
>>
>> OK, I'll double check this.
> 
> Ah-ha, yes, I'm already testing this with KUnit:
> 
> struct bar {
>          int a;
>          u32 counter;
>          s16 array[];
> };
> ...
>          DEFINE_RAW_FLEX(struct bar, two, array, 2);
> 	...
>          KUNIT_EXPECT_EQ(test, sizeof(*two), sizeof(struct bar));
>          KUNIT_EXPECT_EQ(test, __struct_size(two), sizeof(struct bar) + 2 * sizeof(s16));
>          KUNIT_EXPECT_EQ(test, __member_size(two), sizeof(struct bar) + 2 * sizeof(s16));
>          KUNIT_EXPECT_EQ(test, __struct_size(two->array), 2 * sizeof(s16));
>          KUNIT_EXPECT_EQ(test, __member_size(two->array), 2 * sizeof(s16));

Nice! I was taking a look at this, and now I want to use __member_size(p->array)
instead of __struct_size(p->array). ^.^

> 
> 
>> I really don't want to condition -Wflex-array-member-not-at-end patches
>> on counted_by patches, for now.
> 
> Fair enough. :) One thing at a time is wise!
> 

\o/

--
Gustavo

