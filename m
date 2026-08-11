Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02730FC1D;
	Tue, 11 Aug 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410007; cv=none; b=H3wKTxhBV6OOdnj5xg746yhQ952wHN6vZ9tK12Lw7GhweVZxSFRkX/zTH9evDqdSZ93JK5UQ7/fneXWyNrcbuVdpSF2nDRydkEJ3hpLVf7DctyGgM/pzD5IDiDd+yc9gdnnw/w69pRnwOAWRX/CQwlhwz3OjPuylvU2i8/NXQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410007; c=relaxed/simple;
	bh=bMYJylBqjEriQtd9ENfhJv53+nGA/0e+7d9Y04JaFVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXiW4TW1cY2jwCsoSO2pjgD5uEqB0Cv/ao5uBA0S8/hbjE+HtdzI00m93q6L72z5gEuY9i8SacpsoYDS6H3/A2OP+1KkVBpWqMmxI0GajesZdWMRaEcMDAxZUyA4UXl5xz5XZQzj0XrwMCs1dnRmtuzi0kwziMjlBRbLgFgSPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Hv/v1RxR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hv/v1RxR"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6537B40E01CE;
	Tue, 11 Aug 2026 00:59:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jLrfRAKSsObh; Tue, 11 Aug 2026 00:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786409988; bh=Lf3C+oxNqr+NpVsgP4F4v8pUAT3l0d62sbWcQVSWenk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hv/v1RxRdhZyUn18WHhUoxjJgQ421BLnCSmE3MwtUguDTKb6SH/+WGbZTvL07ZC59
	 up0+TnZBgT7HQjLtHgSWxy04sY51Rt6pCby6di43tJ9yF+mr2I1HgACW6WzsT0gSn0
	 CZNkabJc2I/sNPpf9hWszAw25y0yeuQXLwz8AiIiQHkEHLs3k5cWaOYGgoAUcAers+
	 siBC5kEnxVckQB1M0TRDa3v8DlLrEA+EgV5nJtAKyWx0tinDlGX0Di2/uwqySph41E
	 T2wFIhzJlx7L82Ih5EPbv3BL2Up5SXXpr4H29S607dRAs/Ebs4p696f211/s6GWyCC
	 cMAYL/+LFh0EJXZAjHzAUrZuzJBL4+ZvZoUm2oQneNbhP7GbjmAtBs1Mvis5cygy6Q
	 jhQEr+1GXKih3zPG7pKcnFOq3YAyGLnTShrWHtI4cD4b6zTcwCjsbsqmlT+ZJM46B7
	 VTow96G/7fCU3X7rpvU7ShnT0/X6y4gPWB7f6W4S8IuC8HYKZEZWu0ufsFTA03UDUQ
	 A/Lk8ueDmuRo6aqIvZYfYQrb/XB7MBWRwRP+O9PbOh9hakqckWerkfWZECEMToEeOE
	 wFYhpYbQ60Ti82dYrmfNHZrmZEh0hhEoXKPEFbtKPX4XTXHabWJaDveCyRXZEB+wZv
	 mQXrMiLvbSVMnQUbgqyFnL1k=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A928F40E016E;
	Tue, 11 Aug 2026 00:59:41 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:59:38 -0700
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rric@kernel.org>
Cc: Ian Bridges <icb@fastmail.org>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EDAC/thunderx: Replace strlcat() with snprintf() and
 seq_buf
Message-ID: <20260811005938.GFanpz-lT91PuwD08_@fat_crate.local>
References: <akYJUdY1hVABUQH6@dev>
 <amppKvK6mIJRmoL8@dev>
 <20260729230035.GDamqGE9bKD5ncU6ZV@fat_crate.local>
 <annRsN6UBDPsFLr2@rric.localdomain>
 <20260810134506.GAannV4uJN0I1UXh0q@fat_crate.local>
 <ano_uQtMIjcoFcs9@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ano_uQtMIjcoFcs9@rric.localdomain>

On Mon, Aug 10, 2026 at 11:16:41PM +0200, Robert Richter wrote:
> > Author: Borislav Petkov (AMD) <bp@alien8.de>
> > Date:   Mon Aug 10 06:40:13 2026 -0700
> > 
> >     EDAC/thunderx: Orphan it
> >     
> >     Robert doesn't have hardware to test patches anymore and no one else has
> >     shown interest in maintaining this driver, so orphan it, for now at
> >     least.
> >     
> >     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> 
> Acked-by: Robert Richter <rric@kernel.org>

Queued, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
