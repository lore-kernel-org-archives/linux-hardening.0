Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42139199FB1;
	Wed, 11 Sep 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077582; cv=none; b=oAmxOwMTK97+TiKEhWRuvfGGOwK4ABhTAes59B3X71WMUStrIPmwIqm24ul3O+jUO7IRg2IoZWZISDUuwScR69UKWKbOKmOdX9R0JYcWrkrKyxFRhC3YNjmoAdt9RmPiGlq0bJ+V6zfOvudNmahxuyg4zAECq6npia1IgTtiBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077582; c=relaxed/simple;
	bh=aFYF4gHVnxsjme0qIzfmOz16G3996uXo9BaiN/a+rxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cizQmcunXeWY8BimzRjjmZO3XWmsbAqdeVip8Y93VuCbad/TX3rBlphq7hTWPTJu2V4OCqbSFJHpeFSArI4Dkev+xVPUUrLAgdu93K+PWJcv+eMmF5mSy7AulGaR3wnVKGRH1zG9zsM1imjbovs4NKRlpTGk/jlc8anmFS0cCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyVxaK88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyVxaK88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C66FC4CEC0;
	Wed, 11 Sep 2024 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726077580;
	bh=aFYF4gHVnxsjme0qIzfmOz16G3996uXo9BaiN/a+rxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OyVxaK88r+ziEtLuyVQ1IvUf9L8uN54sVQSdF8kMbQcAXXxRpc4f/YoSJlwrMGlz7
	 LUmzUMVpxnPNTVmRI7EUE1nnxrwwafziVpnOq8an6kgDS6MLPJglTk+jkQ974ERgt0
	 s856zr/6eu0xc9k81aKACGN0+o52OglGI9I0i1Y9fSW4SMtIshnv1iqw8zM+qED5Ki
	 kuAP+n61HQlHWlGN5KDfp9zU9z4xPNWTFNkY2Zky8NwRAPCzl3JqjdXIzyww8ffDg2
	 fMjEHxm2tD+XSkwdV5wYp/BQbpSQFAyeTHQrmKqj5kILjMgeNjuEAIF132oH7a/smZ
	 EDUvG6lUfa6PQ==
Date: Wed, 11 Sep 2024 10:59:38 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kees@kernel.org, gustavoars@kernel.org,
	andriy.shevchenko@linux.intel.com, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <ZuHaiiMV6ESS8p7z@bombadil.infradead.org>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909162725.1805-2-thorsten.blum@toblux.com>

On Mon, Sep 09, 2024 at 06:27:26PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> attrs to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Increment num before adding a new param_attribute to the attrs array and
> adjust the array index accordingly. Increment num immediately after the
> first reallocation such that the reallocation for the NULL terminator
> only needs to add 1 (instead of 2) to mk->mp->num.
> 
> Use struct_size() instead of manually calculating the size for the
> reallocation.
> 
> Use krealloc_array() for the additional NULL terminator.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Use krealloc_array() as suggested by Andy Shevchenko
> - Link to v1: https://lore.kernel.org/linux-kernel/20240823123300.37574-1-thorsten.blum@toblux.com/

Applied and pushed to modules-next, thanks!

  Luis
