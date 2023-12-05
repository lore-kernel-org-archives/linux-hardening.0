Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A0692A8;
	Tue,  5 Dec 2023 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Umm13VIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C92C433C8;
	Tue,  5 Dec 2023 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701810290;
	bh=oBo9P7E2H1qo/8P7D4Gn1bqot50xulgDivPddX3B360=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Umm13VIfsxObQ8ml3mnlVj2Ggug4q74F5giIj1ChM2SJpMGqfOoIJm/I/zwxWurWb
	 UO3nMTeKUpysC/bdJyiBA/s/ehpIBbSeHj6P+xggFewzgSUQw6z1xt+5uNePlJR/MN
	 WX7rq/HoUa6w6xG42vWWspTCu+TsBaCrNZzf6wT0=
Date: Tue, 5 Dec 2023 13:04:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: tanzirh@google.com
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Nick
 DeSaulniers <nnn@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-Id: <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
In-Reply-To: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 Dec 2023 20:58:53 +0000 tanzirh@google.com wrote:

> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.
> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5232 lines (-80%).
> 
> If there are any problems with the output of the tool please raise an
> issue on the github.
> 
> Link: https://github.com/ClangBuiltLinux/IWYUScripts

Issue:

> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -16,16 +16,16 @@
>  
>  #define __NO_FORTIFY
>  #include <linux/types.h>
> +#include <asm/bitsperlong.h>

The preferred way to import bit-fiddling stuff is to include
<linux/bits.h>.  Under the hood this may include asm/bitsperlong.h.  Or
it may not, depending on Kconfig settings (particularly architecture).

