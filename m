Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD93161BF
	for <linux-hardening@vger.kernel.org>; Thu, 17 Sep 2026 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628347; cv=none; b=ZwzCMz07Vqe5zVK2NJynJwtQsVyqzSrTgTDJcW3jwI9tMsXmR5JYjpbcdRsY8BpwjcpncYxmsMaEF+inq+xH3jMBHZaG40ZONCKnhEgwJGZd3AlGQTqKgCdyDQsfK8Q9MKBFnnDsu+V77rJ7ymcTGWwqv70AOXKtluuT12GaXAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628347; c=relaxed/simple;
	bh=TD/LHX83uzt2WOdvZi6XMa4BFQp+KmDW3mtwPFcWEyk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AIn/R6eFDjxSLcvCaWTnGa44/Qss5GKcZp0dZ//7C11KqnrIlXb2VkeY+hdCYYVvhFQc1S3lwaZEll1eRyISOQPkamSARzS5ZMykhe3SdNqvK3ezM0tvbAeblBtjR64cfbzOqNpwixIJo3eHz2O1jXHmUbGZBuBgdOc13TIFSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cD9qoVZo; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cD9qoVZo"
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 6sZ6xBrEbv0nd765Bx1ncZ; Thu, 17 Sep 2026 06:58:57 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 765AxHMHACZwg765AxS7gq; Thu, 17 Sep 2026 06:58:57 +0000
X-Authority-Analysis: v=2.4 cv=f4JIBPyM c=1 sm=1 tr=0 ts=6aab8fb1
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=Axhoo3-dusYTlG4bs9oA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=yDisUYLWR+RbDZYtxIoExkeG65QoyAF5bvyrFF+qxTk=; b=cD9qoVZog0Dz
	dmE7tQr1cpRdUW5SW35dYkCdV2sCzFRXIsWRPGV9wCBASJZD4MgP+ySi2QpnoSUEq4H1AEk4qLZRZ
	EsaMbs/piCdNZkzZnAK7gsEAuZ6ZqeTRfrLcP09/o5heiNo9Uws09DNAsCV8T6kO6vyhqk0B3N/xb
	5eP5/G8ewsiVMv0M4REKVe+p5Nt/Z2IKv1pKrVFzBdjoqnDnDfcB56bYdpk3olLVpYPHovvB2nSQl
	artFLoBlejcmltrxc6XqMto2ATm7q9xpuaCcCIP3FDcd1Q56wJjffg5eZdIVQwUysr6ePiM7+d2iN
	uR637S3fAdtwhL+omFn42g==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:53224 helo=[10.98.166.146])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <garsilva@embeddedor.com>)
	id 1x7659-000000023RD-3esH;
	Thu, 17 Sep 2026 01:58:56 -0500
Message-ID: <8d7393b5-1fd1-4db1-9f26-aa27c09ff426@embeddedor.com>
Date: Thu, 17 Sep 2026 15:58:41 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jakub Jelinek <jakub@redhat.com>,
 Richard Biener <richard.guenther@gmail.com>,
 Siddhesh Poyarekar <siddhesh@gotplt.org>, Kees Cook <kees@kernel.org>
Cc: gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
 josmyers@redhat.com, Bill Wendling <morbo@google.com>,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
References: <apomrLZp1ee3NnBF@kspp>
Content-Language: en-US
In-Reply-To: <apomrLZp1ee3NnBF@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x7659-000000023RD-3esH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.98.166.146]) [125.195.69.90]:53224
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHxOQYGrjML3KSkAsvc8Q/WNhWSWTJlVsoo2VURNLe7Le10UAp1SrK+ebN1wqIk089m1YSqGxS9CZ59odphkaV9J+nK8/IrfQwNxN0K3OCHgmvmeNCIe
 owrNoKGKEErdBBDXuTp0DZD2lE6V3919nvYqr4rQIFYOVbcsy2sUEL8CfP3UhFEOwoBU6zlkH9GtHl8RUemcYReSQ6KVcv0XwM5b0DSEhqeuTu250Ogv+tsB

Hi all,

Friendly ping: who can review/apply this, please? :)

BTW, I have a patch ready to address this other bug:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127234

but I'd like to land this bugfix first.

Thanks!
-Gustavo

On 9/4/26 11:02, Gustavo A. R. Silva wrote:
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
> 
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
> +
> +  __builtin_free (p);
> +  __builtin_free (op);
> +
> +  DONE ();
> +}
> diff --git a/gcc/tree-object-size.cc b/gcc/tree-object-size.cc
> index 54c320d36d0..90d2ac32614 100644
> --- a/gcc/tree-object-size.cc
> +++ b/gcc/tree-object-size.cc
> @@ -734,10 +734,13 @@ addr_object_size (struct object_size_info *osi, const_tree ptr,
>   		      }
>   		    /* if the ref is to a record or union type, but the type
>   		       does not include a flexible array recursively, compute
> -		       the object size directly.  */
> +		       the object size directly.  With -fstrict-flex-arrays=3 do
> +		       the same even when it does, so type 1 measures the subobject
> +		       instead of collapsing onto the whole-object type-0 size.  */
>   		    if (RECORD_OR_UNION_TYPE_P (TREE_TYPE (v)))
>   		      {
> -			if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v)))
> +			if (!TYPE_INCLUDES_FLEXARRAY (TREE_TYPE (v))
> +			    || flag_strict_flex_arrays == 3)
>   			  {
>   			    v = NULL_TREE;
>   			    break;

