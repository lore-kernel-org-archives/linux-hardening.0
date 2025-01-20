Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065E194C78;
	Mon, 20 Jan 2025 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407326; cv=none; b=rQGMY+iC4dQE1e/r6LndzqwpLU1bAkq+jxGwXc9IWfu1iN1zvwnwjMSi6b36aixMyA+pTepjnl5clcRec1wfTiLDcmQUMifM6qUaoZU0u2Qpe0kxSq4OpGURUAfh0b9fXl768su8XtVJY6PbFqU111oA6VSAqtQa3FTgdtkL570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407326; c=relaxed/simple;
	bh=XUGGNdq/0ifsTM4G6k8372salwzo/rMe7ksQXCbnqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDxGvdd3WqrkkHpcTkkcV/V9wYoDp9ULQFdEvduVwntnagb0f3hqpzZVFS7mdZFEkTacQF7YC29HVJTr1c12g1pI2vbIWQCW72xt9MSFOEneuIczfjue2NI4CsiLHYn81BuzxRwBjdrfuzm2HGx4Wh8nQWUJ+5BnoJn+CxpHr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hib4Jir4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hib4Jir4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38661C4CEDD;
	Mon, 20 Jan 2025 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737407325;
	bh=XUGGNdq/0ifsTM4G6k8372salwzo/rMe7ksQXCbnqy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hib4Jir4XmFVTRxMP8h9ajgXunXp1gTrPpY8Jwyo+Q3+Eh15lG5JmHG5gb7ZLFFCk
	 t8LKjhhgnHkFhuww/5uuUyzCH6gbFDvAK9OwUU0nkh3jBbRVD//tP6niwzkcpASUxX
	 L+XKmPSU2PtXFBjaNocvPp4LRvb+rXl13hbZWq2craoZd4r083te2k4JPSvDUTuOva
	 TeWpVknid8QT1dniY7hFMe0QQDSH1Vto6WHdA1bjEuoHv8tvSQwcp1TpdE5wwlunwq
	 A0ZlbxfwBgwghwhS07CyHzrGHFk8do00G3q+/Gi0LEl2Mif/gTbV5jUG6tyoAgjr1X
	 cf8NzscmNTBNg==
Date: Mon, 20 Jan 2025 13:08:41 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Allow default HARDENED_USERCOPY to be set at compile
 time
Message-ID: <202501181226.58FDDB7@keescook>
References: <20250117130337.4716-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117130337.4716-1-mgorman@techsingularity.net>

On Fri, Jan 17, 2025 at 01:03:34PM +0000, Mel Gorman wrote:
> Some hardening options like HARDENED_USERCOPY can be set at boot time
> and have negligible cost when disabled. The default for options like
> init_on_alloc= can be set at compile time but hardened usercopy is
> enabled by default if built in. This incurs overhead when a kernel
> wishes to provide optional hardening but the user does not necessarily
> care.

Yeah! I like this. It's been somewhere on my TODO list for a while, so
thank you for doing it!

Nits/ideas in the patch replies...

-- 
Kees Cook
