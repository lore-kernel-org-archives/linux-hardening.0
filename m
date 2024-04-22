Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5B1CF8B
	for <linux-hardening@vger.kernel.org>; Mon, 22 Apr 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823234; cv=none; b=G/1ZKIPEnugF39jqBjRCIVXmBxBiJRiPdlPgGDRjRwFGzF+pcvOlOozOqVSxWDcqKA3y3qKgS+dZ3FxlL5Vh6//ggELmO3NKZeN+DdYDZsnM1N08CR1VFS0cXmrOaIkXe3TG3IibAnLN4wa5loMgXlWA/d0KZRp4mSOApPxrCEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823234; c=relaxed/simple;
	bh=p6JLCBkvqNIqEQ1ubJ7C4eRLscLaJJerM3bMGqhvbpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGl8rtt/05/rTQqrXcwTz4Jupm/c6lHWOdoOk8Ni2Hsocp+byxbYCp5/AM6Cdi9GJW5Xf92ZYYtcMJsjfyMkllZEru/8b7G7vreg+ZlhhFn+A2Y+VCRz476DBwMAFvzyMM2OmU2QnG4jvwFAWeQuL4ZwaesruAtNZBYitgKqvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMRz5BBc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMRz5BBc"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36b1774e453so12405775ab.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Apr 2024 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713823232; x=1714428032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfsxkV//StRJTp5rV5sDpYK/AhHv/YaJcS8pvnmBwck=;
        b=iMRz5BBc1WSmVZVCzij8jLpLC+8ek+4xB9WMDUcyxJeVVrtUgi3aRlxGmdDxFWxRLk
         EQaC889xT9PedaFI6RuSrvl54jqIGs/16WV/yOOiiuNaLO30aNZzLuBAEFEG5UELt3Fp
         wnv+hNqm867Ac9eWadjjTtufMm0j8rjmWQFtgZE+6R1ZaIrfVTFM/AGVIhPnnp6eb4Uz
         732vyD+HCUsfVVsIU0GudUkzrUEK2+SoHar3EDkxFF4tCo6f/hWX0ENe+Tzi9+wNrvLa
         QoMD3iyoPr8DqSaF7Q5m5Ht63Y1M6XL13TltQaEptYZdnGorfW5thMnTFwM5WpF2XoTE
         R4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713823232; x=1714428032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfsxkV//StRJTp5rV5sDpYK/AhHv/YaJcS8pvnmBwck=;
        b=GnBu3WnDuIJnPzrvVBzRBNYq7S472r+TpQmtEM+wM5yeTHO4pkuVm7eaaR1k6Ub3Gx
         R53WJ6M/GPhXjozItLPey99ACf/8J3O+GP9uAjcKMcAKVVhbTpm2PmRoXl/tHdtEdWKl
         SnC8vZt2PaZtOOs8P3rsmREWG97UL1/2pMKKaHctTylCDyH5fEiGN+sqD44M++X/sX7n
         nHXkHcBQcsAMJf5cepta6OpM/VbJBdQwdWkP4HpjobuzTxgCidv6bWiBNt2XUnAXJ0A9
         iTsx2xZC3R+e4A+Q+Q4CJDrRE33LTsTv5u0TguS+AGSfVhrdToGEy4VyflPRunb8eXi9
         cl5g==
X-Forwarded-Encrypted: i=1; AJvYcCVPIuaPU43DW6kPl3cPi1d8OR+LvS3SvSez+nXfbPSM2ttyORvY2u5gEAMrO2i/U0WaevaFHr3FWhjoMnR2Yji5UNb48ewgSHcEi50LO2ak
X-Gm-Message-State: AOJu0YyeW7mfyh2dAITdrgBFxOpspKReskwF7ax+OrMN55Xl+aqWyslX
	862CitfZWyaTweA9g5948XTh1PLgRIi+KT8bY5MIhsTL+qNc715rBIGF0GkNLg==
X-Google-Smtp-Source: AGHT+IE1s84FuNiBnEmUnzVxcubsnGcOdxIb0/gx3HMK35WxITZvDb5sx+Z1is2zB3cqYbD1nsqQSg==
X-Received: by 2002:a05:6e02:f14:b0:36c:a50:af9f with SMTP id x20-20020a056e020f1400b0036c0a50af9fmr6553951ilj.6.1713823232526;
        Mon, 22 Apr 2024 15:00:32 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id a9-20020a056e020e0900b0036c12bfff5asm445381ilk.65.2024.04.22.15.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:00:32 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:00:29 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, gustavoars@kernel.org, 
	linux-hardening@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/2] configs/hardening: Some fixes for UBSAN
Message-ID: <mcgs5qsnhmsg3iaxzzdhgiab36pb5zlt56lbxpiaxxotykpzgv@ipvgvrj2w4jf>
References: <20240411-fix-ubsan-in-hardening-config-v1-0-e0177c80ffaa@kernel.org>
 <202404151110.8D4AD8E@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404151110.8D4AD8E@keescook>

On Mon, Apr 15, 2024 at 11:15:05AM -0700, Kees Cook wrote:
> On Thu, Apr 11, 2024 at 11:11:05AM -0700, Nathan Chancellor wrote:
> >   [    0.189542] Internal error: UBSAN: unrecognized failure code: 00000000f2005515 [#1] PREEMPT SMP
> 
> Oops! Yes, I didn't update the (arm64) trap handler to notice integer
> overflows. I think I need something like:
> 
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 5fc107f61934..a2fb19f75825 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -77,6 +77,14 @@ const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
>  		return "UBSAN: alignment assumption";
>  	case ubsan_type_mismatch:
>  		return "UBSAN: type mismatch";
> +#endif
> +#ifdef CONFIG_UBSAN_SIGNED_INTEGER_WRAP
> +	case ubsan_add_overflow:
> +		return "UBSAN: integer addition overflow";
> +	case ubsan_sub_overflow:
> +		return "UBSAN: integer subtraction overflow";
> +	case ubsan_mul_overflow:
> +		return "UBSAN: integer multiplication overflow";
>  #endif
>  	default:
>  		return "UBSAN: unrecognized failure code";
> 
> >   [    0.198326] Call trace:
> >   [    0.198544]  cancel_delayed_work+0x54/0x94
> >   [    0.198810]  deferred_probe_extend_timeout+0x20/0x6c
> >   [    0.198988]  driver_register+0xa8/0x10c
> >   [    0.199122]  __platform_driver_register+0x28/0x38
> >   [    0.199258]  tegra194_cbb_init+0x24/0x34
> 
> Justin, does this trace match anything you found running syzkaller
> against SIO? (I assume not -- this seems to be a tegra code path...)

Nope, here's a full list of the SIO (just signed-IO, not unsigned-IO)
crashes I encountered with about 10 days of syzkaller

title|frequency*|date|repro
UBSAN: signed-integer-overflow in __do_adjtimex	100	2024/03/13 08:54	has C repro
UBSAN: signed-integer-overflow in __gup_longterm_locked	1	2024/03/13 00:48	
UBSAN: signed-integer-overflow in accumulate_nsecs_to_secs	7	2024/03/11 23:35	has C repro
UBSAN: signed-integer-overflow in ata1	3	2024/03/11 12:45	
UBSAN: signed-integer-overflow in blkpg_do_ioctl	100	2024/03/13 07:53	has C repro
UBSAN: signed-integer-overflow in cdrom_ioctl	100	2024/03/13 08:31	has C repro
UBSAN: signed-integer-overflow in corrupted	10	2024/03/12 08:03	
UBSAN: signed-integer-overflow in dcache_dir_lseek	10	2024/03/13 07:55	has C repro
UBSAN: signed-integer-overflow in do_io_getevents	38	2024/03/13 07:59	has C repro
UBSAN: signed-integer-overflow in done	4	2024/03/05 22:31	
UBSAN: signed-integer-overflow in generic_file_llseek_size	100	2024/03/13 09:04	has C repro
UBSAN: signed-integer-overflow in hugetlbfs_fallocate	1	2024/03/01 14:29	has C repro
UBSAN: signed-integer-overflow in init_file	100	2024/03/13 07:47	has C repro
UBSAN: signed-integer-overflow in ioctl_preallocate	95	2024/03/13 01:33	has C repro
UBSAN: signed-integer-overflow in scrollfront	31	2024/03/13 06:16	has C repro
UBSAN: signed-integer-overflow in seq_lseek	100	2024/03/13 08:29	has C repro
UBSAN: signed-integer-overflow in sr_select_speed	100	2024/03/13 08:26	has C repro
UBSAN: signed-integer-overflow in sync_file_range	100	2024/03/13 08:09	has C repro
UBSAN: signed-integer-overflow in timekeeping_inject_offset	100	2024/03/13 07:57	has C repro
UBSAN: signed-integer-overflow in udpv6_sendmsg	25	2024/03/13 07:12	has C repro
UBSAN: signed-integer-overflow in vfs_copy_file_range	100	2024/03/13 08:51	has C repro
UBSAN: signed-integer-overflow in vfs_fallocate	100	2024/03/13 08:24	has C repro


*duplicate crashes past 100 are not reported or attempted to be
reproduced.

I don't believe any of these match the trace Nathan reported.

> 
> -- 
> Kees Cook
