Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6874017E006;
	Thu, 22 Aug 2024 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371140; cv=none; b=APO/eKPSEcgH2uOcktRzp/ZP3MZdr7n5f0bR4Bda+qcKdfWXC4RZBpqsrPKgaRMhIo/zd5BonvqqAymznENcllgZsss7xiQjGZzaA2Bq6cz762uwom3G0OBHOiKp+GAIvpIaES5YN4Zs3HB+ItZkHZr+HmfUn/f+EdPlYJaQrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371140; c=relaxed/simple;
	bh=Nfgs2H18rvyUT4iPuxAM3mDp2uiilbwcNp7VD1Y9lrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbaLE0BkpC+OOelHD03Nf1ik+UcXDQlrI/8peozWK3Pl2XmEoXzE+XQFmSVm/TfqogOMnkMcJwR5BGT5oGTpotm/7nEoeBZjZqNdeHYcdQxPYJESI36KLQHdZuS8EaDVOkw/hAEUXOr917kwCPh5ZbCkyvirlp2W9Z1ZMhyCYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh4bT3Rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh4bT3Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4642EC32782;
	Thu, 22 Aug 2024 23:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724371140;
	bh=Nfgs2H18rvyUT4iPuxAM3mDp2uiilbwcNp7VD1Y9lrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eh4bT3RqlOhQlt4p1pqlUIwcrozDq4tbJPh4LRq5KSV3qCWMQMbq39xYG8/WVgbO3
	 7AKU3wfohF8shsrrKu01FYueDtuKww2fLlYu838ifM2B/v1rVywnIjNAkwT8vVjyrV
	 jXDLv4UQUKIzks07oX8omNTlj0WWcFN7B9ZDgWwOrA2+TRRTuXVoD/mgD/DAFIfzdW
	 6s1516MFxMfFfU1oRz0l2JnmJSjNeIOYhHxezay/If6Cg33YdEALVLP173P2EPblRF
	 xWmfmNzvte6ALXXdKhc3r4VRnS2u1VjP2Uyi78llZ+0clmeQRr92aGBXruRFSBAg1N
	 cA4Rz8Q6c9pmw==
From: Kees Cook <kees@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: struct vmmdev_hgcm_pagelist: Replace 1-element array with flexible array
Date: Thu, 22 Aug 2024 16:58:53 -0700
Message-Id: <172437099981.4120913.7515639803730422686.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710231555.work.406-kees@kernel.org>
References: <20240710231555.work.406-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jul 2024 16:15:55 -0700, Kees Cook wrote:
> Replace the deprecated[1] use of a 1-element array in
> struct vmmdev_hgcm_pagelist with a modern flexible array. As this is
> UAPI, we cannot trivially change the size of the struct, so use a union
> to retain the old first element's size, but switch "pages" to a flexible
> array.
> 
> No binary differences are present after this conversion.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virt: vbox: struct vmmdev_hgcm_pagelist: Replace 1-element array with flexible array
      https://git.kernel.org/kees/c/5ac86f0ed04b

Take care,

-- 
Kees Cook

