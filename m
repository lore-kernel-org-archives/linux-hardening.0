Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA7413D2A4
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 11:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129524; cv=none; b=oRmI+lsrB+2TB48Z8zx/1RBgROlM2q9cuAHv9sHIG2BQopCrYJAOG23RkDT6JFfI30At13v5Xi3L/0+uO1zJeJmcrlm3kI5UzWwomvBWG8h2J635FZrAXS+z0pgeq11Oa8UG+uCO5NTNn9RU1D2xFLgWdqSfeQG50h5ylvYBqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129524; c=relaxed/simple;
	bh=rlo30+owHu5Rt2jo2hgUO++4+6OM0lijE05ELQk0XLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rud2wSnbRQppUJnGoKDBLpfbb/DEkrb9cARSuLjuHPUwrNrqcAYC5jGukRSUy2SdtcVsNW04y6s/YVVbHEFbK0DwELLSbDJYEMdnOhnYN+udrF54Lj1QqWpY1SB7R1HI1BMVjz+pfMPmMTtDR5bdz8VuFrx2O3VGJFr7P5RxmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R285MnxX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R285MnxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721129520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wS8IhieGZEGOs6So34MinArqLEMTFaAJheWRiSUC3Ws=;
	b=R285MnxXziYg/NB4vNabpTJRmZvfRpC1J/+CUNB7rZ+gaaRMnI/NUdUWnTVWLZBrALr7e1
	uO2xBEzsIAQN+pZ9Xq53HXaQfZIxTCL2zxwtj39DYLBkBzxrj5eQ518CNxwNCDKqyLi9Gr
	C7XobAytnVKYchZwVUQ4TrUsyZcTkGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-q_zNT7ueP02aRAZM96Fn6g-1; Tue, 16 Jul 2024 07:31:59 -0400
X-MC-Unique: q_zNT7ueP02aRAZM96Fn6g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42669213f26so10090035e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 04:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129518; x=1721734318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wS8IhieGZEGOs6So34MinArqLEMTFaAJheWRiSUC3Ws=;
        b=ZiXmbdt2ZNwig7/qrHY+8WblwwMjQwvFR2pI3G2iZsJZu27DogOaQoe53jKQY7Q85X
         4vccMEDl/t1GEyNlvYS3s5DytQg8BNDvjyR5CpwV3fJWoIojJARp/DSkl09h2cE2aUN3
         GHk4xLkEtByFCn8woBIxhjdr4gGC2p+MAI0bNc9hmWzl+Wt1S+IvhLQlzkNt3hADh3gQ
         V/rmiIHt0jCs/+2wWSP0tlSx8qz14ENOM3mrGQGS12WdWbJaIbamKdYRo3TLh0a31Xf3
         C7mpD+8PXHJmtIo6G3w0wyQA6yKBeiM+2Mv0MNBiOBt/7c5x8LViZ8Klbmy4OhiyhCV+
         8ZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIsDemb+p/kxNZSJl/SEUBhiMKLRNaWKxlpqspwSBJwZaXBznyHpQgvYFlf9sUgj64/vLPbjNrD12umdQAmXMB08Lg0MzWFwhYSBPwzhsV
X-Gm-Message-State: AOJu0YzXn7wCBlprJUQKz0994O4G87PH1HNtLwdLwr2EC1g1Owv2Bv3E
	OfWANeFrXyrNj8/vrdNobLjFWlzJVaYT6pMbOBQgRasbgG8kA/SrOpsa3EAeXf+TX24cBkwjt4A
	OeuWimXPnUlWujaz/vx9w7EwT0fJbfm+c9IKJDXeVZwrGPjzEjkN/Hu61etyMUeUQbA==
X-Received: by 2002:a5d:64c5:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-368240c50b6mr1250928f8f.7.1721129517978;
        Tue, 16 Jul 2024 04:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw4mlz5Eqf83dMPSKFCXM5jNJw+x1Bc4/Vh0VpL7NnFMTMQckuVWIERpgMS5Em6aSzgUuVmg==
X-Received: by 2002:a5d:64c5:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-368240c50b6mr1250920f8f.7.1721129517598;
        Tue, 16 Jul 2024 04:31:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3? ([2a0d:3344:1738:5210:e05b:d4c9:1ad4:1bd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3d4dsm8793172f8f.23.2024.07.16.04.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:31:57 -0700 (PDT)
Message-ID: <6d1a441d-31f9-4bc3-8856-be18620e4401@redhat.com>
Date: Tue, 16 Jul 2024 13:31:53 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
To: Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240714041111.it.918-kees@kernel.org>
 <20240715094107.GM8432@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240715094107.GM8432@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 11:41, Simon Horman wrote:
> On Sat, Jul 13, 2024 at 09:11:15PM -0700, Kees Cook wrote:
>> Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key()
>> and tcp_get_default_congestion_control(). The callers use the results as
>> standard C strings (via nla_put_string() and proc handlers respectively),
>> so trailing padding is not needed.
>>
>> Since passing the destination buffer arguments decays it to a pointer,
>> the size can't be trivially determined by the compiler. ca->name is
>> the same length in both cases, so strscpy() won't fail (when ca->name
>> is NUL-terminated). Include the length explicitly instead of using the
>> 2-argument strscpy().
>>
>> Link: https://github.com/KSPP/linux/issues/90 [1]
>> Signed-off-by: Kees Cook <kees@kernel.org>
> 
> nit: Looking at git history, the subject prefix should probably be 'tcp'.
>       And it would be best to explicitly target the patch against net-next.
> 
>       Subject: [PATCH net-next v2] tcp: ...
> 
> That notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

@Eric: I can fix the prefix when applying the patch. Please LMK if you 
prefer otherwise.

Thanks,

Paolo

