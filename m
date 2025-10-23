Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2ED30649D
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217210; cv=none; b=DqUycTroBDbKSdTwNPWVfiVQpguynWckphBIpVme1S9AKm2f+3pTxZGKHuvZ0r3jTXWMgM38/Mk7VE/Ae/MSXcuFHIAuclY5CnwaKkfb3+IpM0+JMqV5NlttM8qfIZV9xnet5ACHxR9o/CC5QRr+aBVhWwajy1j44ekTxc8rsUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217210; c=relaxed/simple;
	bh=C1Pp292wr9u8EzQo5FGAynEK1LI49VCDkvagkZiSjy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6BYn13JbE8bdB6/sQXWi6iZmH45e65A/2ZXayuAdvJL2cAsXuoJTaWCOTpud5cVli7v0OSTiKyH/E56UTCeZILRT8gsevjQ0oCsrwfv3kBNlexYOMvPAvDrxObBf6JQyrpIaioz3pQLh7Yy3GnQ9xi+t1s+QVnsKzN4IhDX9DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9L9q0Zd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9L9q0Zd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761217206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
	b=N9L9q0ZdvWZcHf7bIcCamCjVL5d79UJV/tS3fHyGcIJTYOxo4gWTJPQnJNtQIJ075JSf4P
	Lg8jEHtZnjlNuCiCmIxBve0AdPOp1dGFQoKZbH1RV2VPuzVPZNSYCAy1srJVkynk68I7q4
	KKqGrRQZKMUVc7T7lAMFRKwnQcNbLSo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-xbNquanyP2WE7Noyq4C-yQ-1; Thu, 23 Oct 2025 07:00:03 -0400
X-MC-Unique: xbNquanyP2WE7Noyq4C-yQ-1
X-Mimecast-MFC-AGG-ID: xbNquanyP2WE7Noyq4C-yQ_1761217202
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471168953bdso5471075e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761217202; x=1761822002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tbe/B1o/HvtDs6xz/RlrYs8WR4yY3Q1mvgAb2M+S7k=;
        b=Mx8pNtLPK9+CFb/dFLC+dQoyIpvbtsUWsUQgEsHOH32u5xp1HJIedLb/LVyFlUeHUl
         443M15ZmVNR+tYxS0qJ1qk262nyQQkFSb7AgDLxJJcTJEIr0ZsYZpf3Opn2zfyRb4no+
         u69OrofobocxBVxhPtUoH/Bb9PLlIs40toseTziecpAbTMVRAanALHjghrZsSmypzW4f
         ZDHPPvDq6V2R/eyV3d7XvYX/9pxMeEDkix7G9GNhMCKe0bwjIjpfQWwr/CLtNZKUnSsF
         pzdjrnOthl5shvmuCmLdIK7nnhy4d35WOGzTheR75mhqCVRcSJMB39h4yKy9wCc4AEdD
         Q17g==
X-Forwarded-Encrypted: i=1; AJvYcCVgl0vrxxW7xmw5lQjhM6a4FiaDWAj5S3UJYZlJtcGpTnlBr3TdGbP2+hpflSYpftDiCudhWM6ETbA3a/wc7VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLUNgolAti+H05NumFtTfCZ08IjVjNfxspcDKwMfunL3wRXG3
	eJnimAwXf8lhsGoThaXq25lMfkazzmavlqtGt63PyW1ZDAC34X3uSC3V3862QF5tJ5lynVGOKtU
	t59yIbC5mnC9nqOJ9RUOy3262p7ogVw8sOb2YMtbk2EdCXAo4Lqx1TTo+Rgdogw3HnshKTA==
X-Gm-Gg: ASbGncsMe3PMhZWYfBymoF2W6s6KoupAWInmt79MpgyfIxjqAoMt1wthe5++2yIbL5e
	DIUWTnyxYaV9BVQpgF/lwV7K+J8G//e7BfJ+Cgq1AWsPRhtgENsBhsyPOOVqLL4d5QjPTj5eQhP
	PEkEh4sqfFQ7pln/VNWu92y2dNvFUYPvqJjYslm9d3It5FLaB4t+bVw1XItUgDqT4739d9bjhGb
	WpJu+0GaHBYsdQ2XXccv2ERaQhNnqK4YIcp4NuxEdmsLwILYvn9OG37tKxPXtM7Dutj8pq07/EV
	SHZRElhObzMHw92RBzWmkmDjdOcSJBta7VHTJ2mWSvn0c3dwR2+ZwnAKGJhK4OvSXPd0UPe/H5r
	4ICXSipHFUlq5dVrMwC4Oh6a9s0sgk56k4qM3Sd2ysOf/snA=
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330355e9.8.1761217202292;
        Thu, 23 Oct 2025 04:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVkcD6BOYZ24anCxqkCdENWyVIeDStBshfMtRIpeohF2t+fEegH7komx/yFzU5BEDs7jhjg==
X-Received: by 2002:a05:600c:5803:b0:46e:7dbf:6cc2 with SMTP id 5b1f17b1804b1-475c6f202e9mr30330125e9.8.1761217201896;
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc6esm3288915f8f.25.2025.10.23.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:00:01 -0700 (PDT)
Message-ID: <980907a1-255d-4aa4-ad49-0fba79fe8edc@redhat.com>
Date: Thu, 23 Oct 2025 12:59:59 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
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
 <20251020212639.1223484-1-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O3jl7hLUjrNOWrNdSTcbL6auiC_66lWLwN69U-nZoZ8_1761217202
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Another side note: please include the 'net-next' subj prefix in next
submissions, otherwise patchwork could be fouled, and the patches will
not be picked by our CI - I guess we need all the possible testing done
here ;)

/P

