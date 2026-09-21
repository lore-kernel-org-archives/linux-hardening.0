Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92048E0E7
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991470; cv=none; b=qnvAWy0ra6CMgq8gDVqtRQ0Pd00jAJV0xLJqB3TbNBy5g5BF/kRgU26RaPDUxugJgYh5Qr98xzEjFfMAyVwZAklU9eeFAQebcB0v30Rw/gkXjKguvjQiQWBSj8bPzj3ph92FIcaMXnBJvpLN4JY+uRpIV7g4zb7Gnmnjp+TIZGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991470; c=relaxed/simple;
	bh=10nfhjAIJnsXe1hZcXAe82N07s0DDGp1qST1Dsza1zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQe8UfsglU1X8gnUOU6ALHV7Elbu94g0wFWV9LoLvO32lPrLCFyxrkJE2Qv0GY5ujE/eXMlLbD8XgbCot2xDJKd6wkNHJvrGc9dLLLbuSZIxg67AZSdIR4IBJjAzU0Ms7sbSR2xCW2lV9Fyvw24C5cHLaSQysl9TbciYucqBtoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=GUBtPJMC; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="GUBtPJMC"
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id 8be9xlqczc3Xs8cWYxrgRq; Mon, 21 Sep 2026 11:49:30 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 8cWXxNiafMB9V8cWYxfW38; Mon, 21 Sep 2026 11:49:30 +0000
X-Authority-Analysis: v=2.4 cv=d5D1yQjE c=1 sm=1 tr=0 ts=6ab119ca
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=mDV3o1hIAAAA:8
 a=VwQbUJbxAAAA:8 a=n1VusUbl1kj_oJ1DzoQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=e0ORIRaW1pRFVLSVMe9CQtNJd9lWH1Pfzw3oEBrxTQo=; b=GUBtPJMC+h8Q
	6ACAAWzKjMUDVHPrh03uGCjTaM/86Bhkm6PM75gBQ8AAv8i69jNE1ExzVWGXsesgplLiX3et/Djbt
	rtOrngx6NHgA4cc529T83B3K+503fFdgv1hUVmXlxh1SK9WvNIRpTYs6ZrO8+vJgKQC5+Wnj+LUup
	BrYcYNW+pafZAI7DwAaq2K9mJ8eu8+qMyIFYMAm5Plg/Ex7Uz0Yt8bFXwN+M/EA6+siXEXQpXRl3f
	gpY4TOBmOhPSLvdjLXk+jpO2nrxTf1ngfCN5XOUCNlyNw9n6rv6Z71Vr+WWqCDbkFwCeEvzbl1ju1
	0oihA+dMymcPy5ubngHqhA==;
Received: from [61.251.99.138] (port=6891 helo=[10.98.166.146])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x8cWW-000000006C0-3WTe;
	Mon, 21 Sep 2026 06:49:29 -0500
Message-ID: <2df2f47d-5bef-4272-936b-13cfb350aac7@embeddedor.com>
Date: Mon, 21 Sep 2026 20:48:56 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
To: Siddhesh Poyarekar <siddhesh@gotplt.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 Richard Biener <richard.guenther@gmail.com>, gcc-patches@gcc.gnu.org,
 Martin Uecker <uecker@tugraz.at>, josmyers@redhat.com,
 Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <apomrLZp1ee3NnBF@kspp> <202609182117.7AFD5B1@keescook>
 <7f43c0b9-2ea7-4038-82c5-ca01aa2c1309@gotplt.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7f43c0b9-2ea7-4038-82c5-ca01aa2c1309@gotplt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 61.251.99.138
X-Source-L: No
X-Exim-ID: 1x8cWW-000000006C0-3WTe
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.98.166.146]) [61.251.99.138]:6891
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMRXv8Gf4rPHYGcYjozK7Ajaq9ZffGav7jlO8m6nEm/GVu5c8z5WUOcXY5p1uX8VRMvTRducYE/DMiH86S2Occr42ZzfBnpIzm07ULm+48Dk3H1cngNO
 mRglU70Ti4vCNUBPvTFLk+X37TOfYfLpL/6eQdIM+F7muMLozidrnTciN+9a130R4MGtGqDgraeahRbFQU9aDB50uFqm/xE7NY6q3UEpu9umw01+YTE4BfRC



On 9/19/26 22:27, Siddhesh Poyarekar wrote:
> On 2026-09-19 00:22, Kees Cook wrote:
>> On Thu, Sep 03, 2026 at 08:02:20PM -0600, Gustavo A. R. Silva wrote:
>>> For a pointer to a subobject whose record/union type ends in a flexible-array
>>> member (directly, or through a trailing nested struct), addr_object_size()
>>> walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
>>> measuring the referenced subobject.  __builtin_object_size() and
>>> __builtin_dynamic_object_size() type 1 therefore returned the whole-object
>>> size, collapsing type 1 onto type 0 and losing the distinction between
>>> &p->inner and p.  FORTIFY_SOURCE relies on the type-1 distinction, so this
>>> weakens its bounds checks.
>>
>> Looking at the PR:
>>
>> struct flex {
>>    size_t count;
>>    char fam[] __attribute__((counted_by(count)));
>> };                    /* sizeof(struct flex) == 8  */
>>
>> struct outer {
>>    int hdr;
>>    struct flex inner;
>> };                    /* sizeof(struct outer) == 16 */
>>
>> int main (void)
>> {
>>    struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte object */
>>
>>    /* This is a bug. */
>>    expect(__builtin_object_size (&p->inner, 1), sizeof(p->inner));
>>    expect(__builtin_dynamic_object_size (&p->inner, 1), sizeof(p->inner));
>> ...
>> }
>>
>> Before:
>>
>> WAT: __builtin_object_size (&p->inner, 1) == 56 (expected 8)
>> WAT: __builtin_dynamic_object_size (&p->inner, 1) == 56 (expected 8)
>>
>> After:
>>
>> ok:  __builtin_object_size (&p->inner, 1) == 8
>> ok:  __builtin_dynamic_object_size (&p->inner, 1) == 8
>>
>>
>> This makes sense to me, the dynamic size of "fam" is ambiguous between
>> being 0 or 48 (from the "alloc_size" attribute), so type 1 chooses the
>> smaller.
> 
> I think you're confusing type 1 with type 2; type 1 is the *maximum* subobject size, not the minimum.  The whole object and subobject size distinction is only 
> material if there are members after inner, which is technically "supported" by the complier as an extension, but is a terrible idea for members with FAM.
> 
> Here are the different possibilities for &p->inner:
> 
> 1. If the allocation via __builtin_malloc is visible: same result for types 0, 1, 2 and 3, i.e. allocated size - offsetof (struct outer, inner)

When the allocation is visible and the FAM is annotated with counted_by, we use
the information provided by counted_by. See commit 6f17933548fc ("Use the
.ACCESS_WITH_SIZE in builtin object size.")

BTW, I recently filed this related issue:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127234

> 
> 2. If the __builtin_malloc is not visible and there's no counted_by annotation:
>    - type 0 and type 1: cannot determine size, since FAM could be any arbitrary size. So, -1
>    - type 2 and type 3: sizeof (&p->inner), since that's the minimum estimate.
> 
> 3. if the __builtin_malloc is not visible and FAM has __counted_by__ annotation: same result for all types: sizeof (&p->inner) + p->count
> 
>> I would, however, expect the use of counted_by to change it. For
>> example, if it were this:
>>
>> struct flex {
>>    size_t count;
>>    char fam[] __attribute__((counted_by(count)));
>> };
>> ...
>>    struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte object */
>>    p->inner.count = 48;
>>
>> I would expect the results to be:
>>
>> ok:  __builtin_object_size (&p->inner, 1) == 8        /* compile-time size */
>> ok:  __builtin_dynamic_object_size (&p->inner, 1) == 56 /* run-time size */

I agree with counted_by changing things here. This is actually something
that Jakub mentioned in a comment to v1 of this patch:

"What we certainly can change is the behavior when
-fstrict-flex-arrays unless it already behaves the expected way,
and perhaps also when the flex array has counted_by attribute."

See: https://lore.kernel.org/linux-hardening/aogVH8UtICMP1Ihv@tucnak/#t

BTW, I have a patch ready for PR127234 (the missed counted_by bug) where
I implemented some helper functions to get the size of the object based
on the information provided by counted_by. I could use those in this PR. :)

Thanks
-Gustavo

>>
>> As the known size of p->inner is everything contained by "inner" and
>> that now includes the 48 bytes of "fam".
> __builtin_object_size is not the compile time size, it is a runtime constant size estimate, with the `type` argument deciding if the size estimate is on the 
> maximum or minimum end, and if it considers the whole object or only the immediate containing subobject that the input pointer points to.  In the presence of 
> FAMs I think sizeof (i.e. the compile time size) should be seen as a minimum size estimate for the subobject, if you want to make an equivalence with 
> __builtin_object_size.
> 
> Similarly, __builtin_dynamic_object_size is exactly the same as __builtin_object_size, except that it can return non-constant expressions too, not just constants.
> 
> Thanks,
> Sid

