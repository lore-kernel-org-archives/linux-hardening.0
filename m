Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDEE2BAFC
	for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902555; cv=none; b=hxC8oOrhyL32ArQGbIBw5yzM1G4hAWL50ElP9DlnqA6OAMiO0PUSPboUJQp+bAfXxGp3nJATocCc5UJHPIK1yS5d9e96WYzGHrD6FD6XI+zhV7WXUGt/Iv/12KMv0DTahoyhkFg5e5KvjQhbp6s0etTiBfsJ6gjJw5UshJo95RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902555; c=relaxed/simple;
	bh=s7xt3J/x1P5iR0tIyAeOfFanpdd7tKxd4ngYLSRwbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+b9xI1UWN+RFUikBR8HVjXyBuCrzemwXKPaxe4Xi7LL4HkbGi7UzM3zN3P1UTQ4N3FNLszuPcJyipMNy2frNEEH/sCOSeEjWx+NQRbJtli8ARp8QnLrATL10zKMgbkoUAwS38+5bTWgDlqbLgwHoidemnDwjz0JkRhiSJqIGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FpK80cf2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FpK80cf2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6082eab17so5457001b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 19:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902552; x=1711507352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2Ii+qg5LzdQ72UpZAw1asNIZXswSUTe3sjnBVEowPI=;
        b=FpK80cf2hM+7NsrMo3H6/99ZxSX+fOtbFEkSaWi8p3DN2NqOxOHPtTOkYEavLFkjT5
         YXJaHKy6FKA12ArFyKOD9WEx+X6Z3d+QJbdN6O6TvYVK3+E1BnOTYovb9pY3ngHxO6Jc
         Fc16DNvtVH5bddpkenEerj37o+ETzsWjyW4dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902552; x=1711507352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Ii+qg5LzdQ72UpZAw1asNIZXswSUTe3sjnBVEowPI=;
        b=q+JawssLCzcO+WdreMfMCvyX2lEW/9arRbH0e2B0kgbeg/l5CYPRFOwFKKXXMa/VKi
         jNVvUSHjYIJofpnwNbmE+dedN/eYDSxsQwwyIqdFn+Wyoas19FFPMmLB1iQ056KyKqiK
         Fku6cXMsklUIKtTZQyb9p3DpA0oAHQWnWW7Upt/mbc4XCImSc9M0vLQbzz1KD10O2xiT
         PsxvWDkYe0smcoXqxdb+xu+TuDKs7MLNtdshSfirfMa7dBMLixqPtEppRIblmLZww8tv
         7pbyB92ytSvainaq119o3ZDPeZ7ZHnuczFvD9RTG6DFFVAbELjxOZeMaj0K6OlAZoANv
         hqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBout2oW5R2LyXMyibPCMjEUWjHDySGlIfAhCN8BB9fot2+2jtgMutCHgm0Jy+Hm/DmcgwN04nvemnNpRg4ltOtzf0S6pFh2Yz6lcNhf5x
X-Gm-Message-State: AOJu0YynmceLVuRaQ5lr1ooVQWxClARWBwQjkxtz6V4m7/8PDdNzAX2P
	7bNUWRCNHlxYSbJd/0eLo4RztRPKG1siX9hNqIyPxCpnHxjz8TK866qILM5vpg==
X-Google-Smtp-Source: AGHT+IFJ3mimqhyXJl6uZ2iBD7JX313NaQ7js3fa+uG7RNJZ8WFe7D0jn4BJmpYU7bSd6VfpiwLGDg==
X-Received: by 2002:a05:6a00:21cc:b0:6e7:20a7:9fc0 with SMTP id t12-20020a056a0021cc00b006e720a79fc0mr9982708pfj.34.1710902552625;
        Tue, 19 Mar 2024 19:42:32 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r10-20020a056a00216a00b006e6eb8e07edsm10032341pff.50.2024.03.19.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:42:31 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:42:31 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: core: replace deprecated strncpy with
 strscpy
Message-ID: <202403191941.D2818DB@keescook>
References: <20240318-strncpy-drivers-target-target_core_transport-c-v1-1-a086b9a0d639@google.com>
 <202403191908.1B6BBA3@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403191908.1B6BBA3@keescook>

On Tue, Mar 19, 2024 at 07:23:43PM -0700, Kees Cook wrote:
> Hm, this actually fixes potential over-reads and potential memory content
> exposures (in the face of malicious/weird hardware) since p_buf_len
> appears to always be sizeof(p_buf) in callers, which means the old use
> of strncpy() could have left the string unterminated.
> 
> In practice I would assume it's not a problem, but, for example, here's
> a place where the 254 p_buf_len could run out when doing the sprintf:
> 
> #define VPD_TMP_BUF_SIZE                      254
> ...
> #define INQUIRY_VPD_DEVICE_IDENTIFIER_LEN       254
> ...
> struct t10_vpd {
>         unsigned char device_identifier[INQUIRY_VPD_DEVICE_IDENTIFIER_LEN];
> 	...
> };
> ...
> int transport_dump_vpd_ident(..., unsigned char *p_buf, int p_buf_len)
> {
> 	...
>         unsigned char buf[VPD_TMP_BUF_SIZE];
> 	...
>                 snprintf(buf, sizeof(buf),
>                         "T10 VPD ASCII Device Identifier: %s\n",
>                         &vpd->device_identifier[0]);
> 	...
>         if (p_buf)
>                 strncpy(p_buf, buf, p_buf_len);	// may write 254 chars and no NUL

Wait, no, it's safe; I got confused by the double buffers. The
snprintf() will always NUL-terminate, so "buf" copied into p_buf will
always be NUL terminated.

So, nevermind! Regardless, still a good conversion. Thank you!

-Kees

-- 
Kees Cook
