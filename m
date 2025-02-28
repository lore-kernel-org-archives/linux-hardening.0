Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5143230BDA
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771895; cv=none; b=GaQJDFSCc8JX+xIh9lF9sugnY0KOTbF8J91aQqRXxZgUwO/2PRK/YsYO5Fqd+h7DHEXhWpGVXHHtf1jOwaQZOwFJhibZV1EU7tgBRiVo44GXUm35u1rMMX/If7pJ5raV/PRQUXExBtpIP6jrzMaGheLArCiLiiTMh3WfBc375qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771895; c=relaxed/simple;
	bh=Ubh6ZA2c6mWvFy0Jhs/53kzbC1CCVoGhfn0nWKyPlhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2CRcmRy2fNSS2tRUwaFtpz/2fMFqGpcLr1IK/ioG4vWAd5a6b/Pn1t7x/M6gM3x6vzqMrR+PMx+K8hUw+GWIgVN/TPaz29XMMAWxgJ17q2sms2tQ9SOee2G1ywhqxiqx1ziOzKIIIOjDIyCQyM5x8xs6aAXy2onCDkaUTrxKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzbcuO/F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzbcuO/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531BBC4CEE5;
	Fri, 28 Feb 2025 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740771894;
	bh=Ubh6ZA2c6mWvFy0Jhs/53kzbC1CCVoGhfn0nWKyPlhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzbcuO/FpCJ+wtqkzURWtPHjqSDs9DIXdOIPLs0bcaflbyuGJlP4y5HF0V3eaAeYh
	 TD9w0j6BOqZkc4XnMPLVsyeqs/Blktpx+LORFhTO05GkuznAU5pltktVA/sHnQ8qfm
	 VRX36XSE7RNMfcX6QhkY0gq2M2D99oGU2DpxiP/BtZrOHM3CLaPzsYDDiq8qlv3lPo
	 CjgZ8RSpNJRDw1K5N7wXmKJht9rZulZvtiP9Pzo5jo6SF/mNWR8+FyAg4acVfV7F33
	 j3/GQQv7vEyAr+smMK3y1NZ4yRH++2itZwa0flqM3F+TQYui46jPg4QjekuPutxDdR
	 h9Ft0Ij5U+36Q==
Date: Fri, 28 Feb 2025 11:44:51 -0800
From: Kees Cook <kees@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/10] lib/string_choices: Add new helpers
Message-ID: <202502281143.149423E53@keescook>
References: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0xt6zgn.wl-kuninori.morimoto.gx@renesas.com>

On Wed, Feb 26, 2025 at 05:34:48AM +0000, Kuninori Morimoto wrote:
> I would like to use string_choices helper to cleanup the code, but it missing
> some of well used string pair in kernel. This patch-set adds it.

Do you have some Coccinelle scripts or other patches that show the use
of these helpers? We tend to avoid adding new helpers to the kernel
unless there are active uses of them.

-Kees

> 
> Kuninori Morimoto (10):
>   lib/string_choices: Add str_tx_rx() helper
>   lib/string_choices: Add str_enabling_disabling() helper
>   lib/string_choices: Add str_in_out() helper
>   lib/string_choices: Add str_input_output() helper
>   lib/string_choices: Add str_Y_N() helper
>   lib/string_choices: Add str_pass_fail() helper
>   lib/string_choices: Add str_to_from() helper
>   lib/string_choices: Add str_level_edge() helper
>   lib/string_choices: Add str_kernel_user() helper
>   lib/string_choices: Add str_attach_detach() helper
> 
>  include/linux/string_choices.h | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> -- 
> 2.43.0
> 

-- 
Kees Cook
