Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66433ACF06
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854285; cv=none; b=rXeqzSifUP/kGoAjt8g65F1iGoepJ2VTIrlRN5NqZFLWfSc6IBlaxWkh95Ch8ZSRRfXGrEYju6uvTLc6uxG5HNmdDANmmiJygB/oha8gvv16TCfRrqQ25ld3vQrqtc7UYPDiww6ybbBCVnLwOIymaB7TjrrgHg5uvAaq3zVcAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854285; c=relaxed/simple;
	bh=muMECbO96Q17a8vw7+GcxCDFTKIrG/mBOtBi3cQA3vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUu/JsXtMH67XZbKtdy8u9NeCXA/rAuynjlii2hWqAKV9eWeEaOQNGMwzdDiRYGb+tIpQ8JY8NqG95Ae1h6aiv6Hl2oqvIJZliR1be7lmuHw2xw4LPnxaPA1qNIbmG56BuwGjUiXQZDgTTBECoZEzBK7TGw6Rq8mpSfYPURCxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wot4HfEz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wot4HfEz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40361476;
	Tue,  8 Sep 2026 00:57:57 -0700 (PDT)
Received: from [10.57.7.202] (unknown [10.57.7.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D52773F7B4;
	Tue,  8 Sep 2026 00:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788854281; bh=muMECbO96Q17a8vw7+GcxCDFTKIrG/mBOtBi3cQA3vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wot4HfEz7L7Q1yhwW45ocjyTfVDEuEXikMJ5kqcAakvtvEBJPgf7VrrSQ+VR90R66
	 nQTplq4uplypYc4ur9gFPAllc8RxJ18oJh2EbVsjZ0sqmY7En9vasX7BBaIfw72daz
	 tcrAlaVBIZk7x9aCnwAAI39FOlKwEMbyjHI3frww=
Message-ID: <df68a260-c9d0-4f5a-918f-00dd2fb8d6fb@arm.com>
Date: Tue, 8 Sep 2026 09:57:50 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v9 01/25] mm: Introduce kpkeys
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-hardening@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>,
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>,
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>,
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-1-743ad31b2c8f@arm.com>
 <178877845406.3691569.6930315020588094755.b4-review@b4>
 <3f6e7678-0784-4ac1-acb4-b128887803c5@arm.com> <ap-wnHAwfdX_b39o@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <ap-wnHAwfdX_b39o@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2026 08:52, Mike Rapoport wrote:
> On Mon, Sep 07, 2026 at 05:49:42PM +0200, Kevin Brodsky wrote:
>> On 07/09/2026 12:54, Mike Rapoport wrote:
>>>> +
>>>> +#include <linux/bug.h>
>>>> +#include <linux/cleanup.h>
>>>> +#include <linux/kpkeys_types.h>
>>>> +
>>>> +/**
>>>> + * KPKEYS_GUARD_NOOP() - define a guard type that does nothing
>>> Nit: I'd suggest to drop "define" from all the descriptions, they would
>>> read better without it IMHO.
>> Fair enough, but if we say just "a guard type that does nothing" is it
>> clear that this is a macro defining a type, and not a type itself?
> Then maybe "helper to define", like cleanup.h does?

Sounds good, will do!

- Kevin
