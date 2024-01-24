Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445FF7C082
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109167; cv=none; b=STrme1ykoldhBIP1bnYBdD/65VltuqjSpuOeJmWdLT1GvVayu2EYj5imjh02NBhH6fdPxHhsrlFJxif7HCKrFWQbnR5WP0SmWW3OKJOXGT90mHxFBbWvKMsYjK3l0UwdQtzR1wDvpzrV5jD5o7bxpzVpK66gZuerhz8z39O/5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109167; c=relaxed/simple;
	bh=wSUcVORR/B8/hFASvmkzEW/qWMh/vNxVvV+IJjMASVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2oK/0OmQM9vga31VASemVQ24ciokeSQ0R4YUuURVZa1qPujaAXgQt5mBVnm7euMZUDzxtjfx+Zc+mlExo9qQ+KgOx8mI9M/qjesdpq3oC4vVeRO12j326WfBzUo7C8KzyolaRm6jPvS6+2xmM/Npw4Ewahe0ie6KbVutLZ27es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVf+utJV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVf+utJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706109165;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9OCrAN+UT6ymJtmxhV/6yB5yqd39wFue7pD1+4bFjs=;
	b=aVf+utJVDkEDIC7/BOKFhyTqYlpaJoPfvlmIJFdJBHPIH7jPBNa4O81RnWvdEdPlAzyBtS
	cnSBVQRHLm/8JVxOy8rOr3gqkTcLpIv+Brnd3qflhvYdwqpAnwL8fNVMWbRNmqYw/Jbk4+
	Q3cpHyaiJWMHycx8idXJo6TkvAOJsyc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-VvwMLtMPPoa1zp2Es6Qgug-1; Wed, 24 Jan 2024 10:12:39 -0500
X-MC-Unique: VvwMLtMPPoa1zp2Es6Qgug-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7816e45f957so860750885a.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 07:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109159; x=1706713959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9OCrAN+UT6ymJtmxhV/6yB5yqd39wFue7pD1+4bFjs=;
        b=FmAfHAxMo1x7r3nkIDHRIcfnUX71tNozHENpdncJtpx9bgKlqPZ13NqOUmBsORHnXT
         oGBeBMm1D56xlwObTYGA9HfvS7tsxp1AqVU3b8ks/dugzo3N8Dy1kNAzifM/I57UmpZo
         TTFXpHgdLU9AOKKdUKcjlzFYUu4n9StCvrWvHTh0Jx0ATCso5F7GULShbsQM7aTXRMZE
         XyD+OTKvUzPRss7GcXTqhK6vctWV6ak8nGNb7WJEM7v/+jdlJS0aw1zrYQ6V44yntjdc
         Ha9EGhu7HISOhavp51YSG1q1MZ2U7UClMFTpVwYVJax3mwWT+/8jxC+GQuw2LpxZFL2L
         Kk4g==
X-Gm-Message-State: AOJu0Ywad6qsMIGHpR2zCHnEfWNbIk9jqu0qNyC0PabBS94zTsSjyIuG
	soIBu28/cRcWQdLDpx9si3rtgFODpiDCvV3+bziiaK272/YWyUtZldWC2aYzOSkGx2STt8GZzWO
	fTTsHK/ejyEAAM0mmUqXYpYa1wiiiJRrSFOPajvp+51TnyFBY7ltDxyEZLiXF2LXKGA==
X-Received: by 2002:a0c:e18b:0:b0:680:b7fd:e3c0 with SMTP id p11-20020a0ce18b000000b00680b7fde3c0mr2602207qvl.130.1706109159390;
        Wed, 24 Jan 2024 07:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4YjMHgP4yQO1A1mLPxyYWjKYZXB3p75FsIdtm86FMAXD3LcuTiRkAWk2NCbxXvKHRbEkVxg==
X-Received: by 2002:a0c:e18b:0:b0:680:b7fd:e3c0 with SMTP id p11-20020a0ce18b000000b00680b7fde3c0mr2602197qvl.130.1706109159137;
        Wed, 24 Jan 2024 07:12:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cfc0f000000b0067f2559fd5esm4562012qvo.34.2024.01.24.07.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:12:38 -0800 (PST)
Message-ID: <6efb0e40-a1e8-45d8-8b59-c3e5a90daa4a@redhat.com>
Date: Wed, 24 Jan 2024 16:12:33 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 57/82] KVM: arm64: vgic-v3: Refactor intentional
 wrap-around test
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-57-keescook@chromium.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240123002814.1396804-57-keescook@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 01:27, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Zenghui Yu <yuzenghui@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> index c15ee1df036a..860b774c0c13 100644
> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
> @@ -863,7 +863,7 @@ static int vgic_v3_alloc_redist_region(struct kvm *kvm, uint32_t index,
>  	int ret;
>  
>  	/* cross the end of memory ? */
> -	if (base + size < base)
> +	if (add_would_overflow(base, size))
>  		return -EINVAL;
>  
>  	if (list_empty(rd_regions)) {

