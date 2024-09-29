Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63618EAB
	for <linux-hardening@vger.kernel.org>; Sun, 29 Sep 2024 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727641265; cv=none; b=L4/CjnirAR0Fnzxk/LfsLSVaQhueAyk5Iq1Bg9r4ER8CVk9XmHR3gdEZ/HPT8PiCax0FT7lIYqBpWY5td0YWXfM2XmgKTWUn3YLRmOCePikDd3N2pSrS8KizJAqD2vKHitLnDBMKsn5dCC+nGQkN2hu7PNV8Q33+2SDWtVLLsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727641265; c=relaxed/simple;
	bh=NCMujOi7gIknHs127h5m38WVgd6G0xciBwWlyhI04G4=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JR/bcxiUBtFP039TTJmjmP/MVQ6EY11V9r6w8KLY4hWurOQyQ2uGCw+OyH5HWI+KohMp8/2xj9gr2WYxdnvW8VTbLESHQoWUdhOzhA+R/qvZd9I93Io77CO+WxJo6O02hT/nXoatbfVSTxbR5fVXIoyPwzLuOHWr95B0mPMBpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FbirAg/Z; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FbirAg/Z"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9ac0092d9so434834285a.1
        for <linux-hardening@vger.kernel.org>; Sun, 29 Sep 2024 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727641262; x=1728246062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j730t5RgznBmQZu3lvSO1ELFYrR4fxxSXPbfDnOL7lc=;
        b=FbirAg/ZSZj+9IbidxOvv4MW2hjAtpLYy2R2whBxT9uCtH9/Z19joik6o+0vayOTDK
         JyiywBmlX8zVIQeo9Dx8dTRucpMdbGaoWhwPVDDrxbEnEJd8jKAWSfQRr7KU2aP0jE66
         +uWhs5/IrpkAtzBoL5YynpwdN/bDtOQoEFUircp/TPvet9dejhkLD+loPdJCyMDFuuYS
         UZEWO2HrewotMsOigrcRKTe9qDW1CrGwtF7doS+bH/ZT2GthiJQLQqyN4UvMa9LZggME
         ww1cYsohwGHfz6ZTHqk32J9xXGeSMZY2cR/z7EcIdKJcKCRwYbK5GBydd28Gzop+4DTO
         JP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727641262; x=1728246062;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j730t5RgznBmQZu3lvSO1ELFYrR4fxxSXPbfDnOL7lc=;
        b=LGrELH/YkgSY3qp7gqRO5eRn1jngL1/hO/p/SayUoX/zHW33oMOO2kKCqTECTRbRM+
         b4/apSkUphVxPZcBMVX5SHloCA+fGZQ8vnKSR1SQ5R0YMz5pKexF/zoIDfKvaZu+L0or
         igsfUlNhkIX3KQpBvLQ+UDc8DaR3L6y4FZw5j6TAoAGLzmwFFDFkbaFsnGrrOD84wfvW
         p1TBwJ/RNWXynm2ReGKDBvTpZ2zKY7Cvrzx1yCXYgg11Z9aurVUw+6yBHxK9DlkNOvyI
         fils7S6LHWI0khy+3Rb2jrOLgzyoDqayojDRcBt7RaxG9wBlwQ6OuWxaRWQzcBjJtTxT
         yUFg==
X-Gm-Message-State: AOJu0Ywtr9ZN/gXQ73+X3Uo9DhqXNJbZDNAlEA4PzpBZTR3G5pPSh08P
	pCqQc474413P7Tc/QP3iIhNWiOFFIvttYnAMSOr/8o77Jd1aZJa4GHpBoSfdJUvhzszf3SsfeKD
	TZQ==
X-Google-Smtp-Source: AGHT+IE3rPnUiHlGZpJAiiSi2r8ITRz1wB3lhzsgmG3CaQpGo6aFcM3Rt59tO+884CFfrtoXeBewRA==
X-Received: by 2002:a05:620a:24d3:b0:7a9:b114:4704 with SMTP id af79cd13be357-7ae3783849dmr1387092785a.22.1727641262161;
        Sun, 29 Sep 2024 13:21:02 -0700 (PDT)
Received: from [192.168.22.104] ([62.156.169.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f33a4c9sm31021261cf.73.2024.09.29.13.21.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Sep 2024 13:21:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Date: Sun, 29 Sep 2024 22:20:59 +0200
Message-ID: <1923f716100.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20240928-maintainers-security-kconfig-hardening-v1-1-c8c64071cc02@kernel.org>
References: <20240928-maintainers-security-kconfig-hardening-v1-1-c8c64071cc02@kernel.org>
User-Agent: AquaMail/1.52.0 (build: 105200518)
Subject: Re: [PATCH] MAINTAINERS: Add security/Kconfig.hardening to hardening section
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On September 28, 2024 8:26:28 PM Nathan Chancellor <nathan@kernel.org> wrote:
> When running get_maintainer.pl on security/Kconfig.hardening, only the
> security subsystem folks show up, even though they have never taken
> patches to this file:
>
>  $ scripts/get_maintainer.pl security/Kconfig.hardening
>  Paul Moore <...> (supporter:SECURITY SUBSYSTEM)
>  James Morris <...> (supporter:SECURITY SUBSYSTEM)
>  "Serge E. Hallyn" <...> (supporter:SECURITY SUBSYSTEM)
>  linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
>  linux-kernel@vger.kernel.org (open list)
>
>  $ git log --format=%cn --no-merges security/Kconfig.hardening | sort | uniq -c
>        3 Andrew Morton
>        1 Greg Kroah-Hartman
>       18 Kees Cook
>        2 Linus Torvald
>
> Add it to the hardening section so that the KSPP folks are also shown,
> which matches reality over who should comment on and take said patches
> if necessary.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)

For the sake of casual observers, the reason James, Serge, or I haven't 
merged anything in Kconfig.hardening isn't due to any malicious intent or 
lack of appreciation, rather it is out of respect for KSPP and not wanting 
to step on Kees' toes.  I've happily merged KSPP related patches to those 
subsystems which I'm tasked with looking after and I plan to continue to do so.

--
paul-moore.com



