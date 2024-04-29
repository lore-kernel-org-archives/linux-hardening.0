Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD8129E6F
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415430; cv=none; b=f80ME0kLz+S9uKO40VLtR9fYTWSb2P15PcEjf3L0dqqTrifWOJDsOKSE2/0zssBaoHt2dGSoWGjRmza7Di4SdpXoIzoCfKw4Rn/ZZnreXIhALTCmiScn+tJHwfV3sP43v9rsZojbtvAPM9SuCgWLZl7WlxpeRt+XfNL89paY2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415430; c=relaxed/simple;
	bh=owUnCLYoRPgs0mrdKX/Pm+hC5u4zNv8hMMak4UZoZHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7ynEKmwY0kpGXM43bnSMkVD2U3yoZMndFpYTmHqiRxc/IkAzCG+MxoJ/yy7mLAekvbe6+QIEQTMB+BVGPwwUFGs7y0OPJnbIqcZsBrdUl17T/t/4iVjftQGeTQmrB3KaFi9oaPxnyILLuwYK0V9Y3JaraTSaYIBgbBUjce/Kqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L5T46d4r; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5T46d4r"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4678505b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 11:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714415428; x=1715020228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkpFuoY5aQyyw+nrgLES9BJOsJzkqq/5/Ik8pmOE86s=;
        b=L5T46d4rZ22Ep/ShI9b3mC+yVO3/GqJSPuvSTC+PqjKPi4nyqt6uy589JBFIshTcTf
         rHAj+zTHGphhM9DcOjt18v0c8Dno5csFvRvnC6L34cM9UWXPwVSyIbTY3mmiRNdJN4eN
         DUiKYdhG4+3OCYXDq1HsQqbtFgKIhphGvhn3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415428; x=1715020228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkpFuoY5aQyyw+nrgLES9BJOsJzkqq/5/Ik8pmOE86s=;
        b=qlVNPBqexGnYolUtWpV33fI2AlXLmrCvqm4CuGU3g0V+ALd6mDygsSy44jX9xst94m
         8s02zCi8l6uUWKd2IYUoOVWorOmsOllEASJrOsclbI2esIAnF9eWefskRmkOziI2S+tZ
         9YjOfyLZowKM/3UPSLwjKnZZrkCEuAB0FLjZ0E76R7v2zGhxhnPX5cvDGiEVzimlYlyP
         Xodv8/tEgq4zcZByfG35g9r+gWXc+1ccK8WhLmHcDXJ7G2vPwGQHeYCApKfg4ZyHcPs7
         /zFuM/Z1m0GCHBv0jEfzYT1mblkEPgYH7D5+wqJ5vbRQdjbIR08V05/NWF2VGsNn2Nil
         dBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3HSQOilq7zndDpYemr6XAuhqaddsjJJ6p64TXJmhzTmI8A009duEX1ioHqBaRW1wNSKTBMb3m4Y7SNwrx98iNeF3LeKSRxNeoFlPKSaOQ
X-Gm-Message-State: AOJu0YyGDU1lULEykzhhe095MardEC7PVsLY5qHri2TbcNeGMqB/C8ww
	eAYJHHh75HwJXSvhlYZr2egqtTOIbAg16Pj9nSl7E5/PYvce1jiqldsTE+DsYA==
X-Google-Smtp-Source: AGHT+IFm/F0nByuRkm7UdHH7GTHif1EcCEbCwry9uts5YLa+VEPBdJBvu/5Z6ZOh3u/DAHGVzCektg==
X-Received: by 2002:a05:6a00:4b4a:b0:6eb:40:6bff with SMTP id kr10-20020a056a004b4a00b006eb00406bffmr8812728pfb.14.1714415428214;
        Mon, 29 Apr 2024 11:30:28 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fu16-20020a056a00611000b006ecca2f2a32sm19545034pfb.168.2024.04.29.11.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:30:26 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:30:26 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/2][next] firewire: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <202404291129.F261DEA21F@keescook>
References: <cover.1709658886.git.gustavoars@kernel.org>
 <20240306011030.GA71684@workstation.local>
 <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a7854af-a183-4db2-8400-4d9eb0cc4308@embeddedor.com>

On Wed, Mar 06, 2024 at 10:18:59AM -0600, Gustavo A. R. Silva wrote:
> 
> > Thanks for the improvements, however we are mostly at the end of
> > development period for v6.8 kernel. Let me postpone applying the patches
> > until closing the next merge window (for v6.9), since we need the term to
> > evaluate the change. I mean that it goes to v6.10 kernel.
> 
> Sure, no problem.
> 
> Actually, I'll send a v2 with DEFINE_FLEX(), instead.

I was just going through the patch tracker to make sure stuff got
handled -- did a v2 of these ever get posted? I don't see anything in
the tracker nor changes here in -next.

Thanks!

-Kees

-- 
Kees Cook
