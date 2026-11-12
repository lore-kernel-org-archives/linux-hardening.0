Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507791;
	b=NOAvVjc9I9tcMfCcPpOkJomXHPCWz7N64qltFxq2jW4tAuMDFSvlqTBpv/6VXSJ+ZAGS
	 aj3mSvVoIhR4m7cMJBHnZyvuqDdFVgNXLW81I7Cy0uPc7qQrK5VG3UGakblRKIOdtNuQS
	 qSzqQGmWanQeiJRqy/RkTaxncCmkf5E/uKyd1hV4EDTHDKNKuEsFKPtJZrvvCfc2ixVTe
	 c2AfUBQnxtc+3jpetzic7WtYIMa9x+AlP7WHe30izBftIedicj46rYQQmqVLtBbilYAmy
	 AIBryWy5s2vAXjZ65dvnI7g11XKVcOZoleELJPJG5siCr9RXtog4GBYl5P7uv7XhWdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507791;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aZfej9mgZwVFYQI8nFMtJg3a2yXEJBTyr1oRqLjT+fc=;
	b=jlYq5wN3JNABqPqI0t4DVEjyzXCtPMqpY74bjkuqESkbqBjA5eHm5MxSzi1jyIUctKs9
	 bHDhh88d+VOnnPl0AgTNypoKzPUw9X0gfLl8SKyQ0Zptrzgsc4P8xNOw9wDY+JZE2xrKU
	 n3OmJ1dhrQ9b7LH3nxAb0EE5qL0m0D/uoI4eswlkzdzCf5hJJ9+KnUovvpuppE8L2KC2L
	 n4bJQ/mcj+vEtZeig5TfH+65xoZpJyAVxoUR8XB+zAX14472qdCiSTDpR3auLK+Nnv037
	 tBMHtW86aVdD7va9NEgkiAFPgBdzXmra8ZovtU7lSc7LBjCvBeIBuFkm6OcxiCh5O6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8ThRzZp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117C606A321;
	Thu, 12 Nov 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8ThRzZp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC6A1F000C5;
	Thu, 12 Nov 2026 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794507791;
	bh=aZfej9mgZwVFYQI8nFMtJg3a2yXEJBTyr1oRqLjT+fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h8ThRzZp9xfSo8kPstvcnHh4oW++vNVs2dRAlyj9J7hY+vdbHeCVSHImavtGBclb5
	 ZW0ywfrjQUXxuG57VUDz7DIhG20zf39ohoNBzWAIwVowxwR671pzZV8Vwx5Inl2x3v
	 ly7cDrM4FmCCofUr/w1SDqPZyJ2Q4wt8Ss5sZqCYc1UsLSb1mz+9pWb3TXs5lqLibR
	 08HNeeFeuzwMD60xhqSHRV9Rd6dw7yPFGLyjKZpp6dxLIOwDZi28MNo8n6EC3e75DI
	 hrWmUartQcj7HjBAwlCy4Po81jqG0Rk1hi1raJN+zeQjCx1vT8/Z2BBJISnjxEzmEd
	 fYScd4JxaWk8g==
Date: Thu, 12 Nov 2026 10:23:11 -0800
From: Kees Cook <kees@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	justinstitt@google.com, morbo@google.com, alx@kernel.org,
	shlomojune6@gmail.com
Subject: Re: [PATCH v4] media: siano: Replace strlcat() with scnprintf() in
 sms_ir_init()
Message-ID: <202611121022.A022CD5A4@keescook>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
 <20261107033928.13891-1-nikitash.mariiaw@gmail.com>
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
In-Reply-To: <20261107033928.13891-1-nikitash.mariiaw@gmail.com>

On Fri, Nov 06, 2026 at 07:39:28PM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1], replace
> the strscpy() and strlcat() calls with a single bounded scnprintf()
> call to construct the IR device path.
> 
> This preserves the original NUL-terminated output, including partial
> or omitted "/ir0" suffixes when the 32-byte buffer is too small.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Thanks for the revisions! :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
