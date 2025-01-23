Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924671BDAB5;
	Thu, 23 Jan 2025 23:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737676272; cv=none; b=NpSNVj6Y6Pbwx3XJx9XPtP9Ox95xTP+QnYLNiHNt1qLsJGi+TtpCv7ZnABcxK4WyquEprm0jNCa6gFEjuQKfPf6qXY0ZQOeyGPoASriokzX0vsnMAPfeoXB4e2FgWqhppJ2a15K9zkDTaN10EZdwoq8VdcXlAZQ5l61+5UV4onE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737676272; c=relaxed/simple;
	bh=DT6oax769El5tLMXqfdJPrLfVYni1M28D02nz3sh8Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwxlUpJPf+Yycd6oyJ6I657FgbjAUzJJ28kIu9Em/d9mAfWvzbUJb6lgwbqcL8rJ/qcawvvOlZkooX5wQ8vJ/BwV6QPSDerk0MSSjy9f3CKGypZVZtzub05CJg88JPydHP82XU+WkSFH98sP9rYEUDOHwMmvWMw1aiN8T+7kjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUhy7IzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUhy7IzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23035C4CEDD;
	Thu, 23 Jan 2025 23:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737676272;
	bh=DT6oax769El5tLMXqfdJPrLfVYni1M28D02nz3sh8Hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUhy7IzYtWwCPOHMuA2Cd2Gjvleq5Yqmei09DkzBZKs91b8g4FpLqDxIxf9SEe0Vq
	 eaK8weE4Yhsf2IoKppHGFXOwjuUMN59ehvvS1swQxo8e1EeRI7SFChSKD0yFY0GCKj
	 PVqheZzuo5DoVymItpCbwKIHASqzex0tyKqwAivqNGWN52jdcETaxNlJCVNQKdaT3d
	 hWfC9xhwbuVRvnDT4sM0xJ5v4MRIfs9yNwGAFx6SzYfH+ZgQznrtPASkQ0JM3/4tAH
	 8ZGl+fdHnejozF75wQ41S5nQOHOf9j/uMznffh+fFP52jJtVpjMHfgpn2ulBwSLHwe
	 9QzXc9hnN4ZUg==
Date: Thu, 23 Jan 2025 15:51:09 -0800
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Daniel Micay <danielmicay@gmail.com>, Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Allow default HARDENED_USERCOPY to be set at
 compile time
Message-ID: <202501231550.1D3B9C9@keescook>
References: <20250123221115.19722-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123221115.19722-1-mgorman@techsingularity.net>

On Thu, Jan 23, 2025 at 10:11:11PM +0000, Mel Gorman wrote:
> Changelog since v2
> o Default on
> o Logic correction and simplification

Thanks, this look good to me! I'll get this added to the hardening tree
once the merge window closes.

-- 
Kees Cook
