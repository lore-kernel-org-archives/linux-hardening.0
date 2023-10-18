Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812B3984F
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GQhkVl/9"
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794511B
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:36:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5cd27b1acso62265195ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697668562; x=1698273362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU8UgFLtIwBMnNin+UfjeLA6KRbmnG6Wd91XkYWntpA=;
        b=GQhkVl/9fDceZRGSVUreqYnt3zuY5DMfBTEFTanW2ex901gUNulYVNrrmdTLIvHRt7
         w54JVgMxU+iBiWwDff9UJNcaBR6Dyixjer5sedl1HZc/Vt5DHZLrAMffHaHQyWUOYFYS
         Sq/fV1rqYB1Sjq5yIIjAdwZqeYPzg/ybbts/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668562; x=1698273362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU8UgFLtIwBMnNin+UfjeLA6KRbmnG6Wd91XkYWntpA=;
        b=gsJ/O8XLnKd2v0ahBmqRU00HPKLDesUfzxaqJsmfBY0z2AYzNxdOv2jyOf+JSvUkxL
         OiYcjeM9FkUlAwC/+8pxH0624j0ZfLpDft6d5Q5cVWzl7AWL1dJboFFEMyhvfuLMrFna
         D7K2H59A9ZGbDqkQDpf74dk88tnVK6I+/0sHlBvm2qAujJ/DgkGs64f+ug8aee/dHyNj
         djKxK/0iQQDkVIr2uSR0wttOthQBFA+DcdRTT8RLvFE/aoeUeK5tXE2TBCdVb1jouYjk
         iQrBXK2O5Ysn3T3EFSH5YrmnsNPZGgzjTKEyAF/QHaLaaQNv10/65lv6x2j7gZpuw8oC
         wILg==
X-Gm-Message-State: AOJu0YxnWTXzE/dUiVIqbxngTnuGMOvyZyHMJZVd357mhEM4HdLLGM+f
	IOqJio85llOhYN/Vyr+BlfDGsg==
X-Google-Smtp-Source: AGHT+IHZ7D6QAbuRry6EjRTPblbyH23khZ4i/P+R2xOAqDQmfqYJkoXHgkb29YoqYPno7OWAy5G2/Q==
X-Received: by 2002:a17:903:2342:b0:1c7:5f03:8562 with SMTP id c2-20020a170903234200b001c75f038562mr729819plh.30.1697668561892;
        Wed, 18 Oct 2023 15:36:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw6-20020a170903044600b001c0a414695dsm453085plb.62.2023.10.18.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 15:36:01 -0700 (PDT)
Date: Wed, 18 Oct 2023 15:36:00 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <202310181534.54934E68@keescook>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
 <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>

On Wed, Oct 18, 2023 at 06:04:07PM -0400, Kent Overstreet wrote:
> On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> > On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > > Hi Kees,
> > > 
> > > I'm curious if this is something that could be buried in bch_val given
> > > it's already kind of a fake structure..? If not, my only nitty comment
> > 
> > I was thinking it would be best to keep the flexible array has "high" in
> > the struct as possible, as in the future more refactoring will be needed
> > to avoid having flex arrays overlap with other members in composite
> > structures. So instead of pushing into bch_val, I left it at the highest
> > level possible, bch_i, as that's the struct being used by the memcpy().
> 
> I agree with Brian here - I'd like this buried in bch_val, if possible.
> 
> I also went with unsafe_memcpy() for now - that's now in my for-next
> tree. I'm not seeing any advantage of DECLARE_FLEX_ARRAY over that -
> perhaps later if we could use __counted_by that would make more sense.

This won't help here because of the combination of -fstrict-flex-arrays=3
and -Wstringop-overflow (the latter is in W=1 builds). The builtin memcpy
still complains about the 0-sized destination. I'll send a v3 with this
in bch_val.

-- 
Kees Cook
