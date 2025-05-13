Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7161E51D;
	Tue, 13 May 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104653; cv=none; b=G9zGpUNjs93NiCRMFMUJVufZwpFSY3Pj8SZgGPbWjLrXs84470EUsOJRzCS7M9qL775NhbKRLqRA3Ukt60qjFOBqJmcOEpursxjtIlKNSs6/vCpscU+NZkq6WmZrgN6R1Onz2iRtNGMtPF3zptZ3LwxBicW4jPsdFG+HKEFseAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104653; c=relaxed/simple;
	bh=cBL5kQa0jo3tqGwassIsq+HD8kXRQw0IeIK4nreK+bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tb8cHFIDJcc2R1az5yj8rzeuAx3PeUBsDzEcw+8p6ajKjiyQWs7DFeZoFme4iF2ryNAHlzXHWk6zUMG8hGnM+LavH6FKI0qIkGs2O/FZenl8sPGQsG1p/TH7bZu8zcOztjT+MMnU5fPZKBRkXYY22xc9Sp4tTUwdezCBHb7w5/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuAwRffR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuAwRffR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CD0C4CEE7;
	Tue, 13 May 2025 02:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747104652;
	bh=cBL5kQa0jo3tqGwassIsq+HD8kXRQw0IeIK4nreK+bo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JuAwRffR17IrOX1aTjCd18lnlxFxf9DvyzRHgUAhtBYEDeg24wB52Z4iXkFO5NK9L
	 17mHXsN4dpRNemGw7MCoF7LwMnEJByKUpZAMDgYwiP5GTt2DL/ACaua6SCUVx6j67k
	 AwMf3NWBfWEjby/RXR9mhp5YNWFlbnsHjqSOakBUF13klucro3gLrY3UjeXMAq1B/0
	 JtngaVm8DFdhoabueDHloDa2oWTLDWxtf4zfjC0gXEJt1D7GPppW63NgT815XLFAi4
	 JepXagfcAzMoCqu2AcgED0DvhFYPRhS4umJF5d7uSRQd0NpN3vU4UDLdaTLl6+di/A
	 steyagak7fy2A==
Message-ID: <8d147f81-12cc-41f3-ab40-6fb198541e3e@kernel.org>
Date: Mon, 12 May 2025 21:50:52 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nios2: Replace strcpy() with strscpy() and
 simplify setup_cpuinfo()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250509163840.171521-1-thorsten.blum@linux.dev>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250509163840.171521-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/25 11:38, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Since the destination buffer has a fixed length, strscpy() automatically
> determines its size using sizeof() when the size argument is omitted.
> This makes the explicit size argument unnecessary - remove it.
> 
> Now, combine both if-else branches using strscpy() and the same buffer
> into a single statement to simplify the code.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Cc: linux-hardening@vger.kernel.org
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   arch/nios2/kernel/cpuinfo.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 

Applied!

Thanks,
Dinh

