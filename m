Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483593;
	b=ZJwc9WuaDmCMiQIzJnClzDxRxex6161sbWMq97sCD/9AT3kv0UzB6K1nBImtVZL3vOfO
	 MenGphYSoAc5xT+vHPMk8FCbAr9cjVQCL5yOk+ZMX7tql9EXRQGqsj2FKXnHi9ksvDDLy
	 PTaLzkcihoEqaBjzNb+QvFRMZ++/MmzTorScDGCTpnzsi2isfxpFjkLxGL3k4jH6Fhrxm
	 6tmO+NRvJQryOJPNArF1hP8Xp5EooIqhZuR/y3c9DdvTfnNAdxLvGdfvQ9sIUxozmUrx+
	 lMnv/p+xdG0Q7ZcedVw9AqqtqWeqdT7P1j9fjPn5a6W5OkWdHV5GaIIXgUWW0VNI0vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483593;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YL9vPLbC3ZW14DvANU3hpZtkl64GE6Cg8WE0isE/rfA=;
	b=SYN317OHvQN0Yws6zzma1LDv0j1GaZnpTWgvHE8MCes4aRYlu+W5n5zuCVl5CTUULctZ
	 2bSvJZNaO5AYAkY5YxTo9nV2fA2XhgKbqmt4OBUY2wlJ7tc4nVcfmwucldcO1ZOBJMAu3
	 Fr16Twqbk9nwJgQYRk7/ZDNd+e0BxvftBiUKn6mTJKv7C4jAwnl7AfJvNm6LgsDDNEg97
	 IG+7kvnQvjyqolTEJgcqsRoFWRyxDmD6iGvJjYyvLPXatJ2SZQe6L0KygM/NoFA9rmaa2
	 O1i+Madh327xQOu9l50xfilSrT07nVlF3WImGzKAtdGcPT8UpVVJQxgcg6EzJXCXBLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=t64olPTY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F0606A31C;
	Thu, 12 Nov 2026 11:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0F0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=t64olPTY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 680D81576;
	Thu, 12 Nov 2026 03:39:49 -0800 (PST)
Received: from [10.57.59.183] (unknown [10.57.59.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E85A3F632;
	Thu, 12 Nov 2026 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794483592; bh=ZqrSL8M+EK26zZlTilw3+OBU1RXFJn7OmIH1wj8UGK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t64olPTYqsoQruagzwJOaBesAbiAuLSWj19fX/8b7GkaY+T0lCZpZaJDwCz7A9L7V
	 +fqxsw7u8kA5Dpjlo5v6OChVIthmr7+a0bvXzVahIPw5GvhtMB39qoCGMRCkXDT77T
	 iTNyJwWtn5UF4h3ugfYVxBZJaw1lYK9xBCS4ekKo=
Message-ID: <4fab7e04-c429-4a35-9945-57eea8c97144@arm.com>
Date: Thu, 12 Nov 2026 12:39:42 +0100
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
Subject: Re: [PATCH RFC v10 22/22] mm: Add basic tests for
 kpkeys_hardened_pgtables
To: Mark Brown <broonie@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Ard Biesheuvel <ardb+git@google.com>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Maxwell Bland <mbland@motorola.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org,
 Ira Weiny <iweiny@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-22-aa6c4d9603bc@arm.com>
 <2d13fbb7-b5b4-446e-8709-5b43349ff19a@sirena.org.uk>
 <9e59fd71-97e7-422c-a7dd-bc23c6e6a852@arm.com>
 <717cccfe-81d6-4e09-a466-5361ae27776f@sirena.org.uk>
 <0b29393f-bb84-4df1-a699-f7afcb50f2e8@arm.com>
 <9deffbb1-75fd-407e-90cc-59bf4c2fa1a6@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <9deffbb1-75fd-407e-90cc-59bf4c2fa1a6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2026 17:15, Mark Brown wrote:
>>> Yes, or something like that - unfortunately KUnit checks to see if the
>>> config options appear in the configuration so something that vanishes on
>>> other architectures causes issues.
>> Alright, I guess there's not much we can do then, short of creating
>> arch-specific fragments.
> Or my suggestion below, or come up with some generic option that could
> always be there and would in turn select hardening things.  There's
> probably a case for having something given that the hardening features
> will tend to catch some kinds of test error but that feels more config
> fragment like.  Another idea would be to teach KUnit about the idea that
> it should try turning on some config options but not worry if they're
> not selected.
>
>>> Perhaps the default for the config
>>> option ought to depend on KUNIT_ALL_TESTS?
>> Not sure I'm following, the config already has default KUNIT_ALL_TESTS?
> The config for the test does, but KPKEYS_HARDENED_PGTABLES which the
> test depends on does not so unless the underlying defconfig turns that
> on the test won't be enabled.  I was suggesting also adding a default
> for testing.

Ah got it. It doesn't look like there's a precedent for KUNIT_ALL_TESTS
having that kind of side effect though.

A separate fragment for hardening options where KUnit ignores options
not getting selected seems like a reasonable approach.

- Kevin
