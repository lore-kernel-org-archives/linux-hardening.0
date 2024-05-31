Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70B7F7D1;
	Fri, 31 May 2024 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182516; cv=none; b=noD1gpg1tOlMlf4xlbCf5guAVF4xLTT7hh4io+sObAmAGxqirzMQX8aut5DlXLbGdWjOfe/qwMq3oppEpwI8GdtS8TPuOpx1uK5NkyZq8azemv34tlRWD+97hDi1VXiiutOQDjSC4qN3KXDtpAOC3dLtQFzvy5U+KuaygOvzxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182516; c=relaxed/simple;
	bh=+ZwA3B3uUTKPcLPMQO8JUOutJEuWTiTxesZp1gVR1FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0vOkUI4vJ3qr7/Xo+kpNaEOSeJZ06h1pdSYUFvbYeeXMdntbX/YxlxtVtTKQsxEw/8ixx9MTuKIb1Z2vt71SJmrXjFyd6dP9XIQ92nIGIAnRPY+IPYde6Rh17PnfKQWUGO3yUWGqiBBedZD6TKxUrPcO2Io4qPOXdQNYRtmpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ePRI7kWs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ePRI7kWs"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E73040E02B2;
	Fri, 31 May 2024 19:08:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YQHt5Fn7dxfN; Fri, 31 May 2024 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717182509; bh=NzGpXJTXbKmIHkjFqSrkePeRDdQz6l3rbrrmmm9dbpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePRI7kWsGmRmTVawaSnCct4KAy/HrsK/Pzu/KHZ4mfC11QekKZnaOyenXZEpRswrp
	 lhP6Pa94Up/ZB7itrz03ai3HxwQczJCUQvhb0/FjVv7da4GE9MuhSeHEcdgsPC5eOY
	 WdW2Kl6vzRK6j2ARwwBlkNIeilAfF2YIu3bQ2n3igvI87CSdZ3CF/b7oMFQp0/r33L
	 AQCoZ5KNOQXb4cMJ0giIwm3flBqhSLVJiTXvuFH5FvHkY2M1NwyMfuV3JjaagNTNlS
	 +MkFjxUzkj6F0qGgfFPsOL8jkka2dc8WUKyg7Uj7Y6n1w3U5Iyql5J7Qx0FS+Ha5HL
	 Yr69FvCWXeWdjJfGGNlDJclRhwEUqlnAqTESegYP1TxWflFGv83OwZLYHe3cQE5nN7
	 dMk2l7QSZj9bPg6WYj+6gCP7igIkWPXE1pT+/hgNisiyAKeNLk1qjeNszVA2rw31fm
	 UY004yI84iTb/ZhpZD1BOZsmGP9A3VXJmeFgzspnYUcZt75utGJxP0ffSEfwVPzfQk
	 cCKMSCtwd9k2kLJcI+Y6shL0E+lXcObGhO5gTjfVJV/HoSEHOxffQx93LF5N6Mqxa9
	 8H/Fhpi05qDU4ulmyxj4vWEyytITjWdOuXQXoSQBCsJZzCHUezc+nYk224QPfM03sH
	 QFhAQFG5dZEwK468C5iUzMqo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA77240E02B9;
	Fri, 31 May 2024 19:08:17 +0000 (UTC)
Date: Fri, 31 May 2024 21:08:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202405310951.56D9BD5C41@keescook>

On Fri, May 31, 2024 at 09:53:28AM -0700, Kees Cook wrote:
> Under CONFIG_FORTIFY_SOURCE, the boot code *does* still uses
> fortify-string.h. It lets us both catch mistakes we can discover at
> compile and will catch egregious runtime mistakes, though the reporting
> is much simpler in the boot code.

From where I'm standing, we're not catching anything in the
decompressor:

$  objdump -D arch/x86/boot/compressed/vmlinux | grep __fortify_panic
0000000001bec250 <__fortify_panic>:
$

Sure, in vmlinux proper (allmodconfig) we do:

objdump -D vmlinux | grep __fortify_panic | wc -l
1417

but not in the decompressor which is special anyway.

So we can just as well disable CONFIG_FORTIFY_SOURCE in the decompressor
and not do silly prototypes.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
