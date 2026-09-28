Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EED3474261;
	Mon, 28 Sep 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585051; cv=none; b=Hqj0AxZW134vX89wTgT8WTq2GYcrVNKKc84jo7m1jNBjkFre2ymnGQGNRcw6+YYE3c4Crp2u6tRj9+Vs3K+MGC6g29EWI2rieUIXC7W9HXpDRuvSVkio7ZQSI1ybX8zfe34+dmdg8xpMPGVVaquqpCmnqqhg0khx1bmUibObMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585051; c=relaxed/simple;
	bh=FZshP+iIYFrnFz9pDPBaGrQWfYo9TKVKuzBKuEedW4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TArvk782b/+2Ka+KLYL/aCjVyHx2S4jcnp7Jvy0q+tDtczawll5KxaS7eeyPz6xhRTXNRi2Fv52YtZU/RbI7qGbX9D4bu0rT+3xfeFz7iIfyQdoZZi0e1hy9nzlM8Mpdv85pdqptGhCyF+JcCycutUmY8ZWr4gAirL+RJfIJ3H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tnPRLtXp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tnPRLtXp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638DB1570;
	Mon, 28 Sep 2026 01:44:03 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68F223F86F;
	Mon, 28 Sep 2026 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790585046; bh=FZshP+iIYFrnFz9pDPBaGrQWfYo9TKVKuzBKuEedW4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnPRLtXpCVeTSL2ijeUMxzxxfrEkXapzD+971i8GGw4V4o21ElcHWDgt4zfRsp6us
	 qdzo7yX9H2bux7DcqgOm9uipy9b+7dh/NvxZlk455VoMyb4NkHzt54pIDMN0ufHq1Q
	 mNphyGf4Sb8UwgDG9xDRpUpEBoU3Spv42MkwtYs8=
Date: Mon, 28 Sep 2026 09:44:04 +0100
From: Leo Yan <leo.yan@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] coresight: cti: Add const to con_groups allocation type
Message-ID: <20260928084404.GD14479@e132581.arm.com>
References: <20260917211428.i.947-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211428.i.947-kees@kernel.org>

On Thu, Sep 17, 2026 at 02:14:29PM -0700, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>

> ... As there is no general way to
> safely add const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> Build tested ARCH=arm64 allmodconfig with GCC aarch64-linux-gnu 16.1.0:
> drivers/hwtracing/coresight/coresight-cti-sysfs.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
