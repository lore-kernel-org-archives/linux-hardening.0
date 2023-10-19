Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E6BEB8
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TC2KlZq2"
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E56C119
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 19:28:39 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ce2aac0644so50234a34.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 19:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697682518; x=1698287318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm17BzM2ARI2RrzePHTfnzeX6F07vJD4CzibGyt8MNI=;
        b=TC2KlZq2f+2NP9WBSoxKsyth38NDh+ATmZuG2rIQLAIemhXN2auh2MaLS5WF06Y/bZ
         piOMXBk56AEsAsq1lz8yi2ZBNGYm4SPxN4IIcE0SbCrzbrCs5vw7rjiTxiRBgB75DGbA
         vqz3pUbDrRA34Bg0QErysGhegUmoODSxBh8bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697682518; x=1698287318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pm17BzM2ARI2RrzePHTfnzeX6F07vJD4CzibGyt8MNI=;
        b=EwtqAKBDocsrRGeM72LA/AewMIbz5oANq3VBwqYg/7C0wheXFctp79ZXgvalqbXYej
         +OVsSdjVfcX2ElVv259z7uJjRiZNGeJD2HtCmHTp8GoCxPzgEaibktXsSMUT/IRn4fFD
         gwigpjfu9fyiwLsnCmGHL1C25F7SGkzQBKgx+gCLbYIsrZZNChaO6kXiXoRI8FLZnrWn
         LIwlI0w4dsVPvd4x7NGQlMbmlhGjN2JnpHUdui+c7ZViyfzamHDR4ig9wJojaqDBo6Yq
         7TqDfCyLmg8Z530UvPncjuzesR0fU0Gh60zVScSLLHBG0JQ8B/p/AqLA9cGoOa+J6l49
         J4eA==
X-Gm-Message-State: AOJu0Yx/Bk2sYRGm2fXzjaEzc9AD7rh4BOsZ7wLLBehSrVlgsutoBDEn
	H+qPeKSQTSEboel0os4X3Yixow==
X-Google-Smtp-Source: AGHT+IH6n/YddGMyyhykRMLGfcwrjiN8g/F/Ne2bkA3nBvBFFVPKu/XWTZPWpMhTQPVvSmD2Qjdyhg==
X-Received: by 2002:a9d:7f94:0:b0:6b7:5687:8a9e with SMTP id t20-20020a9d7f94000000b006b756878a9emr1006430otp.15.1697682518599;
        Wed, 18 Oct 2023 19:28:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a129-20020a624d87000000b006906aaf1e4dsm4142079pfb.150.2023.10.18.19.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 19:28:37 -0700 (PDT)
Date: Wed, 18 Oct 2023 19:28:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] bcachefs: Refactor memcpy into direct assignment
Message-ID: <202310181927.F9CCC45@keescook>
References: <20231018230728.make.202-kees@kernel.org>
 <20231019003232.5uwphr7de7nybsra@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019003232.5uwphr7de7nybsra@moria.home.lan>

On Wed, Oct 18, 2023 at 08:32:32PM -0400, Kent Overstreet wrote:
> On Wed, Oct 18, 2023 at 04:07:32PM -0700, Kees Cook wrote:
> > The memcpy() in bch2_bkey_append_ptr() is operating on an embedded fake
> > flexible array which looks to the compiler like it has 0 size. This
> > causes W=1 builds to emit warnings due to -Wstringop-overflow:
> > 
> >    In file included from include/linux/string.h:254,
> >                     from include/linux/bitmap.h:11,
> >                     from include/linux/cpumask.h:12,
> >                     from include/linux/smp.h:13,
> >                     from include/linux/lockdep.h:14,
> >                     from include/linux/radix-tree.h:14,
> >                     from include/linux/backing-dev-defs.h:6,
> >                     from fs/bcachefs/bcachefs.h:182:
> >    fs/bcachefs/extents.c: In function 'bch2_bkey_append_ptr':
> >    include/linux/fortify-string.h:57:33: warning: writing 8 bytes into a region of size 0 [-Wstringop-overflow=]
> >       57 | #define __underlying_memcpy     __builtin_memcpy
> >          |                                 ^
> >    include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
> >      648 |         __underlying_##op(p, q, __fortify_size);                        \
> >          |         ^~~~~~~~~~~~~
> >    include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
> >      693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >          |                          ^~~~~~~~~~~~~~~~~~~~
> >    fs/bcachefs/extents.c:235:17: note: in expansion of macro 'memcpy'
> >      235 |                 memcpy((void *) &k->v + bkey_val_bytes(&k->k),
> >          |                 ^~~~~~
> >    fs/bcachefs/bcachefs_format.h:287:33: note: destination object 'v' of size 0
> >      287 |                 struct bch_val  v;
> >          |                                 ^
> > 
> > Avoid making any structure changes and just replace the u64 copy into a
> > direct assignment, side-stepping the entire problem.
> 
> This does make me wonder about the usefulness of the fortify source
> stuff if it can be sidestepped this way, but hey, I'll take it :)

Well, the "weird" cases like this are the ones that get attention. All
the places it's working more cleanly are very effectively stomping real
bugs.

> Pulled it into the testing branch, https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

Thanks!

-Kees

-- 
Kees Cook
