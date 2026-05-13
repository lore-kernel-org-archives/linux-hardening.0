Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6D136358;
	Wed, 13 May 2026 04:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647645; cv=none; b=QFATJReqyptpPmR/SnDb3ldZsM0Jh3fq3ZHItI0hPeXcFOsruIK5g8I3MBT9fEd3RsnJNHhnQJBXYsYWxL/1HiSOftyQ5Q57cAf3WPTK0DY4J26dUNRyu7GmFujFES8+rXpN51rRKAYxYZX4JMuLx2wthw0IsZJ7ouGNNxeOlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647645; c=relaxed/simple;
	bh=EF73rmMsHNn/rUjZrvZ/O9Lh4cEfj2tKSJODcAPsUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8fEZ1P/ij70wMdBc7xszVWtCGdxDrJuHGnhXIBe9o+36TBHCU1wrRUlpuVyUZUsMKPtWvbKWEMjHro/sC6B9D+HeGnBCyX3Yke/KC39UABOu/LqEGErUhK8vP7loDZzMendmJ3JzfjKZn9R6lUcohnIZaYOC8edlQZ6M5JhEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzfkfsBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzfkfsBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1574C2BCC9;
	Wed, 13 May 2026 04:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778647645;
	bh=EF73rmMsHNn/rUjZrvZ/O9Lh4cEfj2tKSJODcAPsUuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzfkfsBTW+gxu99znVD11iOYUnhojAJvvR4wyb9dRehrCJ/kbWi3T+hlc7LD/hlXs
	 yIhOXrUPJjMhmg/Yu6pyWh98aUTjpJJ3xPEf4gUukKXLOQOyTyH+ak08SLYRQQI3Bm
	 z6AtL1R8Q1Cd4ajsNjeWyujBqmpxuNeOxsYCrj7cbanYbadnx16oExMBBlVu9Ajedi
	 5AfurjJ2sUk9PGtrWmObf5OCNuhjDttd+87lVZ2ynJiWmnfJ/REuIlDu6ekjFS2YQ0
	 eaCxrdbGo7fS9rOm9Fljfc/bwzhSqDra3Kwsm4NKVwU76ns05NW9VTg9/GNR/3wyZu
	 Zis96hKj9wn/A==
Date: Tue, 12 May 2026 21:47:24 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH][next] stddef: Fix kernel-doc/Sphinx warnings for
 __TRAILING_OVERLAP()
Message-ID: <202605122146.99F15142@keescook>
References: <agOA1PDX2h3PNhl2@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agOA1PDX2h3PNhl2@kspp>

On Tue, May 12, 2026 at 01:34:44PM -0600, Gustavo A. R. Silva wrote:
> Fix the following kdoc warnings:

Thanks! I've squashed this into the original commit now.

-- 
Kees Cook
