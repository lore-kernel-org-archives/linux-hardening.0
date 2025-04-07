Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34121147D;
	Mon,  7 Apr 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044547; cv=none; b=p+a5zaYZ45Wi+iXc0Qzpd0Lah4owv3VNF6FZ/leDmvU+mBwm+EBgvBAnZn0CC6ihniyv+9v9N/dMQ9x3XdI8P1pD2SSrHv8qzRufmzdMmgMctsbYl3sOHGwMoQMzsgVtaC3POJZKukHZ+ChZ3Xk+Q8T9jxA5aoxUxJU2Pbp5tBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044547; c=relaxed/simple;
	bh=Mo1OFtMzcDJIdxM0+OZ6cHwpURehbkEEK2v2x8Ci1Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkFWcjFW13yQeNmBJo3X9ql6HOJD4XSB2UkLDlZD3nrrYirINGK0BKq74vrq7QtfmIa5tDFF4EtO7ARAs+jSAIPZSpvyR4XVV7xMkFn6sNXrG+1CxLkxTXBtsydm5i7satsYIgqr5lL25dCC7X7wUUqERC/HY30MFXRFUQn+p+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT8lzWk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT8lzWk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33675C4CEDD;
	Mon,  7 Apr 2025 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744044547;
	bh=Mo1OFtMzcDJIdxM0+OZ6cHwpURehbkEEK2v2x8Ci1Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iT8lzWk7CbdXINHOXKDP7w992v0qdICkqSUEpgHxGwiE3p3hwmz+nax9Exh4b90Rl
	 CgCcwsfkiNJnpfzDNbcb+o993dst/v2bdB8mRuJKrTrp57Fv0HuOf/vN+rOMB1mKar
	 kZs0OYGrAafbWwa2rYN8cEZVrXxVhu4Hl6pA5ePxJRRWc0LcgOSuzNAY4fKe3i0+JB
	 RBDxSXHUs6wDtZDqosPhmduYSMezbH/qJqFngaJTFtQMJA7KMwn44t++rYss2rGXpq
	 K9DTKcQgRZKJmwJ/qfpODR5XtUIneruAg9OByNoySDX8EzQrXKcXW3CmTQltoxWVo+
	 Dq1cKiHVwzOwg==
Date: Mon, 7 Apr 2025 09:49:04 -0700
From: Kees Cook <kees@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Alex Elder <elder@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	alx@kernel.org
Subject: Re: [PATCH] EISA: Increase length of device names
Message-ID: <202504070948.B71965DC7@keescook>
References: <20250310222424.work.107-kees@kernel.org>
 <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c6bc732-bd90-4a29-bcbc-f545b0ed79ad@riscstar.com>

On Sat, Mar 15, 2025 at 09:27:36AM -0500, Alex Elder wrote:
> On 3/10/25 5:24 PM, Kees Cook wrote:
> > GCC 15's -Wunterminated-string-initialization warned about truncated
> > name strings. Instead of marking them with the "nonstring" attribute[1],
> > increase their length to correctly include enough space for the
> > terminating NUL character, as they are used with %s format specifiers.
> > 
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
> > Cc: Alex Elder <elder@kernel.org>
> 
> This was interesting, but based on the bug text I suspect you
> meant to address this to Alejandro Colomar, <alx@kernel.org>.

I think you got tagged because of the Reviewed-by on commit d69d80484598
("driver core: have match() callback in struct bus_type take a const *")
which touched include/linux/eisa.h.

> For what it's worth, it looks fine to me.

Thanks!

-- 
Kees Cook
