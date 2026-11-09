Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216091;
	b=llPSRUszhC8iJ+S2JkXnc5RkdZEiTyuu+vMrjFohXL4SfLJDAlXUh2Ih2sPvCo7YAXtQ
	 qQDkIlcRRlqIxSc4ZsQ+B0T7a4Iu0RRTgnK0AWF9guzHBHEZcT3Lb591WLe8P77KeXfko
	 GjtWkblos6HWG2Jte3SMJSXspJKzIu34yEoVM5iueFrZUXFVDQqGAXdXS4rbkqbi+dMVs
	 A5uZ3Ce+MIrqPU4KyfsijH1K2WOLAwMZ/D47L1UeCSBl5A+V4iNCJqundIimcMQ8AWaNr
	 SE0m6iEE03V0bTD1Edg7I2vwNzur+sbsQ/5cmuRilKmIwHPGwVRn4CNunsNE1F5udxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216091;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/jPaI1IP/2aPVomPfhc+HK+dZ/V9MffvwmdW9sTHrb4=;
	b=rZnIOQqgJaAkHuEjZWPaMxE9JwT0oeSPGMOUXpukRDQCEigJI8Sec24bdYtm/E9AVFA8
	 1mWAoov6XzsgxNeTkMN/S7egRXpX808cDBWVPS5oGCzKAa3YPaxchEdASFsivn22vsMYI
	 PjIY2bq6sCj8iIrEMUFMWL1gYTo+GBjPePcQd1WEBlUDZRxZmQyXwsiriASYfDMJ+CRfw
	 Lo8MLdYuShCPQXMT7foIH2CpNCOxsETdyOHspNco55zKO4+mlnDk0WuqTrFhAiM4meHEp
	 cM6AlDC7fdGuUT34WrZxL3jIVOUP1Bv/4Jmqs+8LXgpLgVUE9dhxer3Z8Fv16yDsaXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZbWXdbw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4DBDD606A322;
	Mon,  9 Nov 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZbWXdbw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D6C511F008A1;
	Mon,  9 Nov 2026 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216090;
	bh=/jPaI1IP/2aPVomPfhc+HK+dZ/V9MffvwmdW9sTHrb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kZbWXdbwgBohm9qlpH0WJWdYlpSqB+5dnNmNgRlWudyRz1jN1tqoDzWu+TagEy+2H
	 YCJDktCTnJW+FAgrRETnpSG8Vn+L6IwoXUj+yLXEMD4XBU3YJquO/mVIHJ/kKYW8+D
	 mmg9b3FCS1ewCSFEOnl3Bk3uAcET0BceAIshuyUyUk5sh5L6BXXPhheErIRz/6KBx+
	 1EzSBLaeS2BW/AymAPucysMp/+FGcAR8obRa2bHZCVHBInOCIGWcUc4TYHWiX3JkJN
	 zp4yb2ThgGTHfQ0k/TE8ruz/cQAAsql8GocrvOXZYxCRkYpbK0/17hr0biqaqsCGW4
	 WAtLDHGeKp3ug==
Date: Mon, 9 Nov 2026 10:21:27 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Linus Walleij <linusw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Jeremy Kerr <jk@ozlabs.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
Subject: Re: [PATCH v2] gpiolib: annotate struct acpi_gpio_mapping with
 __counted_by_ptr
Message-ID: <kcqbiis4m7zqlm6nzpacx6fkbycyy5gjz5nnhtlxlhzxn3tklb@d7j7ciafnpew>
References: <20260928063824.1386524-1-morbo@google.com>
 <20261002124226.435265-1-morbo@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002124226.435265-1-morbo@google.com>

On Fri, Oct 02, 2026 at 12:42:25PM +0000, Bill Wendling wrote:
> The 'data' pointer field in 'struct acpi_gpio_mapping' is associated
> with the 'size' field, which represents the number of elements of
> type 'struct acpi_gpio_params' allocated for 'data'.
> 
> To improve bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE, annotate 'data' with the __counted_by_ptr
> attribute.
> 
> Analysis of allocation, assignment, and access points shows that the
> pointer is never accessed before the count is set, which guarantees that
> this annotation is safe and will not cause runtime panics or
> false-positive bounds checks.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM

This can be dropped now.

> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v2: Undefine "__counted_by" and "__counted_by_ptr" in the EFI stub
>     library as it doesn't need it and Clang is missing a flag to
>     enable them.
> ---

Plase, don't send new versions of patches as replies to previous
threads, this confuses tools (and maintainers).
 
Bart
