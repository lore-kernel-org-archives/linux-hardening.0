Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725E372
	for <linux-hardening@vger.kernel.org>; Wed,  8 May 2024 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127078; cv=none; b=u6Gg5ZY+2HpL1381AUS82Zc4OKJtAmVS9N2BpJtukDTAB4R4D3eG8STsewXtzc2bQ28uUjnioKbJo527JlOiF46amVszOlmymOIGTrHwn1kmeDSeBBmJgyG/E/7HSEaZDX+QJsaAgFea6UUPmy+qoNYbJPFExpsy7+O5Zcyp4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127078; c=relaxed/simple;
	bh=8EEaDJUXAyse1mHZGe32mB5qOjAH2U7utH1XD6WCh6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF3yO058TF8Fp0i426F0PcJpTYwk4Y5jAFWQs7LV2UPGI46eTvoRkt93N2+A3YnP5qhxC4ICsY1TR4MnsrYlUgX+RibmIriQ4R0jiriMFm7i3qUWX9Kos/34Vb55hk0tgmAOBebMnY/XSOn0UtbHc3r7FvLNrMbD+0q0nUc6QVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JZOMtm3w; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZOMtm3w"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f0277767fbso1551490a34.3
        for <linux-hardening@vger.kernel.org>; Tue, 07 May 2024 17:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715127075; x=1715731875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tyQ7xybcQL7dkQ2tP9bw8EvtlpggYRp5xKvXntoLsjI=;
        b=JZOMtm3wwsANUNxfsRgkIuaNlO69Y0+5vgq0iYqnCO29XvHGaWoFxqwklywmSHIZte
         colHLD/BlyxvLSd0nUPnl+aXI758M0PH2/FNS984KQBUB4rI6VRkzJ0oMWlVp57Plkmu
         3hgFeugcEQf4MSRqZCubp1MULB/dlqPkIkM4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715127075; x=1715731875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyQ7xybcQL7dkQ2tP9bw8EvtlpggYRp5xKvXntoLsjI=;
        b=pWXzqn4SFGVxX9qYuc1W5tJPb7IXX6not/RqKBy1TF9hZieNgbjb0rvP993/UgMjGN
         XHEoXaGNOmArVNntlkPBfQhZIY7edNFe6OzwRJ79V8g658NbfQGCTMT5wpb6wVbsFcjA
         oawwGzGy0FaGeA1EofpAH7dApRYo0PK8ESK0Y6LKA09n5wXxG06YC+0i3kUoJVnWmKhq
         kPJ5BMjVBsxrLN4tUYiVmC999g3lp03XwXmtYjwWSXoYeUSheSdGM6I6jI9+7CBk4BwI
         N45yNItNwefk6Nz6nIZyPRd7jifoFETAE5lvkNdIol5meSj8RnxuAIcndvdIOOK/TNqU
         s7og==
X-Forwarded-Encrypted: i=1; AJvYcCW+13Vu6Ucag609S6kw5UcXjlniui6iehtqeAN2zswXcSZdODP8PGtPj+xBoW/i+FXLbCraMHgOP2ah0F4PEQwRzqS7wsG9/jhJcc29nRFA
X-Gm-Message-State: AOJu0Ywzvwf9HAt6B/aWSLM3xSXUSbQSal1HfhSWZuzJ7z5qfeBBp+6h
	KzJVUma3sFf1Dae98i6J5dvS3ZrpXhWDa7/KOKfCyCIGR7Vz41JYR8IdsfFHrQ==
X-Google-Smtp-Source: AGHT+IEF0Ps1LbalzQosbUHnWCLLdAIMrWpsVYxRsKASu36AiWu2UixrPEFmFCVhW8/0m3IhK8baJg==
X-Received: by 2002:a05:6870:3912:b0:23c:f645:944f with SMTP id 586e51a60fabf-240979e1905mr1263605fac.11.1715127075218;
        Tue, 07 May 2024 17:11:15 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w24-20020a634918000000b005ffd8019f01sm10235451pga.20.2024.05.07.17.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 17:11:14 -0700 (PDT)
Date: Tue, 7 May 2024 17:11:14 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: remove accidental overflow during wraparound check
Message-ID: <202405071710.1B6F1990@keescook>
References: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>

On Tue, May 07, 2024 at 11:17:57PM +0000, Justin Stitt wrote:
> Running syzkaller with the newly enabled signed integer overflow
> sanitizer produces this report:
> 
> [  195.401651] ------------[ cut here ]------------
> [  195.404808] UBSAN: signed-integer-overflow in ../fs/open.c:321:15
> [  195.408739] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long')
> [  195.414683] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
> [  195.420138] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  195.425804] Call Trace:
> [  195.427360]  <TASK>
> [  195.428791]  dump_stack_lvl+0x93/0xd0
> [  195.431150]  handle_overflow+0x171/0x1b0
> [  195.433640]  vfs_fallocate+0x459/0x4f0
> ...
> [  195.490053] ------------[ cut here ]------------
> [  195.493146] UBSAN: signed-integer-overflow in ../fs/open.c:321:61
> [  195.497030] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long)
> [  195.502940] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
> [  195.508395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  195.514075] Call Trace:
> [  195.515636]  <TASK>
> [  195.517000]  dump_stack_lvl+0x93/0xd0
> [  195.519255]  handle_overflow+0x171/0x1b0
> [  195.521677]  vfs_fallocate+0x4cb/0x4f0
> [  195.524033]  __x64_sys_fallocate+0xb2/0xf0
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Let's use the check_add_overflow helper to first verify the addition
> stays within the bounds of its type (long long); then we can use that
> sum for the following check.
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/356
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

I think this makes the checking more reading too. Thanks

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
