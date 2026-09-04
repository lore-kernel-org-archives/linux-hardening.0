Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DF43C051;
	Fri,  4 Sep 2026 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521166; cv=none; b=ErdNNvI+2awZarw/SYQm8ZyK8oY5OisuC5cGYCh0VO9lzewlb7YkfM9hovGrTXQmWNbQE7ZS/g/W5CDmohsBmgDOdS436FiKPdAr7yuUBPbIiCB2TfdGV9Ipw5RFL4ooC13Bm3DRgHXsLwiGtDc0Mry4DNFDXuZqysRq4iWziiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521166; c=relaxed/simple;
	bh=L80i9hlVbUmhAA7RZtkdYwsX5/2+IaWODZria1XvUI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RawAvXP8QkTtKR/A8e+jdghtgddMB5DxilRn6grns8/7QK0oEsebWLdMjEXWIb37lmifXTq9sxWtVwolhgbY+SS71tT/wxzv5Zpq1g5n1+yiozPPYspPSsp/QxPJ/6lB5rEVE1LvXu4+8C9aG260bwwUK6ETshWOk/Davy5cUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mluJvJ+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mluJvJ+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356561F00A3D;
	Fri,  4 Sep 2026 11:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521164;
	bh=XXIZF5ElAIHZa1rnUZHWNzzVs/Jy9yMMRkt9sWYgbvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mluJvJ+244GVSHaOz7Q2krQ0KhxoLZs7iOnA4ksTTISOwY2skVParSwBT9v/4F0OF
	 g3xtpF8RfDAHJHVIcRhTHSQ+Bqle/H/Hvrnyrb2jk4Zoqbdcqt1HVWBDYJoAjafN8i
	 9kx6abHPk8ucvAX1eyRsxH/xeCyxC0guHR0CsHqOGT3+Gd1jYXTCRSyyfnROvZFGrn
	 8qYi5w7eqFltyhRXUIx3S6Vi1pai4OLZej+YcrU3JXyJzalY+QnRbFlhA8E5vImoZn
	 CKhhb7EZuqP6UXbHbxDA3RXkJWh7XlTBs4tvQRC42O4apjIBSym9i3tloAihiDGU45
	 e/j5PHm1j3JXQ==
Date: Fri, 4 Sep 2026 12:25:59 +0100
From: Harry Yoo <harry@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] slab: ZERO_SIZE_PTR alignment and ERR_PTR
 hardening
Message-ID: <apqmVDiyGJWnEnp8@nixos>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903203720.63689-1-kmehltretter@gmail.com>

On Thu, Sep 03, 2026 at 10:37:15PM +0200, Karl Mehltretter wrote:
> The kmalloc entry points promise ARCH_KMALLOC_MINALIGN alignment but
> return (void *)16 for zero-size requests. Patch 1 aligns the sentinel
> to that promise.
> 
> Patch 2 limits ZERO_OR_NULL_PTR() to NULL and ZERO_SIZE_PTR. Patch 3
> handles ERR_PTR explicitly in kfree() and hardened usercopy, without
> giving ERR_PTR special meaning to other users such as krealloc(). The
> old helper did not match ERR_PTR values either; patch 3 addresses the
> adjacent hardening concern raised during review.

I don't understand why v3 of this patchset suddenly implements
hardening for kfree() and usercopy to handle ERR_PTR().

The address range for 'zero or NULL PTR' range and ERR_PTR() do not
overlap. The bugfixes and hardening patches are irrelevant.
It should be a separate series?

Also usercopy.c changes go through the hardening tree, slub.c and
slub_kunit.c changes go through the slab tree, and LKDTM has its own
tree. Patch 3 and 5 touch files across multiple trees, which can be
avoided.

> If backported, patches 1 and 2 should be taken together.
>
> Patch 4 adds zero-size KUnit coverage; patch 5 adds ERR_PTR KUnit,
> LKDTM, and kselftest coverage, which is why Arnd, Greg, Shuah, and
> linux-kselftest@vger.kernel.org are newly copied on v3.
> 
> Tested on 940de590b839:
> 
>   - GCC 15.2 UML slub_test: 10 passed, 2 skipped, including
>     test_zero_size_alloc and test_kfree_err_ptr; NULL and ZERO_SIZE_PTR
>     produced no warning, and the expected kfree(ERR_PTR) warning was
>     suppressed and counted
>   - GCC 15.2 matched x86_64 builds immediately before and after patch 3:
>     kfree grew by 15 bytes; __check_object_size gained a 13-byte
>     comparison on its normal path and a 23-byte cold abort path
>   - GCC 15.2 x86_64 defconfig with HARDENED_USERCOPY: build and normal
>     QEMU boot passed; the committed LKDTM selftest matched the distinct
>     ERR_PTR diagnostic after reaching usercopy_abort()
>   - Clang 21.1.8 armv5 UBSAN_ALIGNMENT: no alignment-assumption or
>     slab.h report; generated code retains the exact comparison and
>     single evaluation
>   - GCC 15.2 MIPS64 big-endian noncoherent build passed with
>     ARCH_KMALLOC_MINALIGN equal to 128
>   - Microchip SAM9X75 hardware (armv5, ARCH_KMALLOC_MINALIGN=32):
>     ZERO_SIZE_PTR was 0x20; zero-size allocation, ksize(), and free
>     passed with no boot splats
>   - Raspberry Pi 400 hardware (arm64, Cortex-A72,
>     ARCH_KMALLOC_MINALIGN=8): ZERO_SIZE_PTR remained 0x10; the ERR_PTR
>     KUnit and hardened-usercopy rejection paths passed with no boot
>     splats; the revised diagnostic was retested under x86_64 QEMU
> 
> ---
> v2 -> v3:
> 
>   - document why patch 2's sentinel-derived low-address window in hardened
>     usercopy was incidental
>   - add new patch 3 to warn and return when kfree() receives an ERR_PTR
>     and reject ERR_PTR values in hardened usercopy
>   - replace patch 4's pointer-cast static assertion with a run-time KUnit
>     expectation
>   - add new patch 5 with KUnit and LKDTM coverage for patch 3
> 
> v2: https://lore.kernel.org/r/20260811141240.62519-1-kmehltretter@gmail.com
> v1: https://lore.kernel.org/r/20260808105622.62026-1-kmehltretter@gmail.com
> RFC: https://lore.kernel.org/r/20260712120728.96628-1-kmehltretter@gmail.com
> 
> Karl Mehltretter (5):
>   slab: align ZERO_SIZE_PTR to ARCH_KMALLOC_MINALIGN
>   slab: check for ZERO_SIZE_PTR by exact match
>   slab: handle ERR_PTR values in kfree and hardened usercopy
>   slab: test zero-size allocations in slub_kunit
>   slab: test ERR_PTR handling in kfree and hardened usercopy
> 
>  drivers/misc/lkdtm/usercopy.c           | 27 +++++++++++
>  include/linux/slab.h                    | 20 ++++++--
>  lib/tests/slub_kunit.c                  | 61 +++++++++++++++++++++++++
>  mm/slub.c                               |  3 ++
>  mm/usercopy.c                           |  3 ++
>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>  6 files changed, 112 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 940de590b839f71d6dc846160534bf202401b8b7
> -- 
> 2.53.0
