Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2E3FFAC3
	for <linux-hardening@vger.kernel.org>; Wed,  8 Jul 2026 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783499460; cv=none; b=ckOzDgruIKrLcjGK4ttELoqlDFvL4u42bURps03lawT/zwSXH4pW4c4t4gJzkzEUndCnwQDVVsdA74yC1dCVKHBMAqqH+9EFJMKHNFrE0KTEA21GBsqP68T6EWeJ8H54q0ebB12PrhAW/fUJXRVwsRhQazwAIVAA57mCU8KDZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783499460; c=relaxed/simple;
	bh=vUxkYgLjD7SSNYU9O4l3RAJNTa98pYA33vlEm8vPQ1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=audTtmx01+IMPVcEVPIERoyUY/EmFSj6kgi/DyvNfeocIeoMsRJX8bJqxQo468tvg+CrExJiQY4PUM5Ubo7q+p+N6jc2W0cjnC//y5TkpfMfMGzi2VGWW2iEXvtoTkaV1WL/X399utdqPuQMtB4yTABUbfbNvWv/AF4KjF8T1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJp8+7TZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJp8+7TZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783499457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2x2KW8jXt7Qu/ChgVuNcsLQe8Mz8PkKb4meLHcRszN0=;
	b=AJp8+7TZRod0ZIKcJDH8kzc60F8yYp6XJNE3Xmc4w52v8xk/ulPvTbjIkrC5JAxJiRTIyH
	lh8H/m76BH7g0bxkRjIJ3YTJtPoHkTbJYoWKqVoHMds2JGF2hmomm5O7nwkjIVi9GqQBFD
	pprM8YLyDe/xOhW27qjOwKvklVuC5gI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-GHAtOLwsMYCa2JOHOl3xIw-1; Wed, 08 Jul 2026 04:30:54 -0400
X-MC-Unique: GHAtOLwsMYCa2JOHOl3xIw-1
X-Mimecast-MFC-AGG-ID: GHAtOLwsMYCa2JOHOl3xIw_1783499453
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4740be00302so346326f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 08 Jul 2026 01:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499453; x=1784104253;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2x2KW8jXt7Qu/ChgVuNcsLQe8Mz8PkKb4meLHcRszN0=;
        b=n6KKHWqDLOor25rXrnUjYlmlq5VG4MtKq/vtOIls2WqA+kZVHGbFDo1swTonttuWrT
         UOFfZ8GbX4r8QeKdb4ku1uvp7U6+b2TOveAeC89AzanL3hHVZdy4YGI88XtblqJAKEBs
         LjzRfiW2+9XsHMIa+cTIAsZSs82hHYiPqIweZ8/7AYzJ3LLaDGMZnOcVeAS/Vf0JQL7p
         jXNRF30PN5n2+gwFlHjyzmdAKpp/vNokMf/U/PUB6Wu4dptt77WBJK4HV62uk59wSniT
         UWGWs91atkW5eVglRhzAnNqfagbb68f77l0iOi0mRJ4gjMGAgMs1IA9eBtHZ7rOxLhNv
         Jt4g==
X-Forwarded-Encrypted: i=1; AHgh+Rrlab/aBZbFhmwyupi1kF0x60Sn1TkMUdY8gDWIkwe2d19fNFO8WYpJ4VkUvyy/w/FYUcGIyCWpX+RTPz4H1Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6DICm+WX6chHtg78ujABxEOF2cUFHVLdeDLZwOS9eYtVgUJw
	9zuwgraD+y+aTcQemRE6AZWLeqKd4sE7GnUViXXKnXFhimPpw+N+U18ql/xydUEzvIiNvkiBjKN
	O7neot0thppg+9Vj+xs5MiDAZDfUMjV41AXXozKCRzwbFtmW/HepXL6efN3TciarCnwfZBA==
X-Gm-Gg: AfdE7cn7QwUnwBBOygppggNxTBM0sD/arzTHZtwkts6a9rVseoPHr3q7KYEKLa6PQ0c
	4l5wonkRoo3R8L/nNEORQfGBy8j5Hen6fI4aaqROQtb0fBRvnIV5AOOkHAn4jrtAy5AvAyzgUMK
	dsjgBP+smabjX+vuUz/Bl84B5r/r+Kd+e5ovkiZxyPOP+VyGZgZ7exJ9kgKBxw0VcY6S2UgJvEF
	6UWy4ij7OHGerghkLA7D8awckGLlhngP/qrRhGCTLcahRIxgpvjp47Nbk+JHSdZiCUoY3iuIr//
	sPQLMtscG+v7nq+orKFadN8NdNpzvjSc/iDcYoTwDTTibLuqZe0aXnZy6U8/VpSCBO7kGXNqD0j
	GZRH3i6qOWzeqQQDN65UrRam2mlkIPdjon/Td4RYNv+VKRWQn82nMgKbqBf4KW+22EJDfCpTpD3
	87xq7GmfN8GmBx
X-Received: by 2002:a05:600c:6206:b0:493:bc92:ba9a with SMTP id 5b1f17b1804b1-493e68bee61mr14536015e9.13.1783499452653;
        Wed, 08 Jul 2026 01:30:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6206:b0:493:bc92:ba9a with SMTP id 5b1f17b1804b1-493e68bee61mr14535405e9.13.1783499452198;
        Wed, 08 Jul 2026 01:30:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0faed08sm111777175e9.11.2026.07.08.01.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 01:30:51 -0700 (PDT)
Message-ID: <04debe19-bbe8-4b5f-9668-753d1f97832d@redhat.com>
Date: Wed, 8 Jul 2026 10:30:50 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: skb: isolate skb data area allocations
 into a separate bucket
To: Pedro Falcato <pfalcato@suse.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20260702170728.168755-1-pfalcato@suse.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260702170728.168755-1-pfalcato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3nWOJHRRle9E0MF6pdbOpV-Cwe6zdlLGm-OIqEYEQSE_1783499453
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 7:07 PM, Pedro Falcato wrote:> @@ -586,6 +586,8 @@ struct
sk_buff *napi_build_skb(void *data, unsigned int frag_size)
>  }
>  EXPORT_SYMBOL(napi_build_skb);
>  
> +static kmem_buckets *skb_data_buckets __ro_after_init;
> +
>  static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>  {
>  	if (!gfp_pfmemalloc_allowed(flags))
> @@ -593,7 +595,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, gfp_t flags, int node)
>  	if (!obj_size)
>  		return kmem_cache_alloc_node(net_hotdata.skb_small_head_cache,
>  					     flags, node);
> -	return kmalloc_node_track_caller(obj_size, flags, node);
> +	return kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
> +						    flags, node);

Sashiko noted that some drivers may require GFP_DMA buckets, and the
above may break them:

https://sashiko.dev/#/patchset/20260702170728.168755-1-pfalcato%40suse.de

>  }
>  
>  /*
> @@ -634,7 +637,7 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
>  	 * Try a regular allocation, when that fails and we're not entitled
>  	 * to the reserves, fail.
>  	 */
> -	obj = kmalloc_node_track_caller(obj_size,
> +	obj = kmem_buckets_alloc_node_track_caller(skb_data_buckets, obj_size,
>  					flags | __GFP_NOMEMALLOC | __GFP_NOWARN,
>  					node);

Minor nit: checkpatch laments WRT brackets alignment.

/P

