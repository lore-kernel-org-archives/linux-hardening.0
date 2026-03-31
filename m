Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FC2F60CC;
	Tue, 31 Mar 2026 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001087; cv=none; b=hNqFHlwNwRLOTxe6xu4vdixlncLrOI/+0fa0RQ1CnRXgJfL/Mfh8/4+qfOI1iAKLXYCzgmdtV66Jqn/+fNwb35jotIrWGDZubPculU/mBywVXRF/1x+om/eyGoWM/+ThS0e6s+qzhZ8+VSFwzXkkOOCGfh+xX7GBrhxl1Na5WAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001087; c=relaxed/simple;
	bh=Egy2oSkeq5sizJrXZhz7SklN2vaJx4xQWmbakrjq4Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkgYq9SmvIgxbyjIBKiJx7BiG2AqLCdMM0I2kRU+b3xZbpzhYGCgZYQehwbI7z0BKWT13QvOUDMJKUuIllvkUFxf4fE/i2bSDB3GeVX93qJjQG3gtzJJgIx89ZvTdktoPwUFwLUC0yKn33Ktydb19UenPIcMCe+BoV6VEEV/uLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBvF2kSH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBvF2kSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111B7C19423;
	Tue, 31 Mar 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775001087;
	bh=Egy2oSkeq5sizJrXZhz7SklN2vaJx4xQWmbakrjq4Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBvF2kSHYIZstHCjhAT8oYw7b2dXBTavOcLH3jSf2NA8tRb8MYNlJQrbKx5w6xCjy
	 N7nIicZ8o4VdldAMtd7XznbYTHF+46YILW5iCsnZx+nV4lKGrQ3VYhiT5qkk2vga8c
	 vLRS9TYhJmdMZjWLeBZXFJQt71O/FJCkvJPUP4N579sLSCeD8TSrdeDx8wTBRPaoGK
	 COR4jUjhYwvLiWMejl54JmE0NhTlKoAWMTGZuZvWfDauBtpDsQr/1cy/DmMlWRl/t6
	 mommAczdaXcpeYlfTaTc9px2iHpflTHUUEs2aNtb2yo06geLJ2QWTOmQYgt4nom/Gm
	 7iWicUnFreDyw==
Date: Tue, 31 Mar 2026 16:51:26 -0700
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 2/3] fortify: Optimise strnlen()
Message-ID: <202603311650.A59396A@keescook>
References: <20260330132003.3379-1-david.laight.linux@gmail.com>
 <20260330132003.3379-3-david.laight.linux@gmail.com>
 <202603301650.E7C1536632@keescook>
 <20260331230914.43698e74@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331230914.43698e74@pumpkin>

On Tue, Mar 31, 2026 at 11:09:14PM +0100, David Laight wrote:
> Any uses should be replaced by __builtin_strlen().

When I looked at this before, __builtin_strlen() flip to run-time strlen
on non-constant strings, which is why I had to jump through all the
hoops to avoid calling it in those cases.

-- 
Kees Cook
