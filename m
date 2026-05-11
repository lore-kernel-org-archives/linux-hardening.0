Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D94D2EDA;
	Mon, 11 May 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527137; cv=none; b=XUl/9ua7c9SJthdEe1Ph2VeyG9eBg/c3Q16nLsP8mZHF7D/YDIFWTaH8x5Jj6oasB7/9RmBSFsAU6oGwRk7Zc2g4a7gihBBF6wBYPVBHDjw+x0+TrDPymQuw4G6a6IQohyOx92AAx/Dc7kjFOKTFDbskMwkBNo3UtSsDf9gLebk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527137; c=relaxed/simple;
	bh=UyXiW1P+qYuQsY71vmkKDd/PSp+hTb3luY9g2u6dl5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAptfRmOA0N/R1ctZ+PDzsW65zZsOYAIV2FIhLckpp3wCdG6sjOkw5vi9kDd/ikpr/5pbar4UPa2/QLkDZdzhPhJXO5tfiE1ormVYUEm82PnRwUgRuvddXOTH9oCewsQXF9gpscXG+u0ehvpWzlwTImmTAX+wu8/kEOUyrgWG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xlhq4r/p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xlhq4r/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A2DC2BCB0;
	Mon, 11 May 2026 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778527137;
	bh=UyXiW1P+qYuQsY71vmkKDd/PSp+hTb3luY9g2u6dl5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xlhq4r/p8MNUIbGIBJ88dhf/xRLbmUg5gcevXwzZ5LRFq1cM+T/XBRGxgpZrJsGPE
	 H83rZqrcvg9eYqDfEZxnt09gIqx5qt5uMnbPeRbOwgopS2nzmv4m/WC6DXawl10zzS
	 GNkZ9ZWFrMFqt0CBoj7bXBkbw8CvuLC0pWugqFVVMd8cvXXBbeMxFLy+e0upv15g0f
	 MSjbUFh081bborGBVCVfZc5q79bbpzpkxvz6+l5Y/3VGIz+91PZXtSSiL1btFOelPc
	 FJdkPzpO613fvHp8ZS+Lb1H5ULVdEee/6sLrFbxF3UJ8lojmRadJsiET35NN3ebpwj
	 JzpfH9vhWz8fA==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] stddef: Document designated initializer semantics for __TRAILING_OVERLAP()
Date: Mon, 11 May 2026 12:18:54 -0700
Message-Id: <177852713147.699524.16456484510741382829.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <agD0R-kNbg9YMOCT@kspp>
References: <agD0R-kNbg9YMOCT@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 10 May 2026 15:10:31 -0600, Gustavo A. R. Silva wrote:
> Document the designated initializer behavior for overlapping storage
> between NAME and MEMBERS, and clarify the implications for static
> initialization to help avoid unintended overwrites.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] stddef: Document designated initializer semantics for __TRAILING_OVERLAP()
      https://git.kernel.org/kees/c/3c7495593752

Take care,

-- 
Kees Cook

