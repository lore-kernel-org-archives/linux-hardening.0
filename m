Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E1382378;
	Mon, 20 Apr 2026 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667632; cv=none; b=choo+F+wt4rKJv/GuTdO1D05k4RXHDcDRiPqR6zp/UWqfnrhQQ7OwjeMxOUyTv4qwUVwiWEGokLmmzvOo/orZodu97gglMeuo6/NSjgrQ5LSPKsNXXTrnZG+Dx99ovkC7UMsFn1y699+2tYJ+X3xqkJLo4olcNHxKXnCFAQvf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667632; c=relaxed/simple;
	bh=FOT+rxetMCCm/Vt/n/onmxMCYGq9cNElSNypd+yNhnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtUygPHklOLTBjg/I/hO3dd9rcDRJ67hxkp09DkQfhRFCDP3PgV/+sZsWlMQhPEhSG58yZng6Xwn+bNVZ/LuVBEW8hJxb9sFONL5iQ3/jEQM4rbhyBTeIiBtWqwHobdXUkABWbrCLRpUbSCHTjc3ahQN9tYcG61lOksprcluJNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j4epmrx6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j4epmrx6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0650E1516;
	Sun, 19 Apr 2026 23:47:03 -0700 (PDT)
Received: from [10.57.63.177] (unknown [10.57.63.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A3F3F641;
	Sun, 19 Apr 2026 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776667628; bh=FOT+rxetMCCm/Vt/n/onmxMCYGq9cNElSNypd+yNhnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j4epmrx6ayUafCVEQ7h5jQnxg6ml5eCR2lSQ+K/AG8/lUgNRBeMqJIC9TwDXgnhFL
	 m4RmLBmEqyihwgMV+Er/qJM7r3qMVW+zoaiWAHClxUtZ0fNTb8Y2Qj6fEA/l8Wldud
	 UmkwT8YdneFQ678p88xVouNXYqX+mgCG6ljkWgoQ=
Message-ID: <c78a9048-52a0-4a22-ad69-4bb5e84895b8@arm.com>
Date: Mon, 20 Apr 2026 08:46:58 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/30] mm: Introduce kpkeys
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
 <20260227175518.3728055-2-kevin.brodsky@arm.com>
 <00b24db8-0063-48d6-8bc4-e8b670d8f0d5@kernel.org>
 <913002a5-e002-4001-ad19-037102d1f97d@arm.com>
 <cd2bcc09-2507-4ed4-bb92-2d53baedaf04@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <cd2bcc09-2507-4ed4-bb92-2d53baedaf04@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/04/2026 19:38, David Hildenbrand (Arm) wrote:
> On 4/17/26 17:59, Kevin Brodsky wrote:
>> On 17/04/2026 16:37, David Hildenbrand (Arm) wrote:
>>> On 2/27/26 18:54, Kevin Brodsky wrote:
>>>> kpkeys is a simple framework to enable the use of protection keys
>>>> (pkeys) to harden the kernel itself. This patch introduces the basic
>>>> API in <linux/kpkeys.h>: a couple of functions to set and restore
>>>> the pkey register and macros to define guard objects.
>>>>
>>>> kpkeys introduces a new concept on top of pkeys: the kpkeys level.
>>>> Each level is associated to a set of permissions for the pkeys
>>>> managed by the kpkeys framework. kpkeys_set_level(lvl) sets those
>>>> permissions according to lvl, and returns the original pkey
>>>> register, to be later restored by kpkeys_restore_pkey_reg(). To
>>>> start with, only KPKEYS_LVL_DEFAULT is available, which is meant
>>>> to grant RW access to KPKEYS_PKEY_DEFAULT (i.e. all memory since
>>>> this is the only available pkey for now).
>>>>
>>>> Because each architecture implementing pkeys uses a different
>>>> representation for the pkey register, and may reserve certain pkeys
>>>> for specific uses, support for kpkeys must be explicitly indicated
>>>> by selecting ARCH_HAS_KPKEYS and defining the following functions in
>>>> <asm/kpkeys.h>, in addition to the macros provided in
>>>> <asm-generic/kpkeys.h>:
>>>>
>>>> - arch_kpkeys_set_level()
>>>> - arch_kpkeys_restore_pkey_reg()
>>>> - arch_kpkeys_enabled()
>>> Another thing: why not simply drop the "arch_" stuff from these helpers?
>> The first two are not meant to be directly called, they're the
>> arch-specific implementation of kpkeys_set_level() and
>> kpkeys_restore_pkey_reg(), and those generic functions handle some
>> generic logic.
>>
>> arch_kpkeys_enabled() is directly used in generic code, so I suppose it
>> could be renamed to kpkeys_enabled()? It's actually implemented in an
>> arch header so I wasn't too sure about it.
> I was skimming over patch #13 and spotted:
>
> +void·__init·kpkeys_hardened_pgtables_init(void)
> +{
> +›	if·(!arch_kpkeys_enabled())
> +›	›	return;
> +
> +›	static_branch_enable(&kpkeys_hardened_pgtables_key);
> +}
>
> The arch_* there can just go IMHO.
>
> I'd also do it for the two ones used by the GUARD macros. If we don't
> expect common code wrappers (arch_kpkeys_enabled() vs. kpkeys_enabled),
> then the arch_ is unnecessary information -- IMHO

Makes sense. I could just rename arch_kpkeys_enabled() to
kpkeys_enabled(), but I'm thinking having an arch abstraction could be
clearer, after looking into protecting sparse-vmemmap page tables. The
new version would look like this:

* <asm/kpkeys.h>:
    - arch_supports_kpkeys()
    - arch_supports_kpkeys_early() [can be called before features have
been detected]

* <linux/kpkeys.h> defines:
    - kpkeys_enabled() -> arch_supports_kpkeys()
    - kpkeys_hardened_pgtables_enabled() -> static key
    - kpkeys_hardened_pgtables_early_enabled() ->
arch_supports_kpkeys_early() [called when setting up sparse-vmemmap,
linear map, etc.]

There is extra #ifdef'ing going on in <linux/kpkeys.h>, but
<asm/kpkeys.h> doesn't need to worry about it. I think this might be
easier to follow, I don't like too much having an interface function
like kpkeys_enabled() defined in an arch header (not great for
kernel-doc comments either). Any thoughts?

- Kevin
