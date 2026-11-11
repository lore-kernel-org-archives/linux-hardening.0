Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410545;
	b=y2GAD1CWaxW3P2iJmcrfR3ElWeeql7wwFWkzIL+9x9tZfDVTusZLbHGuZsPLaHK4fTJF
	 FsWtZ4+HzWynrRQzpGVjvc4SyWexIgMDsdfcVYfKU49MxcVDuLV7wf45/GSkZ4tu0qAeU
	 zhaN2KxmeMq2qs+CH7S3bZdOtKxfibDDoBrEVcp2yJOX3kreA8FA6pOs2+mFGua+UiNHH
	 SVOI9XvnoC/33vnh7V0+yoOnzGzokJxwN4hdsaKoPgma51Qz15Nd1JRH6oDCRzsHMID73
	 WTifrM80fUolylcAFpRuCKo7GgmU2xDHm2jnaFm0L62Uphp6iite+RMUKMEau280DPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410545;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mBSo8+i91CrACZrxGkLXrZpH+5L8K8Z5H9NJzXzfrR4=;
	b=UbygsxD900NBtYx1yXo3SLqXvQe3Y4DxvIPjDJM1ejaPELYKvFexlBll7ua/sqTkGMlu
	 kD9C36FhrUuRYR9K5OU4Oi6CYIzSkq7QJ1eF/QrjzYYvIjE2/XVsL5HP3CVGpf46kflmD
	 OCoMPLask0NzITOOp07vpg9eFyksIBJdx8t4q3N3A0oKVjGQzwTG4/en4GSrWmVb3e0wo
	 O18t1GIsiA/fHy62h9KYjleiMXtXTVPHsGe+b6D6LdNghlOZs+2qSdF7vjmBG3JoTKb8b
	 Hl6YoPmEMG5eiyGFLqFfRiiS5JTtsZsdTFkWDjNmQZteEn8ShIHbDb6ozcLKxclWYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CPe6sEoD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7378A606A32D;
	Wed, 11 Nov 2026 15:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7378A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CPe6sEoD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1AC61576;
	Wed, 11 Nov 2026 07:22:21 -0800 (PST)
Received: from [10.43.20.72] (e126510-lin.lund.arm.com [10.43.20.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2A903F632;
	Wed, 11 Nov 2026 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794410544; bh=mBSo8+i91CrACZrxGkLXrZpH+5L8K8Z5H9NJzXzfrR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CPe6sEoDXEq0CUSjZ6jny/Hfzg7F0nl2TvWdHaTVM/Z8om2nXFrbUEHiNinOsLi3G
	 b+zM4dJw+QxdRaUrtNxakmzC6AiBkhYtoNt/T+Y94M/CGZNoMTkg+so51tIkMogts4
	 Zp7PhvG4gHcOkBuMpB9jhCJKm3Tc9Y9pOp0sQA68=
Message-ID: <0a48af69-d0a9-410e-9d10-389eed0827c9@arm.com>
Date: Wed, 11 Nov 2026 16:22:13 +0100
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
Subject: Re: [PATCH RFC v10 06/22] arm64: Disable EL2 trapping of POR_EL1
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
 <20261109-kpkeys-v10-6-aa6c4d9603bc@arm.com>
 <3500936b-4177-4ba0-a9df-7eb9d9d75b0a@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <3500936b-4177-4ba0-a9df-7eb9d9d75b0a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2026 16:29, Mark Brown wrote:
> On Mon, Nov 09, 2026 at 03:58:31PM +0000, Kevin Brodsky wrote:
>
>> Make sure EL2 doesn't trap kernel accesses to POR_EL1 by setting the
>> nPOR_EL1 bit in HFGRT{R,W}_EL2.
> This wants a matching update in booting.rst as well for when the kernel
> is booted at EL1.

Good catch, in fact POE requirements are completely missing from
booting.rst. Will post a separate patch for what we already need
upstream (i.e. POE at EL0), and then expand the section in this patch.

- Kevin
