Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD92D0614;
	Fri, 17 Apr 2026 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447545; cv=none; b=I+OJkF5oeuebd9DXcgcOAHP/lBR0lzE6pAsjXJxfrANkEH70jYfMQZ/laXYDMyuRPVYuoSp96zPaJzlXBaFZFNLjQJxCkplCMQa+Nr4VTUsGwSo3FNO0wBLayLawUoiCEfRwl6VNC2AqeLFURXdAhp13+EEqwhTVUc1swxEzxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447545; c=relaxed/simple;
	bh=rtaHgFZXQZ78ik4SRZtEsybXv6W9bNkHH0T25TFSeL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMMzKRf2oij5illdGj7aXNVfHGwKtjFysYhnmhPBYQmectH2EKHq8tVQXumUnz8EpfQYGoSBDs2YVdqcJCByHWhx0Uf9AT91BYDZyDeUOd0e8h9Zr09NnfchM79tTLCplAjoiGt1VzHONbI0BXZZbdxaoGGxqX7mOV+LsizZGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2/EyyMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2/EyyMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E384FC19425;
	Fri, 17 Apr 2026 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776447545;
	bh=rtaHgFZXQZ78ik4SRZtEsybXv6W9bNkHH0T25TFSeL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2/EyyMbkNoksqyFV6DhyMLgjgwjvgYI+oEXVsEeJHbk1ckE8Z09qoH0k6nFGQFm9
	 cY75hCwPK09VXs+Xm520/ICdasDxYK+68y0wlLNPceDO8WaB2iNuZu5lBnyugyK8mH
	 FtC7u0OpIzmBSwpTZQYHkrrhJLkHKDaQ/uH3RpDJYHzA/vrhG/xwVSk7i4jOMnmtx+
	 kfIciHnRXI8LXvxbZUpxFSrLKOnTtcOJi+GpcJPKkJzPjyI29rI5qjq57rjoiI3FSj
	 56GoJa6eh3WUF9kwy5eyLXswYoVwGrq+EKOl7BDlJQuKsL7Catq5Czvt+C9MJ72ICR
	 qXUGtyz6RjjMQ==
Message-ID: <cd2bcc09-2507-4ed4-bb92-2d53baedaf04@kernel.org>
Date: Fri, 17 Apr 2026 19:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/30] mm: Introduce kpkeys
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-hardening@vger.kernel.org
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
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <913002a5-e002-4001-ad19-037102d1f97d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/26 17:59, Kevin Brodsky wrote:
> On 17/04/2026 16:37, David Hildenbrand (Arm) wrote:
>> On 2/27/26 18:54, Kevin Brodsky wrote:
>>> kpkeys is a simple framework to enable the use of protection keys
>>> (pkeys) to harden the kernel itself. This patch introduces the basic
>>> API in <linux/kpkeys.h>: a couple of functions to set and restore
>>> the pkey register and macros to define guard objects.
>>>
>>> kpkeys introduces a new concept on top of pkeys: the kpkeys level.
>>> Each level is associated to a set of permissions for the pkeys
>>> managed by the kpkeys framework. kpkeys_set_level(lvl) sets those
>>> permissions according to lvl, and returns the original pkey
>>> register, to be later restored by kpkeys_restore_pkey_reg(). To
>>> start with, only KPKEYS_LVL_DEFAULT is available, which is meant
>>> to grant RW access to KPKEYS_PKEY_DEFAULT (i.e. all memory since
>>> this is the only available pkey for now).
>>>
>>> Because each architecture implementing pkeys uses a different
>>> representation for the pkey register, and may reserve certain pkeys
>>> for specific uses, support for kpkeys must be explicitly indicated
>>> by selecting ARCH_HAS_KPKEYS and defining the following functions in
>>> <asm/kpkeys.h>, in addition to the macros provided in
>>> <asm-generic/kpkeys.h>:
>>>
>>> - arch_kpkeys_set_level()
>>> - arch_kpkeys_restore_pkey_reg()
>>> - arch_kpkeys_enabled()
>> Another thing: why not simply drop the "arch_" stuff from these helpers?
> 
> The first two are not meant to be directly called, they're the
> arch-specific implementation of kpkeys_set_level() and
> kpkeys_restore_pkey_reg(), and those generic functions handle some
> generic logic.
> 
> arch_kpkeys_enabled() is directly used in generic code, so I suppose it
> could be renamed to kpkeys_enabled()? It's actually implemented in an
> arch header so I wasn't too sure about it.
I was skimming over patch #13 and spotted:

+void·__init·kpkeys_hardened_pgtables_init(void)
+{
+›	if·(!arch_kpkeys_enabled())
+›	›	return;
+
+›	static_branch_enable(&kpkeys_hardened_pgtables_key);
+}

The arch_* there can just go IMHO.

I'd also do it for the two ones used by the GUARD macros. If we don't
expect common code wrappers (arch_kpkeys_enabled() vs. kpkeys_enabled),
then the arch_ is unnecessary information -- IMHO

-- 
Cheers,

David
