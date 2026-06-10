Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B1F91D6;
	Wed, 10 Jun 2026 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053124; cv=none; b=ajsSeVLlAqFtjSYV+Q1Y+XvDfO9vcNb8GtnlSxL6rmdSd2pABFZ+/jCtbpjT2hfqqUs+Uqv/Jr03a038mwjJWZCsSHqi/3LRArp4mPrPciXl5fLXVDvobptuQ6qyDRW7CiLLCMZoPQgLZhbCtOvp2JGj40w5sitJ+hQ4CWq/4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053124; c=relaxed/simple;
	bh=OmoFitpYKHAIiEcivzw+3UTezocvyEIrQudTiKwQvLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjPlY9iFe/5yP2BUz38jJXaHL5LnIh5TqQV7eG7U8GUteI8gunwzxETAMLjuI06a829CBlMsB9I6PmIJggD0lF3xI47duqF6DAYfsXiGUKXrN1mqIUlVy7SGque1o237VdxjN4ul5vbMGy8nRb6TseASHrEWTntjd7SAa+lUgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh85YTRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh85YTRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A89B1F00893;
	Wed, 10 Jun 2026 00:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053122;
	bh=2I5nSFx17QTOsvRQJ3lHz/Nw8uM87WWs52G6x2E43tY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yh85YTRl4/MtXnUTaFnEBfDHb/kfCjTZMXOrYx+ThffEvO9DaWhHD1gefDT4qChBr
	 hTUdN184LoGEpxrqyz4wKl9RuR+sP4O8eXxCUG7xnnGKjYLSx0/6BV5AwXCHdUaB+B
	 hVdEG2Rhb4d9nlML+CX5TvgkA0AzoA/ZvORW4Phzvf8W75fj2x/hj/A01gjNNLf6QJ
	 wbdWtTfgZ29bqf2SJOI8pluhN7W+9Aw+umAU4PxKVS0TQc1xc89xqw6g1Oe956X7M8
	 B8yr/dcDBF1LSfleuF7NOf+RtxZtU4Y8EqfJFUC0eTS8YMM+Ro6128C3FCw/vIVH5P
	 6NxoUhKQtg0Rw==
Date: Tue, 9 Jun 2026 17:58:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260609175841.3ce88cf0@kernel.org>
In-Reply-To: <20260606202633.5018-14-david.laight.linux@gmail.com>
References: <20260606202633.5018-14-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jun 2026 21:26:08 +0100 david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>

Commit message is required. Please explain why you think this patch is
needed. AFAICT it copies data between two well formed IFNAMSIZ strings.

> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>  drivers/net/bonding/bond_options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 7380cc4ee75a..c57b7d6af043 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1525,7 +1525,7 @@ static int bond_option_primary_set(struct bonding *bond,
>  		if (strncmp(slave->dev->name, primary, IFNAMSIZ) == 0) {
>  			slave_dbg(bond->dev, slave->dev, "Setting as primary slave\n");
>  			rcu_assign_pointer(bond->primary_slave, slave);
> -			strcpy(bond->params.primary, slave->dev->name);
> +			strscpy(bond->params.primary, slave->dev->name);
>  			bond->force_primary = true;
>  			bond_select_active_slave(bond);
>  			goto out;
-- 
pw-bot: cr
