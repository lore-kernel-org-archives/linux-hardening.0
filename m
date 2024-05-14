Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB517CD
	for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 01:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650179; cv=none; b=DSwQW4LLKcS+qJDrpxemgOECaEB4YtIruoZG8rP43+F7B3nr80JkltxW0TBsj12oWUiuaxUefC/SGx0+ad99sPir6oZBvmeGODDy7x3Ge7KRm1zVF3t2DuJqVOBFllrdRnY7vXt1heJCHlKNdsK7R/vXku7Y+Qn9xYCiTKb2q7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650179; c=relaxed/simple;
	bh=ydzzvUXzzyHYXDB3rdnfrOfaFvankCzu/PpfufEIZ8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXYLnfR8BETidnJUbGiRRh9QN1urDuApC23SDyaBYLJRIk6+FylPuRlLzIrJjv9UVBboKrbIf5VbeNlBLbuTRFzmo8WaNMitpXUb91umV//A3Kt43CWyxq7kyXSu27Vs9F+3uaEN/cARU7yGT8HqjJwvM+9OzRQAg6tjJ5sgGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q11ISna/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q11ISna/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b239b5fedaso3928922a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 May 2024 18:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715650177; x=1716254977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G12oTJkF8iLsh/4R29i5V3FaUw9E3HvRiqsr9Lc4hks=;
        b=Q11ISna/dGYd0RKqsssggPYEJ09PrCw7rr9dXahPg6UfB972ECTIihuHy5MsNKuDv0
         XsTtJNAnPgHEyy474vIvEb48pfycJ1wt+on7chv472yD7edWkJBJ2Mx/f+w6dcnx/AKw
         VK2sjWba+n4MZ0CnQH9D/B3Q3xbxschvB7Zmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715650177; x=1716254977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G12oTJkF8iLsh/4R29i5V3FaUw9E3HvRiqsr9Lc4hks=;
        b=QW+lnCo2m395QemdtaMV0wWR0ip2D6kOW/r7ahwS/qDc7o0kOnJ85b1fzqG3rPA/yd
         82zx4Aa8FCj9rJi0hAE5vDVCvuEFgvwrupAxjtQ4Zpfwi0xuXUZc56bLMNPyKbNX/q40
         KjlmoamJ6hC4eK7gZf+7FVvWEAmTFJ5ojVCKgRXNC4Ji12/qf53zARrdM/qNt2kCr6aE
         mTt4Nmdh0CqiBKmL6J14Q1Haia7KCcqVsBX5cf8fLu3FbdKE7lflYEcq9hLuG1QPfxKM
         Jjo/rnevQ9h2I3j6YboUQblq8mhiX7esVTSv5AvD8w42HKhYhOkFxwpWj+EP3ox6wW2s
         RuvA==
X-Forwarded-Encrypted: i=1; AJvYcCV2AMmGMgcAsV29SAFxOYwQ9k8inoZKwfxCVwjr9ZDc8EtWXWagiXLaMWn1txibfCpuisoIM1G+0d3U2o6JP3IS0cnPnAIx5e4fICQWzHDC
X-Gm-Message-State: AOJu0YwzNVZKmcgRF8Bcucu2VwGxIQ5USILnYu73jE4SzYMMb2Fw4rAP
	Uz1AwHDNh02xum8XZj0oP+V2Lr7M3T8oke+tLa432ieHE5BdU16tkA42OUC4dA==
X-Google-Smtp-Source: AGHT+IFEJye/Z8WAoZs9+YbGZcRqMhUSZmFn6dkSlu0jABBG8huBwOzQtMUM1ErHVjwk6NyoQ170SA==
X-Received: by 2002:a17:90b:3a85:b0:2b2:c85f:aa0b with SMTP id 98e67ed59e1d1-2b6ccfed296mr9212935a91.42.1715650176932;
        Mon, 13 May 2024 18:29:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ca53b8sm10361200a91.45.2024.05.13.18.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 18:29:36 -0700 (PDT)
Date: Mon, 13 May 2024 18:29:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Bill Wendling <morbo@google.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hardening@vger.kernel.org,
	clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH] hpfs: Annotate struct hpfs_dirent with __counted_by
Message-ID: <202405131828.9CD8E5A@keescook>
References: <CAGG=3QW4b9mqh9oGQ16NmMGbo4HVHmdM00Be1Qk97StCpW4xTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QW4b9mqh9oGQ16NmMGbo4HVHmdM00Be1Qk97StCpW4xTA@mail.gmail.com>

On Mon, May 13, 2024 at 04:45:54PM -0700, Bill Wendling wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time checking
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  fs/hpfs/hpfs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hpfs/hpfs.h b/fs/hpfs/hpfs.h
> index 281dec8f636b..ac137787f1f9 100644
> --- a/fs/hpfs/hpfs.h
> +++ b/fs/hpfs/hpfs.h
> @@ -357,7 +357,7 @@ struct hpfs_dirent {
>    u8 ix; /* code page index (of filename), see
>      struct code_page_data */
>    u8 namelen; /* file name length */
> -  u8 name[]; /* file name */
> +  u8 name[] __counted_by(namelen); /* file name */
>    /* dnode_secno down;   btree down pointer, if present,
>         follows name on next word boundary, or maybe it
>     precedes next dirent, which is on a word boundary. */

Looking through struct hpfs_dirent::name uses, I think everything checks
out. I do see some confusing manipulations in hpfs_add_de(), though. I
*think* it'll be okay, though.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
