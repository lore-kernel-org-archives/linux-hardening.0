Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1398224CF;
	Wed, 11 Sep 2024 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093381; cv=none; b=PDItI7Cd7SGPMBgC65iBUIr8I8/KU5DbABkMXwLe/VSQUsMMsPGlBuQa/EoeFSb++RKLlKxYGZJsLqmAKxTEr0WHRFlZpFwx7fY9Y1dTQdkrxGvhxG/rWCKsz7068x/s+kkBikuGxPrGmZ/dvy08T8HgMAN71WMSF1QE4t4xvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093381; c=relaxed/simple;
	bh=CeTttMY+Q4kBmD++wQT3MC8a2EQVjkLZY1H2aiNffnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgtLcQCiUAueI50Viu/LH1443+uiCtNML16vCjK+lsmZBU3Z14w6C2hBiYeesWqG4rjzjCTrGHaqw4/GnKmpOXu3ioyWpTzMJ5Fg/1SlxW0TmFRtavJCH7xuEcgp8LPZcreOliU2cOH65ZDCmizB4wXqPMC654Vym6/7zDK6OXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru1n3iJ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru1n3iJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C602C4CEC0;
	Wed, 11 Sep 2024 22:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726093381;
	bh=CeTttMY+Q4kBmD++wQT3MC8a2EQVjkLZY1H2aiNffnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ru1n3iJ/B8YJ1ZpgyY7IPBFRjhOFSewXm+3nGEPbUuOBmiMrGjYq2F/mpQA2TxToG
	 fpljZNIoepfHYLq2EN5kI3d4T4LCCyjpNzyJOY5kgy5RoOygkrCa8mST66x1vNK/NP
	 iHyqEoFEfqLFjM0kMM9B8ak0y9EAlthfn4+4qAzLeX+KoHAWlJLu+UNrJSVGirLU7E
	 QQuTI4YAN6T9W1DmjiX/MtTNyjOothx/MqXh6vb1A7qmAUnIiclq/rvdg1RpskTB1X
	 LByUYumU0YY6Wc7JI+n7ueaRFXSxbXtj1VIYc1U549v9P4WRf4X4tcwZQTKX2UZzXx
	 4hBeueanl4QCw==
Date: Wed, 11 Sep 2024 15:23:00 -0700
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
Subject: Re: [PATCH 4/5] alloc_tag: Track fixed vs dynamic sized kmalloc calls
Message-ID: <202409111518.9D90EE197@keescook>
References: <20240809072532.work.266-kees@kernel.org>
 <20240809073309.2134488-4-kees@kernel.org>
 <CAJuCfpFXTDnqZphJ1z37KkqMt5nuOqaoWMJMRBOkA8Dnf1Dh2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFXTDnqZphJ1z37KkqMt5nuOqaoWMJMRBOkA8Dnf1Dh2g@mail.gmail.com>

On Thu, Aug 29, 2024 at 09:00:37AM -0700, Suren Baghdasaryan wrote:
> On Fri, Aug 9, 2024 at 12:33 AM Kees Cook <kees@kernel.org> wrote:
> [...]
> > -#define kmem_cache_alloc(...)                  alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
> > +#define kmem_cache_alloc(...)          alloc_hooks(kmem_cache_alloc_noprof(__VA_ARGS__))
> 
> nit: seems like an unnecessary churn.

Whoops, yes. This was left over from an earlier pass and I failed to get
the whitespace correctly restored. I will fix this this.

> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index 81e5f9a70f22..6d2cb72bf269 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -78,6 +78,14 @@ static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
> >
> >         seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
> >         codetag_to_text(out, ct);
> > +#ifdef CONFIG_SLAB_PER_SITE
> > +       seq_buf_putc(out, ' ');
> > +       seq_buf_printf(out, "size:%s(%zu) slab:%s",
> > +                               tag->meta.sized == 0 ? "non-slab" :
> 
> "non-slab" term sounds overly specific and we might extend this to
> some other allocations as well in the future. I would suggest
> "unknown" instead.

Heh, yeah. I went back and forth on the name for this and went with
non-slab because we do know what it isn't. It's not some kind of
unexpected state. Maybe "untracked", or "unsized", though both seem
inaccurate from certain perspectives.

> 
> > +                                       tag->meta.sized == SIZE_MAX ? "dynamic" : "fixed",
> > +                               tag->meta.sized == SIZE_MAX ? 0 : tag->meta.sized,
> > +                               tag->meta.cache ? "ready" : "unused");
> 
> I don't see "struct alloc_meta" having a "cache" member...

Oops, yes, as you found this should have been associated with the next
patch that adds "cache".

> Since you are changing the format of this file, you want to also bump
> up the file version inside print_allocinfo_header().

Okay, yeah. In that case I'll probably split the report into a separate
patch after "cache" is added so there's only a single bump in allocinfo
versioning.

-- 
Kees Cook
