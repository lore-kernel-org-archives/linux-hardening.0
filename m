Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DA238C0A;
	Fri, 20 Mar 2026 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034275; cv=none; b=jPp9cgK5zXbbtzYOt94klVnIK79yCiG/7PMe+UODHQyu7PwaRa+FWeDi/fYiX+nJyvp/nD/MHb8SEyDTSooisHCPJZ7k3KYeqg1GAtzm0HRV7+j9A7+I5HhHRLpz6v6WA+e25QeU2yUscOGn6wcD/qClMT4wr177QGDP/MQuLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034275; c=relaxed/simple;
	bh=9TZIMqUnNBD0DEJe2/OMUDzBG5+dAMkv/0IXuJcy46A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwGwjJGqZm5CJFbRIuAvwKh6PMc0CMu0oHtXTVy46FbbtiuIRIYMWnVVn1HCokQb3FywatLPQGUp2m0WdFk7cNs7cL1uozuQMO/jwEz0ERATJ/uHv7IPIQX1FERZrB1AwEyAbNxnfe6h2QcgaA3cqZX/kmw0lIIeH0hFgrWwCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2w91l2B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2w91l2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E275C4CEF7;
	Fri, 20 Mar 2026 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774034275;
	bh=9TZIMqUnNBD0DEJe2/OMUDzBG5+dAMkv/0IXuJcy46A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2w91l2BWtvl2nVeulquTZZ+CheLOBRJSMGMojBV3DIC80v6J7Sr7PoKdO6ZIkCvF
	 n905DAXgpsGZ2qgjMb1tZu5oMRqFxtcO/LyZvXeo6LDX0XMXBxi/R3ww4E/Z+/2VBV
	 tCdNSCcNNmi0inBDoyCwoeuroFVYQVnLkxh+msjNZ96nWThffr6k+wbA9SbNWf5aiG
	 QLn5QdIbi+kKpUl+tSLh5jXGFn+xGRTFe2hVOdkHv+mm/sXzYhEnBteQPiyZdWFcy2
	 KJiq7QYN+5agU4b01l33KzaO81k+ldHNrJ4LrLknSF6dJEn8fHQQvFDw3gy+qr3hMz
	 btJ0Z+e/6NbyQ==
Date: Fri, 20 Mar 2026 12:17:54 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Josh Law <objecting@objecting.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: processor: idle: Replace strlcat() with
 better alternative
Message-ID: <202603201216.3CD33C4@keescook>
References: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316170158.1596857-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 16, 2026 at 06:01:58PM +0100, Andy Shevchenko wrote:
> strlcpy() and strlcat() are confusing APIs and the former one already gone
> from the kernel. In preparation to kill strlcat() replace it with the better
> alternative.

Yes please. There are a few places I looked at in the past that might
benefit from being changed to seq_buf or similar (where snprintf doesn't
cut it), but otherwise the removal of strlcat should be straight forward
and would be well appreciated. :)

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> ---
>  drivers/acpi/processor_idle.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 45b5d17443cf..498d88f5d5c9 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1010,9 +1010,7 @@ static bool combine_lpi_states(struct acpi_lpi_state *local,
>  	result->arch_flags = parent->arch_flags;
>  	result->index = parent->index;
>  
> -	strscpy(result->desc, local->desc, ACPI_CX_DESC_LEN);
> -	strlcat(result->desc, "+", ACPI_CX_DESC_LEN);
> -	strlcat(result->desc, parent->desc, ACPI_CX_DESC_LEN);
> +	snprintf(result->desc, ACPI_CX_DESC_LEN, "%s+%s", local->desc, parent->desc);
>  	return true;
>  }
>  
> -- 
> 2.50.1
> 

-- 
Kees Cook
