Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D50128383;
	Wed,  8 May 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191128; cv=none; b=Hm8tZVA5+UEJgJCWhbWI8zZZOpdjEuo8szrphpY/4gWsIXp6bQLt3TaGFo2S8oztsGFpVBcPIvp0PuZHaRxgMRNTRD4EvvMAVdgVlEnPzAltRrP5orj2o1faO6g9Du1xH/8ZaH4q4Ee8WHzcboD8tI1MLYwCSV3GoIjV4gLgYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191128; c=relaxed/simple;
	bh=izy9mUQYXVfZMmrD6pld1qKnZtPknLMwwyonH4yL3Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSMje7ThkHlzloDYPhQlx1YUnCFOepU758HKB2CkSoXpCqUzOdNUsQpfhe14PKI5Moi82KeUYk19MvVf4MoZz77baOiKjogCwVMC33v1oa2IMuRexh+CM4qkMNHvc2VWCidAgMz9aA6QLiIXqEIfFmNscUqpuGH+yrvxwHp7rBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Rq+glfXL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Rq+glfXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715191121;
	bh=izy9mUQYXVfZMmrD6pld1qKnZtPknLMwwyonH4yL3Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rq+glfXLt289eemZq+1r+iaNMBnTWPvdeQLQ0NyoL09uhVDMAJ3wxRUCjqVjOV2SK
	 YTITbS8yN3LNivomPWmqSMt6P4XqWSDQOn+Y/Up9LO2PRMAfQqTyynHW9Xt5wwqKTD
	 cCLO4/9kms2cEpiWrbhUc1dnRaoQ0XfXj3fWusLw=
Date: Wed, 8 May 2024 19:58:41 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] seccomp: Constify sysctl subhelpers
Message-ID: <26ee93db-a924-46f3-b7eb-4a89a6a59932@t-8ch.de>
References: <20240508171337.work.861-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508171337.work.861-kees@kernel.org>

On 2024-05-08 10:13:41+0000, Kees Cook wrote:
> The read_actions_logged() and write_actions_logged() helpers called by the
> sysctl proc handler seccomp_actions_logged_handler() are already expecting
> their sysctl table argument to be read-only. Actually mark the argument
> as const in preparation[1] for global constification of the sysctl tables.
> 
> Suggested-by: "Thomas Weißschuh" <linux@weissschuh.net>
> Link: https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/ [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Thanks!

Reviewed-by: "Thomas Weißschuh" <linux@weissschuh.net>

> ---
> Cc: "Thomas Weißschuh" <linux@weissschuh.net>
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> ---
>  kernel/seccomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index aca7b437882e..f70e031e06a8 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -2334,7 +2334,7 @@ static bool seccomp_actions_logged_from_names(u32 *actions_logged, char *names)
>  	return true;
>  }
>  
> -static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
> +static int read_actions_logged(const struct ctl_table *ro_table, void *buffer,
>  			       size_t *lenp, loff_t *ppos)
>  {
>  	char names[sizeof(seccomp_actions_avail)];
> @@ -2352,7 +2352,7 @@ static int read_actions_logged(struct ctl_table *ro_table, void *buffer,
>  	return proc_dostring(&table, 0, buffer, lenp, ppos);
>  }
>  
> -static int write_actions_logged(struct ctl_table *ro_table, void *buffer,
> +static int write_actions_logged(const struct ctl_table *ro_table, void *buffer,
>  				size_t *lenp, loff_t *ppos, u32 *actions_logged)
>  {
>  	char names[sizeof(seccomp_actions_avail)];
> -- 
> 2.34.1
> 
