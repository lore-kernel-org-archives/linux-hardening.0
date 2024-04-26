Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C9208CA
	for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163289; cv=none; b=OWFBO7dlMxozUjASN5wn+bJpNcMc1r8RhaatQ9EJXxPtG/KqTJBt8IF1AudLQXmrxNGVb20Cdbbf0iiLZbyOOtO4MuKji2DIyeaNWXBS3vj+nbA/ztcxrnlMysR3eXWs+WmgNAcLgzAQQyvxUAs+ICT41I3eeXZAjHiBCY42AYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163289; c=relaxed/simple;
	bh=TtoJasaeQGgnALP0rtQ0ZwOtOqDfU1tZPTxkeDPjRHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5pqVeIzCPtVnx2ni95g2uiTqNfj7cO7GMol3DZqan2M/quY06Fpd7fUSAmntVGVlUMlRrWiKbcWRPKnT5dJmhvSQychOQ5jU0Z+YhhUmD6r0VwS9Lp4/9cfqVK3pyN51CwOedI+7oIT5KD1Zaia6D941BgpSjPVmPfhcTTAXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rvnarEw8; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvnarEw8"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7dea2de1301so88402739f.3
        for <linux-hardening@vger.kernel.org>; Fri, 26 Apr 2024 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714163286; x=1714768086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0HjfgQeMYeniizrlmmHEmgJt7Z1IePAUwGcoRhvByo=;
        b=rvnarEw8pkvPc5WDvXYRaQBoM1BRj4wxELvwXNCjwHbb9dp7p3EdycBFKN3xybl4GE
         ddlcmBxTNOrGXrYBxpcnEJhWRHCOJ2wmsqoje6PBnw7YROaC8hcr/E50nncVasJRPax+
         IqJq80MUrR307P8xppugyz349wCc2QG/qoxP+OudSRBal8PWqwIARoZdzVlLx3XIqzLd
         JY4VppFeqdGZ26t+/iJHOXDbw2vtkstYEv3wKnMsU1vgZ02x5QdkpZEmzet9tmcumqBu
         ZeERD5BzN8+o3iKDz+8OtgXZLyjauNyEbZovbB9Ax3E4AsgjwAe2lw6dJDZb7quDLL0U
         TQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714163286; x=1714768086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0HjfgQeMYeniizrlmmHEmgJt7Z1IePAUwGcoRhvByo=;
        b=vdvVuAa94hMoSst7DqLYQSRlmwm45GRIVDpKQ13iq1ecn2aC7mN9RhlB7piTmWb2aX
         kTeDNvtzSeEw3CW34FTKwAYtdxIqsR/86jq9TYaCRrlmPCo9+B8MQMxka4V7lVeQ2Gab
         X0CUlBmlWILKgArvuR1uagwQO2cXA7Ic6ogeOi+jpsXmc6gRR+grN6EZAboJuf9nDGqD
         +/1JEflSI11qm19jG6BClOaPVhQYw9OOAcctPpanBYiMeMpxXffv+voAMFj1or7N7IZ2
         irfbyrZl3PD2tB3mcZsqUZGi2jgd8mrNAS+KfY2WJU/00ppQJu0uJ9lbi28/QRzIIBTW
         c78A==
X-Forwarded-Encrypted: i=1; AJvYcCVdfLNGsJW2lvIl8ouvcMPPs8vKyxDLCjCSP2iGl6m/ZCEEPITSSJcMUouKB57592xigDhDuwR4wAFlUhIS63tzN9mlCTf/dcyi2geey94d
X-Gm-Message-State: AOJu0Yy6tE4rmy1oOFYOvJFx249/vr7ay3+oMJnhrYY3kS+I1MWwzy3l
	flmcUNYhBV52YkqzbYYkN+mjVDsz4oCb7Y0dgD0C+nxm+stz1h392TXQO9sdIQ==
X-Google-Smtp-Source: AGHT+IEDLzup8dAjXDwrXqvfO3khOMafAlVMyWw462IeEbbgXPBlppCqAlUnNkur3oxRSm1RxOew3A==
X-Received: by 2002:a05:6e02:13a9:b0:368:80ff:9bc4 with SMTP id h9-20020a056e0213a900b0036880ff9bc4mr1236703ilo.1.1714163285655;
        Fri, 26 Apr 2024 13:28:05 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id x17-20020a920611000000b0036c28ba3ecesm1089777ilg.85.2024.04.26.13.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:28:05 -0700 (PDT)
Date: Fri, 26 Apr 2024 20:28:01 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Erhard Furtner <erhard_f@mailbox.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, llvm@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ubsan: Avoid i386 UBSAN handler crashes with Clang
Message-ID: <kxzozn56f7xknswj4xmss5agncpy7t7apke665swpcvrijt4uw@35rfqgyuyp5v>
References: <20240424224026.it.216-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424224026.it.216-kees@kernel.org>

Hi,

On Wed, Apr 24, 2024 at 03:40:29PM -0700, Kees Cook wrote:
> When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> option used on i386. Hopefully this will be fixed correctly in Clang 19:
> https://github.com/llvm/llvm-project/pull/89707
> but we need to fix this for earlier Clang versions today. Force the
> calling convention to use non-register arguments.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://github.com/KSPP/linux/issues/350
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: llvm@lists.linux.dev
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
>  v2:
>    - use email address in Reported-by
>    - link to upstream llvm bug in ubsan.h comment
>    - drop needless /**/
>    - explicitly test Clang version
>  v1: https://lore.kernel.org/lkml/20240424162942.work.341-kees@kernel.org/
> ---
>  lib/ubsan.h | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 50ef50811b7c..07e37d4429b4 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -124,19 +124,32 @@ typedef s64 s_max;
>  typedef u64 u_max;
>  #endif
>  
> -void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> -void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> -void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> -void __ubsan_handle_negate_overflow(void *_data, void *old_val);
> -void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
> -void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
> -void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> -void __ubsan_handle_out_of_bounds(void *_data, void *index);
> -void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
> -void __ubsan_handle_builtin_unreachable(void *_data);
> -void __ubsan_handle_load_invalid_value(void *_data, void *val);
> -void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> -					 unsigned long align,
> -					 unsigned long offset);
> +/*
> + * When generating Runtime Calls, Clang doesn't respect the -mregparm=3
> + * option used on i386: https://github.com/llvm/llvm-project/issues/89670
> + * Fix this for earlier Clang versions by forcing the calling convention
> + * to use non-register arguments.
> + */
> +#if defined(CONFIG_X86_32) && \
> +    defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 190000
> +# define ubsan_linkage asmlinkage

Clever.

Acked-by: Justin Stitt <justinstitt@google.com>

> +#else
> +# define ubsan_linkage
> +#endif
> +
> +void ubsan_linkage __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_negate_overflow(void *_data, void *old_val);
> +void ubsan_linkage __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
> +void ubsan_linkage __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> +void ubsan_linkage __ubsan_handle_out_of_bounds(void *_data, void *index);
> +void ubsan_linkage __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs);
> +void ubsan_linkage __ubsan_handle_builtin_unreachable(void *_data);
> +void ubsan_linkage __ubsan_handle_load_invalid_value(void *_data, void *val);
> +void ubsan_linkage __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
> +						       unsigned long align,
> +						       unsigned long offset);
>  
>  #endif
> -- 
> 2.34.1
> 

Thanks
Justin
