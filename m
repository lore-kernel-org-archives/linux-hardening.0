Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E097525D523
	for <linux-hardening@vger.kernel.org>; Wed,  7 May 2025 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620109; cv=none; b=ceszEI+u/t+GjOOCpSXO7kk1fBcubmuwqauAJcwA6Hcc4oqMAIiJLrjcQe2fgvfzfD/MC74NW0fEwClxjRMoXI3xtJO9aCAH/hAkNh6L6Kq0/g8ElCGlEqBCoNNEpZ1VUtRniJBMNjjvweKSkPBgpc53PtGfg43JJTu/ZOKiF+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620109; c=relaxed/simple;
	bh=iiyFqjFV+FBMamxUoQ9fowPeGDOc/bEQD8kMCuJQ5IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkVnvPGEN0bCYLtKR7Qr5GB00k9RSyJTVBKbcVqJJ/fAKFNHrRsI83BEVjjw2Y7xKJlV1yJGez/jbrEyVril0N3fx210vIvauZ5Nfy+nu9yPEuBzFH9KP+VL7UClrHjyp5f9dR5eykVmQCGmX6Ea2FYQ9OgVgeLENsRJyZmFwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qJMnoz3T; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qJMnoz3T"
Date: Wed, 7 May 2025 14:14:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746620095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XqY7YuOdihrc7IqXrXm7afvm5cHVdOv9tTA20piJDQ=;
	b=qJMnoz3TCVgFT90wHbgAuMARE4tyDEdTXu1GGiUMEmfWvmobyWu21eqoz3fkQf21QXpM1J
	HI7dPUd/tij0tLll0xPsc1vuByJezmA3I/1mLDNlYuy32AhhZ5rvSWpa1CMiS4izgo+QBc
	EaVWT6caCiWno+XisCIPNUYx5sVyOjM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 2/3] randstruct: Force full rebuild when seed changes
Message-ID: <20250507-righteous-turquoise-bustard-4fca48@l-nschier-aarch64>
References: <20250503184001.make.594-kees@kernel.org>
 <20250503184623.2572355-2-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250503184623.2572355-2-kees@kernel.org>
Organization: AVM GmbH
X-Migadu-Flow: FLOW_OUT

On Sat, 03 May 2025, Kees Cook wrote:

> While the randstruct GCC plugin was being rebuilt if the randstruct seed
> changed, Clang builds did not notice the change. This could result in
> differing struct layouts in a target depending on when it was built.
> 
> Include the existing generated header file in compiler-version.h when
> its associated feature name, RANDSTRUCT, is defined. This will be picked
> up by fixdep and force rebuilds where needed.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: <linux-kbuild@vger.kernel.org>
> ---
>  include/linux/compiler-version.h | 3 +++
>  include/linux/vermagic.h         | 1 -
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler-version.h b/include/linux/compiler-version.h
> index 74ea11563ce3..69b29b400ce2 100644
> --- a/include/linux/compiler-version.h
> +++ b/include/linux/compiler-version.h
> @@ -16,3 +16,6 @@
>  #ifdef GCC_PLUGINS
>  #include <generated/gcc-plugins.h>
>  #endif
> +#ifdef RANDSTRUCT
> +#include <generated/randstruct_hash.h>
> +#endif
> diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
> index 939ceabcaf06..335c360d4f9b 100644
> --- a/include/linux/vermagic.h
> +++ b/include/linux/vermagic.h
> @@ -33,7 +33,6 @@
>  #define MODULE_VERMAGIC_MODVERSIONS ""
>  #endif
>  #ifdef RANDSTRUCT
> -#include <generated/randstruct_hash.h>
>  #define MODULE_RANDSTRUCT "RANDSTRUCT_" RANDSTRUCT_HASHED_SEED
>  #else
>  #define MODULE_RANDSTRUCT
> -- 
> 2.34.1
> 

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Tested-by: Nicolas Schier <n.schier@avm.de>

