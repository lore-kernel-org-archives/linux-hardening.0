Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCC280038;
	Tue,  6 May 2025 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746557507; cv=none; b=KVTl6PCy1i6CV+BzYS1K5p4msLpEC4BANaQtaMsbCEQeINfzfFmw7kLxvMy1ROFFMJEWEWFChWQs4nFU8KzQT0sWyoXCySNzja+0Z7plD+lmFZTA/bkOtm+9ba1icm6HpbwUOzDeo48TmifkrBe4nemcl9JKAMxzJ8uNxHH73JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746557507; c=relaxed/simple;
	bh=wPDzA4ttC/R1/Xii+RrgeoEAZdmrCIsBbsqW2vY6e04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpOTd8NOJzBpfI9RNppMu4DkkfRC2U+gLZa8QvtrHlW7S719Vz5s2gpR7yStDFGNX/OYwXMYYPPgHcFf/B3JjuLBVxMp83FEe7YQ+eDjw9t352BHbbwWMl7SoU48Zf5Z5qKDpVN9zD1reHPO8BSKsjgJEBbgq30mM2X91epqed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBU7xYV1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBU7xYV1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272DEC4CEE4;
	Tue,  6 May 2025 18:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746557506;
	bh=wPDzA4ttC/R1/Xii+RrgeoEAZdmrCIsBbsqW2vY6e04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBU7xYV1dcLl3JAwncJb16XMauTkGRSxfcWBBl8eu+oHrgXS4LfdllabVK/qQnCAf
	 L9ZutjQuzKiLnV40+EbAlYA2CNSXWyYvUQpjMTfDWioLR23RZhJZ4fZoCBZ6M8yOWQ
	 T/cz+UCuAVUysY81pPhNirDju1qbzjSaeqOAVa80gyCo0mYfuHt1+Wrs/cL37pR3br
	 VUlHJrELOtFyL7ktbW4jQ528YjCbTW7p7i2domC6jaqfe3NUT68VIJpHnf5JHUpg1k
	 itWNaKMUP1w5uBZtePJ/GaFEy5fKGNUUbKePO6qrlTwge1K+BJowrSCckSbMAiH4rm
	 zQqYaxZsGc+rA==
Date: Tue, 6 May 2025 11:51:42 -0700
From: Kees Cook <kees@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Move devlist.h out of obj to always
Message-ID: <202505061150.4B9A78AC13@keescook>
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

AFAIK, this needs to go via Greg's tree, but I can see if I can send it
to Linus directly.

-Kees

> 
> >> ---
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Alejandro Colomar <alx@kernel.org>
> >> ---
> >>  drivers/eisa/Makefile | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/eisa/Makefile b/drivers/eisa/Makefile
> >> index f0d6cf7d1f32..552bd9478340 100644
> >> --- a/drivers/eisa/Makefile
> >> +++ b/drivers/eisa/Makefile
> >> @@ -1,7 +1,8 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  # Makefile for the Linux device tree
> >>  
> >> -obj-$(CONFIG_EISA)	        += devlist.h eisa-bus.o
> >> +always-$(CONFIG_EISA)		+= devlist.h
> >> +obj-$(CONFIG_EISA)	        += eisa-bus.o
> >>  obj-${CONFIG_EISA_PCI_EISA}     += pci_eisa.o
> >>  
> >>  # virtual_root.o should be the last EISA root device to initialize,
> > 
> 
> -- 
> ~Randy
> 

-- 
Kees Cook
