Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410953;
	b=qsDZ7S2SiVrZQRTHJkUBnE/Q8y5p4d6gxxb/HF8T5nf04aIpGp/B8/qkvkZHeRYoWclJ
	 /zOmVUviyPpD3JBwTFP/PGHnVEv8npVEzme8mJODxJqvpQfCn8VrQ9PcosgJ1hI/24odZ
	 OhGBNT2qZHu/j8WIwfqunxLKmpQps50f7g0XwTWFRUkffHGwX+io+1cjHUljlnSlMNnLX
	 jS2QQvJkKFeOw8nV/Zp9cRxvjKaWUl25p3qwwEJQ/I/87/feHH1TVO7K7DwJcAlDutUpn
	 IGWmV/nQfFfV/VXOCOifvgFkbghHM9YXldVw/YrrsLcKFQ5V+3tRmPHBbc+9OtVe0yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410953;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zx9iLP78IiBq1ALzjHVMZmBMtAYpZpkd8prlcsOB6hg=;
	b=QGlpoSd3Ix465KlcCb7Ezzj7L4iUYkuxEkaKOv6U7B1bw9iXZQBWhaFuJ1tUnDLIY9A/
	 uyj3Li50nyYxFNVBHph6AWOZJN8ZGfal/mTWANRyzsTSBaPs7YAjK258MbrpZjfH5ovpx
	 j9whNW5wTEMDWhFcC0exkDzyRRx6Ea8bVJ4PAdYVaFp8c+FUHuSFFS/XmVPqPEkA9BY7x
	 MqkybolwSHFiBfkXM7Ckl8DVRkmVKJSQwfQ0R2Zk0HCn3evFjaOopTnxvtQ2M6iia4oFr
	 6OBZc4lNjn2/8+ndajcN1oR9NqMvttEPTtgkIir/9PrOohZgD4sIZUdzeKSZYJ5tenw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Dhj0+Yym;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A408606A332;
	Wed, 11 Nov 2026 15:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A408606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Dhj0+Yym
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C9A61576;
	Wed, 11 Nov 2026 07:29:09 -0800 (PST)
Received: from [10.43.20.72] (e126510-lin.lund.arm.com [10.43.20.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A40E73F632;
	Wed, 11 Nov 2026 07:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794410952; bh=zx9iLP78IiBq1ALzjHVMZmBMtAYpZpkd8prlcsOB6hg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dhj0+YymHc7rFomknPwPRmnpBiVc9HeX4e1Mrc54aUxPNZzLyPVAjsbvoz7F/WA5c
	 x/6gWKxQMKSaONFtPfoPEoqkOwozaexXi53y72L4XOIUfLKIaabfuCO6VO8rtFgrHt
	 4l+2j1iAJMYNQaTu2anzXCelavKQ28MV+LNM1n5g=
Message-ID: <0b29393f-bb84-4df1-a699-f7afcb50f2e8@arm.com>
Date: Wed, 11 Nov 2026 16:29:02 +0100
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
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <717cccfe-81d6-4e09-a466-5361ae27776f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2026 12:24, Mark Brown wrote:
> On Tue, Nov 10, 2026 at 10:01:36AM +0100, Kevin Brodsky wrote:
>
>> Do you mean adding the dependency KPKEYS_HARDENED_PGTABLES=y to
>> tools/testing/kunit/configs/all_tests.config? Indeed that would only be
>> meaningful on arm64 (for now). That said it wouldn't hurt other
>> architectures, so happy to add it there if you think that's worth it.
> Yes, or something like that - unfortunately KUnit checks to see if the
> config options appear in the configuration so something that vanishes on
> other architectures causes issues.

Alright, I guess there's not much we can do then, short of creating
arch-specific fragments.

> Perhaps the default for the config
> option ought to depend on KUNIT_ALL_TESTS?

Not sure I'm following, the config already has default KUNIT_ALL_TESTS?

- Kevin
