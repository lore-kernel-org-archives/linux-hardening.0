Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C82032B
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lr9ID9yD"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F19D5E
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 11:22:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c87a85332bso9239225ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697826149; x=1698430949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04gH1wK0MN9lWn/YJPzI2WddwHxIZ8s/y81mEW7mDkQ=;
        b=Lr9ID9yDkM16bb+2HlLfqAc8MuKa/2cAzq2S5BVwOZieEabyqCzHWeO4KBtbfKmpxP
         oTCMyHlXZJoilixhSCR43zUBFkipk72FygdgC5UARU73Sjxr0WzjQjNmvgTRDn5eVCAL
         K2A1KODbNRfea20xFtiItjHYYsW8xr3mXFVQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826149; x=1698430949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04gH1wK0MN9lWn/YJPzI2WddwHxIZ8s/y81mEW7mDkQ=;
        b=n/ex+m8V9HU9qSGD9SAVxwlbyz70h0GJEEQU8unYnCbVSzLuDOe427CxG5DFvTJTnJ
         UnUfr7H8WjsqQZifx5QJq4EmfWzkWwGyOoR38ITrYDdjsP6yMMueFIOr3oHeD/o0F9/g
         6pjS/KDzwGWv+bwFBfQ+9Uax74aDhGcqvWGNlicmKhTnh22+SL7OcoZUAIcb0zi8aqYn
         JOzV+ZYbCYzc1pBXN4X8haGebzuo92pxrRnT3KA0mjVzJpf/QdBqBM3KTPdCCRkUTemF
         8/4OeM29VfjW/BBZtOsDjAYRXNuJZLU2g5TCGs/Evhpdc2h+NmRmpNd7DEkUQRSohK6f
         t3Iw==
X-Gm-Message-State: AOJu0YzhJUvBe4Q2SWguYy4KKxFTuW+Bq1wFAx1LA0B0IyI7OLqKcJES
	f2h/ULsOO5WXM9DEe73TNUw8bw==
X-Google-Smtp-Source: AGHT+IHY7//XAjVbmv0+8CTvhanr4J11DW7dmowhqoeDWSPu7A2hJov+lZgIQALeiVmTuJFeYMRjFQ==
X-Received: by 2002:a17:902:ea0e:b0:1ca:20a0:7b08 with SMTP id s14-20020a170902ea0e00b001ca20a07b08mr2589174plg.50.1697826148954;
        Fri, 20 Oct 2023 11:22:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001c625acfed0sm1826088plb.44.2023.10.20.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:22:28 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:22:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Justin Stitt <justinstitt@google.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev, Azeem Shaikh <azeemshaikh38@gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <202310201111.595F790@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>

On Fri, Oct 20, 2023 at 10:56:31AM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 10:40, Justin Stitt <justinstitt@google.com> wrote:
> >
> > There's some docs at [1]. Perhaps there could be more?
> >
> > [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> 
> Note that we have so few 'strlcpy()' calls that we really should
> remove that horrid horrid interface. It's a buggy piece of sh*t.

Yup, that's on-going. There's just a few left; Azeem has been chipping
away at strlcpy.

> It does mean that if you used to have
> 
>     dst[4];
>     strlcpy(dst, "abc", 8);
> 
> then that *used* to work (because it would copy four bytes: "abc\0"
> and that fits in 'dst[]'). But
> 
>    dst[4];
>    strscpy(dst, "abc", 8);
> 
> will overflow dst[], because it will do a word-copy and you told
> 'strscpy()' that you had a 8-byte buffer, and it will try to write
> "abc\0\0\0\0\0" into the destination.

Luckily, we already have checks for these mismatched sizes at compile
time (i.e. CONFIG_FORTIFY_SOURCE will already check for pathological
cases like above where 8 > sizeof(dst)).

> The above is insane code, but it's an example of why a blind
> strlcpy->strscpy conversion might change semantics.

Totally agreed. All of the recent string conversions have been paying
close attention to the behavioral differences.

-- 
Kees Cook
