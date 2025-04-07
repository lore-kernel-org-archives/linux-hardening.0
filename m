Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38985F9D9;
	Mon,  7 Apr 2025 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992197; cv=none; b=U5c1KPP2dsKihVCevPYnDDtSLLKKXmURmtQM2ndrFpbh+2F9Bnwo2VkYSeufL1YnD7pjBFWYhQDpmEcJXZuXINbgqN7+PNXEsTbX8C9QjNdjipDutVkyzNHfhjiyxhwy+yK00dPYOOrlh3Fndd/d30B1dCndC84xpKl8J2mFPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992197; c=relaxed/simple;
	bh=6dDjNCYltJOLLOE08ZsvzNZg9rdG/Se4AN13cxDZwq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyLqoOBwZd+jN1nfxMnsQkMLWycKrGO4VwPX4k7KCisf8Qry2OP3ceOtdADUF1uRm6I7Sb6sg97aDyG8sCNM0zEcHsbHCLIu1dn+iSQQ5wdJ0GS2wJwkpik0qT1qCNLkNfCO/k7mTWTbnNSAxsgNGlMVwtOqqDdULyYl22pVM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9TL4zr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9TL4zr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FE8C4CEE3;
	Mon,  7 Apr 2025 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743992196;
	bh=6dDjNCYltJOLLOE08ZsvzNZg9rdG/Se4AN13cxDZwq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9TL4zr02OqaGSGDdzZ5LSS5WmXcSqCezkC4yrg3bp138yebYb/U7OjFduOlqV1Gi
	 vMC0uKbeutnwpL/eQ8Er3wsSJ63GsHnWwFRajr7G3wqt6V+SFLZYosdYMRLIQVpHQd
	 oR5a3qjGiQLxjgNswRz/yeuHba1xhkPEwkuEeSsof0O9a9to/zauZzgOGBYkXeSZHR
	 8GJXYY5VJQz6WL7AXUqo06Ne50W9cyIO1Ljr7e6wB3HY7PLk2LC4dil0ewJ+1FC78l
	 FtinIx9YavdvrYpzz99TmlYTYfoyvOy9aKh06EuYsg6HbbruvkoJCxWMWtJpjynnbA
	 01SvUMmyh0GBw==
Date: Mon, 7 Apr 2025 02:16:33 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_ec_proto: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z_M1gVnbMlOcdOAA@google.com>
References: <Z-adX1BB30dcSJ7x@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-adX1BB30dcSJ7x@kspp>

On Fri, Mar 28, 2025 at 07:00:15AM -0600, Gustavo A. R. Silva wrote:
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

[1/1] platform/chrome: cros_ec_proto: Avoid -Wflex-array-member-not-at-end warnings
      commit: db4ea66acddf95b4bb13ef17537097820218fb7a

Thanks!
