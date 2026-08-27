Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8529538423A
	for <linux-hardening@vger.kernel.org>; Thu, 27 Aug 2026 09:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787821509; cv=none; b=mKcT3XQ1yNelzgDn1P27HYAziFuHT1T2mmrVndEeJQixYdtJMphaLY9je8D+beH8Meaw+i0Kf6U6wke6Fg0FHuYBPJ8+4RgYtsOl2b2hh+yAZrXhBkAqVg2ljqM/ukEUG3Wciqe5Nk0/zrfHEP6F6i/6xspyTmhN/0fmxFcVdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787821509; c=relaxed/simple;
	bh=46eODinQSHgqruwzsLbjLe5hKqtKjPlW6wrViGRehgU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=phqeNPLppMVyudmeIxxKq/1QDsQK0+Jr+wQJwLXsxonqelU+qWF7dL4LmGtY4OA6Rfp/kE9rpRpy5Ex3F5BoLbY2ur0VuSQ769itaMpsNBRAT5E68DH2AX15+8JmMVC0/XKpYWx3OuKJWk3O0Lj/h1kkMlNKtOKz6mq2HeI5W8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVrEGwOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVrEGwOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3231F00A3A;
	Thu, 27 Aug 2026 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787821503;
	bh=R/wTq/5h6B601AMx0G4llf/VxEFalYv5uCBT4yZMs9g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=EVrEGwODkaBeMvrzrWbxnKuvHTJe2XfMSbwd7+GA7eWJReKwPuPqsHZPw+/M2HMK+
	 O7AnOVqe6fZY4YeRNPOrtVcn6wHWRw+vahFNpyuNY6TR0FesLTs6XvfjK5AhXAJE7A
	 7OIU/maYtgJLhQ9iypsBA9gENQFEAsQcruhvId38PV4X+1nbFRC5CLoU/ybbKLM679
	 6Wmmqipni/jQnjatDW/GwgiyM5Jmwtzsr7SzqL9r6LYY3pWivLPCnIyMfAMuDvSNtW
	 YgYQ3LMFybpS9np1nyr51RPLG9iEmiVXOdtmca4999q/s3bJmvaxsElHmHa5YfhaGU
	 icymwBBtw9+Pw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id DFF761980054;
	Thu, 27 Aug 2026 05:05:00 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 27 Aug 2026 05:05:00 -0400
X-ME-Sender: <xms:uv2PapEcsbDsHBA17pcE_TbDcGzVEuZUTQHUrMHdfI5tQlBFrO70Uw>
    <xme:uv2PapJDTkoopXDikPKXxe7HaHkhusQRTVLHYEb3Zn-XdhbJ6sO9WnodAPY90w2St
    TZ_FDokvrRu8nM0_giF5f1VVN4Ztyugkl2ROwOohf02fvULlyajnUU>
X-ME-Proxy-Cause: dmFkZTGal3LTGiskcZm5hnhJnxJ1Ju61Op2mR279qugGtVZrD2mheMSsjh759w2vrJFl7k
    3ogR/jxYpOyvp8DRx8rLBqX/CgmTwZbEMeyMpzmYsBtDUJMMlRYm/Ra3AZeeKUcvxua4p8
    yP5IldUlpKR/lblJdOanc3D1+1uqgKOHrGePH9hDSIf+EMHizlAOXwdWCL81tOFIYcQTQW
    CrHURoea925DMvaM6vueOkyFKpR6qkCkDH7C83iobGiTtHjQEZtHRbO1hhnYuBSj26NE8Y
    zcL1mdN+K5SLXBk9vQ3wx8zbgEJmEvS1Rrpb3ha29CljSsl9rhpeUw5836NS2KPFCsU/g7
    abfUuRn91fRw8DunTiHOcZU+6r+SRr2eqkLI7MukdkS60TaogXjGq4Uw7Ee6yUUIZH2y0w
    7mIxFWMdMd44pMLWRvHcu56PHv25KD29ZIVwq9ZoQF1aI7BczAJlpjjP0IGbVpUy3J0ogS
    sF1sniQlbDl/AFYfdWg6CDg4BhWt8pIuA3aVlzqua76GKOQQsNDdaadtz5rt23djd2ZFj7
    lARXePJS1dOTYFzNB2Q+DZ2aiWj7j/XRxiXZHU62lXu/3RYMuAs+uV7LI4Rqf1SYu7x4BR
    N/KWlD/GeWDX3kM2tZ3YUyCSAFsiZVKHQFCNwmXQddq04AAcQnq51etoyl/w
X-ME-Proxy: <xmx:vP2Pau5h6HXffnZdDLDnCx8ir5SdbubSJzDjMpKxhU37SeXXjkZ_zQ>
    <xmx:vP2PaknS_7QV4_U1v3F-i2CpXeBUq5cHUzn6noRT_a8d0irnw0UzCA>
    <xmx:vP2PahUCFIuC28uR2sgFRtcWsLqu4sovUQGP91xexrJijC-fmUcmWg>
    <xmx:vP2PalS0hfDXBU2w8JZqRB7d8Au8deXNsoAbzD9_7VqIEqBlQVNE_Q>
    <xmx:vP2PamCN2GXtrMZd_Zx9Y0JlwqWeVRWgTlwM-JPOffEauk26RLUz7TV3>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5E923F8007D; Thu, 27 Aug 2026 05:04:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 11:04:38 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Jann Horn" <jannh@google.com>,
 linux-hardening@vger.kernel.org
Message-Id: <1c0299ab-9f5f-4c7b-826e-a0547f7863dd@app.fastmail.com>
In-Reply-To: <c33d081b-7886-4db2-b1d9-61dc195844e5@arm.com>
References: <20260805104042.1107678-2-ardb+git@google.com>
 <5a3b89a6-bc42-42c3-82e8-25d6f1a2c5d2@arm.com>
 <a277a83a-cc01-443d-be42-775ce0bc96dd@app.fastmail.com>
 <c33d081b-7886-4db2-b1d9-61dc195844e5@arm.com>
Subject: Re: [RFC PATCH] arm64: mm: Map fixmap PTE tables r/o in the linear map
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 27 Aug 2026, at 10:55, Kevin Brodsky wrote:
> On 26/08/2026 11:07, Ard Biesheuvel wrote:
>>>> [...]
>>>>
>>>> +static int __init fixmap_remap_ro(void)
>>>> +{
>>>> +	return set_direct_map_ro((unsigned long)lm_alias(&bm_pte), NR_BM_PTE_TABLES);
>>> Should we not also remap bm_pmd and bm_pud?
>>>
>>> For that matter, do we need RW access via the linear map for any page
>>> annotated with __bss_pgtbl? I suppose that might be the case for
>>> kasan_early_shadow_* but I don't know enough about KASAN to tell for sure.
>>>
>> bm_pte[] is special because it is only ever written via the kernel mapping,
>> and never via the linear map. This is why it is being singled out in this
>> patch.
>
> Right I see __set_fixmap(). This is a very special case of calling
> __set_pte() on a pointer derived from a global (i.e. pointing to the
> kernel image and not the LM) so it makes sense to treat it differently.
>
> I do wonder whether there is that much value in protecting bm_pte while
> all page tables in init_pg_dir (also at a fixed offset in the LM) remain
> writeable though.
>

Yes, so those need to be taken care of as well.

> Either way all this is interesting for my series protecting page tables
> with pkeys [1] - it seems that to protect the fixmap, the easiest option
> would be to change the pkey of .pgtlb in both the kernel image and LM
> (the former for bm_pte, and the latter for everything else).
>
> [1] https://lore.kernel.org/all/20260818-kpkeys-v9-0-743ad31b2c8f@arm.com/
>

Thanks, I've been meaning to go through those but they are a bit overwhelming :-)

>> Whether or not bm_pmd[] can be treated as a special case depends on the page
>> size: with 4k pages, the whole array covers a virtual region of 1G, which is
>> currently guaranteed to be shared only with the PCI I/O space (but we could
>> move that out). With 16k pages, it covers 64G, and so it is shared with the
>> vmemmap and other virtual mappings in the vmalloc region, and so the current
>> kernel mapping code expects to be able to write those entries.
>>
>> What we might do is generalize the logic that uses the fixmap to modify
>> pgd level entries in swapper_pg_dir, and use it for all modifications
>> at PMD level or higher if those tables are in .rodata
>>
>> But this is a bit more complicated than this change, so I decided to
>> present this as a separate change.
>
> Definitely, this is orthogonal to this patch. I wonder what the
> performance impact would be if we used the fixmap for setting all kernel
> entries at PMD and above. It would be nice to keep that logic easily
> togglable, because with the kpkeys approach I mentioned above we have a
> (most likely) much cheaper way of protecting these page tables.
>

I'm currently experimenting with using __put_kernel_nofault() to update
the descriptors at all levels (including PTE) and handling the fault
using the fixmap approach. That way, all statically allocated page
tables could move to .rodata (except bm_pte[]) and there should be no
substantial performance impact.

>>>> +}
>>>> +late_initcall(fixmap_remap_ro);
>>> Is mark_rodata_ro() definitely too early to remap these pages RO?
>>>
>> No, we might just call this from there, afaict.
>
> Sounds good, could we then use update_mapping_prot()? I suppose not as
> that would require mapping bm_pte separately in map_mem()?
>

Yeah, but perhaps we should do the latter anyway, so we can remap the
region even if !can_set_direct_map().

