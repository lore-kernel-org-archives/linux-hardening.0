Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705659B4C
	for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798792; cv=none; b=owIj5WTssZjK38fgm1dGFneLM2WsrycUNldqg4QS3Zc44qfuBFCHeuV+GR9tRd4k0Qg/gh9Ig3XlOfkF/Hzu3FeAI0fOzvOl1CVio0fiqoHyXtVORFk7UpF+ECbPOijt8Amr2aN97fFwMlbx8r/3bP6bQaw/SBZ3S2jxQuddrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798792; c=relaxed/simple;
	bh=JizSFbjtx2htSyk8SkATyClTMTliTcHMUD9iIRdZRdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0iz+EFcs3leXTI2PgXl+uzBay1NgHrKG3aTm96FZ2enkPrtMt2Uhrb6lw0egAbCQE9pGljwsou0INucH8xfum/ZSqha4ncMTxEBAvfyPI58aEgCVm02Rw46N2zU+Jk0jCoIHAXNuPZ4knvH1R7Bk3ctGRO2wfgLQUl4YozleqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iaNzDjOa; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iaNzDjOa"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so2379534a91.3
        for <linux-hardening@vger.kernel.org>; Mon, 18 Mar 2024 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710798791; x=1711403591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtzX3B0TpCLSG/r678eRw7F3f4FGYZRbRXL/8dQddU4=;
        b=iaNzDjOa64gmGV/i244zGJQEMiRulP5z1WVeu3Sqi6F00DCy2hmOmXQJ0EXDxMY8vi
         TwC5aZP9PumCTH7f40WJRSYJI5+Qb3XtGRUNxNoVIF7d9I0ZIEarXWX13A/g8qbXeGlX
         Pu/lETOdVlYDMxuaIKLb/v9yiy6nVJOd4ZB/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710798791; x=1711403591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtzX3B0TpCLSG/r678eRw7F3f4FGYZRbRXL/8dQddU4=;
        b=t4F9Qsq8ke1zU0P4GVOC355UuhYwoZDsxKoSh4JISEPCGwaOLQqpiMCJhf+tQIYtf6
         wseoYVkoB5EhCjpfRlF1PQI4uKpCyBA0DultRQVm6fXMwcAMCBF8aLAsXl/Vdmpx+NoN
         BwzQqRBhysD1DpEfBntm0fiJmQSEX+NpMiiJT+A4qL7TmFL47RbZ9Q3G/yajR/FRTH2j
         s93+FHOFertY6Ub6P3aYeth1BunVe3fVqUNkbNR9Hh7h3nfEkOsGe4obssNK3k6PX7OP
         Hsmp7NyhQjGF2DQMZgrMQVZOr9I+FunGOxJUQ6tj2YIV0Kc3szkmPwVTTHRMQKCTwNlX
         TJ7g==
X-Forwarded-Encrypted: i=1; AJvYcCWmu2XN9lo6Ztz1oGvoZu0TvO0XTF2n3CfkAG+LXJBFGndYADWT4ylu3lkVt/e98oVKBMCjzEhpdCL8IsSON1/85b6Ns7iF7sz0waKSYm+B
X-Gm-Message-State: AOJu0YyYvpu5krv1u9SGh+AyL0ooTR/7W8D3QitQ3K302D67aW6HVcdr
	mvt9pqNZbOEqfzDhCH1Tyu42vB6HDZ/rS1HoASWSz8eala4GzfK8CGwWi7ceRnotgHcGl0gOeas
	=
X-Google-Smtp-Source: AGHT+IGv4Kqn7atIxrIijFKf64/vFsVwStmAQMvmLnWKqPS6XvTIKQsbJnzlt/yktHSLuH3RG7+/jA==
X-Received: by 2002:a17:90a:12ca:b0:29d:f086:9e44 with SMTP id b10-20020a17090a12ca00b0029df0869e44mr8248526pjg.46.1710798790706;
        Mon, 18 Mar 2024 14:53:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ok5-20020a17090b1d4500b0029df9355e79sm6731928pjb.13.2024.03.18.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 14:53:10 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:53:09 -0700
From: Kees Cook <keescook@chromium.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: elver@google.com, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ubsan: Remove unused function
Message-ID: <202403181452.500EF35300@keescook>
References: <20240315015347.2259-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315015347.2259-1-jiapeng.chong@linux.alibaba.com>

On Fri, Mar 15, 2024 at 09:53:47AM +0800, Jiapeng Chong wrote:
> The function are defined in the test_ubsan.c file, but not called
> elsewhere, so delete the unused function.
> 
> lib/test_ubsan.c:137:28: warning: unused variable 'skip_ubsan_array'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8541
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/test_ubsan.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 276c12140ee2..be335a93224f 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -133,11 +133,6 @@ static const test_ubsan_fp test_ubsan_array[] = {
>  	test_ubsan_misaligned_access,
>  };
>  
> -/* Excluded because they Oops the module. */
> -static const test_ubsan_fp skip_ubsan_array[] = {
> -	test_ubsan_divrem_overflow,
> -};

But then I'll get warnings about test_ubsan_divrem_overflow() being
defined and not used. :)

-Kees

> -
>  static int __init test_ubsan_init(void)
>  {
>  	unsigned int i;
> -- 
> 2.20.1.7.g153144c
> 

-- 
Kees Cook
