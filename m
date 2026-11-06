Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971208;
	b=rM8exJ7u1gPAZonXG4GpIhY8b8QXcubXVPAuXdnBpN1Y83rQGgGvepNzvxovURBAd0pD
	 OS+dK+vRGWAD43hhTZKMZo03aSfPvHIqKmw8wbxgH25dmHLVDUVYff/ovZjcZS91NfwxO
	 Nl6RzoNFpoxFDBkezQcMuZqb6Muk6GZIRWPtDZ6F7XBFyQ01xc2IOFEvNcvpEJ2Uw8vCH
	 SnG3ROpYYGobr7wvcnN9Bi2KRQM2JRigCCQ5Vnjz6N5YOpEczbL9aFeoDyqmxHFaHqvlx
	 GoSism09auwsIfJG3x+bJLk/BgTcJgu52frozBXBcHfXS/2M2EjJcUP/iFoSFK5QiLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971208;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Skirt-Army:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=WrIkDP7lEX1Ul54y2EnYD596ZorJ+dbYux07rZCxk/4=;
	b=vdIcr+bXKx0GxF5ay+37KvayCjFrY2LynVQX4noZfIL/RGpzG7pCp2lB3EsnvShgC8qc
	 70aqM7rSFgQ2zf5szS9TqHkzbGs3P/9A85dUJlTwVFFixJR8uIvKKJ8bAFk8YIRcjwOW8
	 nvBZdgJSsywQjSLC1EqOpYyoM6/ViTYCaCWoOdZNUgO4EkjXyaaTyru/EEKygQZ0XdeXb
	 YYiD46YfNnybiJ4TTQFmkOT/BOXN3W6mr3YKHjq0z+BNgPAMg2bq0uO7wNrXrUfEde+d5
	 /3AjaUqL1qSeTSYocIhjaO/uTit5aNFho6s7sHlPnshzQwFWkcozkQ4B+0oG/T26jHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gotplt.org;
	spf=pass smtp.mailfrom=gotplt.org;
	dkim=pass header.d=gotplt.org header.i=@gotplt.org header.a=rsa-sha256 header.s=dreamhost header.b=QUWlVK99;
	arc=none smtp.remote-ip=23.83.222.61
Received: from fly.ash.relay.mailchannels.net (fly.ash.relay.mailchannels.net [23.83.222.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B8606D827
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 288B8606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gotplt.org header.i=@gotplt.org header.a=rsa-sha256 header.s=dreamhost header.b=QUWlVK99
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 61B0F162560;
	Fri, 06 Nov 2026 13:20:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.99.211.79])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F1B1C162448;
	Fri, 06 Nov 2026 13:19:53 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Army: 4b59d1d213e3d2d8_1793971199088_3429607601
X-MC-Loop-Signature: 1793971199088:3889041008
X-MC-Ingress-Time: 1793971199088
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.211.79 (trex/8.0.2);
	Fri, 06 Nov 2026 13:19:59 +0000
Received: from [192.168.8.195] (unknown [38.74.41.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4jLft06yqbz105D;
	Fri,  6 Nov 2026 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1793971193;
	bh=WrIkDP7lEX1Ul54y2EnYD596ZorJ+dbYux07rZCxk/4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=QUWlVK99CyrqLU5EbRRO6Vx3nqJmWRjePDDSRKh4FA8QSwBs8wlKIpfFVZfqOK/lP
	 danPQM+CZj8XFL0h+zoOBlpU07TDTfmLC99eX4TrO4pHM5cdPdh4HZAbJrNDTn7XWS
	 YKyEONZJ3/NHsQ9L/Uo4mK1CmhXcJKgv3sq7egexvmhYGz+kK9TJTh0YfdOvFD4rCr
	 NrDdmpmNVGZpYLTuMb5itc0x5sj+5tIihkrpgUTSOL0BsB/HXR8hqgHcrN0WjViylZ
	 fJvV1XRcVjuKsdvopSZORMthvz69L8R0u7km2XXqpvSPbs2AZXCMFf0Kwi2nXjhBrQ
	 g7wz4cvVrKOxg==
Message-ID: <cf259095-e322-467e-9d12-7539ac0194e0@gotplt.org>
Date: Fri, 6 Nov 2026 08:19:42 -0500
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tree-object-size: let counted_by determine __bdos type-0
 sizes [PR127234]
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Jakub Jelinek <jakub@redhat.com>, Richard Biener
 <richard.guenther@gmail.com>, Kees Cook <kees@kernel.org>
Cc: gcc-patches@gcc.gnu.org, Martin Uecker <uecker@tugraz.at>,
 josmyers@redhat.com, Bill Wendling <morbo@google.com>,
 linux-hardening@vger.kernel.org
References: <at8LD2CsvtNJLNZz@kspp>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <at8LD2CsvtNJLNZz@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-26 04:10, Gustavo A. R. Silva wrote:
> For __builtin_dynamic_object_size(&p->inner, 0), where the referenced object
> ends in a counted_by flexible-array member, that member's count fully
> determines the size of the object at runtime.  GCC used it only as a last
> resort: it answered from the allocation when visible (so an over-allocated
> buffer reports more than counted_by says is valid) and returned -1 when the
> allocation was opaque, making the answer depend on whether the allocation
> stayed visible.
> 
> Make counted_by authoritative for this case.  For a COMPONENT_REF with
> OST_DYNAMIC set and OST_SUBOBJECT clear, compute the size as
> component_ref_size() plus the counted_by payload, recursing through nested
> aggregates to locate the flexible-array member, in preference to the
> allocation and without clamping to it.  This is the size implied by
> counted_by.  It is what FORTIFY_SOURCE should enforce.
> 
> The counted_by size computation is factored out of
> access_with_size_object_size() into a new helper.
> 
> Clang had the same opaque-base defect, returning SIZE_MAX (LLVM issue #205652,
> fixed by PR #205903).
> 
> Lastly, I used LLMs to help me research the GCC codebase, debugging,
> generate test cases, construct and run builds and tests, as well as
> writing a few lines of code (in particular the testsuite files).

The GCC AI policy allows LLM generated code only for test cases, please see:

https://gcc.gnu.org/ai-policy.html

could you please clarify what code the LLM generated, other than the 
test cases?

> 
> Bootstrapped and regtested on x86_64-pc-linux-gnu.
> 
> Assisted-by: Claude Opus 4.8
> 
> 	PR tree-optimization/127234
> 
> gcc/ChangeLog:
> 
> 	* tree-object-size.cc (counted_by_object_size): New function,
> 	factored out of access_with_size_object_size.
> 	(component_ref_counted_by_size): New function.
> 	(addr_object_size): For a COMPONENT_REF that ends in a counted_by
> 	flexible array member, use the counted_by attribute to compute the
> 	dynamic whole-object size in preference to the allocation, and do
> 	not clamp the result to the allocation.
> 	(access_with_size_object_size): Use counted_by_object_size.
> 
> gcc/testsuite/ChangeLog:
> 
> 	* gcc.dg/builtin-dynamic-object-size-counted-by.c: New test.
> 	* gcc.dg/builtin-dynamic-object-size-counted-by-2.c: New test.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Hi!
> 
> I'm new to the GCC codebase, but I've been doing Linux kernel
> development for nearly a decade, particularly kernel hardening
> as part of the Linux Kernel Self-Protection Project, led by Kees Cook.
> So I'm serious about fixing toolchain bugs that affect some of the
> hardening features we rely on in the Linux kernel, in this case,
> how counted_by works.
> 
> I'm happy to answer any questions about this patch and discuss
> how LLMs assisted in its development.
> 
> Thanks!
> -Gustavo
> 
>   ...builtin-dynamic-object-size-counted-by-2.c |  65 +++++++
>   .../builtin-dynamic-object-size-counted-by.c  |  34 ++++
>   gcc/tree-object-size.cc                       | 162 +++++++++++++++---
>   3 files changed, 237 insertions(+), 24 deletions(-)
>   create mode 100644 gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by-2.c
>   create mode 100644 gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by.c
> 
> diff --git a/gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by-2.c b/gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by-2.c
> new file mode 100644
> index 00000000000..f46376fceb5
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by-2.c
> @@ -0,0 +1,65 @@
> +/* counted_by is authoritative for __bdos type 0 for both a visible and an
> +   opaque base, even when the count exceeds the allocation (no clamp).  Last
> +   case is a negative control: a plain FAM (no counted_by) stays unknown (-1).  */
> +/* { dg-do run } */
> +/* { dg-options "-O2" } */
> +#include "builtin-object-size-common.h"
> +
> +struct annotated        { size_t count; char fam[] __attribute__((counted_by(count))); };
> +struct nested_annotated { int hdr; struct annotated inner; };
> +
> +/* Plain FAM, no counted_by.  The opaque base is required: on a visible
> +   allocation a plain FAM answers from the malloc, not -1.  */
> +struct flex        { size_t count; char fam[]; };
> +struct nested_flex { int hdr; struct flex inner; };
> +
> +__attribute__((noinline))
> +struct nested_flex *alloc_plain(size_t count)
> +{
> +  struct nested_flex *p = malloc(sizeof(*p) + count);
> +  p->inner.count = count;
> +  return p;
> +}
> +
> +/* counted_by object reached through an opaque base.  */
> +__attribute__((noinline))
> +struct nested_annotated *alloc_opaque(size_t count, size_t alloc)
> +{
> +  struct nested_annotated *p = malloc(sizeof(*p) + alloc);
> +  p->inner.count = count;
> +  return p;
> +}
> +
> +int main(void)
> +{
> +  /* Allocation LARGER than count -> counted_by wins (result < alloc).  */
> +  struct nested_annotated *p = malloc(sizeof(*p) + 10);
> +  p->inner.count = 3;
> +  EXPECT(__builtin_dynamic_object_size(&p->inner, 0),
> +	 sizeof(p->inner) + p->inner.count);
> +
> +  free(p);
> +
> +  /* Allocation SMALLER than count -> counted_by still wins (result > alloc).  */
> +  struct nested_annotated *q = malloc(sizeof(*q) + 2);
> +  q->inner.count = 100;
> +  EXPECT(__builtin_dynamic_object_size(&q->inner, 0),
> +	 sizeof(q->inner) + q->inner.count);
> +
> +  free(q);
> +
> +  /* Opaque base, count EXCEEDS the hidden allocation -> counted_by still
> +     governs the size (not -1, not the allocation).  */
> +  struct nested_annotated *s = alloc_opaque(100, 2);
> +  EXPECT(__builtin_dynamic_object_size(&s->inner, 0),
> +	 sizeof(s->inner) + s->inner.count);
> +
> +  free(s);
> +
> +  /* Negative control: no counted_by -> recovery must not fire (stays -1).  */
> +  struct nested_flex *r = alloc_plain(10);
> +  EXPECT(__builtin_dynamic_object_size(&r->inner, 0), (size_t) -1);
> +
> +  free(r);
> +  DONE();
> +}
> diff --git a/gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by.c b/gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by.c
> new file mode 100644
> index 00000000000..b90c1f6f85e
> --- /dev/null
> +++ b/gcc/testsuite/gcc.dg/builtin-dynamic-object-size-counted-by.c
> @@ -0,0 +1,34 @@
> +/* __bdos type 0 on a counted_by FAM reached through an opaque, nested base:
> +   must return sizeof(subobject) + count, not -1.  The noinline allocator keeps
> +   the base opaque.  */
> +/* { dg-do run } */
> +/* { dg-options "-O2" } */
> +#include "builtin-object-size-common.h"
> +
> +struct annotated        { size_t count; char fam[] __attribute__((counted_by(count))); };
> +struct nested_annotated { int hdr; struct annotated inner; };
> +struct outer            { int hdr; struct nested_annotated nested; };
> +
> +__attribute__((noinline))
> +struct outer *alloc_opaque(size_t count)
> +{
> +  struct outer *p = malloc(sizeof(*p) + count);
> +  p->nested.inner.count = count;
> +  return p;
> +}
> +
> +int main(void)
> +{
> +  struct outer *p = alloc_opaque(10);
> +
> +  /* Recurse through struct nested_annotated to the FAM.  */
> +  EXPECT(__builtin_dynamic_object_size(&p->nested, 0),
> +	 sizeof(p->nested) + p->nested.inner.count);
> +
> +  /* The FAM's own struct, directly.  */
> +  EXPECT(__builtin_dynamic_object_size(&p->nested.inner, 0),
> +	 sizeof(p->nested.inner) + p->nested.inner.count);
> +
> +  free(p);
> +  DONE();
> +}
> diff --git a/gcc/tree-object-size.cc b/gcc/tree-object-size.cc
> index 196aa93d44f..bc750034b99 100644
> --- a/gcc/tree-object-size.cc
> +++ b/gcc/tree-object-size.cc
> @@ -62,6 +62,8 @@ static tree compute_object_offset (tree, const_tree);
>   static bool addr_object_size (struct object_size_info *,
>   			      const_tree, int, tree *, tree *t = NULL);
>   static tree alloc_object_size (const gcall *, int);
> +static tree counted_by_object_size (tree, tree, tree, int);
> +static tree component_ref_counted_by_size (tree, int);
>   static tree access_with_size_object_size (const gcall *, int);
>   static tree pass_through_call (const gcall *);
>   static void collect_object_sizes_for (struct object_size_info *, tree);
> @@ -590,6 +592,106 @@ decl_init_size (tree decl, bool min)
>     return size;
>   }
>   
> +/* Size implied by REF_TO_SIZE for a counted_by FAM.  TYPE is the counted_by
> +   field's type, ELEMENT_SIZE one element's size.  */
> +
> +static tree
> +counted_by_object_size (tree ref_to_size, tree type, tree element_size,
> +			int object_size_type)
> +{
> +  if ((object_size_type & OST_DYNAMIC) == 0)
> +    return size_unknown (object_size_type);
> +
> +  tree size = fold_build2 (MEM_REF, type, ref_to_size,
> +			   build_int_cst (ptr_type_node, 0));
> +
> +  /* If size is negative value, treat it as zero.  */
> +  if (!TYPE_UNSIGNED (type))
> +    {
> +      tree cond_expr = fold_build2 (LT_EXPR, boolean_type_node,
> +				    unshare_expr (size),
> +				    build_zero_cst (type));
> +      size = fold_build3 (COND_EXPR, integer_type_node, cond_expr,
> +			  build_zero_cst (type), size);
> +    }
> +
> +  size = size_binop (MULT_EXPR,
> +		     fold_convert (sizetype, size),
> +		     fold_convert (sizetype, element_size));
> +
> +  if (!todo)
> +    todo = TODO_update_ssa_only_virtuals;
> +
> +  return size;
> +}
 > +> +/* REF is a COMPONENT_REF whose type ends in a counted_by FAM. 
Return that
> +   FAM's dynamic size.  */
> +
> +static tree
> +component_ref_counted_by_size (tree ref, int object_size_type)

This unfortunately could be problematic when the counted_by field is set 
in the same block as this __bdos call; since the compiler doesn't see 
(before this pass is called) the read dependency, it could reorder the 
write after the read.

This is why we need the .ACCESS_WITH_SIZE in the counted_by design; it 
acts as a barrier to prevent such reordering.  It looks to me like this 
needs a .ACCESS_WITH_SIZE generated when reading an aggregate, if an 
aggregate contains a FAM with a counted_by attribute.  IMO the 
.ACCESS_WITH_SIZE could get the full size, i.e. component_ref size + the 
counted_by size since the component_ref size should be visible to the 
frontend.

With that .ACCESS_WITH_SIZE, you may not need any change to 
tree-object-size.

> +{
> +  if ((object_size_type & OST_DYNAMIC) == 0)
> +    return NULL_TREE;
> +
> +  tree type = TREE_TYPE (ref);
> +
> +  if (!RECORD_OR_UNION_TYPE_P (type) || !TYPE_INCLUDES_FLEXARRAY (type))
> +    return NULL_TREE;
> +
> +  for (tree field = TYPE_FIELDS (type); field; field = DECL_CHAIN (field))
> +    {
> +      if (TREE_CODE (field) != FIELD_DECL)
> +	continue;
> +
> +      tree field_type = TREE_TYPE (field);
> +
> +      if (TREE_CODE (field_type) == ARRAY_TYPE
> +	  && TYPE_SIZE (field_type) == NULL_TREE)
> +	{
> +	  tree attr = lookup_attribute ("counted_by", DECL_ATTRIBUTES (field));
> +	  if (!attr)
> +	    return NULL_TREE;
> +
> +	  tree count_name = TREE_VALUE (TREE_VALUE (attr));
> +	  tree count_field = NULL_TREE;
> +
> +	  for (tree f = TYPE_FIELDS (type); f; f = DECL_CHAIN (f))
> +	    if (TREE_CODE (f) == FIELD_DECL && DECL_NAME (f) == count_name)
> +	      {
> +		count_field = f;
> +		break;
> +	      }
> +
> +	  if (!count_field)
> +	    return NULL_TREE;
> +
> +	  tree count_ref = build3 (COMPONENT_REF, TREE_TYPE (count_field),
> +				   unshare_expr (ref), count_field, NULL_TREE);
> +	  tree ref_to_size = build_fold_addr_expr (count_ref);
> +	  tree element_size = TYPE_SIZE_UNIT (TREE_TYPE (field_type));
> +
> +	  if (!element_size)
> +	    return NULL_TREE;
> +
> +	  return counted_by_object_size (ref_to_size, TREE_TYPE (count_field),
> +					 element_size, object_size_type);
> +	}
> +
> +      if (RECORD_OR_UNION_TYPE_P (field_type)
> +	  && TYPE_INCLUDES_FLEXARRAY (field_type))
> +	{
> +	  tree subref = build3 (COMPONENT_REF, field_type,
> +				unshare_expr (ref), field, NULL_TREE);
> +	  tree size = component_ref_counted_by_size (subref, object_size_type);
> +	  if (size)
> +	    return size;
> +	}
> +    }
> +
> +  return NULL_TREE;
> +}
> +
>   /* Compute __builtin_object_size for PTR, which is a ADDR_EXPR.
>      OBJECT_SIZE_TYPE is the second argument from __builtin_object_size.
>      If unknown, return size_unknown (object_size_type).  */
> @@ -676,6 +778,7 @@ addr_object_size (struct object_size_info *osi, const_tree ptr,
>     if (pt_var != TREE_OPERAND (ptr, 0))
>       {
>         tree var;
> +      bool counted_by_size_used = false;
>   
>         if (object_size_type & OST_SUBOBJECT)
>   	{
> @@ -804,15 +907,44 @@ addr_object_size (struct object_size_info *osi, const_tree ptr,
>   	  if (!var_size)
>   	    return false;
>   	}
> -      else if (!pt_var_size)
> -	return false;
>         else
> -	var_size = pt_var_size;
> +	{
> +	  tree op = TREE_OPERAND (ptr, 0);
> +	  tree compsize = NULL_TREE, famsize = NULL_TREE;
> +
> +	  /* counted_by is authoritative for a component ending in such a FAM,
> +	     whether or not the base allocation is visible.  */
> +	  if ((object_size_type & OST_DYNAMIC)
> +	      && !(object_size_type & OST_SUBOBJECT)
> +	      && TREE_CODE (op) == COMPONENT_REF)
> +	    {
> +	      compsize = component_ref_size (op);
> +	      famsize = component_ref_counted_by_size (op, object_size_type);
> +	    }
> +
> +	  if (compsize && famsize)
> +	    {
> +	      /* Static part plus the counted_by size.  Takes precedence over
> +		 the allocation (even a visible, smaller one).  */
> +	      var = op;
> +	      var_size = size_binop (PLUS_EXPR,
> +				     fold_convert (sizetype, compsize),
> +				     fold_convert (sizetype, famsize));
> +	      pt_var_wholesize = var_size;
> +	      counted_by_size_used = true;
> +	    }
> +	  else if (!pt_var_size)
> +	    return false;
> +	  else
> +	    var_size = pt_var_size;
> +	}
> +
>         bytes = compute_object_offset (TREE_OPERAND (ptr, 0), var);
>         if (bytes != error_mark_node)
>   	{
>   	  bytes = size_for_offset (var_size, bytes);
> -	  if (var != pt_var && pt_var_size && TREE_CODE (pt_var) == MEM_REF)
> +	  if (!counted_by_size_used
> +	      && var != pt_var && pt_var_size && TREE_CODE (pt_var) == MEM_REF)
>   	    {
>   	      tree bytes2 = compute_object_offset (TREE_OPERAND (ptr, 0),
>   						   pt_var);
> @@ -880,26 +1012,8 @@ access_with_size_object_size (const gcall *call, int object_size_type)
>        flexible array.  */
>     tree element_size = gimple_call_arg (call, 3);
>   
> -  tree size = fold_build2 (MEM_REF, type, ref_to_size,
> -			   build_int_cst (ptr_type_node, 0));
> -
> -  /* If size is negative value, treat it as zero.  */
> -  if (!TYPE_UNSIGNED (type))
> -  {
> -    tree cond_expr = fold_build2 (LT_EXPR, boolean_type_node,
> -				  unshare_expr (size), build_zero_cst (type));
> -    size = fold_build3 (COND_EXPR, integer_type_node, cond_expr,
> -			build_zero_cst (type), size);
> -  }
> -
> -  size = size_binop (MULT_EXPR,
> -		     fold_convert (sizetype, size),
> -		     fold_convert (sizetype, element_size));
> -
> -  if (!todo)
> -    todo = TODO_update_ssa_only_virtuals;
> -
> -  return size;
> +  return counted_by_object_size (ref_to_size, type, element_size,
> +				 object_size_type);
>   }
>   
>   /* Compute __builtin_object_size for CALL, which is a GIMPLE_CALL.

