Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652B2FA0DF;
	Wed, 13 Aug 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078939; cv=none; b=Nj4SyiyMzWFmNkPfTZoG+m7QNXqzL+Liw+tfXt4/C4BGTyK1BpDclcZK7G7EeMGA2INS9oXGC89i+GAVuFWCTYFJDEzemZSPHQWv9BsQqIj8eEJ7TGFaCJ8ZaUE1ExoyHnuqeNOwgxolH268+GFYTBV3avDaJ3UyK6zA8yaoG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078939; c=relaxed/simple;
	bh=RDsfFOpJsyTy7qlEBbtSozjXF6awxrszAO0Ud1U/2JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVLdrE1BGm8vT9inGEvLlRth/wsK5U+6bs9DbSWklMfx/7w5THt/Ji0vbNw4kw8xZbKzrMbXfAMGjbfpzy+e0oVqn/fzcl5Qby3c3tvgciMqTTo/AhizRVMrGDbXu34n041bRICZaMyUGTXuiYH7eBE1AJx1NiltBfmr2nG8Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP3ZUYQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP3ZUYQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4FDC4CEEB;
	Wed, 13 Aug 2025 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078939;
	bh=RDsfFOpJsyTy7qlEBbtSozjXF6awxrszAO0Ud1U/2JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UP3ZUYQcXPu1m7KBZR2A8x45TwDGxnr9HvGaBOfwUPkE4f5Qdqx8hxovaiIEKNcYL
	 vS85Vw4gHYV5qga5NNerIkgjzjthm4wNNTibpaRs/uOqPO1Re3t+yA9g2Lfp1/uv6q
	 7LRW36x2utf84UBAEm6RxjRHedtjgv/og7aii0fKimyBGav4fve9X+2tEaC08xKnn0
	 q3rV0sFvAMurdJE3m7CVQtmtUkDGIFdY9hjEveS5gX1HkYEpVLq0O81WWcioq2cs4f
	 0FzlDLbuq9r9V1heCIRoRoy4njPAUeapm9ErABiCME1MXkEy+1WjIvp6O5Z1Ypa4Hi
	 mhgY4m+RizeyQ==
Date: Wed, 13 Aug 2025 09:55:35 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aJxhF38X9dtEtRRG@google.com>
References: <aJnvuv334M7TljoB@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJnvuv334M7TljoB@kspp>

On Mon, Aug 11, 2025 at 10:27:22PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warning:
> 
> drivers/platform/chrome/cros_ec.c:106:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec: Avoid -Wflex-array-member-not-at-end warning
      commit: 8abbbbb588f1f1bf95ae56c1531a17520ce487e2

Thanks!
