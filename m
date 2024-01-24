Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E417C09A
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112512; cv=none; b=hXgmktEIwN2OKkn+okNL7FUATewfMCzewzg1yX69zH5jp9QJ7vWnAx9G1Qrlxrw0bXzmtZ5rnjfMwlXQd+BO+yHgDDjRRa83y/hPuYlvxYIHxgagNhmxefhv+vtQKcHjABJeGg2x2pGZqDq8khnfcK0HAY27yo0M4VnwGE8vQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112512; c=relaxed/simple;
	bh=P8x3AO2a8scV6woW1e3Y4EcwMFtwUqE7IRH31eTIO1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzv0wmy5nu2Mr05lhfTCI+ZprO+hgiIf2MRTsx2kOIARED6lmGRnfsNStoYe7efSByut9FplWDyCn/rQuW5kzE2ZjH2XoKLFEBh5KJaKSPqE4ZKeS6h0CHWTjhdcWlg8XsnFq+DpwrKUxmR7Ff+IV5Ok79+uydBbaVNuZsjI584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H3/+W0YM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3/+W0YM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d70b0e521eso41380445ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jan 2024 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706112510; x=1706717310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uwpskAl9LsN0AXCbwXO1lfWjVtroeO2kOOid+4UlMDA=;
        b=H3/+W0YMVWgxEwiDPd/KJ/yN4Bdv8swY5s7ywuxfefsU6zutp0YSD3vjcTdzkewrXO
         6ysQ8aPdahQqDmsMjt+Z8rw1ISYIEK87p9idEumhHusd1zsH6xyEcWUJLnNTvdvZ6TZz
         zkCTz289KG20q07RN+/ZnglMhF/7Ml5hdv5xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706112510; x=1706717310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwpskAl9LsN0AXCbwXO1lfWjVtroeO2kOOid+4UlMDA=;
        b=OURPyg/5ejR7g59T+4g2KGPomdrg9U1spSoYNSPa2cLVkU3cBKaTdAzD4OrKYRwq19
         PdTOK+EFwT31SZcAV3W/E5lYGLME1uopRu1tgpGv9X3ZJJyGjDYQRNXacqI4q0JCs9Ps
         abjljxasIjy7V3J9qBA9s42bbuovSkVAHEOUg1FYgMCLFF6gi7KuquNaWk3QuBpxpItw
         CFBDjqGJZZMmI9hP8794TP2s79TBd+WCo6i+CSuiieOyP7gexGLUnUrnMHaqlWcr3yQU
         9QHqPofeM57w0VD72TZb8ctTSYFjqYZ8DI/HyhFm56c1bxidD8Q7WZ/Ab7Ap0jc12iPv
         Gw8A==
X-Gm-Message-State: AOJu0YweQ45nMC+qnZr604CUb9ynIgDr3RTUVL0FftvfKFK2EVZQTiYq
	d0F4OA7dYP28r40eSorwa7xz9EjxIEodsjcPXiFsmWA8GVKLHQRQFIfdNbYm0g==
X-Google-Smtp-Source: AGHT+IGqSafzwgjxpg5Yxg1Ud2WtYZsnhytXHIISl8WrkHaH3dJ1Txa9c/422e4HCjPEJaoWbtbd+w==
X-Received: by 2002:a17:902:db07:b0:1d7:57bf:259 with SMTP id m7-20020a170902db0700b001d757bf0259mr1003726plx.121.1706112509796;
        Wed, 24 Jan 2024 08:08:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090320ca00b001d737d51411sm6630106plb.227.2024.01.24.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:08:29 -0800 (PST)
Date: Wed, 24 Jan 2024 08:08:28 -0800
From: Kees Cook <keescook@chromium.org>
To: Yang Shi <shy828301@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, mail@horotw.com,
	linux-hardening@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	William Kucharski <william.kucharski@oracle.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
Message-ID: <202401240808.F5659B75@keescook>
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
 <87il3ur1ik.fsf@gentoo.org>
 <ZaVi4ij0jgEz+isx@casper.infradead.org>
 <07c348caaf6b4c457ab4b452f53ed048@horotw.com>
 <ZaWZqnD7XmP5HMA0@casper.infradead.org>
 <CAMj1kXGMPeFE_JAKBhAkh9eqmvEJjucsXru2bjc6oa35oyK4=A@mail.gmail.com>
 <202401231433.FB2D7FBD@keescook>
 <CAHbLzkqmuD-YWxW6oixsFbO9EmDMWKcJ01TMzZxUmO6=CUwrVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkqmuD-YWxW6oixsFbO9EmDMWKcJ01TMzZxUmO6=CUwrVw@mail.gmail.com>

On Tue, Jan 23, 2024 at 05:04:22PM -0800, Yang Shi wrote:
> On Tue, Jan 23, 2024 at 2:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jan 16, 2024 at 09:09:45AM +0100, Ard Biesheuvel wrote:
> > > (cc Kees, LAKML)
> > >
> > > https://lkml.kernel.org/r/69fa6015256613ed10aee996e181ebd4%40horotw.com
> > >
> > > On Mon, 15 Jan 2024 at 21:46, Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > ...
> > > > Yeah, I don't know either.  Outside my scope of expertise.
> > > >
> > > > I received a suggestion off-list that we only do the PMD alignment on
> > > > 64-bit, which seems quite reasonable to me.  After all, I don't care
> > > > about performance on 32-bit just as much as I don't care about security
> > > > on 32-bit.
> > > >
> > >
> > > For context, the culprit is
> > >
> > > commit 1854bc6e2420472676c5c90d3d6b15f6cd640e40
> > > Author: William Kucharski <william.kucharski@oracle.com>
> > > Date:   Sun Sep 22 08:43:15 2019 -0400
> > >
> > >     mm/readahead: Align file mappings for non-DAX
> > >
> > >     When we have the opportunity to use PMDs to map a file, we want to follow
> > >     the same rules as DAX.
> > >
> > >     Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> > >     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > >
> > > which affects *all* 32-bit architectures not just i686. 32-bit ARM
> > > user space is still being deployed widely, even on arm64 Chromebooks
> > > running 64-bit kernels (at least up until recently) so unfortunately,
> > > we're not quite at the point yet where we can just let it rot.
> >
> > Is this related at all to this thread as well?
> > https://lore.kernel.org/lkml/20220809142457.4751229f@imladris.surriel.com/
> 
> Yes
> 
> >
> > Can we avoid this on 32-bit or at least not mislead userspace about the
> > available entropy visible in /proc/sys/vm/mmap_rnd*_bits ?
> 
> https://lore.kernel.org/linux-mm/20240118133504.2910955-1-shy828301@gmail.com/
> 
> This patch basically made thp_get_unmapped_area no-op on 32 bit.

Ah-ha! Okay, thanks very much. I missed this landing. :)

-- 
Kees Cook
