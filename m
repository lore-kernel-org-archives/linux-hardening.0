Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58A35B630
	for <linux-hardening@vger.kernel.org>; Thu, 12 Feb 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902722; cv=none; b=MXwFx2Paems9zK+ngu/sLk0fo4mefwbmUP5a3GB3Tih+MILTLTYlsMytATRgaznapV9JH7GQSXMruccgDsDEMGEWNZJoRp7dRt+NwqzFnI/pWKmtfbOH3+Y8bGj607UIYkNgH20gMuonMR9Tqrn7+viB5oysW2Nu7tCU9VTHYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902722; c=relaxed/simple;
	bh=JXk2Ej5TBrQF8DIR+/aVyp1DP04ICAIrfnWlInhYPcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAsHjSNX/7Sg941oAIzqx7esumSaOyuvpdAfIuC/KYn6hbR32TLsiXCnGEOxG+BMHBWtdbXQtATTUlwhLGTmkzFVxG3cLowI4Cxm1PyFTAS2r9Os+hfz3KB4RoBLZTJLuwy1yH9S3tJ5TKEWeWizKdZxl2Ono1wfzCQMRyVt/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCSO+4hV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCSO+4hV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4376c0bffc1so3661790f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Feb 2026 05:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770902720; x=1771507520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP7FAI3atH8q7kGoiZraE67HwJjBLlIVqi9iW4TLH9U=;
        b=YCSO+4hVAa2P6GZBEm9r6SriGfF99Sz28m8NnJNuYA6yQEp6rWD7oeiv7e3yC6L0jl
         Cq+UZqv0br+/0s0irU4GhvvY8mGM8Tv8eYUINRGwJ7/HXEq2cZeqqrCMhmh2D4a1Zg4p
         xcrqSRvBVvENLw7zTj0TlF9ODdMV5ybiQ1VMduh/W7QkJRkDdPA4eLU8bfiT5yaSsRXU
         JMo1+CkudX5SCVuhb36ag5ILKfyBWqJTOxceFopTsQKgg+XLeAmos2bwTeNddIAT1ce3
         yuBZW8ObEHABwvN4q5qjAEfB8pMXQl/oP629nc9AC0j/1xclvqCOLbYyifLhoLwAZBg/
         SyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770902720; x=1771507520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZP7FAI3atH8q7kGoiZraE67HwJjBLlIVqi9iW4TLH9U=;
        b=tjotmAqCs9jza9kVPVCLEjP+56pZzBhXM010i1ZPyC/42AlKTkxYF8qz/MEVbxx4A/
         q/ILMQOYVVSfoNNg/JgOyFE6DikXILHXqQDCvk7xkuFqW7ddjvkesaeRRZhEtyitsqoV
         nbQQrhcgs/mnm92+bB8bV956PCibV0y2zKEBuYY7rfY9ITO5Z32wkvsVKMMf3m2wQ++w
         nwFWSIlY/vgbuZi87Ht84lmPtq4LfxAtzcQZkGvc37es6prc00apL4P/1g9MRomjAF7d
         od2P1+HGsWMNwkeiofHGIAFmbuNBg7WVyWvkBqvygfe8uhAwQvqEmkwzoP4NrjwyICTg
         wj+A==
X-Forwarded-Encrypted: i=1; AJvYcCUB+/U4+sHDf450oLnvdtV+4FtHNlYn3S/4x/xLtFbqDiIXmL+doGrbe04FzrCgGUnQcfWAU+Tv02ti3U0mfjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBi6CPtd6N3Pz2fptvr8zxWgeHj6AqSGQfWLaqAEqCZuFRyXvF
	R1PFmUlgOZjh+0teqFJIKmhMyr/H6urOcLFHJv3fo3W9DWo0w+ACLFwIPkArZg==
X-Gm-Gg: AZuq6aIKDXK5Ri+/I/l6CcjInz24XXoHMPfer9QNpgmEjjjQrDLD029sSS9Rb5IW/Yd
	n5kpujt6nHUGSS2oRBqeQJAbwXGJ6tqODlBYsTWNHEljtxAbwRKzmHxL/gpt8RWTnDUITUu4dXA
	cjcgVAQTf4XDxwc2EuWlHzlTIhe42Gf9PyPXRO8BrEDmKt+RjFKYIFOOHk1rYTl6C/IKBj+NUEx
	dCXN75jdbgQBJtrtvfoxq8KULyGW+wR99k4c3NyzZ5nxz1gE7sBunG8fsif0kf1cW2G2VC8txbn
	hl8KGZuAIoo2JSq5kU7vcYvva/dcvQL2YYcE1LLUOUQF1BRsY6KjeWzbTngY7a/vDRj0l/OBDNH
	nAykofy+GUOKZiHiiyURRGdHECMb0MRRfUw0jbgaUxusEhKEtkKZBLb90ekKfoPCG/3ZceNoFOx
	nt7OedYaYYL61mIH29EN7eKCRaAoNqQvuXdvysGGoqIlF6DFwhsSaAN2/mtNPOlJyW
X-Received: by 2002:a05:6000:2c08:b0:432:84f9:8bf9 with SMTP id ffacd0b85a97d-4378aca3fa9mr4258827f8f.57.1770902719485;
        Thu, 12 Feb 2026 05:25:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc2b0sm11507302f8f.21.2026.02.12.05.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:25:19 -0800 (PST)
Date: Thu, 12 Feb 2026 13:25:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
 <djwong@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] lib: fix _parse_integer_limit() to handle
 overflow
Message-ID: <20260212132517.1ac5de44@pumpkin>
In-Reply-To: <20260212120030.2f15caaa@pumpkin>
References: <20260209164757.433932-1-dmantipov@yandex.ru>
	<20260209164757.433932-2-dmantipov@yandex.ru>
	<aYrgASJXAyoholbF@smile.fi.intel.com>
	<14e1e0ac3b2622f762c8f369afc9b1e9a84ca66b.camel@yandex.ru>
	<20260212120030.2f15caaa@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Feb 2026 12:00:30 +0000
David Laight <david.laight.linux@gmail.com> wrote:

Re-send with "..." removed from one of the addresses so my MUA (claws) won't
escape the second one and the list-servers fail to accept the mail.

> On Thu, 12 Feb 2026 14:13:16 +0300
> Dmitry Antipov <dmantipov@yandex.ru> wrote:
> 
> > On Tue, 2026-02-10 at 09:36 +0200, Andy Shevchenko wrote:
> >   
> > > I don't see how max_chars is used. With that said, I would rather see the usual
> > > way of expressing the condition in the for-loop:
> > > 
> > > 	for (rv = 0; rv < max_chars; rv++, s++) {    
> > 
> > This will break the loop (and so stop consuming characters) if KSTRTOX_OVERFLOW
> > bit is set.
> >   
> > > > +		if (likely(res != ULLONG_MAX)) {    
> > > 
> > > Have you seen David's question about these checks?
> > > Maybe I missed your answer...  
> 
> I've not seen one...
> 
> > >     
> > > > +			if (unlikely(res & (~0ull << 60))) {    
> > 
> > The first check may be dropped indeed (assuming check_mul_overflow(ULLONG_MAX, a, b)
> > and check_add_overflow(ULLONG_MAX, a, b) always signals an overflow).  
> 
> That check for the high bits may well be cheaper than the one in
> check_mul_overflow() - which is likely to need to partially generate
> the 128bit result.
> Also if the code is going to call check_mul_overflow() it ought to use the
> result in the 'non-overflow' case.
> 
> But there is nothing 'magic' about check_mul_overflow(), given the base
> is known (and the only dificult one is 10) comparing against the known
> limit will be better code.
> 
> 	David
> 
> 
> > 
> > Dmitry  
> 

