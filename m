Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B099C1DFE12
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599228; cv=none; b=DJntfpn7JiWr/JjxoHzE9sZA/lGO0RycTH1q48AB8CTNnjsLgMZWc0cY3arvnPWIyZjukjl62JnN+0Tzyv9xDFWqFQwu39tXngAP36TP1bV12RhsCl44VhcCa4Pip24FhUidNk4pwjnrvyU2bifsca3msPJOBO7WAQ6zPVU+xr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599228; c=relaxed/simple;
	bh=dujpYYkEAuhnVjwRXcOEFr/W68596+RK/2xaBEwTRfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHYu9sJW3Dmg5DLdTAVDmA3qREOJ5JzPzTeyLwxwjtCMUv3uhwfzHr8R61Dd1G4noxiXmQgOIbV2aOxzo/wGFmANrvx0GXe4HrJOYGPOZ5caffs9oitrzCo9FmjEzB0BQsNssO59do8yfAZcAOjZpuDG0E5lURgYEeqjRcOPc3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIAPHdg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIAPHdg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD0DC4CEF5;
	Thu, 20 Nov 2025 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763599228;
	bh=dujpYYkEAuhnVjwRXcOEFr/W68596+RK/2xaBEwTRfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIAPHdg63xsA03+0xdtbaIu0VQ2lXc7juftLQKi2e0sZZBtRvAj//hcoPa0Uo4PwM
	 lc2vr+hMHaXpAYsIGNa35FRChI3BB70zsoyhbJOuLyJB8efprmsJU6xfCDKDOCxyG9
	 loEOCFtnj2i62QlfteKtQXesmbljRhN9IEMRWRSvSbuMyz46E+Iq3HqksPJ+M9rabs
	 qfKRSeh6Kph15VvjaqTtv32BQm32JRySOpJgOtYmVoJKOVOh/XfNvUpEqRtXo5E8mt
	 hMu6Zv1TOUUY9seSjZbfRsMdwUHAoDMw4z30xQLQpMX64mMu/mZxF0CxR8wMu26yPM
	 Pe5n4uHm7k6FQ==
Date: Wed, 19 Nov 2025 16:40:27 -0800
From: Kees Cook <kees@kernel.org>
To: Jeff Law <jeffreyalaw@gmail.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v7 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
Message-ID: <202511191549.E163044@keescook>
References: <20251117201219.makes.617-kees@kernel.org>
 <20251117201231.2160039-7-kees@kernel.org>
 <c8b5038c-222f-4215-84c4-3f0698ccf10e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b5038c-222f-4215-84c4-3f0698ccf10e@gmail.com>

On Wed, Nov 19, 2025 at 08:35:35AM -0700, Jeff Law wrote:
> Note there's still review work to do on the RISC-V bits.  But it's worth
> noting your patch triggers ICEs in the RISC-V testsuite.  See:
> 
> https://github.com/ewlu/gcc-precommit-ci/issues/4115#issuecomment-3543758441

Ah thanks for the pointer -- I didn't know there were any CIs running on
patch submission!

I fixed a bunch of the lint issues and found a few more too. :)

I'll get the test failures tracked down...

-- 
Kees Cook
