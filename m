Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131047A0C0
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644315; cv=pass; b=Rk/2JTpeOFbQd0HOR+GgV6LclaoCb0KDgib1vDSbuFpRglukyG0qrSLiHjQ54sHDnXUgh8M26frSrumJzX6cFycjuzzOc40hvmX1RKCbUq6wxfq744sui6cO44ktCwj7sqnl4/2vVwDOX+ndZscO1qg/gMDEag3G2LNLGNSkmiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644315; c=relaxed/simple;
	bh=HJ6nNLxZW17HnlRUaGy/Sxke2oo2S9hPN7kv1Q8CyYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxk3qp8c2EsBlaQBdzKQblWSHdMKZ7wYDxl4sz61uZPp004Vi3j0uc/ScmeCPgLhNttA1ipzprTsa3q+vXqu24BooAG48yNiThX+UIJgyOPs7oCa85ZK9EUK33394Et4KvzF/OnuA2NVV7UGmX3HpAJ9Ik1izPg4xQktkNa3iho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CPP36oFc; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPP36oFc"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51758478240so7644821cf.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 00:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780644312; cv=none;
        d=google.com; s=arc-20240605;
        b=UqQkiiqUnD1jnuxRHVUFRPIK3E1iMXu0kN9IVGn0b7T86qkPv0JHTxosBHHEIaMzJk
         IJYUAVEwAinyBRi34hXUHjQliMofUiYIAHeSEi4o01UwlqeTvFXNUqD4ZrtrIgD3gO0Z
         l0f59K+iCFbDfu6NLD4m+NApaBZ4rgpcb2w9w5O5o0IYFV2Jvsy8AmCziWMXbiVXXO0p
         xugjCaf2Fv8Og01SYliqeLap2eeEUmYW9JyBF9UmZg//3OMrSgSSaxE6XjTKW020ZrbK
         /V3dtZklcJVl6xf0UH/FR7Cou5AHJMj1C/C3zsE3wh4PA/ijCGYW1C63ep+LKuAobY9O
         49Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKU63sZNkKiVuh/MwJ9Ce0lsts4Qigj8G34ohJIexYE=;
        fh=Gh3SNA1zrhuu0fFp7eeRiHm3Ad252+iZDejwW/VEBbw=;
        b=JFWYx8SG7ho/bpLS4/Sk//TG2GUhhBpcGHqOHWgedhqpBUmG+oodrJ3ccMpxzB3psq
         6l4STUQ9L549K0WFR8t7RvWzFOC/OoCVeu1yrEZluJTDNj8R0TbgYjj9In0cnCSyTQtB
         k6GnaVOGSg4rVUGqnr0orKolwLvtaZEzRK90WQlaJoMajmEGwvDSfVXb5KGkfB4588VK
         +19hlY8T8GLudr4fOJsgA0laXNtSLYxr6RNX6Be2YpdbfPGntfXteGZaxa/2c7wcb4nW
         zojbqR8G5S8xMANsHlq1ue300hyjtks8+Xzn8oeo3bTgzZ7u6EFYH/CDL2XqWbfFWqCU
         LNLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780644312; x=1781249112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKU63sZNkKiVuh/MwJ9Ce0lsts4Qigj8G34ohJIexYE=;
        b=CPP36oFcf4HCXQh8/BWzgdta8IVWrE2/LtI5SluagSi/rVsQ8dEt1dbiGLHfhbgY6b
         J5L2kuByM7lZRCKPJYSDtX0B+WCrQ4nTMiRTM9lMzpnbf3fA/0TRLhGyzdQpxcU3sDM5
         BzqWGJFmV3MMyl0CzFtIRQc2dYyW2zqgkA+xslVHhY7cgR6qZEx5jm5bLjktvj8e7BEv
         NqbGztjkY+ogFoN/edJac2qKDr2rOLEGfEX9jiB0LlYVFvNYKC+7+VIJKjwnu17I3u3I
         zxZqzbiN9mpP3IVn2x3kf8Zsk0/jFttZ8tV1Rxs5EXcNjO7HLVaQsMmh5C/6NhGkVAls
         Vl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780644312; x=1781249112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKU63sZNkKiVuh/MwJ9Ce0lsts4Qigj8G34ohJIexYE=;
        b=gsqKfI8UKUas16Z2XXbOOp5+0ioUNKW/bmiabQz8wpZzeknT+pKI5aYyJQ3ecNnkaB
         PdEwKQcma9R1jjr5GN5+jrwRCwulsGdz9LwCJLZJY0TuAtweEh1Dh0hUyZ4jCacwzek5
         A9f6pN6UTghWuBxrEs+4YE2Izmz4UhnMdsFbWbaKoB9AL+dE+4TuqU7CQ7mGCGBEsp9s
         t9K/GGzBR5sF03ZkHJ/XHz3FDYuXfoAnlzlu4KTMmVLxHrU1chMh5vYWzIhsVCdDNWbA
         u/XKrEac1RKWjaJ6gbP15szNjBYdV/p9Nqx+wynACDtoqDhp8m6Lp4XUTaOxiMnNT5qq
         WMhg==
X-Forwarded-Encrypted: i=1; AFNElJ+YSvoawbh+MEZQm64UYCbBXJ/HefW5+EDS1NpIIjorNmerYEH9ahNuU0SHW9H0qp0fzC0DBLRxeJULnnKR4rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK1flz/dO3iQF3qbCR96uUyfs2H69RejP/pMZnDPEAc1arqUng
	qK8MXUINjXa42nvorNznIhBSOHQmeoNCdSpUuEk2KcNaie5Ip1TxnP3l2zGCqfrLvCDbZknHpml
	+V3nzMRyJTGJhYgn0jjlLIoMcIswkDX7gL/Pi7ci8
X-Gm-Gg: Acq92OHh9ZATXItdHgGccxwM7+iKXp3dQ2wPRpbrgZEHX94mGRpkDxiZXQdk0BeUNGa
	2cN2r9p2oOP3k9LMScNMBcYHhnEvSmtOpXUn4gK0NFcaNXYkv7ybT5CsFFNUArqyZGzmWjCgUxq
	IonQz2RROHpkB3WzN1cWkHHP2/XAgz7VgWy1Lgui4spliKjSDbuPDNeq2mOD4xBNc3s3jucK8Dk
	xs+qNrk3/CGMq6wRYdBCkfvh2vY8jWdCZApfMw2vhvAQUg3XOGmYGx7rrrgq6Kw5AL7/QYwCo9I
	YVjYNgWU5TdvBKWlCpjshOrcdkDNWtdQbKbivUcvLjVzXgncvooYyEMDxmefCNftNra0Oi8uQjO
	48ZPyA8mj7RBkwDgik/s6gC4T84yxBnn+f/7xkzU=
X-Received: by 2002:a05:622a:4d09:b0:50d:65ec:a071 with SMTP id
 d75a77b69052e-51795a8da05mr40394911cf.5.1780644311231; Fri, 05 Jun 2026
 00:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602183122.747759-1-pfalcato@suse.de> <20260602183122.747759-3-pfalcato@suse.de>
 <6d70757a-a849-4828-89e7-f3d51bf8c9f8@kernel.org> <aiHIQ4ZxnMSifhmi@pedro-suse>
 <0198cf7c-ba09-47e9-abc3-dd230c1183dc@kernel.org>
In-Reply-To: <0198cf7c-ba09-47e9-abc3-dd230c1183dc@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jun 2026 00:25:00 -0700
X-Gm-Features: AVHnY4Ljnr1fO2_Ja9ct9TI0Ly9oIHrrXA2zxGwHDZ7iMunMRBy7qMI9IIG7ZO8
Message-ID: <CANn89iK_4g-2_U41CGYNdmBLCXyOARGdAakj26eigDhaL8hkCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: skb: isolate skb data area allocations into a
 separate bucket
To: Harry Yoo <harry@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:45=E2=80=AFPM Harry Yoo <harry@kernel.org> wrote:
>
>
>
> On 6/5/26 4:12 AM, Pedro Falcato wrote:
> > On Thu, Jun 04, 2026 at 02:30:34PM +0900, Harry Yoo wrote:
> >>
> >>
> >> On 6/3/26 3:31 AM, Pedro Falcato wrote:
> >>> SKB data area allocations (as done from alloc_skb()) use kmalloc().
> >>> These allocations can be variably sized and their contents can be mor=
e
> >>> or less controlled from userspace, which makes them useful for attack=
ers
> >>> that want to overwrite a use-after-free'd object from the same kmallo=
c slab
> >>> (which often just requires the sizes to roughly match into the same k=
malloc
> >>> bucket). [0] is an easy example of an exploit that uses netlink skb
> >>> allocation to target another similarly-sized accidentally freed objec=
t.
> >>>
> >>> While other mitigations like CONFIG_RANDOM_KMALLOC_CACHES exist, thes=
e are
> >>> probabilistic. Use the existing kmem buckets API to further isolate t=
hese
> >>> allocations in a guaranteed fashion, when CONFIG_SLAB_BUCKETS=3Dy.
> >>>
> >>> Link: https://github.com/google/security-research/blob/master/pocs/li=
nux/kernelctf/CVE-2023-4207_lts_cos_mitigation_2/docs/exploit.md [0]
> >>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> >>> ---
> >>>  net/core/skbuff.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >>> index 44a7f8401468..1f6c6b531ece 100644
> >>> --- a/net/core/skbuff.c
> >>> +++ b/net/core/skbuff.c
> >>> @@ -594,6 +594,8 @@ static void *kmalloc_pfmemalloc(size_t obj_size, =
gfp_t flags, int node)
> >>>     return kmalloc_node_track_caller(obj_size, flags, node);
> >>>  }
> >>>
> >>> +static kmem_buckets *skb_data_buckets __ro_after_init;
> >>> +
> >>>  /*
> >>>   * kmalloc_reserve is a wrapper around kmalloc_node_track_caller tha=
t tells
> >>>   * the caller if emergency pfmemalloc reserves are being used. If it=
 is and
> >>> @@ -632,7 +634,7 @@ static void *kmalloc_reserve(unsigned int *size, =
gfp_t flags, int node,
> >>>      * Try a regular allocation, when that fails and we're not entitl=
ed
> >>>      * to the reserves, fail.
> >>>      */
> >>> -   obj =3D kmalloc_node_track_caller(obj_size,
> >>> +   obj =3D kmem_buckets_alloc_node_track_caller(skb_data_buckets, ob=
j_size,
> >>>                                     flags | __GFP_NOMEMALLOC | __GFP_=
NOWARN,
> >>>                                     node);
> >>>     if (likely(obj))
> >>
> >> What about kmalloc_pfmemalloc()?
> >
> > Good point, that looks free as well.
> >
> > Sidenote: isolating kmem_cache_alloc for possibly-aliasing caches could=
 also
> > be useful. skb allocation has net_hotdata.skb_small_head_cache. It does=
n't merge
> > with anything for $raisins (odd size, plus I don't think usercopy cache=
s are
> > getting merged?) but it feels too... accidental?
>
> Right, we never merge caches with useroffset/usersize.
>
> Hmm...
>
> /* SKB_SMALL_HEAD_CACHE_SIZE is the size used for the skbuff_small_head
>  * kmem_cache. The non-power-of-2 padding is kept for historical reasons =
and
>  * to avoid potential collisions with generic kmalloc bucket sizes.
>  */
> #define SKB_SMALL_HEAD_CACHE_SIZE                                       \
>         (is_power_of_2(SKB_SMALL_HEAD_SIZE) ?                   \
>                 (SKB_SMALL_HEAD_SIZE + L1_CACHE_BYTES) :        \
>                 SKB_SMALL_HEAD_SIZE)
>
>
> What are "historical reasons" other than avoiding collisions with
> kmalloc caches?

git log/blame might help :)

commit 0f42e3f4fe2a58394e37241d02d9ca6ab7b7d516
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
Date:   Fri Apr 3 09:45:12 2026 +0800

    net: skb: fix cross-cache free of KFENCE-allocated skb head

Note that MAX_SKB_FRAGS can be tuned.

config MAX_SKB_FRAGS
int "Maximum number of fragments per skb_shared_info"
range 17 45
default 17
help
  Having more fragments per skb_shared_info can help GRO efficiency.
  This helps BIG TCP workloads, but might expose bugs in some
  legacy drivers.
  This also increases memory overhead of small packets,
  and in drivers using build_skb().
  If unsure, say 17.



>
> > Maybe passing something like SLAB_NO_MERGE and making the size
> > standard-looking would be nice. I have a size of 704 bytes per object, =
and
> > this probably causes some weird wastage for each slab.
>
> Yes, unless the "historical reasons" do not make it infeasible to do that=
.
>
> And I wonder if net/core/skbuff.c intends to always prevent merging, or
> only with hardening configs like SLAB_BUCKETS.

We do not care anymore of merging or not.
