Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489404;
	b=WfCe3W3JZxO54zFzT32rYXtaU9iepcJW/QWxnmtNTOeoo8pTGDc718jKPDBowXLrRPct
	 J2KcZfGL7EnNR5brc3UR3GsO/0sWAnFYJ466xFEY5Dx2CBM40ANfyCiTSrHPSuuzI3ldT
	 0u+TL0SlwQFM3a+B5at1Mmly2GkX/wggl+Mcl67Emn+XH3R5+kPfB+Xsg6pa7aMymnLUn
	 0Vt6vEW/7xa83T29wMGpMrvNI2UNhSE4/KBbxrwQZVUezXNGys5zRibLSxx2AggieLDIp
	 600KIWYzFfbeyc4esfuvXRYwnypK16P64doDF6zlmmyW/Ij0sCvKtk+40qTIn/EwYaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489404;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wTBvg55fBuWD5tQeyFYmzV7yA87nWgeKUd2BDomzFCs=;
	b=iFUQtmrkO75iDho3x+ptaOC2C8Pa/MJSfBIbNIyJi9ifoT9fDNDQ1lO8tXQKBhZPK4K6
	 KRa6Hlp/cSSe4PAeCzFVqiApgKsu/Hy5+SnVFda9VJhCHRG2N/M2Gl9LfxnLj6yik3b1J
	 /uD6qkglffij3uJU3l/YM3q0ZetUENJCTSr3+7aRqPjRltYQd9VwOye6OmDedUyzFU5a8
	 LvxADDAqruhoRd2PPlSbW2W0JAOhHTQimqX9cTxXjepjtoT/TS1Fq6gQDevHFGPkNxpDZ
	 Kfps+xtDSbI1VlA372l52/1wR6FRomDV1da9B5goZX9xcM+v5K9gpdv9ve5Y+VsBEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qhR8siKF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7649606A323;
	Thu, 12 Nov 2026 13:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7649606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qhR8siKF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25CFD1477;
	Thu, 12 Nov 2026 05:16:40 -0800 (PST)
Received: from [10.57.59.183] (unknown [10.57.59.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008353F632;
	Thu, 12 Nov 2026 05:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794489403; bh=wTBvg55fBuWD5tQeyFYmzV7yA87nWgeKUd2BDomzFCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qhR8siKF3uHjUA/hWmh1H8py+Ns7uPCZYEMtvUSIeYR5dIH30FjHUDT4bD49VvDcb
	 I5k/ohiMpYz3LO+MsI+K1M42BEms0asveRWV7ANV92sDMfAMZoQct9bN5pPyWH2lLi
	 +OTp7Uve9C+YFkm6cp8nZIyyLv2wUgeasDHv3a7E=
Message-ID: <9148043e-580c-42e5-a93f-3a177f8d75df@arm.com>
Date: Thu, 12 Nov 2026 14:16:33 +0100
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
Subject: Re: [PATCH RFC v10 07/22] arm64: Initialize POR_EL1 register on
 cpu_resume()
To: Mark Brown <broonie@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-hardening@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ardb+git@google.com>, Andy Lutomirski <luto@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20261109-kpkeys-v10-0-aa6c4d9603bc@arm.com>
 <20261109-kpkeys-v10-7-aa6c4d9603bc@arm.com>
 <be361be8-c5ad-4ff7-a6db-7b0815bfe1d0@sirena.org.uk>
 <avNH_AdvK9AqvfF7@e129823.arm.com>
 <7b92f7c8-1543-447e-8ef3-aba608141699@arm.com>
 <6808f3a6-1c12-4cb2-a109-30704d812490@sirena.org.uk>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <6808f3a6-1c12-4cb2-a109-30704d812490@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/2026 14:02, Mark Brown wrote:
>> Agreed (as Sashiko reported as well). Presumably that means we also need
>> an ISB after writing to POR_EL1 in cpu_enable_poe(), as that's basically
>> the same situation.
> Possibly just have one before writing TCR2_EL1 rather than for each of
> the indvididual features, that's harder to mess up?

cpu_enable_poe() directly writes to TCR2_EL1 so surely the extra ISB has
to be there (between writing to POR_EL1 and writing to TCR2_EL1)?

In _cpu_resume for now I'd keep the ISB directly after writing to
POR_EL1, as I'm not sure the ordering is needed for anything but POE and
it seems easier to follow with the ISB right after POR_EL1.

- Kevin
