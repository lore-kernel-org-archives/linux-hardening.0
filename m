Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77144C7C;
	Thu, 13 Feb 2025 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485297; cv=none; b=b0lG3LkUhN75TivZt2QET2XonSi3mfvXZOjAmvcyt+BGpaRlGJyDfnYBzf+hwp2201Fr/ssjPL6miQTjiR8vWDLijH/eDtx9V0/7f5FDx3wybD5R5JzGnntobRUR7deNEfUste+vB9P9GIpD5v6lQT6Yf+/gdNASAz1ROBOZbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485297; c=relaxed/simple;
	bh=d2ZZJPzBpVJOLty0sul3Iy/m2zMxloygndmr9MRegZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCzF+/N0QjlbxMfYlfqwyqHIZpejAdtpcwD4K1Yc1ZNmgZEJkKEAu3wFgIiiGB9XoCxpsVMHOaPkhlBZjqE0vtLFn5aA/Owl9UptsoWGrnSgmqG7mVkN031EWU44mjMyua2X1xAsuMGJVqkqJqiJwy19nCYbqQMrtEo2Y/2aFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRzCJ7MF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRzCJ7MF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3644FC4CED1;
	Thu, 13 Feb 2025 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739485297;
	bh=d2ZZJPzBpVJOLty0sul3Iy/m2zMxloygndmr9MRegZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRzCJ7MFxLSVUFsr13ejMB8Aus9c1MrotP2rPHSgFpVedj2ROeOhYilISDigxh/RP
	 nQqhyM9xW44ZsfjQLGo2wmgqyG6g89iFA+1l9KuiKJPocSq8B5uF+Hk9UmHVzm6P79
	 wXZMblwiK3gAdpNq7h/lLtWE4LTUgpwC2Y2M5ugWYIMno9y7Fh2cVeeCUrnLdE0p3b
	 f6FHvpa0H3C4+4FdFVLBRDQ8fnaDZqb7GFuD8B9s458qqivNTshVds5Q3JMfdt7qXQ
	 PU5LhMs7kna4aBcX3Waq7+DtYry+DOD7la3+nK+FnV77vUDHPpbcS8yhNy0G60bhrU
	 iNZUL4x9MaMtg==
Date: Thu, 13 Feb 2025 14:21:35 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <Z65wb-8B2RlPi7Uw@bombadil.infradead.org>
References: <20250213221352.2625-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213221352.2625-3-thorsten.blum@linux.dev>

On Thu, Feb 13, 2025 at 11:13:52PM +0100, Thorsten Blum wrote:
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
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
