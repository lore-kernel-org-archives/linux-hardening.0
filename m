Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774575815
	for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391061; cv=none; b=AuxtuTCOFZ8WOc1PWMdIvPqL1M6AYc+AyqskAt57a88+Gts8NiqMcJT6CAvPJEBqPMT/A3Yv8+cuQW+rdjQ8tN3aKArlXN9/EeFjjwu4l+0qmr1LvHf4qtf0zPueWxQ30DkrPedkSO9wdhqz6SYjapBouX0BzjA5lLkJ1Wxs/dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391061; c=relaxed/simple;
	bh=YsfVTzmPLYWYdgmBjM8zx6lSgYBT13jCl/idN/vK9KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxecE2eJFUKovy4ul51Xtv5VVH0hsxS3OAIsJ7kdTMrGsmi8ZmcFBek5GFMcfSCOhiO0NKcgKjofSGTkUCfdKHrXCmoeltBTZxmfA1nZqRf0/0QSX4EczyERL3u7eE8mhUVNB1r593OBsNnEva0oT9RyRNAsq7j3HlOYWuAXXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xutm/JGK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xutm/JGK"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e152c757a5so2278986a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711391058; x=1711995858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwJ6aw89XG6ag1cAMAye4X3OlKaivOSj4AMu57dyHZA=;
        b=Xutm/JGKCTiAPiiMg9ak9mk6bcX664ZItPrIx1GK5WjNt/oyaVPHO1payKrV6jpag7
         gy5Kza5XdE1vuu58BX9JWZ9cLmG+WfRDoT8pUJ7CipuGSiw017DuAr2ymRD+e+QwxjKP
         RgmboUr2498kR8zDrnZf89PaSvgnENxT4SRPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391058; x=1711995858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwJ6aw89XG6ag1cAMAye4X3OlKaivOSj4AMu57dyHZA=;
        b=PukgRUOFrhrjhgOIZMqHqh2HqfjYut3yj5rqHtjdTkcvfxj4khcrdEEyeg5qG1jzbK
         6+iAk0ZtO067uDPQWKXn81M3huK4NilzVDMRKV2JrLWMfkEIJ1WhcskGAgKgCjBE9BYT
         T1h41ZoQHSkN3nEA5PIKAiX2vf8bnPS9QYiYSMh/S8f3A/rFR0YeTc6CfBGIdcBG8B/y
         aoaG7Q9VDU50Ljax6KMewXwD79twmgDI3rRwHhrXla7rkal9NR4pY+qymsneWMg1gxGw
         J6a+rL/1xncCHAGHcIITFEKhUBDE+hxDJ4FB/L72w/GUXGtSP+vWxIitLjskUfOPuG9C
         5jYw==
X-Forwarded-Encrypted: i=1; AJvYcCUEK1T/qFxs/OEfLRvI2oEmetK3K5Mv7jV9cLK76TPU+uuGoRqd7PbfpgxHYrDX8mShCkKJqSOZ0BZLfxPfYB+Tw9sq6mSNvUmU1NeBVX4s
X-Gm-Message-State: AOJu0YzJ7keOSETHiyhZCYhg1qjxrAszn5+MTubatPf0H4dvGxzDfb3V
	KTrpmLmKKaijOi3CQgtH6sek8tQSIUKDstvPBf0f79rHx0rpsuPig5PikveYaQ==
X-Google-Smtp-Source: AGHT+IHNRBPKz7IkJD3yJgMjJGAVIzlGXkznLyu7qd+9aDITzPOvbPJuNphM2uFoaTabaqgGZ3ou/w==
X-Received: by 2002:a17:90a:f285:b0:2a0:390e:f072 with SMTP id fs5-20020a17090af28500b002a0390ef072mr5691880pjb.40.1711391058608;
        Mon, 25 Mar 2024 11:24:18 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id qa14-20020a17090b4fce00b002a04f430937sm4349793pjb.43.2024.03.25.11.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:24:18 -0700 (PDT)
Date: Mon, 25 Mar 2024 11:24:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>, Julien Voisin <jvoisin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, jvoisin <julien.voisin@dustri.org>
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Message-ID: <202403250958.DAFA70CC@keescook>
References: <20240305100933.it.923-kees@kernel.org>
 <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>

On Mon, Mar 25, 2024 at 10:03:23AM +0100, Vlastimil Babka wrote:
> On 3/5/24 11:10 AM, Kees Cook wrote:
> > Hi,
> > 
> > Repeating the commit logs for patch 4 here:
> > 
> >     Dedicated caches are available For fixed size allocations via
> >     kmem_cache_alloc(), but for dynamically sized allocations there is only
> >     the global kmalloc API's set of buckets available. This means it isn't
> >     possible to separate specific sets of dynamically sized allocations into
> >     a separate collection of caches.
> > 
> >     This leads to a use-after-free exploitation weakness in the Linux
> >     kernel since many heap memory spraying/grooming attacks depend on using
> >     userspace-controllable dynamically sized allocations to collide with
> >     fixed size allocations that end up in same cache.
> > 
> >     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> >     against these kinds of "type confusion" attacks, including for fixed
> >     same-size heap objects, we can create a complementary deterministic
> >     defense for dynamically sized allocations.
> > 
> >     In order to isolate user-controllable sized allocations from system
> >     allocations, introduce kmem_buckets_create(), which behaves like
> >     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> >     which behaves like kmem_cache_alloc().)
> > 
> >     Allows for confining allocations to a dedicated set of sized caches
> >     (which have the same layout as the kmalloc caches).
> > 
> >     This can also be used in the future once codetag allocation annotations
> >     exist to implement per-caller allocation cache isolation[0] even for
> >     dynamic allocations.
> > 
> >     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]
> > 
> > After the implemetation are 2 example patches of how this could be used
> > for some repeat "offenders" that get used in exploits. There are more to
> > be isolated beyond just these. Repeating the commit log for patch 8 here:
> > 
> >     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
> >     use-after-free type confusion flaws in the kernel for both read and
> >     write primitives. Avoid having a user-controlled size cache share the
> >     global kmalloc allocator by using a separate set of kmalloc buckets.
> > 
> >     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
> >     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
> >     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
> >     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
> >     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
> >     Link: https://zplin.me/papers/ELOISE.pdf [6]
> 
> Hi Kees,
> 
> after reading [1] I think the points should be addressed, mainly about the
> feasibility of converting users manually.

Sure, I can do that.

Adding Julien to this thread... Julien can you please respond to LKML
patches in email? It's much easier to keep things in a single thread. :)

] This is playing wack-a-mole

Kind of, but not really. These patches provide a mechanism for having
dedicated dynamically-sized slab caches (to match kmem_cache_create(),
which only works for fixed-size allocations). This is needed to expand
the codetag work into doing per-call-site allocations, as I detailed
here[1].

Also, adding uses manually isn't very difficult, as can be seen in the
examples I included. In fact, my examples between v1 and v2 collapsed
from 3 to 2, because covering memdup_user() actually covered 2 known
allocation paths (attrs and vma names), and given its usage pattern,
will cover more in the future without changes.

] something like AUTOSLAB would be better

Yes, that's the goal of [1]. This is a prerequisite for that, as
mentioned in the cover letter.

] The slabs needs to be pinned

Yes, and this is a general problem[2] with all kmalloc allocations, though.
This isn't unique to to this patch series. SLAB_VIRTUAL solves it, and
is under development.

] Lacks guard pages

Yes, and again, this is a general problem with all kmalloc allocations.
Solving it, like SLAB_VIRTUAL, would be a complementary hardening
improvement to the allocator generally.

] PAX_USERCOPY has been marking these sites since 2012

Either it's whack-a-mole or it's not. :) PAX_USERCOPY shows that it _is_
possible to mark all sites. Regardless, like AUTOSLAB, PAX_USERCOPY isn't
upstream, and its current implementation is an unpublished modification
to a GPL project. I look forward to someone proposing it for inclusion
in Linux, but for now we can work with the patches where an effort _has_
been made to upstream them for the benefit of the entire ecosystem.

] What about CONFIG_KMALLOC_SPLIT_VARSIZE

This proposed improvement is hampered by not having dedicated
_dynamically_ sized kmem caches, which this series provides. And with
codetag-split allocations[1], the goals of CONFIG_KMALLOC_SPLIT_VARSIZE
are more fully realized, providing much more complete coverage.

] I have no idea how the community around the Linux kernel works with
] their email-based workflows

Step 1: reply to the proposal in email instead of (or perhaps in
addition to) making blog posts. :)

> On a related technical note I
> worry what will become of /proc/slabinfo when we convert non-trivial amounts
> of users.

It gets longer. :) And potentially makes the codetag /proc file
redundant. All that said, there are very few APIs in the kernel where
userspace can control both the size and contents of an allocation.

> Also would interested to hear Jann Horn et al.'s opinion, and whether the
> SLAB_VIRTUAL effort will continue?

SLAB_VIRTUAL is needed to address the reclamation UAF gap, and is
still being developed. I don't intend to let it fall off the radar.
(Which is why I included Jann and Matteo in CC originally.)

In the meantime, adding this series as-is kills two long-standing
exploitation methodologies, and paves the way to providing very
fine-grained caches using codetags (which I imagine would be entirely
optional and trivial to control with a boot param).

-Kees

[1] https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook/
[2] https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

-- 
Kees Cook
