Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB80179B5
	for <linux-hardening@vger.kernel.org>; Fri, 20 Oct 2023 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9027310F4;
	Fri, 20 Oct 2023 03:30:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A28A2F4;
	Fri, 20 Oct 2023 03:31:29 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.70.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 067A83F5A1;
	Fri, 20 Oct 2023 03:30:47 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:30:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include stackleak paths in hardening entry
Message-ID: <ZTJWxLq4lHElmR19@FVFF77S0Q05N>
References: <20231019004616.work.960-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019004616.work.960-kees@kernel.org>

On Wed, Oct 18, 2023 at 05:46:20PM -0700, Kees Cook wrote:
> While most of the gcc-plugins are self-contained in the
> scripts/gcc-plugins directory, stackleak actually has some additional
> files. Add those so changes are directed to the hardening list.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Makes sense to me, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f18ed0fbd42..a4de29c0036f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8615,6 +8615,8 @@ L:	linux-hardening@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
>  F:	Documentation/kbuild/gcc-plugins.rst
> +F:	include/linux/stackleak.h
> +F:	kernel/stackleak.c
>  F:	scripts/Makefile.gcc-plugins
>  F:	scripts/gcc-plugins/
>  
> -- 
> 2.34.1
> 
