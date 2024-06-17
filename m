Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7E1D952E;
	Mon, 17 Jun 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650589; cv=none; b=Wzgyoiiw4JLWvDXcmqdS3s+uy5NJBt9Q92YRVE9rNXXAhLxvXXX4HLcyaafut38v0oOkwDaTNqihsU5xHKtWXDhX24J+UemuMGVz/IjpFp1ywKkekwrb3CTNeYvA5Xr0I/1yp4KEDlhPe2Ql2a+MA1iEwDUsi/qvMkJF/dKCseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650589; c=relaxed/simple;
	bh=bKNppUxxKGEIy1ouTAh9i0V63PIWka7DyWL7++tE5yQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqwhIkZPT4YBdn2ibzsmapqmo+gYHWrPmiApeP281ESSq7Z6QJGZ2xUPLAHXjgZ1B6IDWBGhfhF9N23qni9n8WG97mnFPQkz9msKcYurh6vZBoOLaMmHWPjtgHEkgL8b8yabgWXgYzA99mLthZMqE9+p2tG4Cvc/wCpz6gJq444=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIfpDLmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIfpDLmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F55FC2BD10;
	Mon, 17 Jun 2024 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718650589;
	bh=bKNppUxxKGEIy1ouTAh9i0V63PIWka7DyWL7++tE5yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIfpDLmhMMDsPqxUk0E6Akv7LnRXXCnAt16io00Xj7L69X/I1e3cwfFJjlZe2KnUI
	 J2JtFjDJNdnudsw1Wx9YYomu8fUB0xtBwv1y7snG1rBvuUMB0Qtg00/EF+btCbT044
	 tita4PlBjYXSeX4V9Gj+YdxgvLZFVyFPgiMyk/voxk/l+4rxjX/aTDUddi1VnAUaxQ
	 VXjgTNOPDvBtT39C0y8gw2qquwsV/mBwiobtYDnc3bhWHWzKEkH6a6zRQ2kg8/cYfD
	 VBXTqZpA9FI1yh+4Zghe+czNofV1lbCtGUAyOIy+zOg9Gui1Rvgc4F9Y6+4p0PEFv0
	 HZLCmm0hWR2VA==
From: Kees Cook <kees@kernel.org>
To: Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Guo Ren <guoren@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pstore: platform: add missing MODULE_DESCRIPTION() macro
Date: Mon, 17 Jun 2024 11:56:26 -0700
Message-Id: <171865058448.3345201.17964840514906140887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613-md-csky-fs-pstore-v1-1-c525f636b1cb@quicinc.com>
References: <20240613-md-csky-fs-pstore-v1-1-c525f636b1cb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 21:39:42 -0700, Jeff Johnson wrote:
> With ARCH=csky, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/pstore/pstore.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore: platform: add missing MODULE_DESCRIPTION() macro
      https://git.kernel.org/kees/c/9b3c13c9ea4e

Take care,

-- 
Kees Cook

