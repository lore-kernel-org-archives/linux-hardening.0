Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8B13DB93
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710614; cv=none; b=TK+BKEsreGNtePDauYLgv8Jui4nCORzto14fTSO8pjGuOt8uo1ENUt72uWB6B6wsN/g5SB/bQwxKgkU7SqAnWtT3cgyzF/G91e1bDpqCv5GmGg4NuQ6satYa2pK0weWaMr0kTlbGiLvm8p6iOvdYGDsEZCoTwpe01ymo1mxa2sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710614; c=relaxed/simple;
	bh=CjG7WgCgFDAFL/tReNZpG/kD85Tt86MKrrUPD2AYLQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWC6iDx91XfmNOuXrkPrlFHN6hdbse/Sj6IKIjLD5OWHw2VcMQeubnjyUHaFKJmHA7ur4y0cMnkQ6K1Js6PlmxaS2sYvKjLe58l7r/wJYaXKNbhmbJvCVc8t46StDQNLAxT/xzNhhg7c734iH81wldvDORZycjfd/1j38gURrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNfHMMyW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNfHMMyW"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e4de4fae2cso757987b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708710611; x=1709315411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh8E4x68Izt4HceoSL2C5zjPW+nFmkMjm9Tr07dbTE4=;
        b=XNfHMMyWWywPWp6ekMQN2xw5jYA2vu0lHbsC/j8YCsn+aQlDzdprJ3E6jhtEMi2o21
         i42tsViP1d2CHrY5kkF9+W5IyGrSFhJYLbbkLDm5yHnSHLg75qJ+jsvGYMDIZ1qyqTIE
         uYVyL+TZTDVCWwUzkKosPaR/upLby1n5XNrKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710611; x=1709315411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh8E4x68Izt4HceoSL2C5zjPW+nFmkMjm9Tr07dbTE4=;
        b=Rsgrdw6v7xyN3e7Ro5d/uTJ0Q2uifbzEAjC1QByujVxZWi14a3JXAw3HbMo0BDnuwI
         PGlst8pp1wRVWKY1v+xhA/M/t/nVBOym0cSwBhecv7Mb8xIdGgvudI4Tlf+lJEIMhrj8
         UeQ37hFG9swbV9cWZxu2iRtPnId3ywBjl5wnSRKGRpiSl/4mqLj2VfagP/UerqpVQtso
         k2CL0luj5bPpeziYKf8OgsRmkxfgbJxvfejbn+rB6pzJqnelbP1juqLm61jcxitv6dNJ
         GsoUt5JLB4PXMUseN890OFjilXty6p6uUlgFl6hxKOcdoh8gsSxAOGstB8oyzwbFYraM
         YMWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEu6yVCMim6wGS1RJIteOdT+d7W9a29dUJ/DfAlWcSixqEdShyg8TQOe6dc5gSEgfgXBYAxiqoeum4/H+AhlAw2EWK4uQFdurWp4tI1c9J
X-Gm-Message-State: AOJu0Yy/4TaOSPH2E/0BoPTYCS7/C08mA7lsRf/5yyH2J/NMcAe9vclA
	aI+qUv31k/7N03WPffzmNJpYGa/TnzgvdvK8s3KhCCEPkrUXpr17fFYkuZCzag==
X-Google-Smtp-Source: AGHT+IH1UP6oOCdgigSlZN7GfzqMGdE+JitpTrFkneg82nmtKJhtaUdsf1z4v1ua63Pt3t+NHytt5w==
X-Received: by 2002:a05:6a20:a901:b0:1a0:61e4:a940 with SMTP id cd1-20020a056a20a90100b001a061e4a940mr573533pzb.45.1708710610948;
        Fri, 23 Feb 2024 09:50:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a656702000000b005dc26144d96sm10977296pgf.75.2024.02.23.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:50:10 -0800 (PST)
Date: Fri, 23 Feb 2024 09:50:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	Tomislav Denis <tomislav.denis@avl.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dlhl60d: Initialize empty DLH bytes
Message-ID: <202402230949.E06F3297@keescook>
References: <20240223172936.it.875-kees@kernel.org>
 <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>

On Fri, Feb 23, 2024 at 07:47:36PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 09:29:39AM -0800, Kees Cook wrote:
> > 3 bytes were being read but 4 were being written. Explicitly initialize
> > the unused bytes to 0 and refactor the loop to use direct array
> > indexing, which appears to silence a Clang false positive warning[1].
> 
> ...
> 
> >  	for_each_set_bit(chn, indio_dev->active_scan_mask,
> > -		indio_dev->masklength) {
> > -		memcpy(tmp_buf + i,
> > +			 indio_dev->masklength) {
> > +		memcpy(&tmp_buf[i++],
> >  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> >  			DLH_NUM_DATA_BYTES);
> > -		i++;
> >  	}
> 
> Not that I'm against the changes, but they (in accordance with the commit
> message) are irrelevant to this fix. I prefer fixes to be more focused on
> the real issues.

Jonathan, let me know if you'd prefer I split this patch...

-- 
Kees Cook
