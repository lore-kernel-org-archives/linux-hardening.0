Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37187334374;
	Fri, 29 Aug 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485670; cv=none; b=D3dm2CBDHedm+PJPJkKjMrkmhXChgLRUvy2sp9BCjPYlNvBHe3dXaPdaIeY1Mj1SgqdiqkedEehu6j3J8RnGzyfZUGApwtoq830HMkBaXqVb01v1Oz+aG4TfoQWyUMG9fs1+XvDLN2yH83w8nmgxeZLbisHKvNdavdsbU3IkNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485670; c=relaxed/simple;
	bh=QLBTv41xRWK0HCpldcOBdeOLxGpiyGcqZujmArx47Ms=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=in3uxVYfFgk4QW2j9FUKOhd/Ws4OZyxIEqRkK9NN3p5hq1u/9gnnV2o6cu7iiMGK3IoDpW4nUfWxckVvwIsHYvR7bZZdP2zKrem3qJAFcCUODeE/VS9bG1ubcpO3+iabPCYppUxMTFSAkBOT4LXyETyY3fqWOhtMgNO/CJtVYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Os/lNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Os/lNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F0DC4CEF0;
	Fri, 29 Aug 2025 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485670;
	bh=QLBTv41xRWK0HCpldcOBdeOLxGpiyGcqZujmArx47Ms=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q9Os/lNcdCf4Uzum+cE3j5nXRy5ZscRCZhEdoSLsjWAlzWo9hN3BUUwsrbE+HIhde
	 hzI6DH2mawBbExNEvyx5ZpAvZWPfbOB8ALucuFuUY9/L0nSblX7ZT+T5xOvj3w0iHV
	 H7Xq0++BaGEoeeZVgR5ndkpLLCvyXBztp7ZXLymUKxS1iMdNGbPYcCsjoeRqg4sPxZ
	 VOBG2hgFHRQZmrfiDb8ix8VqCU7Tibt/ZgvAYALM0vvMv3vONCRafF+g0DJxGsXl9H
	 hZsHSmOOoTgSnjpUH3PR1qAqPBde8e+QtD9aDFl5QngDTpVcu1hpHp4txYdTVSL9eG
	 I2kzTOerW6fjQ==
Date: Fri, 29 Aug 2025 12:41:07 -0400
From: Kees Cook <kees@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>
CC: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yue Haibing <yuehaibing@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Ryan Roberts <ryan.roberts@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Joey Gouly <joey.gouly@arm.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 James Morse <james.morse@arm.com>,
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_arm64=3A_mm=3A_Fix_CFI_failure_du?=
 =?US-ASCII?Q?e_to_kpti=5Fng=5Fpgd=5Falloc_function_signature?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aLHP-TG3a1Im3kpa@J2N7QTR9R3>
References: <20250829154913.work.943-kees@kernel.org> <aLHP-TG3a1Im3kpa@J2N7QTR9R3>
Message-ID: <315CE055-A886-4322-9683-AFE7003B1664@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 29, 2025 12:06:17 PM EDT, Mark Rutland <mark=2Erutland@arm=2Ecom=
> wrote:
>On Fri, Aug 29, 2025 at 08:49:21AM -0700, Kees Cook wrote:
>> Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enab=
led")
>
>That doesn't look right; that commit is from June 2022, and we only
>introduced enum pgtable_type in May 2025 in commit:
>
>  c64f46ee13779616 ("arm64: mm: use enum to identify pgtable level instea=
d of *_SHIFT")
>
>=2E=2E=2E which landed in v6=2E16=2E
>
>AFAICT, that's the commit which broke things=2E

Oops, yes, I didn't look close enough=2E Want a v2 with that fixed up?


--=20
Kees Cook
