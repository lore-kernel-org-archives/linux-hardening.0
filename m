Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247E2F94AA
	for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770759; cv=none; b=DmVpvMohk8k5rgpQUl+jSyo+++4fi1AWYwMA18ZPZxl6HCpCLD+mgIeBvDDxGjxP+iHTR6uiI1XQVCZnAHx6ZkbPVr5aF7P7z4ELZ5NHVrvt/eWnbgMsmeSnk00juVL6rP8ZENqak53OIf3d1Ryg8qoTscjtpF5RVY7N0+npRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770759; c=relaxed/simple;
	bh=iRnWqNpzFeM5Zf6BqsRpXhJqEgg8Z8aFyrLB8L1gRTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVfFfLBhtUTRkzBo7wZg9wTnaZblKfNn+hwzll26SYx5oU6qDmfA6EfWvm21M9+Yo/Q8mcKe2r3RKvm2AQ3OX2O4f17na/yzQOJu0sxMJSarmwsuUeMPpBdD7qJ9g9uNWJhHIgfspuGV/qayCFiqHR9L42cVy6xs2eqVeMSUgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzyf1cdQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzyf1cdQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237f18108d2so6935ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Jul 2025 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752770758; x=1753375558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKUJNmP0H+2EOEC7uEp9wCLLSrzA1vzqL1Sr2tNFz6M=;
        b=qzyf1cdQlmg+cZOGJSimnKW9/z8+rGON2dH4G/S0oltoNdbHIH7iynTq9K8XuWczYl
         6MK6vzE+aw79HgCfKhbX1G2wfZXAhGLJZW/9aFPl4Nb4P+Eblh39HFX3djQ+MtNjkRMX
         oUTo+2IhD5SMGsPbmIrUKPX5QSBJOvcF6sP/GtpzbVJeCFHbIcbRpSwKx32LjlporrpP
         bvIT0IM1GDIDJBJoC6yyFnM2+KIPdMdTpaKAsR22dzhqqirD/IjedMI3BUkVNWfRuvPa
         VuwchH825xV6WGUywf3/V0EGoX5oGmijxh4iK2SWsz9OI4UVJRYZAwdtVzUBQe6RMUys
         Hsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770758; x=1753375558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKUJNmP0H+2EOEC7uEp9wCLLSrzA1vzqL1Sr2tNFz6M=;
        b=NCyUUVdLoiwwAjU6XXl9gBSzkKhlJetkqiMaw7ZoBLnrs0+n4JYCtJ/NBkuKHxBBqw
         rr2TRgFjnvn6UcO4lAU50zywS79cplDpfUTD5T97ZJLjhsReqPaPLwEFA0sn1h1oy8zf
         ZKbmYKNHB2LXZ5EIj6w1/cpbxha6fPXBjXcy+bcJtc2D/ASwxQ14q4ojcvFmuOEJG6PD
         4ED4PfyOnZb69VeE4tc2F6STb7OaYzeJ1osm+6TSP1GYMnD7oRN5D+BS9ddmbgScIGUZ
         0l8TGH9UsBfL2xne8aqcmTvqd18v8EVxJN5Uc9722EhgMZKwKqAGr6Ts2bH8FpdPKa7S
         QFEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBKA61SA8clD0q/4N3UFGaWi08VkDFEjB2ZWcnznIB1aNVE33mnzg3Aa8GrPvzi1/Z76wcEclysHnsELNYuXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKB3xCiGoACpIG4iAHJ0PU8hVLqQcTMFmvXHcCxEGZOPXGQAG
	pPaIHAmUe+1+9aPTDnwSjGcj7ji9dzdBJUvsWFW8nEAFRgbAC5c/OBGnS8yjADiWJU/lGA5+YZH
	h/yVie0tL8etFKnGF1NXrP5wGC96qoy7NPWx3G+lt
X-Gm-Gg: ASbGnctM0o+BCeA7ffbtso/VNzsdHp5eVK/xTbPKEFGv9vHM6e4yuVSR7u+XKcUzeX5
	0b/U4ThfN0N0bP5x2VXn+fEUwPryDUnbT7QQjROcjumT/BI2iNTstSgz4/CIZnmecTvkXOe+xoV
	F122nFVIqakyVseZc2PPmhUOXcBia66HbQyuT34wB2UbipSWekYD4wiQL7OSRVmJUa8KC28QZZc
	vw8IVDPBwg60Ls=
X-Google-Smtp-Source: AGHT+IF/jbc5KsIrIk4t259Eq/zkKG3YR3wGUxeaP9wSJo62CP4cjrCT1LbXx3KWXrxV/ZX4TXAsZ+zA+Z6VyzKLOXc=
X-Received: by 2002:a17:902:d486:b0:23d:eb0f:f49 with SMTP id
 d9443c01a7336-23e392b9d79mr277515ad.14.1752770757077; Thu, 17 Jul 2025
 09:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org>
In-Reply-To: <20250717085300.work.146-kees@kernel.org>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 17 Jul 2025 09:45:19 -0700
X-Gm-Features: Ac12FXxFBLO3F6u3hRZZBsSiDUycM_ZS3G7VWFf1ItHH-mMCSDv03W4t2NQH_00
Message-ID: <CABCJKucfFyVqarstWRCRMf1DbvM7-SajkxAphsH-X8MgSPPN8A@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Thu, Jul 17, 2025 at 1:54=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> +/*
> + * This tries to call an indirect function with a mismatched hash salt.
> + */
> +static void lkdtm_CFI_FORWARD_SALT(void)
> +{
> +       /*
> +        * Matches lkdtm_increment_void()'s and lkdtm_increment_void_agai=
n()'s
> +        * prototypes, but they have different hash salts.
> +        */
> +       pr_info("Calling matched prototype ...\n");
> +       lkdtm_indirect_call(lkdtm_increment_void);
> +
> +       pr_info("Calling mismatched hash salt ...\n");
> +       lkdtm_indirect_call(lkdtm_increment_void_again);
> +
> +       pr_err("FAIL: survived mismatched salt function call!\n");
> +       pr_expected_config(CONFIG_CFI_CLANG);

Should this test also have a "This is probably expected" message if
the compiler doesn't support the __kcfi_salt__ attribute?

Sami
