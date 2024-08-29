Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A491A3BC3
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937625; cv=none; b=VruGtWEFhvn8LuBqGBJ9KAevbdtVGn0pGHVy4a9ft3qQ5lwYRD4gtzHmTsyuC4SfWI/qtoESfWJNrKAFOp5ctakhBowDchVbupr2ZZILy0Z1dpPfUdB1ziYVo8nul8P79cuwWWOdHjApsKRXB3ZMM5WNjaFqsNjtFvnPemPUg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937625; c=relaxed/simple;
	bh=86Lwe0E4snf8OH/FuDd/GF/Uzj950uUfQPwkRu5e+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5oXDoHLJvOCT94b5Ou72m2goQQIpjQX11wDoSOwaAYoiDwbBUaRo/qKA7uDjS3qIO4nR5VWv6sReycynrYKbVkcWp/q0CIFg7HEnfdD5vyGNhl5fS1kw81LLE7A5g+YGn9uUINZAPzT+oWYkj8dJUtiLYvNEEoWnnEr2RRv93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EF9UfxOD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EF9UfxOD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso7420865e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724937622; x=1725542422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TO8oarX08QKeq0s+M0Wyl/wzcfkTIbZOOC4bUyVHle4=;
        b=EF9UfxOD0hjB/IHlZ71ukFN5YGAbnJOLGuX3beUmwtMXwItQV8Qjm4xQu+Ip38EEsU
         EwSkQK0vQ+/my2DM1nwtyurD9p5tX0PKLNsAgn0dktJMlUm1fwvbDRwqUyNhXixFgPn0
         Ni+SamAGJFRd8i/EfbNiW7tEnnJbBPL25L1SiVpWpE22c3x/Y03Ri4vuGBJu0TMoEkkY
         ErVFemdOjCzeSu2go11L1dUzomr8B3KvPkBILOKZEycWY4QbVtRYEYNBNULqyyPkguiJ
         T9IQbiSDY2fv1eM+SQ1cqdhafx2GipNDGTIFZjzI292pSw2uDUEjaAhx+dUl8Ik0cp8f
         MNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937622; x=1725542422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TO8oarX08QKeq0s+M0Wyl/wzcfkTIbZOOC4bUyVHle4=;
        b=rQBfKZnKkFBFrA9nqjkoimQIMdw8v7j7iTol7paot0iQOOyrdvj42Hfeq3SXmLJXV7
         nyCtSm/oe8pI9NvV3EqNz/xkHvUhLhI2KRlvb/oDWg8Jo92m3LNTuyfMGHSoinpZVb4x
         AkIUPJKaselzDld5lsgkoDMjd/5OQfIll5W3djXalQYazvQSPGcs/Eq0geWJTIR6pUkd
         1gMcCmvFdatfy/Fns3pTQWnKyXdqek+aMuIINYGOVT8UeVhJJjeVl4QjcTdWkqLkYuY7
         Xmg1DoJ0vhE/S/4c40iSWZ0x9vQGgUz6yahfFGdJPSqrXEek3xMZ4woaej2zOSekU8OU
         LXwA==
X-Forwarded-Encrypted: i=1; AJvYcCV8UA9Vi7JVsHO03bYdJ378MnxFQ4f69YMC4ErQSfo3A3vh6b4fPTsrrHV0FZ7l/P76HWin3Z3hB8yxcohhBrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fTvlZCT4AvbD5g2acZY/cmhFI48rzrTEP+Lq3D5mdqDmL6Vn
	ATqjLASf4hkGrZZ7XbhlKrKZ7rqeyehqUCTw5Oyd30O2Kp55cADwCwPzd/qcPGE=
X-Google-Smtp-Source: AGHT+IFG5xKEi8ZsOnVw2Jz8XiZur7+Fa4YTw3Tr8fXJGmRY/H10RnF1p8PnSg6TzvPizLMIX/pOhQ==
X-Received: by 2002:a05:6000:1085:b0:368:6596:edba with SMTP id ffacd0b85a97d-3749b57ae21mr2302313f8f.39.1724937621686;
        Thu, 29 Aug 2024 06:20:21 -0700 (PDT)
Received: from localhost (109-81-82-19.rct.o2.cz. [109.81.82.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df9705sm17293945e9.27.2024.08.29.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:20:21 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:20:20 +0200
From: Michal Hocko <mhocko@suse.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	urezki@gmail.com, v-songbaohua@oppo.com,
	virtualization@lists.linux.dev,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] mm: clarify nofail memory allocation
Message-ID: <ZtB1lLljEk9PVkU7@tiehlicka>
References: <bc952d89-1219-41e9-9a8b-cfe2a758d585@redhat.com>
 <ZscAtVskxgONe3gT@tiehlicka>
 <59e90825-4efa-4384-8286-06c0235304dc@redhat.com>
 <CAHk-=wiyq9vF-L7NXakadGdQ4TvFLrEwds-NzkByDSb2F2YUkQ@mail.gmail.com>
 <be4c9110-72d0-4749-941e-797a861d8319@suse.cz>
 <CAGsJ_4znRBscU8FWMZL7Z9qLUMxCPtupRcJqu+PXz260p-S6MA@mail.gmail.com>
 <c258403c-afc5-4969-b7c5-fa2a6c257371@suse.cz>
 <CAGsJ_4wu3theWe0iyXdBK-JvLfuBh7Qw-B+9Wztm2XyrU1Uzeg@mail.gmail.com>
 <2663352f-ecef-4e5b-bee5-e31d2b286c63@suse.cz>
 <CAGsJ_4zY5jwCsJh94OFMi1UqzFu5Ji3OeJZz91p2YKT5jxBc5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zY5jwCsJh94OFMi1UqzFu5Ji3OeJZz91p2YKT5jxBc5A@mail.gmail.com>

On Thu 29-08-24 23:53:33, Barry Song wrote:
> On Thu, Aug 29, 2024 at 10:24 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 8/27/24 09:50, Barry Song wrote:
> > > On Tue, Aug 27, 2024 at 7:38 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >>
> > >>
> > >> Ugh, wasn't aware, well spotted. So it means there at least shouldn't be
> > >> existing users of __GFP_NOFAIL with order > 1 :)
> > >>
> > >> But also the check is in the hotpath, even before trying the pcplists, so we
> > >> could move it to __alloc_pages_slowpath() while extending it?
> > >
> > > Agreed. I don't think it is reasonable to check the order and flags in
> > > two different places especially rmqueue() has already had
> > > gfp_flags & __GFP_NOFAIL operation and order > 1
> > > overhead.
> > >
> > > We can at least extend the current check to make some improvement
> > > though I still believe Michal's suggestion of implementing OOPS_ON is a
> > > better approach to pursue, as it doesn't crash the entire system
> > > while ensuring the problematic process is terminated.
> >
> > Linus made clear it's not a mm concern. If e.g. hardening people want to
> > pursuit that instead, they can.
> >
> > BTW I think BUG_ON already works like this, if possible only the calling
> > process is terminated. panic happens in case of being in a irq context, or
> 
> you are right. This is a detail I overlooked in the last discussion.
> BUG_ON has already been exactly the case to only terminate the bad
> process if it can
> (panic_on_oops=N and not in irq context).

Are you sure about that? Maybe x86 implementation treats BUG as oops but
is this what that does on all arches? BUG() has historically meant stop
everything and die and I am not really sure when that would have
changed TBH.

> > due to panic_on_oops. Which the security people are setting to 1 anyway and
> > OOPS_ON would have to observe it too. So AFAICS the only difference from
> > BUG_ON would be not panic in the irq context, if panic_on_oops isn't set.
> 
> right.
> 
> > (as for "no mm locks held" I think it's already satisfied at the points we
> > check for __GFP_NOFAIL).
> 
> Let me summarize the discussion:
> 
> Patch 1/4, which fixes the misuse of combining gfp_nofail and atomic
> in vdpa driver, is necessary.
> Patch 2/4, which updates the documentation to clarify that
> non-blockable gfp_nofail is not
>                   supported, is needed.

Let's please have those merged now.

> Patch 3/4: We will replace BUG_ON with WARN_ON_ONCE to warn when the
> size is too large,
>                  where gfp_nofail will return NULL.


I would pull this one out for a separate discussion. We should really
define what the too large really means and INT_MAX etc. is not it at
all.

> Patch 4/4: We will move the order > 1 check from the current fast path
> to the slow path and extend
>                  the check of gfp_direct_reclaim flag also in the slow path.

OK, let's have that go in now as well.

-- 
Michal Hocko
SUSE Labs
