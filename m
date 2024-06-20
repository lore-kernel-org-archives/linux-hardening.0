Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A966EB7C
	for <linux-hardening@vger.kernel.org>; Thu, 20 Jun 2024 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917261; cv=none; b=CmkNshzzPIPWh2PH8O1BI+44XQxHys4qvehFHQkRWGq6qaNgTnDq/lSvBEmpgdbL0Js/eMt+eOuFxOl4qZS06I6AA/Bhg3SweBQzaWQp3HueRbgG8qt1ockH3X65dZB3Q9egV7wLcg4ldq9xENiwL8fP3drs9oejan3FG6PQLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917261; c=relaxed/simple;
	bh=egAWnAyxKEcGYqBb8KysmqEYwI5NpvcOXUNw1MnaEzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwMnuJ3blWyURQ24ZoZtDQJDYtTxdq/3CH98RtaMFF1/Z207XyHfn1zKqsL2Q1auCX2wuZIuwGjK3OaxeL0ceN8TSTWbB5nhm7YMYWmhKPeKONMz3gOpTSqxwtFWw5mqSv1VRZEWfM79Gxflrz1fc0XWgmncSDHtvLEajrbsyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQi73C1+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQi73C1+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-423b89f9042so785e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jun 2024 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718917257; x=1719522057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF98VwdCcJqbDJTb4AUwn3sHBg8bzfdX8R18O7bVHHE=;
        b=JQi73C1+reQlPOwWaixSzkrk4LSBLs9N6IqGzn077XxmQY22ygUtTY8vnnjqDeM+Ni
         pEaMNrTxwcfDAnRsvyMCEx55EvCQekWpNswmO7bx27Lw4UbN5C/NaD7jC6DhZIKyju+m
         Cr2d56QqBZSjutlhbnEAUgE9O1blDJ12mK42MJCm3Z80kqyqS400Dc8UzuM+/S5KpGVc
         VKQFd0/XOA5l1Yy9Nww5Jc6FAq+vogfXiE+4D62J3xi38sy8VUy0M2s/z88p4DbVDOgd
         SJzDmcabOi0nq4WB9+8OB+5vk8z1a6ZPsdsbfDkvt4PvKth8sr3r2RRUGtLVCn+/B4gc
         9NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718917257; x=1719522057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF98VwdCcJqbDJTb4AUwn3sHBg8bzfdX8R18O7bVHHE=;
        b=r6/LP4eFvR8OHL6/TJa+2qGhaMSPbwN1oScwdxISS8riMCAe4daBEyD2RqGf1VyYm+
         nsYiGNB8LB5za4eus3DOiB8Kz7ufBhsZoijm2POc7zXdUrQem/nVbcpmBD/TP5gHj88L
         eUIxH8SYGbr8abAp0g4VsMyjb78SOc7f14/m9KL0RtGpQKIcK+0nuJW78MejX2e8Fl70
         Vq7IJcHLrOk2MLPanVYVGn46ZOmQZ215crW3G6NWxZdVs8MZumfi6F2GpsplTj0qG9Dv
         HBVqXw6BnOZNbcWPdPdK5P4siUoMCJqKUvnpUdkqPJNs6r1VN7HqnYp9O6oSO/r9hdHB
         sbsw==
X-Forwarded-Encrypted: i=1; AJvYcCVNsXth4zi1LLmZfzNg5yFikepRLCTua/Y3HBP06S6/hGK+dpDQ8yQUic3/Raz+eTzt7YQ6byZtM4jkrx6kI09Roq7z+qOGCE9pZ2D/wM/D
X-Gm-Message-State: AOJu0YzHrJthb9HVljCBqfNkf6i0AMYTyIo2j5U6ANg3EQg4v6Bd5sJZ
	gwwAkykcskxjmfihrg+wr4u3IeBRqxvQCo4ykugs2F0dEfax+PTbZXDKsYI33218/slZcQornHD
	VCVaC87pRn7AmEzB+1gttmyeU1AKeeaOsMDdE0UCTESFr7/LVow==
X-Google-Smtp-Source: AGHT+IGEalrN8Y1clv35ZyNYg5HFsBwJ9BjVUYPVovMUPxvCwRYlIRA5gvDMxrAFpvWJZ0QCYZ6hS4Lq7p37QtNhHuY=
X-Received: by 2002:a05:600c:1da7:b0:422:ff8d:5d25 with SMTP id
 5b1f17b1804b1-42481da99bcmr23335e9.5.1718917257464; Thu, 20 Jun 2024 14:00:57
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619202659.work.532-kees@kernel.org>
In-Reply-To: <20240619202659.work.532-kees@kernel.org>
From: Rae Moar <rmoar@google.com>
Date: Thu, 20 Jun 2024 17:00:44 -0400
Message-ID: <CA+GJov5YCiStd8YJu7NsdtkS+zWSdmksZgAqeRMonRfGO=26JA@mail.gmail.com>
Subject: Re: [PATCH] kunit/usercopy: Add missing MODULE_DESCRIPTION()
To: Kees Cook <kees@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:27=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> From: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Fix warning seen with:
>
> $ make allmodconfig && make W=3D1 C=3D1 lib/usercopy_kunit.ko
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/usercopy_kunit.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

Hi!

This looks good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> At Jeff's reminder, I've split this out of:
> https://lore.kernel.org/all/20240601-md-lib-test-v1-1-a728620e37d8@quicin=
c.com/
> since the file got renamed.
> ---
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  lib/usercopy_kunit.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/usercopy_kunit.c b/lib/usercopy_kunit.c
> index e819561a540d..77fa00a13df7 100644
> --- a/lib/usercopy_kunit.c
> +++ b/lib/usercopy_kunit.c
> @@ -331,4 +331,5 @@ static struct kunit_suite usercopy_test_suite =3D {
>
>  kunit_test_suites(&usercopy_test_suite);
>  MODULE_AUTHOR("Kees Cook <kees@kernel.org>");
> +MODULE_DESCRIPTION("Kernel module for testing copy_to/from_user infrastr=
ucture");
>  MODULE_LICENSE("GPL");
> --
> 2.34.1
>
