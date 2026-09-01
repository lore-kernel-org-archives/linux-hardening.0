Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C53D8100
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 15:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276464; cv=none; b=pRtXZpSbkKQrAOP49uZfWcgM9D43mn46xGymn1/UKOmcCCmeK5sLMaX6vJzvxO+YIbW59l2mSHt+Prl5zgdWHeSlKrNn0RqMPrWhG21ddGuifrafkW3Hpyl/HYMmu3JFwTZfOglUFPdtl+Xq00lJqaKMYr95VebZSIEErm63B5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276464; c=relaxed/simple;
	bh=oUjwv2smWe0xFHylp188LMnL3s3sI4RXp84y/JQaByA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XfOkwJqagqCDmATiBE2fvE/ZEAcYjzW7a5y3DbXXv/KhTkhW0PROioAOG9qaM8p2tDBzK1FkIb3F8qNP+jz8sas/VB6noimsxlFdIZ0H3VmyksDfM+ZsHRK876Ino1eJtT6TZg+eZ/k7K0wlqiBVp/YEWL3hpoRpgWn70z0tNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGjBIESb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGjBIESb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214131F00A3D;
	Tue,  1 Sep 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788276462;
	bh=WyEqG2EDFAv8L3v16RuFJGJjVfEcYFvYeKnOELESY/Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=YGjBIESb0kPhDR3x6K+5zvA56QDewqOX15CYgCBzBPMMuJmzktwQKVdQV3tZFt1Qd
	 vampDfQK4hYZJ0YyviLO9ITENNSPE5DkK/erKPVSu5LMTIYxd0mCmvHhnRDX6tikC/
	 1Tgz7csqXW4AbNSlgipsWPnng0AKp70ErN+lMZ0fg9nB0MgL+nwu3RHXmQu+eWMsiN
	 E0pItI8I9YlJTHzAipJnkCIDY2VoCc95l+DJlHBC4LheqHVM9pdKGL5UVjiAciuDim
	 oTyUvHSG7jtgjtylizBIz9Gm2AW6zc+6iss5nlKQwhNJUL5x6M/THE8A5PLbg/g+k1
	 mHK9g1/WqldNw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id C48981980054;
	Tue,  1 Sep 2026 11:27:40 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Tue, 01 Sep 2026 11:27:40 -0400
X-ME-Sender: <xms:6u6WanUwN2toYHoCila6UWBluSOn6cmNV9HtnPGoAzE5qjZyegk_LQ>
    <xme:6u6WaqaTczmpeGxePouegBQisxXcT62i7JUyqdiRYD_EqGxFZl-GEQdxCrUizrKOM
    TEruKiWGWNPZRk5PcGgM9uyvvtq4qKFoVp9pSbIegYr7wf2f4dF1g>
X-ME-Proxy-Cause: dmFkZTGW+Ifzafl7YaMspyuBctpPC/RThvsqfhP8KkNKucJauF3YPEHcu/NY+tnA4tfIOa
    AsI9YXyR2o/PfrqQn5AzfDwULoj6yxYxqT8H88MJO2Vf1R4oS/QQPXE6lDswShxcssEJa/
    lLEPJ6NLdd8ynBpJZWdvuFD2wjVIaLk/76vUOgCWHpFtlMKWYbGAi70vDXiQbCVOtRnt/d
    SOctprH2hIEQtYoDSNmxcENcHRUyLsHlidGm5DINwV/cTK7n+Jydfl4L4i5zG6zQD+3mCV
    yigVFCmLpqBF0rDa7W9P6uhi/mJ93RKg6aB4ybD5uxuFVhQ5w/K3ilhLnDWQU3KSQ3+rFY
    gDR/u/N74vDciYZyHSBalKtpTSL1mNH8C1SvWxrJAX1a/X9tG5APjQ2jEQuOoVjbkA8qIn
    SUsXq0gC64XojjeCiGdyBDPExQ9Ixc46gEzKnVF5Bh6IuraqtDgs72ex46tkdH1dOKWtO5
    07HpVjmsbmD2XvaN3z8RlSBAM7Xz185beDIQVqC7a7JAhadXsvIqdmeAbNNdMTaSnjJghJ
    6qseeSq0ISD9kWorVdgsXc5KyQBO/t2lzwGUV8xdZB2LeidnAsD8+iLUQL+k/OdYaJh5yT
    /JVos41tmWEWk0o0q7yNd0NTROko2Nqa87+7RMKpPJ9WpzmqVvgEXq0ePZJw
X-ME-Proxy: <xmx:7O6WaqezkyaTLhbEkXdegpBA5gm_MOlFifLCDZ2rcMkqbPHf_NRHbA>
    <xmx:7O6WagDzcE1shyjz0F-CxReJzLIy1oLQJl0QnbHcWISDB5thu7hU3Q>
    <xmx:7O6Wam6wuj_-nwZv-qt-qgIrtCXcFmRBmTfBJZi06lWwFoXACn-zlQ>
    <xmx:7O6WahcwFhl1DO2y6_K_buPTonnV7ToqPMxqKYgH2oOezYncNexQYg>
    <xmx:7O6Waku6ZSuJ96FiO5wL-MtB2iJ94Q8FyoYD1MtbpREkpUEDdXvLiYBY>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BE3EBF8007D; Tue,  1 Sep 2026 11:27:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 01 Sep 2026 17:27:18 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Jann Horn" <jannh@google.com>,
 linux-hardening@vger.kernel.org
Message-Id: <3df447dc-ccdd-457d-aad3-ede116ce552c@app.fastmail.com>
In-Reply-To: <16f40b06-e871-4921-bbc6-42637c63e6bd@arm.com>
References: <20260827164409.3421848-6-ardb+git@google.com>
 <16f40b06-e871-4921-bbc6-42637c63e6bd@arm.com>
Subject: Re: [RFC PATCH v2 0/4] arm64: mm: Map fixmap page tables read-only
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 1 Sep 2026, at 11:21, Kevin Brodsky wrote:
> On 27/08/2026 18:44, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> This v2 now covers intermediate level page tables as well as the PTE
>> level page table for the fixmap. The latter is a special case, as it
>>
>> a) is only accessed via the kernel image's mapping, and never via the
>>    linear map (except for ptdump etc)
>>
>> b) must be accessible via a read-write mapping, as all manipulation of
>>    read-only page table descriptors relies on the fixmap itself
>>
>> and so it is treated separately. The intermediate page tables may be
>> shared with other mappings in the upper kernel/vmalloc region, so they
>> must be updatable using the ordinary APIs.
>>
>> Build tested and boot tested on a Lenovo Yoga C630 using 16k pages.
>>
>> v1: https://lore.kernel.org/all/20260805104042.1107678-2-ardb+git@google.com/
>>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
>> Cc: Liz Prucka <lizprucka@google.com>
>> Cc: Seth Jenkins <sethjenkins@google.com>
>> Cc: Kees Cook <kees@kernel.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: linux-hardening@vger.kernel.org
>
> Looks like the Cc's didn't propagate to the actual patches, fortunately
> my lei filters did catch this series ;)
>

Ugh I must have forgotten to put --cc-cover

> Either way I quite like this series, it's an elegant approach and it
> should increase security without overhead, what's not to like!
>
> I also considered it from the perspective of kpkeys protection [1] and I
> think they should work together fine. The kpkeys series still allows
> page table setters to write to all page tables, so if we get a fault
> there it must be because the target is read only, and not because of a
> pkey fault.
>

Excellent, thanks for confirming.

