Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD083093CA
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216461; cv=none; b=Ka1WAsxJ0f/ylKGBWL6bLWX8YIC3RUmMatZkeoWkYy2bye/nPEmuFDnwZusYTzgFHalYCtjxcNBynkfNYyZuJZBdr22N0P+Zt71sP0FUKElAiZutVK5K1Uw/95OzBPN6QzPdkB1sLqd89BPBG5ywp1h0CCDoNFwYMta5kEntCPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216461; c=relaxed/simple;
	bh=5ifU/Wvg+kVhHnF9BQP9B3foPYA5Ik7jwpTbYYS73os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohuYmPxpxpuIBw7eKwiIj+FChq0BDYeO2QQD283DwNftDQk4d5o4c1YWTdkeh6YinoNdSnC2lldzvkQ5evTdhhxpIyyWU9nPRnIqofRjmoib+g8x2ads8ISFGfJsl7M5FBvpCxX3QAxem++kQYon1VKFwIRJ3xEC3N7Gf3jUiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoiWO0M0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoiWO0M0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7ZtrRY8Csd0mnWVAzPDxeW56oyxBNHzEHf6SjTpI9w=;
	b=NoiWO0M0V38Vgxw1iwFmo6Sfol2RggixjIUsbBtd5MhyAGWKiFVVhfjUbaVXHySP//HYjx
	xAcMwAFLDw9YrrCO5Y/mtjPFmo853aqQAhpCQfhtnN/8n4WED4CaC4EYuq4Li8ba5UJ21W
	gCi4l9uIy50SqC1KYhit0qeuIjUUnVQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-fuawRN5KPr-YqvI2eE95TQ-1; Thu, 23 Oct 2025 06:47:35 -0400
X-MC-Unique: fuawRN5KPr-YqvI2eE95TQ-1
X-Mimecast-MFC-AGG-ID: fuawRN5KPr-YqvI2eE95TQ_1761216455
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47114d373d5so5243385e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 03:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216454; x=1761821254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7ZtrRY8Csd0mnWVAzPDxeW56oyxBNHzEHf6SjTpI9w=;
        b=MpP0pgs953uPU2WYbQ+6UzDLflWm0d3s7Tlxg4UufEMUCsWJR6zDgEVrwLZOduQOJN
         MBlJCLxQbFJvRQcLoCKtbFOHWRzLV7lrdTVOSJWxIVgHGhe8xtOT8I90HyenFmroJABg
         073ci4pbWZYhQOHVDkFnbYYCxJy+7vIPJ9wLZ7MWhyhiLvR3/fYH4p86mWiJIS9nLRRk
         gPr1QOdd/m5WJdIEFe3+qY6HNVJ0Y/KQdFjEBie7kTY0vZV74+u5D3MudU4t21HU7Mu6
         QzbVswDph/aCC5QZPw7u5xWMo3znnZF4FEy7dkiuV2e9Hkaxdaxyd/yhPOXVbVMOJyCt
         ZCnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Ijf4JyjJlbjViOeeSNf2GhmoR0nZvmiNX1Sltqh4DC7sFc+fCGY9f8Zgi1W7e3eacF2bPGunH1Ivwg63TgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eyYCfktHmlr+e6NtGy6evZ/CB+W9TX6zycvOxLDWOsL8nJVp
	8VfM9QiZsP48LhpoQa34USE0NEZL19spo6/5gPr+5pKjYINFdCQlX3Ht/9cpxbbwPNiKD26PVXs
	aCgZnHJ8c/locCKgrh5eOvh2RNdVXqaQWtNKnklKooI+UmT73D9xaEuW0PdtSnt8E4uOKTw==
X-Gm-Gg: ASbGnct3BTYvlgSGiez2WQyu4nEx6JT7T0WV1zo3IJazikhkFfVo+i3f3GKIKp3gssS
	mKY7ECduFN9lp+9sqrkqTLdhDz90vdVny39xxVs0AydHMXuDRc7D+oJHQGKhXpqJyXkjUSwJdFn
	fS/3Eyi7nAYpRqYLjYBXEijXJ4Sft4IXEyvFHZmKoj2k8UZqsGxs3lqrBspsddlyCaBwThaorvh
	C15kq8826kxHQ6D4/8/GckAZvgrYymK/B1jIT2YctzkDPoRsm04c5lIwKX+JVD5LNZPclNudiU8
	IXz3g79LiazzQV1PRwGRlbsybLo//x6kivrObK3skeFMZzKSPxuyOmQ22E8MOjKLdhh6B/KSQRH
	Q/dvlxYYb54+3euZ46+8yvFsS0yWWfCbNpVLfYnZGEYmAWR4=
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr177738605e9.27.1761216454577;
        Thu, 23 Oct 2025 03:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbCjAG6BFqWGtyFJWnnSCkQuOtRF7p6tj9Xo7x9KfV4P2z7kmIFxIZPQ6J9DI6KJJoMB+iuQ==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr177738355e9.27.1761216454135;
        Thu, 23 Oct 2025 03:47:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf4642fsm29122005e9.17.2025.10.23.03.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:47:33 -0700 (PDT)
Message-ID: <52c7bbac-da08-44d5-b1ec-315ce001b42a@redhat.com>
Date: Thu, 23 Oct 2025 12:47:32 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] net/l2tp: Add missing sa_family validation in
 pppol2tp_sockaddr_get_info
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-2-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-2-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IUmFrb_9LiohiikOy3pyHeYeOVQ3tpGViH_doSW7v9c_1761216455
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> While reviewing the struct proto_ops connect() and bind() callback
> implementations, I noticed that there doesn't appear to be any
> validation that AF_PPPOX sockaddr structures actually have sa_family set
> to AF_PPPOX. The pppol2tp_sockaddr_get_info() checks only look at the
> sizes.
> 
> I don't see any way that this might actually cause problems as specific
> info fields are being populated, for which the existing size checks are
> correct, but it stood out as a missing address family check.
> 
> Add the check and return -EAFNOSUPPORT on mismatch.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  net/l2tp/l2tp_ppp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 5e12e7ce17d8..b7a9c224520f 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -535,6 +535,13 @@ struct l2tp_connect_info {
>  static int pppol2tp_sockaddr_get_info(const void *sa, int sa_len,
>  				      struct l2tp_connect_info *info)
>  {
> +	const struct sockaddr_unspec *sockaddr = sa;
> +
> +	if (sa_len < offsetofend(struct sockaddr, sa_family))
> +		return -EINVAL;
> +	if (sockaddr->sa_family != AF_PPPOX)
> +		return -EAFNOSUPPORT;

I fear we can't introduce this check, as it could break existing
user-space application currently passing random data into sa_family but
still able to connect successfully.

/P

