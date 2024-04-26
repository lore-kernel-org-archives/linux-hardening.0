Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C11878
	for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091946; cv=none; b=l0/be5pIsqiaQh19s3+pY8AE5OZ13WvhhR8I1hm47SOheZHXlerMc9qvY4mcgN6N9Ek73Kt5mnZ0SpzBk9Pyt5b/r9uykEUsfOZqJfxh/18rwz2wSDRv31GSDYDfAthl73URCIDMlH52Tj1+gMms3aBYS4JyupyrPHrT7ktfsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091946; c=relaxed/simple;
	bh=UF1k0DTTPn6TCUwLWPXgU3B/ht2pbAkBF2vPrCFb+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAjcq4l6R2GuGrF18Bx1d+a/MeBmVHDC8jWI/5QcRCDME7aI8NKOlGhMt9DFIntv71HdFZQAua3Di6NHSxg/Huv4ct5tWRDt3IjS5eHJy1KU3RDViSfy3PcTq7U1hwsojlXtZMjYDwNMCPpwk68CwXV2DUM0jxaKZUTx136CTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lmoNTEBG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmoNTEBG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3ff14f249so12594565ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 25 Apr 2024 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714091944; x=1714696744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyeyYlhjNPdHyGDZj5zbPNqhK8/HMAhLyRxOSloh5f8=;
        b=lmoNTEBGqb6LCTSXsjc1lHsqmcUdiKVoo1KrSnRNCJNkspz9ER5uKRg4dLGE5ANeRS
         GjH0tO4AusXIU+cmftf5WhUy893YFRTQzLcLGhYnLueNHJ9dgo72kMHjh/Pb7v28Vkis
         /9AodkSd7V9G3n9+UZt1B34ZfbjA1QGo0EDoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091944; x=1714696744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyeyYlhjNPdHyGDZj5zbPNqhK8/HMAhLyRxOSloh5f8=;
        b=w/x93uJmws1B3xnjJAFy2/jaTOT025OOArXG22NJi6FiU1Oa6dt6pKMFyquyWoLk7e
         GV6HOoyTFoQ+GCuCmJIUNo/FKoez3/caWEZIrGmzy0881rONJSwRmS63evuYpf4YLzKh
         mNgEUdvH8asH29d1NfjSSEo7QI92LsbCJmlM39/FVtDPLKzRtiwhJ1PRr+CJJnI6puh1
         qUkQCJ9fg0ntxo1qrDaSBeExofNw4eOaLXB/31+ycpQ21J3aV0eMeHhl8851NYBAD/pf
         HNnuI+8vWrVu7OLFCt8Kq5gu1NzrOEWuXf+0Vy3QJ+0vIDVpgaTEVQIHLpIOU93e5HOI
         gu5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtZcA0Nbv4xNziOUHWjQwJDIMPqPYip7czb3RBrJHU1WmpUfmvknxfB4tPZ0GfNGguuKZpIMsCJA6Qyv9pyxxzSBjijU2d6WAtL55sEOEM
X-Gm-Message-State: AOJu0YwCNFnRzdLykDO32me/xEH9vbbeeMXLYJFLUasa+ddf++f/SmUJ
	cSKFi+GEqXrsortJlkbZ6BU7WSuZshG7mTImMBrhjYFJuIG+xmW3yDeU/buwuQ==
X-Google-Smtp-Source: AGHT+IHuwl3OPPsxNPOtPIxd0SB/ZhDzhbACRb6zBx3eCM0TcAvrfsdWZfXQSNhR2MSNDgZIHy8YNw==
X-Received: by 2002:a17:903:32c7:b0:1e8:682b:7f67 with SMTP id i7-20020a17090332c700b001e8682b7f67mr1960481plr.29.1714091944586;
        Thu, 25 Apr 2024 17:39:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm14397208plw.85.2024.04.25.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:39:03 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:39:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251724.47A3F5ADF@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>

On Thu, Apr 25, 2024 at 04:47:18PM -0700, Andrew Morton wrote:
> On Thu, 25 Apr 2024 15:42:30 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > > The concern about leaking image layout could be addressed by sorting the
> > > output before returning to userspace.
> > 
> > It's trivial to change permissions from the default 0400 at boot time.
> > It can even have groups and ownership changed, etc. This is why we have
> > per-mount-namespace /proc instances:
> > 
> > # chgrp sysmonitor /proc/allocinfo
> > # chmod 0440 /proc/allocinfo
> > 
> > Poof, instant role-based access control. :)
> 
> Conversely, the paranoid could set it to 0400 at boot also.
> 
> > I'm just trying to make the _default_ safe.
> 
> Agree with this.
> 
> Semi-seriously, how about we set the permissions to 0000 and force
> distributors/users to make a decision.

That seems an overly unfriendly default, but I guess if you wanted it as
a Kconfig setting? Just seems easiest to make distros that enable alloc
profiling safe by default but trivially available to root, and specialized
monitoring systems can do whatever they want with their /proc file ACLs.

This is kind of how all of this stuff works. There's nothing unique to
/proc/allocinfo. We do the same for slabinfo, vmallocinfo, timer_list,
etc. And I think it's totally reasonable to have paranoid defaults,
give the kind of outrageous stuff attackers have figured out how to reverse
engineer. Take for example "we can bypass SLUB randomization for the slab
from which struct file is allocated [by examining the /proc/$pid/fdinfo/
file contents]" Jann Horn demonstrated[1].

-Kees

[1] https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

-- 
Kees Cook
