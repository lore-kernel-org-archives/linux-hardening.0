Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53324679C
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778467; cv=none; b=Sb64F9JrEgGmkh1TsYsqG3+YSIr7s+e5dUMJKZPxZe/1OZyPGwoZOicZp86w3+tbwuBQb2dfxhN32iqd3OVizhaziU0980qqsv89u8F5ycvrXJdou/WBgw0XUfQJLjtpjVsLWFqSr49IIS2f1X4A9wVgZMYBGB6FYWZuxj7hAmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778467; c=relaxed/simple;
	bh=hrtmZW2O4NCJt0A366T1FKCnALv6/Z+Miswm72Utq7A=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=OU+qKZQ/K9YhumJQMawd7sglLQf7lwq3VTXt79hcxTvUaW9rUCHnplTHoAxXI64klEUnmjqILiSPOY8xS+T0rCR5U2B7ibLtazHKlzts68VuOUZhoWRpEkfVQxh70LBRDMpto5XJ4qiVxHmUxFNzG/Y98ghUCwLKeXDizvaeEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7/0KQt1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7/0KQt1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EAC1F00AC4;
	Mon,  7 Sep 2026 10:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778465;
	bh=NOGW6/wWy7KCmoBtQtZTuis7xY50X7nU3u2PLYPpIC8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=G7/0KQt1Skmof7ZpkUnZkQDRlafhOO12XFsIOYKQpAZmnVWs9cA5biIbNGPPuXDzW
	 zsWIjohT+04Z7RKrQ4HzEy5BU3ZOMwvrWuBqgfNP1+E/sppYgegCHuaVVral3FOlD7
	 E+BJ3cZ1lOKjnuBo7hq5B+GmYNIA2vRgOiSdaWPEUUmRfgH9LhJoq/xjGrXd8iQxIp
	 0QLHHyb+1PCWt6wcujYQIYJHuxuOw+/3VdqprBCgXm18Ni37snzH3Dcs9NHuc/UdDL
	 gPqtso0FJZynaI1csR5E/lOdWBfyYv0v+WaIOpjWESgWiFg2UzIYKaqr8ob0R4FU0r
	 J5L9r8Wo6IEgw==
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC v9 01/25] mm: Introduce kpkeys
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Lutomirski <luto@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Jeff Xu <jeffxu@chromium.org>, Joey Gouly <joey.gouly@arm.com>, 
 Kees Cook <kees@kernel.org>, Linu Cherian <linu.cherian@arm.com>, 
 Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Maxwell Bland <mbland@motorola.com>, 
 "Mike Rapoport (IBM)" <rppt@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Pierre Langlois <pierre.langlois@arm.com>, 
 =?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Quentin Perret <qperret@google.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Will Deacon <will@kernel.org>, Yang Shi <yang@os.amperecomputing.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-mm@kvack.org, x86@kernel.org, Ira Weiny <iweiny@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260818-kpkeys-v9-1-743ad31b2c8f@arm.com>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-1-743ad31b2c8f@arm.com>
Date: Mon, 07 Sep 2026 13:54:14 +0300
Message-Id: <178877845406.3691569.6930315020588094755.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi Kevin,

> kpkeys is a simple framework to enable the use of protection keys
> (pkeys) to harden the kernel itself. This patch introduces the basic
> API in <linux/kpkeys.h>: a couple of functions to enter/leave a
> kpkeys context and macros to define guard objects.
> 
> kpkeys introduces a new concept on top of pkeys: the kpkeys context.
> Each context is associated with a set of permissions for the pkeys
> managed by the kpkeys framework. kpkeys_enter_context(ctx) sets
> those permissions according to ctx, and returns the original kpkeys
> state (typically the arch-specific pkeys register) that is later
> restored by calling kpkeys_leave_context(). To start with, only
> KPKEYS_CTX_DEFAULT is available, which is meant to grant RW access
> to KPKEYS_PKEY_DEFAULT (i.e. all memory since this is the only
> available pkey for now).
> 
> The underlying representation of each kpkeys context is entirely
> architecture-specific. Support for kpkeys must be explicitly
> indicated by selecting ARCH_HAS_KPKEYS and defining the following
> functions in <asm/kpkeys.h>:
> 
> * arch_kpkeys_enter_context()
> * arch_kpkeys_leave_context()
> * arch_supports_kpkeys()
> 
> Additionally, <asm/kpkeys_types.h> must define struct arch_kpkeys_state,
> which typically provides storage for the pkeys register.
> 
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>
> diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
> new file mode 100644
> index 0000000000000..eac522f552141
> --- /dev/null
> +++ b/include/linux/kpkeys.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _LINUX_KPKEYS_H
> +#define _LINUX_KPKEYS_H
> +
> +#include <linux/bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/kpkeys_types.h>
> +
> +/**
> + * KPKEYS_GUARD_NOOP() - define a guard type that does nothing

Nit: I'd suggest to drop "define" from all the descriptions, they would
read better without it IMHO.

-- 
Sincerely yours,
Mike.

