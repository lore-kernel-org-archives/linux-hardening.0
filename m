Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C478C9D;
	Wed, 11 Sep 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093125; cv=none; b=TvjiIzIqJHsF+AOFP0LJjfcKbGVOmbU1RdbbMg5AKfgng+j/Gpd4C2CQ+6owcsNpOVCnHevrV3IJ7ajTCPrX4V/96av5u3BWfvXtI20q1V+rfZJjIYVF46C0KhGUGHCIqL0OPHSVWR15ofLMSAk2A3x9nQ3w2KwJ7GPGH8DV9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093125; c=relaxed/simple;
	bh=+6cSwg/X+10bSLWe5d2NRG2QHpKGwxHJCNr4zPB6bv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXx7WIE5RGjwfhUopN7V4qJdkGuTEQp0z4jGCucy9xm5mbAWEDxr2NzX0tnCcKhMoeMp6TgnW676s3sAJ2W6ubPg0lkiFA9TFh1yE5VGDdyiOu5+alpysZJWReOL/IJeOopYRXdGRx5ZJau+SxyoBhlHW7iwUSW/jK+qDdF3rAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB3Ma8tT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB3Ma8tT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253D7C4CEC0;
	Wed, 11 Sep 2024 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093125;
	bh=+6cSwg/X+10bSLWe5d2NRG2QHpKGwxHJCNr4zPB6bv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aB3Ma8tTz5vz736fDP2NRhsK/Krhq65bIP1s3XKcy/ZS2XrRJkCXJSvScSICyZizS
	 muZy8dHDlOoJcut6QFbUEcLvIAhBUGZzOWdfN/Er19/ztR7mZTI3D1DI9Fm2hpuzCV
	 WmMhZhImMWkLdp8cVGqV44FcSVvarYZ05TLA7q1rDTZ+ZCMRTd8mSjgamQSRNl8APm
	 S6DlgGDQ6xF+kerYWM6O1lE4fZ/ru5lUBwr85S3GLJJGL4J4WFusfnhABorwb6tmY1
	 o1kJKdxZBY/rS7OUOKLWsvQUo58EuJaKPsliABRdDAC2Y168a0oRry2qSD1X3/UlYb
	 AIZ7RyMJo2pgw==
Date: Wed, 11 Sep 2024 15:18:44 -0700
From: Kees Cook <kees@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/5] codetag: Introduce codetag_early_walk()
Message-ID: <202409111518.FFAD85919@keescook>
References: <20240809072532.work.266-kees@kernel.org>
 <20240809073309.2134488-3-kees@kernel.org>
 <CAJuCfpHLD=rK_xPpZ89t+E=S77dr=0Gq7+L9BLkojiqN+TC0FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHLD=rK_xPpZ89t+E=S77dr=0Gq7+L9BLkojiqN+TC0FQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 08:39:29AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 9, 2024 at 12:33 AM Kees Cook <kees@kernel.org> wrote:
> >
> > In order to process builtin alloc_tags much earlier during boot (before
> > register_codetag() is processed), provide codetag_early_walk() that
> > perform a lockless walk with a specified callback function. This will be
> > used to allocate required caches that cannot be allocated on demand.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Pekka Enberg <penberg@kernel.org>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > Cc: linux-mm@kvack.org
> > ---
> >  include/linux/codetag.h |  2 ++
> >  lib/codetag.c           | 16 ++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/include/linux/codetag.h b/include/linux/codetag.h
> > index c2a579ccd455..9eb1fcd90570 100644
> > --- a/include/linux/codetag.h
> > +++ b/include/linux/codetag.h
> > @@ -64,6 +64,8 @@ void codetag_lock_module_list(struct codetag_type *cttype, bool lock);
> >  bool codetag_trylock_module_list(struct codetag_type *cttype);
> >  struct codetag_iterator codetag_get_ct_iter(struct codetag_type *cttype);
> >  struct codetag *codetag_next_ct(struct codetag_iterator *iter);
> > +void codetag_early_walk(const struct codetag_type_desc *desc,
> > +                       void (*callback)(struct codetag *ct));
> >
> >  void codetag_to_text(struct seq_buf *out, struct codetag *ct);
> >
> > diff --git a/lib/codetag.c b/lib/codetag.c
> > index ef7634c7ee18..9d563c8c088a 100644
> > --- a/lib/codetag.c
> > +++ b/lib/codetag.c
> > @@ -154,6 +154,22 @@ static struct codetag_range get_section_range(struct module *mod,
> >         };
> >  }
> >
> > +void codetag_early_walk(const struct codetag_type_desc *desc,
> > +                       void (*callback)(struct codetag *ct))
> > +{
> > +       struct codetag_range range;
> > +       struct codetag *ct;
> > +
> > +       range = get_section_range(NULL, desc->section);
> > +       if (!range.start || !range.stop ||
> > +           range.start == range.stop ||
> > +           range.start > range.stop)
> > +               return;
> 
> I think this check can be simplified to:
> 
>         if (!range.start || range.start >= range.stop)
>                 return;
> 
> nit: Technically (!range.start) should also never trigger. In a valid
> image these symbols are either missing (range.start == range.stop ==
> NULL) or both are defined and (range.start < range.stop).

Yeah, all true. I was mainly copying all the checks that existed in the
"slow path" version.

I will adjust this for the next version.

-- 
Kees Cook
