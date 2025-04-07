Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DC211460;
	Mon,  7 Apr 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992211; cv=none; b=lnVtruUBKnzxYQlzrFbZzlDLtIFI006deliGD7Tjf64zN9Y8XbycijjMMxnjZkx7fkZxpgW2sb/6t1XLkQ1LEthgc+DtKmp97TIGveRf2kAwSVGmJCT0rrnjlo9iMGMVxHcMZxYZSiPU+Jc17cU3vIhzbKFrxpCZKDbGTOkc1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992211; c=relaxed/simple;
	bh=+YPVBtUdXDL8aIMa/FW9iSku5vdP9lAXtJFKr/FTZ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTDd00bSK6txjNWhXMyoxVpXEeMJ447yVz9Hu+2vJCQphjMhzNxbspy9vWRCDezsGKPceWCKUzbK742OBoN+mKI6oQe7nesauIk5FafUfzYsTG3KLQ9qyUbVjHtwz87QhGIQ6Zpxf8Xd/1XW4Zm4rT1D3ayiVYHwhOHRLLwNZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HShg0dF2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HShg0dF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDD3C4CEE7;
	Mon,  7 Apr 2025 02:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743992210;
	bh=+YPVBtUdXDL8aIMa/FW9iSku5vdP9lAXtJFKr/FTZ8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HShg0dF20RdvloEvlAD/b7m5+ljObjq9aH0wjIuNl4K5x8VZOhwGn3Y36wmu5LGJf
	 wPnL0lyj4AqGN2WzbzUFDqTPgpjk/gylC5ynPd4LUkkWnnmg1ycoh6PkWnqE2gJwSJ
	 hGN3H5Z4HSq9qUzJuxYmvDdNsybUTepfqi7MkdGs/GkqOhA/SwnqdrZtPauUmYKQwj
	 PQLImbL/PJz2ttOlpU3uk9wSU8JBP1bnpYKDCvPHKRkL6/LtvPR30Y8pFELDOl2cAU
	 AjARgo8s0NppzVNTTEcIFgCWGQrNhXM+5OSb034pxnRQcG4mW/iYTHVByTSMdizjch
	 ZpJrt1AQCsBGg==
Date: Mon, 7 Apr 2025 02:16:48 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_kbd_led_backlight: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z_M1kLX_pbcq3taE@google.com>
References: <Z-afGnRbyGs4dHb1@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-afGnRbyGs4dHb1@kspp>

On Fri, Mar 28, 2025 at 07:07:38AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_kbd_led_backlight: Avoid -Wflex-array-member-not-at-end warnings
      commit: 04251bc86653a839ccb1f5ec248ad5e8afd9a627

Thanks!
