Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F210615AAD3
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662856; cv=none; b=iexPPQre7rdUrxXYULtUUsavZBftHagcUioDa387VedyS7RsUY5qXH46yCRhGwkNXWV9A5hK+yJeVe8gIgLLoOdu1jgNthcB7HJdT1W8TdeKXu/IQKa8ww8oKkXCECPivbKkj1ozE+ZKfzMBmMXjEVBwWvsmXYBDBa6ZKHdoFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662856; c=relaxed/simple;
	bh=VDm/f33gMRZJn1IEH8M+iEGbrAW/USVPxcL7qJhNNmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQvyOheEmTYQcKNXdqOjHz0CjXgLfQT0s17FDCQu0QDK2ymqEbHSR3cJtTk2LZSRmhHBBwzGHwxRUWfB9UuUzuTCFdsOQ29fde4zgOf/TDjts4zlOQdTTD7A2RLvoD+5z2Q6RycGBI+75LRYPyh6QcGzeLjbsuWo5itDBEojabw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EYtytLqM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EYtytLqM"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so62239035e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714662853; x=1715267653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbY/VcBLbuHrSNodrdRFjHRQXR5diN61KT/KCDRPbos=;
        b=EYtytLqMVZ76YsJjd0Vx7l2qi2ja/HdQ6nR2lFOW5doo++NiLxvXvIPqcIK1cJACs6
         THV2zuxjlG+z3JXCw2hE6oYKk+7Gc2nKiwAJMlZHnlZ3rndtiyk+aZjR/MdDf6ajIsXy
         UaysEipjVj73PznDKS6d46yOnUcUxT5fxjObkPTogyCtG72wTmXptUUJUjwWU/dEOuZ2
         JOfR5qBGTEb1KnVK1QtDj170tzoma5NZ66hm96/BoBhYLC0mdWj+rOrVRBf80SVM2g/Y
         Cb5nQsw71X1yDFpYTYbee2XEWYC7HP3zAE5DHhL+lv6vWWA5uBzeIRRR3L7+M8zXyCFe
         ++VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662853; x=1715267653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbY/VcBLbuHrSNodrdRFjHRQXR5diN61KT/KCDRPbos=;
        b=NAbxdv1Wc/NwgDQlbNYMYO/0kK41S5N2BdvTziejg4fe6xBTMtKPm5otCdrSya3lDh
         sqr8bpP5RU90NXjOGmVM8l+jKpkT4uBSx2xnVtH+R7Y8CI3dXpjUNTM0XpomJvr6UK8V
         X/MdTprXkG490i5CBiSTI7/UO+ox4JknOVWr62oqK+TbQcpsvV2Ae1BW1WGFGwC8M2N2
         6ddvwdxsJIzo6URkP80M25XEvcU8ya3O0rPX4y1zUfvLKRxAJ2D+23wsZ0/mSUIblxmN
         NUtvhr9uBPtPFXJY5PQBQZcocEfxQVdnhWxkEgTMktmN7h1mqK+MbtnNF5Tml+vzFHUC
         XvdA==
X-Forwarded-Encrypted: i=1; AJvYcCUbcS3bUWBBE0n4ja6kVbI2IpoacxO1V41RGkbWOTbWKkpBOglDEPQnJm7cjmAss8M1HEyaxovWxie3wbhnF2R1P9GqQQ5t5tryT+gJm2Jx
X-Gm-Message-State: AOJu0YxRSK9oRqU4lPq/dvp95ruVtwc+Yq+P9/DnQCmu/VCnuCfy9Aak
	ALUs6epzKnDXXiukO3kz1F+FekBTl9okb2iaqJD5U6EfxeMVXNHeEdg1BpwdRS8=
X-Google-Smtp-Source: AGHT+IFlsoRLNMn3LkTjImslFRW1koUYMMOKLDCsUquNVjPgESRcsDbCgtsLIfRPeZxiBfMILNOLUA==
X-Received: by 2002:a05:600c:450e:b0:41b:edf4:4071 with SMTP id t14-20020a05600c450e00b0041bedf44071mr23404wmo.35.1714662853248;
        Thu, 02 May 2024 08:14:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0041bd85cd3f2sm2256509wmp.19.2024.05.02.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:14:13 -0700 (PDT)
Date: Thu, 2 May 2024 17:14:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Justin Stitt <justinstitt@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] printk: cleanup deprecated uses of strncpy/strcpy
Message-ID: <ZjOtw-ov-GXxG-dv@pathway.suse.cz>
References: <20240429-strncpy-kernel-printk-printk-c-v1-1-4da7926d7b69@google.com>
 <7cdc63b3-31cc-442c-8c2e-75adb2c76b52@wanadoo.fr>
 <CAFhGd8rO=-DYvXi0YHvQqnhTteV+Hgeuou0X3USx61oTobj0kw@mail.gmail.com>
 <289aa316-5067-446e-96d8-7b318fa367a9@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <289aa316-5067-446e-96d8-7b318fa367a9@wanadoo.fr>

On Thu 2024-05-02 07:06:21, Christophe JAILLET wrote:
> Le 02/05/2024 à 01:18, Justin Stitt a écrit :
> > On Wed, May 1, 2024 at 2:39 PM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > > Hi,
> > > 
> > > Nit: The { } around each branch can now also be removed.
> > 
> > There was one line before and there's one line now.
> 
> In the block after the "else", yes, but now the block after the "if" is only
> 1 line. (it was 2 before).
> 
> So, {} should now be omitted on both branches.
> 
> -    if (str[0] >= '0' && str[0] <= '9') {
> -        strcpy(buf, "ttyS");
> -        strncpy(buf + 4, str, sizeof(buf) - 5);
> +    if (isdigit(str[0])) {
> +        scnprintf(buf, sizeof(buf), "ttyS%s", str);
>       } else {
> -        strncpy(buf, str, sizeof(buf) - 1);
> +        strscpy(buf, str);
>       }
> 
> This is a really minor nitpick. Not sure you need to repost if there is no
> other comment.

I could remove the brackets when pushing the patch. But feel free to
send v2.

I am going to push it the following week if nobody complains.

Best Regards,
Petr
