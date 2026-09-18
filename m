Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59D511191
	for <linux-hardening@vger.kernel.org>; Fri, 18 Sep 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748391; cv=none; b=fRDdzo/+7OG9US44gvot3osM45nqdKo0l5koc+z533+wRLUdDdiIpAEuJ2M7AvbWjsfK9/weoxE8WSvOjgvBE88iwgl2v9VyJZEfq5FvU+zZPZTjLbVMFiiUuICKOJkm24gDSpds7TiLcmXgmek+0uiMtJT+pNWOHBY4sXQZ5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748391; c=relaxed/simple;
	bh=o4KApFBeHDkec8RfcRXNlC9Fr3hZx+l4GSqT5jfxwyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmZ2h7SQ/uXUrkYkJ6z9DJh+GR2lF5LmQFOGe09IpAkFb15SkXRJLUiPvcb+zxKH82ZwJr7ZDF9ClqqALn1Qfq2eHLHXHW4P2HGCgX1QHEyeFPN9AZ5zrRY8oNT6kALdNoJ3+b9n5DULbr4EEI1HSk0BobZxKpKthHyZF0eqvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org; spf=pass smtp.mailfrom=gotplt.org; dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b=SWMJhivG; arc=none smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="SWMJhivG"
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 47861944115;
	Fri, 18 Sep 2026 16:19:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (100-99-183-215.trex-nlb.outbound.svc.cluster.local [100.99.183.215])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C25BA944123;
	Fri, 18 Sep 2026 16:19:34 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Wide-Eyed: 22ca7531532678e1_1789748379908_4078105583
X-MC-Loop-Signature: 1789748379908:3703764859
X-MC-Ingress-Time: 1789748379908
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.183.215 (trex/8.0.2);
	Fri, 18 Sep 2026 16:19:39 +0000
Received: from [192.168.8.195] (unknown [38.74.41.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4hmd9x63TKz3B;
	Fri, 18 Sep 2026 09:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1789748374;
	bh=71ba7gNYnomcczEsOvzDpFXe56NEjISo7S7IWtPXpfE=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=SWMJhivGQOc1wxOX6wxcwKiRME7N/HvzYJ7NvBLvKZpTLrHg1M0TIDZOqH+yU8bAL
	 pOIvpi+ijDhAMmO4rZetb4d0votSag17Pgi5HOa1jwbwHwGMlfwcfikQbhAy4dTEwb
	 Sl5qqpmM3rdVqU7HMOEyJfmhEHyTHs+S92SrQcWdPKeOUOu4B8XpMKFDc+Kmk9oI91
	 wnCcxL3Zjm74hGgfG/OCrT7N4x/n7awqJ3E19dYz6hZm51wQL7kuZkT2NvUllI78zV
	 muNn8ThrFTZCf5+ZVIFoQgYM7RrgpnXcR4V7tn0B22tSub1HsvlnXylKRd1saF4vE3
	 eGTvI6cPROOMg==
Message-ID: <9074daad-836b-4eeb-bf1d-01a5b11cea69@gotplt.org>
Date: Fri, 18 Sep 2026 12:19:22 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Jakub Jelinek <jakub@redhat.com>, Richard Biener
 <richard.guenther@gmail.com>, Kees Cook <kees@kernel.org>
Cc: gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
 josmyers@redhat.com, Bill Wendling <morbo@google.com>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <apomrLZp1ee3NnBF@kspp>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <apomrLZp1ee3NnBF@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-03 22:02, Gustavo A. R. Silva wrote:
> For a pointer to a subobject whose record/union type ends in a flexible-array
> member (directly, or through a trailing nested struct), addr_object_size()
> walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
> measuring the referenced subobject.  __builtin_object_size() and
> __builtin_dynamic_object_size() type 1 therefore returned the whole-object
> size, collapsing type 1 onto type 0 and losing the distinction between
> &p->inner and p.  FORTIFY_SOURCE relies on the type-1 distinction, so this
> weakens its bounds checks.
> 
> Fix this by computing the size directly from the referenced record/union
> instead of walking up, under -fstrict-flex-arrays=3 specifically to avoid
> conflicting with -fstrict-flex-arrays semantics at lower levels, thereby
> restoring the type-0/type-1 distinction that Clang already implements.

I don't understand the rationale, why is only the declared size the 
correct answer for maximum size even for -fstrict-flex-arrays=3?  The 
correct maximum size answer should also include the computed size of the 
flex array since it's part of the inner object.

> Bootstrapped and regtested on x86_64-linux-gnu.
> 
> Changes in v2:
>   - Change behavior under -fstrict-flex-arrays=3 only.
>   - Update subject line and changelog text.
>   - Document the new type-1 behavior in extend.texi.
> 
> v1:
>   - Link: https://lore.kernel.org/linux-hardening/aojDH2Db6XIkVqcf@kspp/
> 
> 	PR tree-optimization/126975
> 
> gcc/ChangeLog:
> 
> 	* tree-object-size.cc (addr_object_size): For a reference to a
> 	record or union type that recursively includes a flexible-array
> 	member, compute the object size from the referenced subobject
> 	instead of walking up to the enclosing object when
> 	-fstrict-flex-arrays=3 is in effect.
> 	* doc/extend.texi (__builtin_object_size): Document the type-1
> 	behavior for pointers to subobjects that end in a flexible array
> 	member, and its interaction with -fstrict-flex-arrays=3.
> 
> gcc/testsuite/ChangeLog:
> 
> 	* gcc.dg/builtin-object-size-pr126975.c: New test.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   gcc/doc/extend.texi                           | 32 +++++++++++++
>   .../gcc.dg/builtin-object-size-pr126975.c     | 45 +++++++++++++++++++
>   gcc/tree-object-size.cc                       |  7 ++-
>   3 files changed, 82 insertions(+), 2 deletions(-)
>   create mode 100644 gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c
> 
> diff --git a/gcc/doc/extend.texi b/gcc/doc/extend.texi
> index 397b05ab87d..30fdc702f13 100644
> --- a/gcc/doc/extend.texi
> +++ b/gcc/doc/extend.texi
> @@ -17894,6 +17894,38 @@ assert (__builtin_object_size (q, 0)
>   /* The subobject q points to is var.b.  */
>   assert (__builtin_object_size (q, 1) == sizeof (var.b));
>   @end smallexample
> +
> +When, for @var{type} 1, the closest surrounding subobject is of a
> +@code{struct} or @code{union} type that ends in a flexible array
> +(@pxref{Zero Length,,Arrays of Length Zero}), either directly or through a
> +trailing nested struct, that subobject can be extended past its declared
> +size.  Its size is therefore constrained only by the enclosing complete
> +object, as it is for @var{type} 0.
> +
> +Under @option{-fstrict-flex-arrays=3}, where only a true C99
> +flexible array member is treated as a flexible array, the declared size of
> +the referenced subobject is used instead, which restores the distinction
> +between @var{type} 0 and @var{type} 1 for such pointers.
> +
> +@smallexample
> +/* Compiled with -fstrict-flex-arrays=3.  */
> +struct A @{ int n; char data[]; @};
> +struct B @{ int m; struct A a; @};
> +struct B *b = malloc (sizeof (struct B) + 48);
> +struct B *volatile vp = malloc (sizeof (struct B) + 48);
> +struct B *op = vp;
> +
> +/* &b->a ends in a flexible array member, but -fstrict-flex-arrays=3 makes
> +   type 1 its declared size, not the whole-object (type 0) size.  */
> +assert (__builtin_object_size (&b->a, 1) == sizeof (b->a));
> +/* Likewise when op is opaque, where type 0 would be (size_t) -1.  */
> +assert (__builtin_object_size (&op->a, 1) == sizeof (op->a));
> +
> +/* For a pointer to the flexible array member itself, type 0 and type 1
> +   both return (size_t) -1 here.  */
> +assert (__builtin_object_size (op->a.data, 0) == (size_t) -1);
> +assert (__builtin_object_size (op->a.data, 1) == (size_t) -1);
> +@end smallexample
>   @enddefbuiltin
>   
>   @defbuiltin{{size_t} __builtin_dynamic_object_size (const void * @var{ptr}, int @var{type})}
> diff --git a/gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c b/gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c
> new file mode 100644
> index 00000000000..c8c60c4f76e
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/builtin-object-size-pr126975.c
> @@ -0,0 +1,45 @@
> +/* PR 126975:
> +   Under -fstrict-flex-arrays=3 only a true C99 flexible-array member is
> +   treated as flexible. For &subobject whose type ends in such a member,
> +   __builtin_object_size/__builtin_dynamic_object_size type 1 must measure
> +   the subobject, not the tail of the allocation (type 0). */
> +/* { dg-do run } */
> +/* { dg-options "-O2 -fstrict-flex-arrays=3" } */
> +
> +#include "builtin-object-size-common.h"
> +
> +struct flex {
> +  size_t count;
> +  char fam[];
> +};
> +
> +struct outer {
> +  int hdr;
> +  struct flex inner;
> +};
> +
> +int main (void)
> +{
> +  struct outer *p = __builtin_malloc (sizeof(*p) + 48);
> +  struct outer *volatile vp = __builtin_malloc (sizeof(*vp) + 48);
> +  struct outer *op = vp;
> +
> +  /* True C99 flexible-array member: type 1 measures the subobject. */
> +  EXPECT(__builtin_object_size(&p->inner, 1), sizeof(p->inner));
> +  EXPECT(__builtin_dynamic_object_size(&p->inner, 1), sizeof(p->inner));
> +
> +  /* Type 0 still reports the whole tail of the allocation. */
> +  EXPECT(__builtin_object_size(&p->inner, 0), sizeof(p->inner) + 48);
> +  EXPECT(__builtin_dynamic_object_size(&p->inner, 0), sizeof(p->inner) + 48);
> +
> +  /* When op is opaque, type 0 is unknown (-1), but type 1 still measures
> +     the subobject. */
> +  EXPECT(__builtin_object_size(&op->inner, 0), -1);
> +  EXPECT(__builtin_object_size(&op->inner, 1), sizeof(op->inner));
> +  EXPECT(__builtin_dynamic_object_size(&op->inner, 1), sizeof(op->inner));

I think the ideal correct answer for __bdos(&op->inner, 1) is in fact 
`sizeof (*op) + 48 - __offsetof (outer, inner)` since fam is part of 
inner.  The bare sizeof excludes memory allocated for the fam.

In case of an opaque pointer one may estimate the *minimum* subobject 
size as being just sizeof (inner).

Thanks,
Sid
