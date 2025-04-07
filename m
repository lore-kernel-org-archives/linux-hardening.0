Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4FF9D9;
	Mon,  7 Apr 2025 02:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992148; cv=none; b=DL3cr0RpHWT2aIJAw7zgXkB4igSj/EpbNK+i5N2em8CllgC8Swf35Ld5lwEIvEwDNyX9yxGE7SbG9hnOmpjREDWeQqD3MXxz2wZBWK4dlQ7YpS2lkvPxNrae5qCBcdsnp10YXGELJF0B6r1pKYsshnjMHayoh6vcalbYF8bYhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992148; c=relaxed/simple;
	bh=fWVq5GxNBvK8jcQCgLmMrPyyOGcfXN2mrSWkGFj6nBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK/wc5HWC1rNOrBFFpUfh7CuG5hb8eta9T/+RKrXtH3Kc3oXLfAvdaf6o4SaDOMp/+hjol4o1RlRIAOgYGrEEn2lc35Wc+WUi1r9Ji0z7Dk4zDC+97PTajEjp8YXCKfUbdadv8uro/SSknQxLN9RuqYlkMCiD+nHgeTqupQUmdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi8FdyHR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi8FdyHR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA9EC4CEE3;
	Mon,  7 Apr 2025 02:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743992147;
	bh=fWVq5GxNBvK8jcQCgLmMrPyyOGcfXN2mrSWkGFj6nBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi8FdyHRUkPGHvXSqzgIRll58FpcbYs15TQV/aiz94P+kMnPgbP6uFI3PXMSLt7WU
	 YQ2wa351n4bXUNLE90ZH53RM97hG1ouutMa+LONDKlPy9Qii0/zNHW4jjvzPmSrSS9
	 RHYM28yGx5ZIHtfYQ/VFx98nAL27bFCxnuy29230Ow88J2sHhYZEhyoQzGoDP2Vd/a
	 G2DK2JB1W1GEJreLhhn62r3YEJ167T+cVjg4++Pf+VPJiICBJH5udKeZ0nDgfPupdz
	 O9GpWZtVapZa05eFedBDfzigqEAPO0Mc3e0FJfZRxvuNqZYA4W18Iv89NorrR+4o1p
	 4hiaGYuZXA4vA==
Date: Mon, 7 Apr 2025 02:15:44 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_ec_debugfs: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z_M1UHK3x7h_Zlb_@google.com>
References: <Z-aiAAcIP7sBRtz0@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-aiAAcIP7sBRtz0@kspp>

On Fri, Mar 28, 2025 at 07:20:00AM -0600, Gustavo A. R. Silva wrote:
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

[1/1] platform/chrome: cros_ec_debugfs: Avoid -Wflex-array-member-not-at-end warnings
      commit: da90147bf52b7ab6d8f021418496a7b6f39b2249

Thanks!
