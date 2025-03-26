Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB91F4621
	for <linux-hardening@vger.kernel.org>; Wed, 26 Mar 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009189; cv=none; b=LeIUELpwwR28cGWhmAeb6KlOS/UcXgVvmV76V7SYbHBCX7JKuR27f1bOsqwbQtQYGTEvt5CNxh6DhN8WRsOV7HkP5+P29C1YvBYXRweUHpLjJIyr/EXt4dNSV6X8dOCmrW7QisbllL4EQuBD9UUH6BUPkqHyKv4Q0wUqNmHtnqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009189; c=relaxed/simple;
	bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQFdl28AP95XzISZqksgOb1hFRCczYPvjAsW8vEA81srb0urm1SrCCdkm3p4ZtqW/xEJ+u7kb/K2CgXx6WLmURxRQd1uMMjFnkGESDqLhg9qZJI8iR2rMPa+vNyauoSngqDrAdYMq+4a8HJaJh4qrv7qOL72ZFEI9hdNen3hPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ulq3LNU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ulq3LNU"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2264c9d0295so12305ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Mar 2025 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743009187; x=1743613987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
        b=2ulq3LNUbq8QlmlGGFHsJyljuyR3endfuqLV47tEye+OYOrJwCV85qm4mkFkiAZi0U
         0c4XJv7YGjfFcA7rB0v3qD4P1fhGIvN0X4AtFZmGJ4VIsi93w3bjFz6xu8DJTjql3JJk
         +QKDyBwF2yuvM3X9Qzh5dBImn1IHAX+stvGP8t62JN+ag3D6HfluNYbG1G10obJA7kln
         HnPEWvyiAZ6aZMlWfQMaPzq0ceoh7FJTK+iJfqU7tv4VnPDW4JYcU8BK6lL8m7EYLgNQ
         nvqMPmo0IrDpxmnNV8iNmvojvksxKbqP1i2IpUB8QfzKgbcfYY2ag7hXW4oSK3lutrYB
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009187; x=1743613987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
        b=tiU0gtk1VZ2jO4ROPvHeNC7IshRQC04mohNStjbmwINqNNLssPrdU1UXELsuzK8zcY
         yZ0wjVYj3Nzh4iCFpeIl2x3wwM+uczMjkl02RutNtio1eJje27YkfbIMvjlHoGVJWqKk
         keNklRds6e2tgI0Op+MvGHTCwS1LsXZvJqYLOm3Cnov9r5kWeBeRPjiv/OswVuxqRt4F
         DabgfLvp4Oygn/AFcF3eAP/ifcVaHph/LXmPtFtV0kGqBNLoHUF03f5WTd2F+NlIAllP
         nAIfe8CuakgTJ+64SUIqVGszEqHpscITBSKEcMIlOR/WcOCdzHDB1LTi6+xEZXLei1xs
         Ijuw==
X-Forwarded-Encrypted: i=1; AJvYcCXM2dE2fhXVdaW7yzYUTlSAXOAfg/Ki756p8yEsqKmj+kGAbaEMJFaLOiy4YW9oOTtdELwpyX2/95SPdxcHyVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Levb+63Y/u53CkJk9XnPDACHVo4QUMe7SJ7U+DGiAoinGyZ1
	l4QRZux1Eutmzd6DKkvaM+QmyJgC26BiXOhJlPDhj1zahfZYQXR6GAiUcJSDEvWCzP/X/dWsNRU
	Uj76oo52A93t0fOJOPWoIm73Y6lGM5chlh7ES
X-Gm-Gg: ASbGnctlq7UOP32dHQdr+T/SxQhuhhKE8my/HUpuEcPLq6kkyfITmx992b3WGoGsl/u
	fkFyvr6GNAdf44tVIXAhKM4AyxxKnF1CKBGacNn4avKDW8ipDwFr6fPdhbq3PRV1O4BlG1GuilH
	9gr4ERefouuEivDLUWlNBGkUq5bxd1KSgNQrilYFiHLYZhotL10139+3bO
X-Google-Smtp-Source: AGHT+IFvk39LnkeMkX25OX1JcG8F54jZn2W19dDnfX7iWusa4FMz7ouKzjv48eaBIVtkQbCfKLgP4xKq2VNnjn++uzA=
X-Received: by 2002:a17:903:13d0:b0:223:37ec:63be with SMTP id
 d9443c01a7336-227f365b723mr3316495ad.4.1743009186911; Wed, 26 Mar 2025
 10:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com> <202503251242.FFDB6940@keescook>
In-Reply-To: <202503251242.FFDB6940@keescook>
From: Peter Collingbourne <pcc@google.com>
Date: Wed, 26 Mar 2025 10:12:54 -0700
X-Gm-Features: AQ5f1JrGljJm4PeWBnKXpI12td-rU59plY-cd4apU9o-HArGlIBfJwqu8UHG7l4
Message-ID: <CAMn1gO5Ero80wm=P3_-BQAFPuefUr_VUBV-msTN-FD6oL_1Gig@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 24, 2025 at 06:56:13PM -0700, Peter Collingbourne wrote:
> > This series fixes an issue where strscpy() would sometimes trigger
> > a false positive KASAN report with MTE.
>
> Thanks! Should this go via string API (me) or KASAN?

Let's take this via string API.

Peter
