Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E27CF0D
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107741; cv=none; b=W+4Q9vKlJ5URogEQmoAIgidoP6fzF4MzSGE6FhGWjCendnZQtzAy2ysG0JniSjBhpPSqpf/0/vIX2sdo/ZUkq0OHiwTWlJFSlHF/Bpj0vqP+si8e6R6KT6hKIpsb+jwgNJqq8XIknMneyP5zJAKDNuW9+nBoDRXCkfrry7mlAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107741; c=relaxed/simple;
	bh=eDTJ2mw+CpW7gkWAtFI6KtiT1a32SBUN715ePecnFk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O01Ds1YuI5jtwfy3L8aoTxyrPJJMEtmj0m3JkwrWHz1s21CPQsJLxWgMzAh//3cShtKfDY5MK3Dv6jxkhjaLue5+4tdUr1NEc1VtPcwYy3iCmpCcNVJy8J/Dgnw42zEtVp9d5Y7Cv1YItUrQylcNBLTx77e5+vm4q0rnsyGtp/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DrHs2dU9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrHs2dU9"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3392d417a9fso2455253f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 06:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706107737; x=1706712537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QODSxkvFxPjK1+hRtzc6D4olCOqkz85HGYaIxMx2/lg=;
        b=DrHs2dU9N8rU86NeDOqnozLug87QeW55jOr17SIzXqSQWnVYMREUi74QlCNyIOfNf1
         9yVxesRCpS5Y+qv4WflZqyFuuRZVvweiy8lQ4jKalIlJfBnRdtV+pEvPaBWuoXtqv8xo
         fxj6PW1Li6Roo29Dq/5o61z4RRMQiqeTzWz8poT73OeUbfEGPLcbHid1dEsrMYeNQ4E4
         p4+UpAuxEkk+yqiYsUYBwUMAzJyMb/QKQubdkwRUunrPEGIlx3e2H/qof0Gj69N42mEX
         7GIcBEXZOT6Uk25rnUl90A/O80vxZzHGrNHBqJI+Ec9koN6PBbjHOLpx3kvqywfyjshj
         GYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706107737; x=1706712537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QODSxkvFxPjK1+hRtzc6D4olCOqkz85HGYaIxMx2/lg=;
        b=bIfQmVXQI6bjoZJ8qZ0CTKYLifdmNWID6c4OWHxQ/HftW1kmMtj939Y8NFmikssbvj
         yuh6vA+NaAtVNirkU+lZElL8Hm8kvriOnMsmjnMoH3Qu123ML7HdpHDc038PmBiFG0PU
         Gq2wAndgXmr99ztuMo/v6czjFc6u9QbHxGgd5cMNV0wuRarsD2cOgFQzsQfAXPN3e0Ly
         nUJOXkXeHYJO9KlGiK72UGppcLXLhBG3ggd5dnfS6tK/FRRyxvdOr3f5lrEVMsYmvlXd
         H4oOrv+LLla9OCVzWgwPOwzv1thOa4/4EUPnKEKSEDoY4IzYbjrBWC2ljfOz55XNnZfj
         mh3g==
X-Gm-Message-State: AOJu0YwIvpbJaXw8grb25eQnytwtrvCiTfZmc6VVZDiwXOA5207jP0Qn
	mOpiHsgGwMKbxCHSoYl/e55C1lkrMJolA9xFoGmmJ4rl6zmMIlXD7FaoqQHoQU4=
X-Google-Smtp-Source: AGHT+IFlnXFany3DKmq0AiSNyBmdVgJ6QzzzZkSRSQk+Q3fvZ3Km2AgLj9J8hM5gTwv7eyESMIN6Yg==
X-Received: by 2002:a5d:560d:0:b0:337:9b30:36f0 with SMTP id l13-20020a5d560d000000b003379b3036f0mr686579wrv.67.1706107737388;
        Wed, 24 Jan 2024 06:48:57 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b0033922468707sm13522422wrv.83.2024.01.24.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:48:56 -0800 (PST)
Date: Wed, 24 Jan 2024 17:48:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: Use kcalloc() instead of kzalloc()
Message-ID: <b40e12f6-176a-4bf6-8ab0-d1cf783033a0@moroto.mountain>
References: <20240119173900.11035-1-erick.archer@gmx.com>
 <a5d8a5f1-432d-46f0-84fe-7b5b22ff5f32@moroto.mountain>
 <20240122181654.GA2834@titan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122181654.GA2834@titan>

On Mon, Jan 22, 2024 at 07:16:54PM +0100, Erick Archer wrote:
> Hi Dan,
> 
> On Mon, Jan 22, 2024 at 09:55:11AM +0300, Dan Carpenter wrote:
> > On Fri, Jan 19, 2024 at 06:39:00PM +0100, Erick Archer wrote:
> > > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > > and Conventions" documentation [1], size calculations (especially
> > > multiplication) should not be performed in memory allocator (or similar)
> > > function arguments due to the risk of them overflowing. This could lead
> > > to values wrapping around and a smaller allocation being made than the
> > > caller was expecting. Using those allocations could lead to linear
> > > overflows of heap memory and other misbehaviors.
> > >
> > > So, use the purpose specific kcalloc() function instead of the argument
> > > count * size in the kzalloc() function.
> > >
> > > Also, it is preferred to use sizeof(*pointer) instead of sizeof(type)
> > > due to the type of the variable can change and one needs not change the
> > > former (unlike the latter).
> > >
> > > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> > > Link: https://github.com/KSPP/linux/issues/162
> > > Signed-off-by: Erick Archer <erick.archer@gmx.com>
> >
> > I quite often write responses to patches and then never send them.  I
> > wrote this response and debated sending it but in the end I decided to
> > send it because you have sent multiple patches.  If you had only sent
> > one patch then I wouldn't have bothered.
> 
> My intention is not to bother anyone. I'm a linux kernel developer newbie
> and I try to do my best.
> 

Yeah.  It's not a problem, we all started as newbies.  I guess what I
was trying to say is that if you're going to be sending a lot of patches
then it's worth explaining this but if you're only sending one then I
wouldn't bother.

I don't really expect people to figure out all the code, it's just that
if you can see the effect of a patch right away then, please, include
that in the patch.  Even when it's like in this case, "This patch should
have no effect on runtime."  That sort of information is still useful.

Or if you can't figure out the implications that's also useful
information to me as a reviewer.  Just put those I don't know comments
under the --- cut off.

regards,
dan carpenter

