Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF4224DC;
	Sat, 21 Sep 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726897965; cv=none; b=VLimP/E3DTUbfXiOWZEUHv6aZ5f3oZmyPVMu/8qcsB9LAIZ2AWvbF7CBminWEGtFLFQZ7dfKbfj6ox1+TLeXDVCyBkTaTIvNYJER1HC+6AFTgaVvIABw97tBA2/RgvYt5uxh1IVgF4eA0UcicidyBASpM/gJL/+jXCXTbVjGo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726897965; c=relaxed/simple;
	bh=0JwiFbtg8EHAbDcg/yeuaiSAQKmzYC5c9NwDR70TmFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqbFwkPdW++ZsWKV9WG4W1N1qMaptW41wpF55e63oHwlguyauC/TpnDoo0ntdPfrJhicJeFIYszAspyyqD2tbhcU0SXad6osdxlAd0q6/lyiwSCaEj07mbAoOmJ6VkVz2rV5wHsO/P3F4S9DS5eeRXShVsliYj7GWwufhXfl0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q3aFsQN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q3aFsQN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79952C4CEC2;
	Sat, 21 Sep 2024 05:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726897965;
	bh=0JwiFbtg8EHAbDcg/yeuaiSAQKmzYC5c9NwDR70TmFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3aFsQN+TywQO8cvtlpbOdPsQ6mQ5d9N0fm0DcZ3BjaiD8qLoAf7GKmioI2Kk6ME7
	 v/HGGKyJFoD2H+0empwT3w5l0Tsf8LsPWNDJ4YA4wqXSTAc8cLAui3hoMRNMAexTCU
	 spz1qyO1IWMigCjPMdcIF5lC2KD9PuxzMnDDN8J8=
Date: Sat, 21 Sep 2024 07:52:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] container_of: add container_first() macro
Message-ID: <2024092149-stove-babied-e7cc@gregkh>
References: <Zu1vekikKNR5oUoM@elsanto>
 <694a8a87-cc98-4c04-8228-d399133fdd39@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <694a8a87-cc98-4c04-8228-d399133fdd39@suswa.mountain>

On Sat, Sep 21, 2024 at 08:45:28AM +0300, Dan Carpenter wrote:
> On Fri, Sep 20, 2024 at 02:50:02PM +0200, Gustavo A. R. Silva wrote:
> > This is like container_of() but it has an assert to ensure that it's
> > using the first struct member.
> > 
> 
> I just remembered that Greg wanted this based on container_of_const().

Yes, that would be best.

> Really container_of_const() should be renamed to container_of() and
> container_of() should be renamed to container_of_helper() and we
> would add a #define container_of_const container_of for the transition.

I agree, but I wonder if it's safe to just do that already and how many
build warnings would happen.  Last I checked it was a lot.

thanks,

greg k-h
