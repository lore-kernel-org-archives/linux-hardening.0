Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4622D3A8F5
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049722; cv=none; b=FGld4jP4WLSn1gT8zfHAFGZdc4PBMzTMcUIG0AkCeOhxSRAzAQfz8iADUtIDxpMO4LUVXgwtPGSIfX5Yh77WETvL0WTRCsGcGgye+pxkxKBusy9VEd6wlX56/aE6NGumswnpzzsONsyUXTUgJsEUuEfcpg4YIwe+UH9hN1fLLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049722; c=relaxed/simple;
	bh=zKrh9Cm8LBMdmMkZwJbUhPVyyd35s47X76PNGXAhQBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaMqNEx7K3fShSBUtJr1MO/4a34J//Sp7tBNkn0zgNubKUC2JTkzZxhyuPJMimyfrkfF/DxN1H/eT5WvzeQUoN69Bu7MCTn0gbuUrhLEhwP9KeT/4CUK/fGhYKgTpTxMxQxuyQ1It92BqOdvpNaE7/qD8gdpiFANTidGmlc965c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A7C2args; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7C2args"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dd7c5437b0so1007009b3a.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 14:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706049720; x=1706654520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLP204yME76cKWvSKqR4QvH8/WxYNOPL78/EyvH5yzk=;
        b=A7C2argsd3w1FTAqLxve7TteXsyWVG+pgmxReCn2t0rVKKDeQI8i0DZxUyQUulG//H
         7NXwjNUhMY/+uLxTo+BvibNxtnB1+tuMjREgkpQvI1twX5dYst7kqTkEeReA0gVAmeOg
         VD0WojfvS6MrngQ7AAduFdFv3hPiiG957MXps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049720; x=1706654520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLP204yME76cKWvSKqR4QvH8/WxYNOPL78/EyvH5yzk=;
        b=nIYzJJl7Yo79N2Ta2ZVtnnemiMKB18J5sSTrosWjQcj5Ww+H5pI4MnHpX+/pO+VOS2
         6qLUGH1+WRqdVJpn2Rn6bOsc3HKZeUm1zWWYLTzHOr3u6QmWZUBxxyAAYPxqTrZ1zs12
         iTzAnCabZ3dtHKzKjOwN29NVnjw/aNklu5Y7DR66t9w4T5khXFGTBMLbfF+LqZUdspms
         Zvkeyo2LCedFU3RovKMqcPjMK9FfWYlPpP/H1MRZ3NMYP6uDsAtkKllaexxPSbj54oob
         yJxNexmBbltHJKAz/TocvYe5HVFz4n3KIKdtyyufaUJjwLpbdVyEe9OrU5L9cvhok31I
         pD8g==
X-Gm-Message-State: AOJu0YydCR8ejgvHUTL6fAijAl6BtQ67e68vRrZ2pOdjYB01LdB71TWl
	iYykYx/zr8pq1Cxn/Como/VgQADs3gKwMhILKtx1Hws5VOsHA89rl51ZIoLh+A==
X-Google-Smtp-Source: AGHT+IHwpTHhUNklJYwoOZzlpbiuoqmorVbDQt+RpuA3sITy6NnTDgE24fxse09JSEmVMJKrdG/Alg==
X-Received: by 2002:aa7:9f4d:0:b0:6dd:81e6:e93c with SMTP id h13-20020aa79f4d000000b006dd81e6e93cmr1032305pfr.63.1706049720687;
        Tue, 23 Jan 2024 14:42:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hq15-20020a056a00680f00b006dbd2231184sm6411616pfb.70.2024.01.23.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:42:00 -0800 (PST)
Date: Tue, 23 Jan 2024 14:41:59 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/82] arm: 3117/1: Refactor intentional wrap-around test
Message-ID: <202401231441.7A15A53419@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-38-keescook@chromium.org>
 <Za-NRm5e_-Cfz1Nl@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-NRm5e_-Cfz1Nl@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:56:22AM +0000, Mark Rutland wrote:
> The commit title is odd here; '3117/1' is the patch tracker name for the last
> patch. The title should probably be:
> 
> 	arm: nwfpe: Refactor intentional wrap-around test

Whoops, yes. I need to teach my prefix-guessing script to drop the ARM
patch tracker numbers...

-Kees

> 
> Mark.
> 
> On Mon, Jan 22, 2024 at 04:27:13PM -0800, Kees Cook wrote:
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> > 
> > 	VAR + value < VAR
> > 
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> > 
> > Refactor open-coded wrap-around addition test to use add_would_overflow().
> > This paves the way to enabling the wrap-around sanitizers in the future.
> > 
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm/nwfpe/softfloat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
> > index ffa6b438786b..0635b1eda1d3 100644
> > --- a/arch/arm/nwfpe/softfloat.c
> > +++ b/arch/arm/nwfpe/softfloat.c
> > @@ -603,7 +603,7 @@ static floatx80
> >      roundBits = zSig0 & roundMask;
> >      if ( 0x7FFD <= (bits32) ( zExp - 1 ) ) {
> >          if (    ( 0x7FFE < zExp )
> > -             || ( ( zExp == 0x7FFE ) && ( zSig0 + roundIncrement < zSig0 ) )
> > +             || ( ( zExp == 0x7FFE ) && (add_would_overflow(zSig0, roundIncrement)) )
> >             ) {
> >              goto overflow;
> >          }
> > -- 
> > 2.34.1
> > 
> > 

-- 
Kees Cook
