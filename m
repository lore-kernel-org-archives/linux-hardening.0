Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6A376E5;
	Thu, 11 Jul 2024 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721342; cv=none; b=Ko8U/+eK1y435iVwSoRNnj03lAbNIRn3dbgG8acO7qN/my7MfpTRsJ7Af21vlU1st7EgyohP8Lc/H3JiSL24lBmnil/ljDooICEclpLcdlvXR5dabYWWe4gYlQChGhaOXKeWTlszbJbpfSZ9aFbiH3saq3EtfgtWdFVBV+uhXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721342; c=relaxed/simple;
	bh=NXZRBWqNoRIQfyGRhSwWqVwr8stM/YWB7s+aam2b0RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVKZRUfaQgd06lDnhGnr0eqjxRYjwUeXelmtv2kI9USbZCmHOb59seI07AyFtlBLUedSNx3k35QdEITceMpkCwf1TFyxjSMCVf4ox59rDQs6357R7qTGlwvW1OaXPpVJjnHEMAe2orxm+//2X33uSe/8a7vIKNZdTybrWAkQEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADCCC116B1;
	Thu, 11 Jul 2024 18:09:00 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:08:58 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: Replace strncpy() with strscpy()
Message-ID: <ZpAfuh3rX7dysg8O@arm.com>
References: <20240710001300.work.004-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710001300.work.004-kees@kernel.org>

On Tue, Jul 09, 2024 at 05:13:08PM -0700, Kees Cook wrote:
> Replace the depreciated[1] strncpy() calls with strscpy(). Uses of
> object->comm do not depend on the padding side-effect.
> 
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(usually Andrew picks the kmemleak patches up)
