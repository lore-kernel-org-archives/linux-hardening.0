Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11495F859
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 23:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805549; cv=none; b=GdMNQm5sFSZ69MGUBu5fJkF+wJkPRDwmgM7eLqfA5Mab2YCBChJJwK4RB6JG636elwW0aGlUzN0XO+li4EfutT2NIVYT3nGddDWfdENiFxNxHqrmqMqCLer/HBd1dZ6h2X5wjzyIJ2hs1tpXimyCOojjQirKhZF+5WSVHJF0ygQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805549; c=relaxed/simple;
	bh=ddIX1pX8PUKYlrEFSGxj4dp81Coz+WVwDW5gqZgq2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acaePTSfetzeNVI9DyxAhRGljJL5uR7drXCXPH5cOSLt5MvTsFiBSfrYYDi1OnaIWuAyO04BljIkRGKsQNnfCik+u6ouj0ZzJQ8mInOXNs9WDdySUoidIS8ycjiNvG+hMUgXrBxHmLGmsJptQ1tBV/YdD39ljWroMFaS9UBm52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UP+WJbvt; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UP+WJbvt"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-221e6bf537dso3430459fac.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710805547; x=1711410347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyNKKJaFo0RNnDw1cX76A1V9oBiLwk9MCVF82VfEr8Q=;
        b=UP+WJbvt4DkTE/aSDfcB2mZPHNKGKPI21xQbR4yaLTSXHLgFLohjYywOc1ESA/2dDW
         eUGQWwXJqlBMmtf8kuDJvvyrYKtErkTttlhTVESunE6AEFIkFFNv6YaFtLzmjpFyP8x2
         e1FWvDbKSQ8KM4wciG+pl3yMNLU8Ga6Swmcsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710805547; x=1711410347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyNKKJaFo0RNnDw1cX76A1V9oBiLwk9MCVF82VfEr8Q=;
        b=J6h0UV/lnX8iuOn0d1Dxf44ogR7RTjwBXBZiasKKP0Ngs6zAE1VkSoPesMGZg5s8ij
         ogXqRbYQz366Mf02FO94aeLt2GHgmZz6ttdwC6dAL342wrZIF28c3Kk6c4i1BRjAK/QB
         PUIWosQll+zCWUKfeajYXAB9WVpRrvfDiENMq2GTkCcJXyV87EvGguXR/rSPjD3uX6x4
         8QmQjYVPp/JCzW8vfAwpxsoeDiVZdvkX9qtmK9yfWRqewJAapUaa1jW6XpVCL+7Q8D9T
         /J88EY92j9J2041v12MmwtSftKWaG2Zaug+9ng4LMH68rnZPQplREPAezDNpopGiZ3nA
         W6IA==
X-Forwarded-Encrypted: i=1; AJvYcCVMz2sgGaX9Ipek9gSmCfddcK5XhbdHdUilq/kmWu08hwwc14F2uzO2ch5UMKQM6DwUb0/e81epsV02z3U+6sY3QIKKILGY3raJIjp9t69/
X-Gm-Message-State: AOJu0YzTtYCTD7RfRK1OWXN+jUy2GVjMyh7ME45ZujEiHGPsTdb03KJu
	ZZxtO4ilFgeEdQHtprhDLUdcaFCdLmyZ8CaNEHPsuvolpPd2lEJHIGu9LbKh7w==
X-Google-Smtp-Source: AGHT+IHuGsFZKeGKS+5IfIvaZGbwZxy1NkSSfWwS6FkEclzsGrRPwV1rjWc4/CqC4usYaEiXM+0A2w==
X-Received: by 2002:a05:6870:3926:b0:220:9f8c:b97b with SMTP id b38-20020a056870392600b002209f8cb97bmr16205988oap.4.1710805547072;
        Mon, 18 Mar 2024 16:45:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b006e6c38cbe96sm8493254pff.29.2024.03.18.16.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 16:45:46 -0700 (PDT)
Date: Mon, 18 Mar 2024 16:45:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, Guixiong Wei <weiguixiong@bytedance.com>,
	jgross@suse.com, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
	gregkh@linuxfoundation.org, tony.luck@intel.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section on
 walk_relocs
Message-ID: <202403181644.690285D3@keescook>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
 <171079804927.224083.15609364452504732018.b4-ty@chromium.org>
 <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318215612.GDZfi4fG52DTgra51p@fat_crate.local>

On Mon, Mar 18, 2024 at 10:56:12PM +0100, Borislav Petkov wrote:
> On Mon, Mar 18, 2024 at 02:40:50PM -0700, Kees Cook wrote:
> > Applied to for-next/hardening
> 
> Why?
> 
> This is a patch that should go through the tip tree, if at all.

The commit it refs to landed via -hardening, so I was taking the
responsibility of landing this fix too. But it's fine to go via
-tip if you prefer?

-- 
Kees Cook
