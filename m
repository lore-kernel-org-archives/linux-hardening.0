Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2B2248AF
	for <linux-hardening@vger.kernel.org>; Sat, 19 Sep 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789826103; cv=none; b=rQQYE7F6EndhqTmfXr6Awf5eLf4zht5hCr1K4F4KNigR1Znd8ScVe6mJY5rmx6vWCHniXktZQgZXhtG8ko4tvkUrLDLYQ6VFXFnaBpB9ummLudhW6M9p09B3pQJMCQ3AUJyoGE8SHElpSaEx6M5nP/CG394byRazKR6hv4g13/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789826103; c=relaxed/simple;
	bh=z37ZfrxlR24gJfRlfPpJeU7bRoEaGRwC5zkJxzWTj/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLd3NCgAK/lhKP11lAtNTgV/U+D3GsHk4p4oGacUaSk9uIRVvmaWb8wMskc8IK9ACw4edwotJ2fJ3K46QSkcqu8Ai3R88OXLAUl7fI8HsqkQ/MP4cQPhfwtz8fBaGMcv8SgX2HnCtRDiz8UDUrHulGylKZ8DKaLXeHXqsfS9PrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org; spf=pass smtp.mailfrom=gotplt.org; dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b=ZRvkBvTF; arc=none smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gotplt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gotplt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gotplt.org header.i=@gotplt.org header.b="ZRvkBvTF"
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EE7BE40120F;
	Sat, 19 Sep 2026 13:27:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (100-100-242-123.trex-nlb.outbound.svc.cluster.local [100.100.242.123])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A5DE6401BCB;
	Sat, 19 Sep 2026 13:27:51 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Fumbling: 3a985f236c2287bd_1789824476787_341899940
X-MC-Loop-Signature: 1789824476787:928661428
X-MC-Ingress-Time: 1789824476787
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.242.123 (trex/8.0.2);
	Sat, 19 Sep 2026 13:27:56 +0000
Received: from [192.168.8.195] (unknown [38.74.41.78])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: siddhesh@gotplt.org)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4hn9KL4sXHzPH;
	Sat, 19 Sep 2026 06:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
	s=dreamhost; t=1789824471;
	bh=5B/9KskiLAj7h/46x+aHjZNZRgCWopZSnZKOSukgRyo=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=ZRvkBvTFQlwe5Fwp62EGJm4Wv5jspT3wB6pditcgfqN5mkBj9ElhWkZfwBuK5jR3Q
	 ++tLqoxjy/uY4lj7QNYFpfuk06vcu2Kc/HMNSHzskFYrButOP92kf8HEEdtrsBj84M
	 Je/4I5VEj3M0dKrpBXTF5lW6dlVW3USPPX290i7j0rV4hyXkoikb3nF6BN2GeHNkJO
	 wJnwJisU/t+hXnVbjr3fWzx5+mL0B4XTUt9J62H/cAMlzH7/tetes4erCV2qpiNmGZ
	 P1k4cW0w+iXFMAkVneDuLchvpsYJ7Y7euNWWMLcBafCr2o9dr2vZtZuViBb1bjBGid
	 WIXMNzImE+Drg==
Message-ID: <7f43c0b9-2ea7-4038-82c5-ca01aa2c1309@gotplt.org>
Date: Sat, 19 Sep 2026 09:27:39 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tree-object-size: Fix type-1 size for FAM subobjects
 under -fstrict-flex-arrays=3 [PR126975]
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <garsilva@embeddedor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 Richard Biener <richard.guenther@gmail.com>, gcc-patches@gcc.gnu.org,
 Martin Uecker <uecker@tugraz.at>, josmyers@redhat.com,
 Bill Wendling <morbo@google.com>, linux-hardening@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <apomrLZp1ee3NnBF@kspp> <202609182117.7AFD5B1@keescook>
Content-Language: en-US
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
In-Reply-To: <202609182117.7AFD5B1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-19 00:22, Kees Cook wrote:
> On Thu, Sep 03, 2026 at 08:02:20PM -0600, Gustavo A. R. Silva wrote:
>> For a pointer to a subobject whose record/union type ends in a flexible-array
>> member (directly, or through a trailing nested struct), addr_object_size()
>> walked up to the enclosing object (v = TREE_OPERAND (v, 0)) instead of
>> measuring the referenced subobject.  __builtin_object_size() and
>> __builtin_dynamic_object_size() type 1 therefore returned the whole-object
>> size, collapsing type 1 onto type 0 and losing the distinction between
>> &p->inner and p.  FORTIFY_SOURCE relies on the type-1 distinction, so this
>> weakens its bounds checks.
> 
> Looking at the PR:
> 
> struct flex {
>    size_t count;
>    char fam[] __attribute__((counted_by(count)));
> };                    /* sizeof(struct flex) == 8  */
> 
> struct outer {
>    int hdr;
>    struct flex inner;
> };                    /* sizeof(struct outer) == 16 */
> 
> int main (void)
> {
>    struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte object */
> 
>    /* This is a bug. */
>    expect(__builtin_object_size (&p->inner, 1), sizeof(p->inner));
>    expect(__builtin_dynamic_object_size (&p->inner, 1), sizeof(p->inner));
> ...
> }
> 
> Before:
> 
> WAT: __builtin_object_size (&p->inner, 1) == 56 (expected 8)
> WAT: __builtin_dynamic_object_size (&p->inner, 1) == 56 (expected 8)
> 
> After:
> 
> ok:  __builtin_object_size (&p->inner, 1) == 8
> ok:  __builtin_dynamic_object_size (&p->inner, 1) == 8
> 
> 
> This makes sense to me, the dynamic size of "fam" is ambiguous between
> being 0 or 48 (from the "alloc_size" attribute), so type 1 chooses the
> smaller.

I think you're confusing type 1 with type 2; type 1 is the *maximum* 
subobject size, not the minimum.  The whole object and subobject size 
distinction is only material if there are members after inner, which is 
technically "supported" by the complier as an extension, but is a 
terrible idea for members with FAM.

Here are the different possibilities for &p->inner:

1. If the allocation via __builtin_malloc is visible: same result for 
types 0, 1, 2 and 3, i.e. allocated size - offsetof (struct outer, inner)

2. If the __builtin_malloc is not visible and there's no counted_by 
annotation:
   - type 0 and type 1: cannot determine size, since FAM could be any 
arbitrary size. So, -1
   - type 2 and type 3: sizeof (&p->inner), since that's the minimum 
estimate.

3. if the __builtin_malloc is not visible and FAM has __counted_by__ 
annotation: same result for all types: sizeof (&p->inner) + p->count

> I would, however, expect the use of counted_by to change it. For
> example, if it were this:
> 
> struct flex {
>    size_t count;
>    char fam[] __attribute__((counted_by(count)));
> };
> ...
>    struct outer *p = __builtin_malloc (sizeof (*p) + 48); /* 64-byte object */
>    p->inner.count = 48;
> 
> I would expect the results to be:
> 
> ok:  __builtin_object_size (&p->inner, 1) == 8		/* compile-time size */
> ok:  __builtin_dynamic_object_size (&p->inner, 1) == 56 /* run-time size */
> 
> As the known size of p->inner is everything contained by "inner" and
> that now includes the 48 bytes of "fam".
__builtin_object_size is not the compile time size, it is a runtime 
constant size estimate, with the `type` argument deciding if the size 
estimate is on the maximum or minimum end, and if it considers the whole 
object or only the immediate containing subobject that the input pointer 
points to.  In the presence of FAMs I think sizeof (i.e. the compile 
time size) should be seen as a minimum size estimate for the subobject, 
if you want to make an equivalence with __builtin_object_size.

Similarly, __builtin_dynamic_object_size is exactly the same as 
__builtin_object_size, except that it can return non-constant 
expressions too, not just constants.

Thanks,
Sid
