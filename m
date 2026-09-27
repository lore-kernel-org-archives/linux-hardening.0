Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC513CE4B2
	for <linux-hardening@vger.kernel.org>; Sun, 27 Sep 2026 08:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790497468; cv=none; b=hb4T2IqKGGSZmzHMfIy4dpO8Ej+I7/AQfFzBUtdHgQDsgsLJyY0SKu03ykyMBwuq9HJ+4MLnkDIXQxVN1aO6cG036qlUUTHxb8W+QwCBa5ZluGSuYso9u6/d15iRgXx2r5vHWDCZ6FGboxxKOWL/7azbCQzh6WKzR8+9CPk3GfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790497468; c=relaxed/simple;
	bh=3rxqKQhNHuL7o+xcCUTkX75IBd8KS+Bj2j0NN6nk9ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K27qb07XVxtdgeZyoEiYV1dvxIuXzEFEA0w5t5XZ6mvEe16YToEyx2Md6skJ2EUzcB827ROhXsYWYah+bTE7PV9oKxCoXac6FJpsLpXN0KninO3gtM7zkpabBoke5857sK5vP0riVC4puApuIkbH7m2+5IaM3G55u7eQmuO0vGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiwPjk0D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiwPjk0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790497463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwGov1WfVqjaD3uyRV6IMvRELVNTsPWtY2wOQdAbySA=;
	b=LiwPjk0D+ndrNTCR+LMbb5/pDl9PZcbJZvbBXQp/QSyZHyc840xLgbZiYSQg8kZ3TTzjY+
	V+9/FAZY0Kv2+peAPhhy2vGTqJ8HL1s+nDmGqFVaTwKDQ2+EEvHbGfCxm1nT+FizRT12dP
	PHcjXwJGrhnO1loZVGLR0ITS7aLK4tg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-0yXf3j95MDKnoFqofhqCyA-1; Sun, 27 Sep 2026 04:24:22 -0400
X-MC-Unique: 0yXf3j95MDKnoFqofhqCyA-1
X-Mimecast-MFC-AGG-ID: 0yXf3j95MDKnoFqofhqCyA_1790497461
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ffe287240so5540575e9.2
        for <linux-hardening@vger.kernel.org>; Sun, 27 Sep 2026 01:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790497461; x=1791102261;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwGov1WfVqjaD3uyRV6IMvRELVNTsPWtY2wOQdAbySA=;
        b=tLMS5/eKLOlJ/UnjRlhRuN+keOhV9zNDELp+DCTV3q0Kna6VbhIqsb+1/JearW6njU
         XHKkuIiAstin+vJEA91H0voYOxzKZmvd9B8swCcmNFM2qnJbOC7rcn50b7XAioVYX3GA
         aBMQOZC8wKoFX+NKdkGOTm8gxqQVV88nXTNqRNp1ERKMKxpHNgDPT6hpycFNQQ0i+gBn
         4CxjbiK5HIdc0jE8OPcB8v5uAKKC3NX9DPcpSyejiEj0z33MQuFvJiDKq3cKzrGmWVpv
         E4CXv3dAZ9uOdyZJDKWmDMuRYD0XjUqXTDXfAerqb+M0EpX1uS/fLqc6M/eh5M1x55kO
         7Irw==
X-Forwarded-Encrypted: i=1; AKwUvBw4/DJ2Qu0U8NCsQvyZNTc2n9Sq0mSQM510+nOAgaFO6EiyBwXN7/wpouQP7iKF9H92b/UbIHHMD3USd9Bp1os=@vger.kernel.org
X-Gm-Message-State: AFuF++lu/L4sLiaENSUppNe6svhNVDRrH+f7F5sA9oW7yu0iiXJkne0g
	V31U/9RjjsJtMAa3/wLTqW/EzkqTAUHWNHPPXKo7+ZGx7XTCB6W3dkvieWhaRWyQZ8wXrhsPs3y
	Zw1hGlT1VMxUs+4cjNVIZM3bRfTnTP+XwbZY5pX5Ma03mXa390jZmneGyX1CERLz6n0r9wg==
X-Gm-Gg: AYBFou0mpz0rjJLwOJ+j2qNqjuuMJtyluXjKoLJh1XPbGG7nnjotTFmADRxaygYmSPk
	Dn5A2xT1MtjoD8Qfq82IH6Az5uugKrQ8xS3DR/Z54O9K2W72BzxfDMRJHAhN8oz+nz9juWtkOpa
	SegVuC4PbFVWreBNI/eQoemULvBVSktXSy7LCS/gbQ5H1PyGVE650odIIMvi0n5inFWi2x/D6T8
	Fu0v7YhevhbE/GbIeyOHabOLRWWEX6EgGJx5ZsloGCknyiVKKDo4G32mr0L5R1PbFac4MF5L8Mm
	3kgA/9yLIRmfrrfBcJBMH9RgY+pwRpFvFpUizd1jYUxse19cxamoVirQASWK94xUPr6Jp0u6KaX
	kSye4+hXWPwv6M8z/gfZO/ymAj3USDxbxGOrQhgrk0qzbp8c0Lcm6/7emedJfdzK9CDClPv6+SA
	==
X-Received: by 2002:a05:600c:83c3:b0:49f:fdca:c348 with SMTP id 5b1f17b1804b1-49ffdcac594mr41989035e9.10.1790497460719;
        Sun, 27 Sep 2026 01:24:20 -0700 (PDT)
X-Received: by 2002:a05:600c:83c3:b0:49f:fdca:c348 with SMTP id 5b1f17b1804b1-49ffdcac594mr41988585e9.10.1790497460317;
        Sun, 27 Sep 2026 01:24:20 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f3e68sm40012525e9.9.2026.09.27.01.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 01:24:19 -0700 (PDT)
Message-ID: <8862b9ed-6f96-48c6-a134-6e8635c38987@redhat.com>
Date: Sun, 27 Sep 2026 10:24:16 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] net: skb: isolate skb data area allocations into a
 separate bucket
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@google.com>, linux-hardening@vger.kernel.org,
 Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260921075811.too.775-kees@kernel.org>
 <20260921075820.1718334-7-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260921075820.1718334-7-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QALcOy14BSd0SqxNrpJwm6t8XXA70nl5VgmBYC1Cz8U_1790497461
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 09:58, Kees Cook wrote:
> From: Pedro Falcato <pfalcato@suse.de>
> 
> SKB data area allocations (as done from alloc_skb()) use kmalloc().
> These allocations can be variably sized and their contents can be more
> or less controlled from userspace, which makes them useful for attackers
> that want to overwrite a use-after-free'd object from the same kmalloc slab
> (which often just requires the sizes to roughly match into the same kmalloc
> bucket). [0] is an easy example of an exploit that uses netlink skb
> allocation to target another similarly-sized accidentally freed object.
> 
> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, these are
> probabilistic. Use the existing kmem buckets API to further isolate these
> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=y.
> 
> Ask for the accounted kmalloc type as well as the normal one. AF_UNIX
> sets sk_allocation to GFP_KERNEL_ACCOUNT, so without it every AF_UNIX
> skb data area would fall back to the general caches, and those are the
> ones most worth isolating. GFP_DMA is left to fall back, being passed to
> an skb allocator only by rare devices.
> 
> Link: https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

I would be curious to learn how about the memory usage delta.
However I see buckets are protected by their own kconfig, small
systems can unselect them.

For the networking bits:

Acked-by: Paolo Abeni <pabeni@redhat.com>

