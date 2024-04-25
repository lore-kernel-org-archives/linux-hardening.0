Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0514D715
	for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065361; cv=none; b=ssfg2kRCwfWhfhZ3xnLqM8c3Qx75E+1Zxi6q37LTuzkQR/NjyTi2RnDRPmjEGBXUg9D0dS/vrO2Rw9bmQ3CiOG5kyTdNKr3mYDeo95bbIZMQxUad+aPm+MhIf1kFsC4PapBA0DAgFWHQL+6384SjCzAMt+Bt0TwDkzwdPJS9eZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065361; c=relaxed/simple;
	bh=loutFTRPxrxYr3/PG7rK+RIYvqgawCw+3TUN0V/RE+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skr3xRzKRnr/J8oyYptMpE1zuh6CMrRs2UTs6Nv6V4R966pTjhQ5ZD7TX9a6a5aB75BWZq2b4Aei9S5SlRqmusOrL19oC63Gt+A398M8GwAu28rt2l4I076xRutiTkZwqewcewk5WGC+F/Mymj92CMGh8xuWOknx1cvlExiyq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P7T9iPVD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7T9iPVD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eac92f7c74so6396275ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714065359; x=1714670159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVoFOxCV1JHDP2aoF03ZloAG5l88Zzw+9lsvPKG2m90=;
        b=P7T9iPVD+2R53GLkaWp8eM6uQt16bT30vpH5xZwO4eFQIB4+EGuoou/GYU2riiWyHE
         3evN8VcEsQfjSXGSIjwx1ULvndqb3fTmkexkTGGH62Dop1a4uYw2LA85BoZwKGoPL39B
         yd6LOJ/i9aGq1llTByppVYPO3/bmdf0JFC08Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714065359; x=1714670159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVoFOxCV1JHDP2aoF03ZloAG5l88Zzw+9lsvPKG2m90=;
        b=o51sqzbg5YapGvYicJ58hPC1drgwgk6CsLPDMssU3q7GhFDX4WsbdUpr4GTg/Y6Zz5
         irKEuK9BBVEwdn4V7ValERblf9aEjG2ieexVTJuV9C6XT551lZnuqRvLuBQqbvv7k3oA
         3AbE+fucacwmkVQpwmtr6y67f0cu/4POhfGAbRm5bxlHV7pIMKt12J0Vgs4Fwl+fAPXJ
         nCRRzEWswKBKL3iyXGT1E08vdhVSgimooFxVEMJw/5d2hnV6+hoi01kI0Iws964EFvLI
         JRcQ1CdJHBffcSVeKFb0jFbArcRIzURRb2trAv70Yj8/nClkizj96chCaAUdJ7vdeo3T
         zUcg==
X-Forwarded-Encrypted: i=1; AJvYcCWcNgGt+i/RvDBh7GInkzZiQrkPzrgQWVGlpyVi+p/4k1hyZX+MQz165SdkK/APNB2miUn97vdqCW1l/AyxEYlN6PWVDyS5IEYibvryQ4a6
X-Gm-Message-State: AOJu0YzwgrBSNFhg/5IYLK+9Izr9j/9lgM/7luZG2IsEqRV9caqmrV7/
	dHmEmi9Eli+soSzDzmONDYEbnYGTjGiHrsG+Edj15semeysm2CbaCSQ9LBACCQ==
X-Google-Smtp-Source: AGHT+IFTVJMb3BdwwAwsZ2j36LZ7tJkEJr9FFByumTo4ENFk4yglK2iF8e7h1wGaAyCSClq9Nhgm1A==
X-Received: by 2002:a17:903:25cf:b0:1e9:668d:a446 with SMTP id jc15-20020a17090325cf00b001e9668da446mr172628plb.20.1714065359234;
        Thu, 25 Apr 2024 10:15:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001e511acfd0esm13979187plg.140.2024.04.25.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 10:15:58 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:15:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, patches@lists.linux.dev,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: bcm: rpi: Assign ->num before accessing ->hws
Message-ID: <202404251015.46D8BE1F1@keescook>
References: <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-0-e2db3b82d5ef@kernel.org>
 <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-2-e2db3b82d5ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425-cbl-bcm-assign-counted-by-val-before-access-v1-2-e2db3b82d5ef@kernel.org>

On Thu, Apr 25, 2024 at 09:55:52AM -0700, Nathan Chancellor wrote:
> Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
> __counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
> with __counted_by, which informs the bounds sanitizer about the number
> of elements in hws, so that it can warn when hws is accessed out of
> bounds. As noted in that change, the __counted_by member must be
> initialized with the number of elements before the first array access
> happens, otherwise there will be a warning from each access prior to the
> initialization because the number of elements is zero. This occurs in
> raspberrypi_discover_clocks() due to ->num being assigned after ->hws
> has been accessed:
> 
>   UBSAN: array-index-out-of-bounds in drivers/clk/bcm/clk-raspberrypi.c:374:4
>   index 3 is out of range for type 'struct clk_hw *[] __counted_by(num)' (aka 'struct clk_hw *[]')
> 
> Move the ->num initialization to before the first access of ->hws, which
> clears up the warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
