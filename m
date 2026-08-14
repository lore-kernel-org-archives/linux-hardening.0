Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFD13624D3;
	Fri, 14 Aug 2026 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747555; cv=none; b=rGX8uCAiT0M/fRJi44i8Ij5hZ5XU4vkw+PqMbjCRazxptpwhp4wR+H/AFO7vR3QbfL14pKDVm5VZkB0pMDif+PCi2EitULlox0kTqXqN3jWMLodParUOCq3ChQbH2CUaLXlrEn/SxIirajYFBwJA4UIIm+Omcb1K8nwva8IwtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747555; c=relaxed/simple;
	bh=51kq8+fU7ZXt+Kx4T7Z9DIDcAVP9bEdUkbChMtEBwhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCCmj6eYuvjHZw4SgDkl47LlJbM/JtJu08eZsJX5J3ovQyrKIM1kFyQMkcDI09IG3kOXhxC6Ekl9j5+FNYxXxXQoVnpQdPe6gZIxDSYYqRp2sdbdVl25esAnIC42PcllHfyRW5tJxfNOcaWbl9gD+BqnLe5TZuFaKlCD+mXb1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuUv7Iv0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuUv7Iv0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9331F000E9;
	Fri, 14 Aug 2026 22:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786747554;
	bh=hyKuN0hRqRk7tq722Y/Nt40SJ77hxdLkdY3x6UdGuc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VuUv7Iv0Huen9RPRUlDVNlpHDrdPRj3Tte9AxS4dPVCyauVCMWvAl0fMV5AqbsGHa
	 Q8ZZa4szR8K9llQaKYJhnbi+kc7Auro8R0kWbNHTPw8U9Ag20sjuOWXQV89kbSw8Jg
	 Up4nX4y3edzc6MXd3WqLvHfelafQeSed202HyVnOL4Po/QbOo+nhZNJl19Heor9w2u
	 YSE9ebEJZLwiw/zeUDHuq8yzt9NT06XNhzsdDzNHBRkuc9HscN41v00KzDiXkpQuTn
	 O2XoV+Gy9lMO5wYhimh3mAuPJKsB3fj2u83+uaat4diTEjIeGESg6Gj4dEJtJyAj2n
	 6TzSPlneBRs1Q==
Date: Fri, 14 Aug 2026 15:45:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>, Kees Cook <kees@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kstack_erase: suppress -grecord-gcc-switches for
 external module builds
Message-ID: <20260814224550.GA3553101@ax162>
References: <20260803181217.GB1067866@ax162>
 <20260813082949.1622045-1-jaihindy@qti.qualcomm.com>
 <202608130942.4FFA5AAB9D@keescook>
 <CY5PR02MB8991D4B48F9391D1849B2CFCE2DA2@CY5PR02MB8991.namprd02.prod.outlook.com>
 <an9dBpYEIb4GWhAC@levanger>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an9dBpYEIb4GWhAC@levanger>

On Fri, Aug 14, 2026 at 08:23:02PM +0200, Nicolas Schier wrote:
> If there is a need for external kmods to to have 
> 
>   make modules KCFLAGS=-gno-record-gcc-switches

Ah yeah, I forgot about KCFLAGS for the external module build. An
external module could also include

  ccflags-y := -gno-record-gcc-switches

in its build file as well if this is a requirement of their build setup.
Perhaps we could revisit this within Kbuild if there is enough interest
from various parties.

-- 
Cheers,
Nathan
