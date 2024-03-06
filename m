Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154721C684
	for <linux-hardening@vger.kernel.org>; Wed,  6 Mar 2024 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769136; cv=none; b=JIO+vgUDrU1ACtGdtixi9l6NSmI9SOtlo/FPMBFTsI6QF1gYzKKxXfdofldBRGeeXK0dBqQdT7ZJ+g1qNzIwPR5ggHvaxZXAZwsj8INMHZgOIT2bcXzPKeYT52qHjTu8LSWBAdaI53EsfnCnOP0IdamxMj9/BLLBpEKW616lUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769136; c=relaxed/simple;
	bh=HKuLgTVFRKaKDoqvDomRm/dSKx0b/g4r+MceYXqEzKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGvz6mrasSVJ9wVkspPnp1Al1rD13S6FVBvolCJjrbWKW9e8SzpFXvdLYDB+Anh6XL5oDAPx59yoXyMp5E1gC4ce8rZ0auKje/RsjHOL0iqaRhf16Rt2pD+VyhCoFey1B6yGH/lqfVmkv7zpg+LnfgQIEnzJfw8/flDfBwvrFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bwftwxeh; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bwftwxeh"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4e835ee5dso152819a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 06 Mar 2024 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709769134; x=1710373934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZEAVZcoYSQFZcvaftM2f/g9GOC1c60DgaQV+1wgZreQ=;
        b=BwftwxehXmL5+X12BpMGO7AVdGn7ENPJuQO37XD8UvbxMs5R4ODUp+VOoF7Z5txQEh
         syS7pEzNr56D6Au2fD6GvaGI2VNwFl4rp22QJ2O2fwJYG/IxYGgmIDMvHBDP86/oK4i7
         roEAmc7XXuE35VIcYB13UGSySoCraUw+m+GTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769134; x=1710373934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEAVZcoYSQFZcvaftM2f/g9GOC1c60DgaQV+1wgZreQ=;
        b=gCBB3DnBA71FergQR9BZt+jlerS1WWqA5UZijCpInEqVjEQUnrtX7TyxjbVx3ocvEp
         pRdJB/vfAbSj7/sipbE8ynIeYQPssx8MnHLNJKtnC+T4U5pVUw0nDp0kG5DOuUMycxDC
         rDXHJPKirdb/dh99EeJ3InRBagOGcQd5qC1UB2TtfQWSMccNxF6SYSu/o0lDs0MTDES6
         7Xx891lvn7p8xXoArfK4yc903E/FwDuun28WVhF+YAm07TbZTV8cOSfvaPg+1DjCK7Rd
         eAQgdJzDxBQyYNvSZ1jd3/oOSGWYhb/UIzh4QXcChd9YhEN6GDg5PHkCyfhj6dlaXfs8
         uOlA==
X-Forwarded-Encrypted: i=1; AJvYcCX0obQWUcWmWyJNkYbd+mZFrIVyNvuctfSZ5BpgTXSFHmrCKnBk78L1E/I/w3UvNrRYW/c1zU11Z4zOVxZtbs0T4P3rhQxunRgLQIw+TXlP
X-Gm-Message-State: AOJu0Yyl2iDb/otKCzG7TYj3rN9vwWmJ5mOXEZe5maufMKb+5o7gON3D
	pKb1I9B/X1bDHDx/QS7dl8Zkyw1woyoaUjiEtblVe7/l+OEbGIj2z9y3ChGefA==
X-Google-Smtp-Source: AGHT+IGzQi4Hj1eR1TravKHp4tPRAiBWafpLp3PdehA3PNgOnJ+Bn3bpQz0p2gslmzv3nDrpdQZRtA==
X-Received: by 2002:a9d:6b13:0:b0:6e4:fa90:3c79 with SMTP id g19-20020a9d6b13000000b006e4fa903c79mr5596220otp.22.1709769134215;
        Wed, 06 Mar 2024 15:52:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b005bd980cca56sm11450066pgh.29.2024.03.06.15.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:52:13 -0800 (PST)
Date: Wed, 6 Mar 2024 15:52:13 -0800
From: Kees Cook <keescook@chromium.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Change DEFINE_FLEX to take __counted_by member
Message-ID: <202403061551.00DAFE8B39@keescook>
References: <20240306010746.work.678-kees@kernel.org>
 <9c2990f0-7407-49c6-9e3a-b92de82ea437@embeddedor.com>
 <bd21f7dc-9f89-40ee-895e-601c80165225@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd21f7dc-9f89-40ee-895e-601c80165225@intel.com>

On Wed, Mar 06, 2024 at 08:06:29AM +0100, Przemek Kitszel wrote:
> On 3/6/24 04:25, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 05/03/24 19:07, Kees Cook wrote:
> > > The norm should be flexible array structures with __counted_by
> > > annotations, so DEFINE_FLEX() is updated to expect that. Rename
> > > the non-annotated version to DEFINE_RAW_FLEX(), and update the few
> > > existing users. Additionally add self-tests to validate syntax and
> > > size calculations.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > 
> > [..]
> 
> Just a note that ice changes are purely mechanical, so this seems ok
> to go via linux-hardening tree. And changes per-se are fine too :)

Thanks!

> 
> > 
> > > +/**
> > > + * DEFINE_FLEX() - Define an on-stack instance of structure with a
> > > trailing
> > > + * flexible array member.
> > > + *
> > > + * @TYPE: structure type name, including "struct" keyword.
> > > + * @NAME: Name for a variable to define.
> > > + * @COUNTER: Name of the __counted_by member.
> > > + * @MEMBER: Name of the array member.
> > > + * @COUNT: Number of elements in the array; must be compile-time const.
> > > + *
> > > + * Define a zeroed, on-stack, instance of @TYPE structure with a
> > > trailing
> > > + * flexible array member.
> > > + * Use __struct_size(@NAME) to get compile-time size of it afterwards.
> > > + */
> > > +#define DEFINE_FLEX(TYPE, NAME, COUNTER, MEMBER, COUNT)    \
> > 
> > Probably, swapping COUNTER and MEMBER is better?
> 
> right now we have usage scenario (from Kunits):
> 	DEFINE_FLEX(struct foo, eight, counter, array, 8);
> 
> > 
> >      DEFINE_FLEX(TYPE, NAME, MEMBER, COUNTER, COUNT)
> 
> usage would become:
> 	DEFINE_FLEX(struct foo, eight, array, counter, 8);
> 
> which reads a bit better indeed, with the added benefit that we
> go from broader to more specific:
> whole struct -> array -> array size variable -> given array size
> 
> so +1 from me for the params swap

Sounds good. You and Gustavo have convinced me. :) I've sent a v2 now.

-- 
Kees Cook
