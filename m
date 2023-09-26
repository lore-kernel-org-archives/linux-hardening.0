Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0C186F
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 04:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C43CC433C7;
	Tue, 26 Sep 2023 04:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695704243;
	bh=PzV9aQcamDLYWUCJlNJtgTlBzrz5YiFxBTx0LXK3QIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoOOo+4TJAXIv0S2LURMn9Nc06RHQX/8SrlxFj8vyxWhv8UpKlW4Bp3eu75uhgp5H
	 2J74JZCA7UdJmWiVHfZofC44WQYG3ikYUsi93E0kbmgwHvNlzMjGet3D7hskpCMblb
	 bpkDLGnXEIA8tGJFzHISewIK8g4Q1UkEwoxymH8P3249j+Mh2KlPs+t1d01Y74gFE9
	 swqnB60qHQcQuYuqYeAor/LLzf2ZSBdJm79d25ldaPwqxaNpLRmMR+P0kv27Y5DvpX
	 i69/TwPjYv9s0DJ/Qm/nVBv+ZTWHVwnILC+nWSJ8eVmyuYYutEEEL5YJwj3pKcx6n4
	 sEcdCDrY6JnJg==
Date: Mon, 25 Sep 2023 21:57:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: hardening: Add __counted_by regex
Message-ID: <20230926045721.GA3118@sol.localdomain>
References: <20230925172037.work.853-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925172037.work.853-kees@kernel.org>

Hi Kees,

On Mon, Sep 25, 2023 at 10:20:41AM -0700, Kees Cook wrote:
> Since __counted_by annotations may also require that code be changed to
> get initialization ordering correct, let's get an extra group of eyes on
> code that is working on these annotations.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 737dcc7a2155..741285b8246e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11405,6 +11405,7 @@ F:	kernel/configs/hardening.config
>  F:	mm/usercopy.c
>  K:	\b(add|choose)_random_kstack_offset\b
>  K:	\b__check_(object_size|heap_object)\b
> +K:	\b__counted_by\b
>  

Are you sure you want to volunteer to maintain every file that contains
"__counted_by"?  That's what "K" does; get_maintainer.pl will list you (and
linux-hardening@vger.kernel.org) for every such file.

Other users of "K" have been surprised by this behavior.  It seems that most
people expect it to only apply to patches, not to files.  Given that you're
interested in using this functionality, have you considered updating
checkpatch.pl to handle it in the way that you probably expect that it works?

- Eric
