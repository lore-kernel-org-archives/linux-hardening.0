Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4988522A;
	Wed,  7 May 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746583520; cv=none; b=KnWvPPZ+e0oHA2F8P9ntklPfjFMVy9814JkD0t7+6WOiMCPZtOaveGdX4DJZCa2vsszGHOUYAPl0QauPUvGIA+MzRUM20gOznhtx9bzTdN3Cgiz4DPDuSFN3dP0gVUclAzX70z0br+IWv4WqZjlYKIMInfzqN09tY7z3ntCj1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746583520; c=relaxed/simple;
	bh=WlKs6VdhdilVeQ5fH1FUm26YkiIMzwBMmnph7tGjo6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbS5nf+IcBV2Ymmc/snZYRet4HC4ysOv9ISLWa2+1KYOPK19TtzE0QooKpgALBFT0ZNaPbSBwjbn8mUBmIr1GkG+/K/CWFBuENkN8vkhyK4GmIZGswa4PyBkiuIid/klIycS8+APdrFmZ3rLFDowz4MYXuDTNfDMPOQXbRbQV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qto8T41H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qto8T41H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2775C4CEE4;
	Wed,  7 May 2025 02:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746583519;
	bh=WlKs6VdhdilVeQ5fH1FUm26YkiIMzwBMmnph7tGjo6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qto8T41HXMc46ND+5Me2BRz5eLAgGFWDZMuR6CXJ3CvYpgeL3LN3v0Yp/xlqPokpa
	 MqIJZYotvHOp2IOMOemj4DyXjv+TSp0HjKEEYjACyUIrVNeYJZ0pw9KQVe1mkcPEsp
	 wBZF11tQXjwwuSf48t7g7fqsPjoeDxpOirp16lLr/IChAHZhA63kI24Dnucb5JCMPJ
	 E5kITWrDAQE04jKzL/iM9Q8HlEgrB35iA5W3FeHAMMtwJxvTJGu/7uvJGoig2rLPS0
	 DDFYDpf4KkhQPk68VkEZGrMFHbwuh+2hc1UZzdQCgfVlpAmnqWcWMDUthjQiqCrf4m
	 gAcuqicZiLhiA==
Date: Tue, 6 May 2025 19:05:15 -0700
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Move devlist.h out of obj to always
Message-ID: <202505061904.BEFEDC8@keescook>
References: <20250423023743.work.350-kees@kernel.org>
 <1f7c8220-09e8-42ae-a611-9a21779badaf@infradead.org>
 <98d34958-e57e-40df-9196-920d40fd57f9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98d34958-e57e-40df-9196-920d40fd57f9@infradead.org>

On Tue, May 06, 2025 at 08:54:29AM -0700, Randy Dunlap wrote:
> Hi Kees,
> 
> On 4/22/25 8:50 PM, Randy Dunlap wrote:
> > 
> > 
> > On 4/22/25 7:37 PM, Kees Cook wrote:
> >> I put devlist.h into the wrong Makefile macro ("obj") to get it included
> >> in "targets". Put it into "always" so nothing tries to link against it.
> >> Solves CONFIG_EISA=y i386 build failure:
> >>
> >> ld: vmlinux.a: member drivers/eisa/devlist.h in archive is not an object
> >>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >> Closes: https://lore.kernel.org/all/4a8ba1d0-d2d9-41f8-abf1-d45ec8996d10@infradead.org
> >> Fixes: dd09eb0e2cc4 ("EISA: Increase length of device names")
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> > 
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Thanks.
> > 
> 
> Please merge this patch. The build failure is killing lots of i386 builds.
> Thanks.

Greg, please take this into your -next tree. The commit it fixes isn't
in Linus's tree, so I don't have any way to land it sanely in -next.

-Kees

-- 
Kees Cook
