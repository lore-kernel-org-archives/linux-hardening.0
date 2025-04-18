Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09378F29;
	Fri, 18 Apr 2025 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745007808; cv=none; b=BB65Jy7UhcwXlHqbIb02BbS7/pdGhYSgZrSPft829gY9B3MDr79oeEifM5qhkBYa8ek2knCEx4HBqFTNX4n2YKbeD405LqR6rP/y1LHJljNK4aet4NCC3UugK9BIGaEXCrHWkldUhNEgwNtAGDesEMq7QfXA/1T9IullMrLXZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745007808; c=relaxed/simple;
	bh=5oHiRtO67AjFam0SoxSr2Ft9xzH28e8c4XBaEze+ANk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxdQtt8DQAKVExfSlUgPXt+33hfMc0JnaKu2Mptu8dMSRahL8YuDKSvxU49GZHfzqmFeyGa0p94DGlu1FbHm7xUMmX1W/GgW7X93YuikKrzuL/DbyXGcZU4OUX2nTh4tvd6cFllsJYEmojzM4gfAs97F743rpO+7vYgMu/ZOwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQeuMgNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQeuMgNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638A8C4CEE2;
	Fri, 18 Apr 2025 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745007807;
	bh=5oHiRtO67AjFam0SoxSr2Ft9xzH28e8c4XBaEze+ANk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQeuMgNE75YcFr98Olbzgm9sInrTSIPbz6I+Wj+u8v1l1XulLVGQ8yYoBWBhE1ElE
	 fgouiOXlvG8+prp5PxbWQBxnag75HcEt57cM/zASw7t2utECeHIpg+lIVf5J4qxRo5
	 y4WDZOsL9qyj4L7/KSpmmHe1xn7oN9TEfTW5GcntbZGjxskE7t0h08/uvwqQzzNwyO
	 qXE/RhHCaTWzyZB4+KGp2ZuPelHX6SryXcMzBVy8VD1HXe0hW62Rg/ru/xRr5YcswU
	 s11eqo7RgjCU8iiSFbkXbqgHlvPE/67LKGEMdnyWdwHvEKpkx6xuKSuZEN6dqiUkEB
	 K6gPYzGxy/ySw==
Date: Fri, 18 Apr 2025 13:23:24 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	linux-hardening@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smp: Replace deprecated strcpy() with strscpy()
Message-ID: <202504181322.5D3B93E93@keescook>
References: <20250417192054.69663-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417192054.69663-2-thorsten.blum@linux.dev>

On Thu, Apr 17, 2025 at 09:20:52PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.

Are there more strcpy() uses in arch/alpha? Maybe do all of them and
give the Subject prefix as "alpha:". If not, the "smp:" prefix is likely
to non-specific. Maybe "alpha: smp:".

-Kees

> 
> Link: https://github.com/KSPP/linux/issues/88
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/alpha/kernel/smp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
> index ed06367ece57..56155b988b9c 100644
> --- a/arch/alpha/kernel/smp.c
> +++ b/arch/alpha/kernel/smp.c
> @@ -262,7 +262,7 @@ recv_secondary_console_msg(void)
>  
>  		cnt = cpu->ipc_buffer[0] >> 32;
>  		if (cnt <= 0 || cnt >= 80)
> -			strcpy(buf, "<<< BOGUS MSG >>>");
> +			strscpy(buf, "<<< BOGUS MSG >>>");
>  		else {
>  			cp1 = (char *) &cpu->ipc_buffer[1];
>  			cp2 = buf;
> -- 
> 2.49.0
> 
> 

-- 
Kees Cook
