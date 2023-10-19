Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA47186C
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kDxXRTAe"
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE46192
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 23:01:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso5651716b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697695316; x=1698300116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7yDeCbKK7RJMvZiIVbGogXmcuCznb6lg3vpgldc7l0=;
        b=kDxXRTAe+Pae7ibWBYLaO5zaM26mXUHLIeTfARzKL3y8pZdbuyII7QyG2ApgkuiDU8
         Oc4dL/4l5JYs+LC94AY0bhrjRlHsx0gKWW87fPc6E8kSnW6Bcx4NvuNa9NeQ6OyCIlhV
         UjyWBuKJJemeseBAO4L7fQyIqfJ5R9ZWj28aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697695316; x=1698300116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7yDeCbKK7RJMvZiIVbGogXmcuCznb6lg3vpgldc7l0=;
        b=FuKmYz8px7SvULTAs8ucQDTJOAr2yFBVbHK32EcjVSMtiqw+c0+yp4mH2uobBtRB01
         c/Xtr3vXlFFst/w+z8dshkT2ZDGqpJivlz4yVbRqT+n6uAW2ruvxCmbhsQLuiYYS8bsF
         ItuxbqPuRX3T8U/TWgtGdA1P/F6Q4Iq798vrptX7eJqMouYnLt7Jk5Wbp8o1kLxp7NEd
         cCPrBwvgDIUeHEMeY6FB+AbNF8fmRLSgNKfW8aSl2kLLmNJG1NV27uyOAS1dulhwzlnw
         a2DEGifr5ugsgkT7GantRQysOiPJyBY+IXMuerIBEb/msbvUOLFRNKLhT0VDr65CBouW
         MYgg==
X-Gm-Message-State: AOJu0YzcD/2L2zQR4Qry3dZjYmiUL4+prz2TVq29zyOEJd+qeKXL5SBH
	i4wImbTv8NbF3yoU7EQZ2QyG2A==
X-Google-Smtp-Source: AGHT+IFscLXN1xjak16gaHb4xEL+yenHdprgdAzW4lIxpVAmm+HGFxqot9MJirUqe2eamHFP5LRRhw==
X-Received: by 2002:a05:6a00:cd6:b0:6b8:a6d6:f51a with SMTP id b22-20020a056a000cd600b006b8a6d6f51amr1126768pfv.31.1697695315885;
        Wed, 18 Oct 2023 23:01:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00000300b006933866fd21sm4291678pfk.117.2023.10.18.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:01:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 23:01:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Stitt <justinstitt@google.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <202310182248.9E197FFD5@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019054642.GF14346@lst.de>

On Thu, Oct 19, 2023 at 07:46:42AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> 
> If we want that we need to stop pretendening direct manipulation of
> nul-terminate strings is a good idea.  I suspect the churn of replacing
> one helper with another, maybe slightly better, one probably
> introduces more bugs than it fixes.
> 
> If we want to attack the issue for real we need to use something
> better.
> 
> lib/seq_buf.c is a good start for a lot of simple cases that just
> append to strings including creating complex ones.  Kent had a bunch
> of good ideas on how to improve it, but couldn't be convinced to
> contribute to it instead of duplicating the functionality which
> is a bit sad, but I think we need to switch to something like
> seq_buf that actually has a counted string instead of all this messing
> around with the null-terminated strings.

When doing more complex string creation, I agree. I spent some time
doing this while I was looking at removing strcat() and strlcat(); this
is where seq_buf shines. (And seq_buf is actually both: it maintains its
%NUL termination _and_ does the length counting.) The only thing clunky
about it was initialization, but all the conversions I experimented with
were way cleaner using seq_buf. I even added a comment to strlcat()'s
kern-doc to aim folks at seq_buf. :)

/**
 * strlcat - Append a string to an existing string
...
 * Do not use this function. While FORTIFY_SOURCE tries to avoid
 * read and write overflows, this is only possible when the sizes
 * of @p and @q are known to the compiler. Prefer building the
 * string with formatting, via scnprintf(), seq_buf, or similar.

Almost all of the remaining strncpy() usage is just string to string
copying, but the corner cases that are being spun out that aren't
strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
and memcpy(). Each of these are a clear improvement since they remove
the ambiguity of the intended behavior. Using seq_buf ends up being way
more overhead than is needed.

-Kees

-- 
Kees Cook
