Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD02DEA7B
	for <linux-hardening@vger.kernel.org>; Sat, 21 Feb 2026 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771705894; cv=pass; b=bEL7Qqv79idfy6W8RKqRip1wSqYqoideLmO6N7UmPer0/3Rdq8Sg96y0M7FzxTKK3LmgsWmOhLhEmsjwWiMLPssmkj3QToZ60rekwiEmKvJYxvQRGQ2qVHFVlkkLR3ig6uaO48PyVV+MhhYIkKJqH368jBiU9s6G1XqOS/6tHjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771705894; c=relaxed/simple;
	bh=FrJ3od3X8M9bOPnstqA2Hb/cX/Yif+NbwT5ilPFnH3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxC1p3eS6RDQuJ8jROjO09Zq5cSB+cTA5aBN+6uoLdMgYNoDHDApAKTtxy9c5aONIt9wIZ/CtafBLB/L3kyXMAIeyB0bSBxFx7ornuJ1C1T5aXc+TPg9JK5rZIJMFettkgt88Pc0SU3VPRslH2AuJj3C+/QX36ctU7Yfa15vAwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6AH5HFN; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6AH5HFN"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bd5658b901so99598eec.3
        for <linux-hardening@vger.kernel.org>; Sat, 21 Feb 2026 12:31:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771705892; cv=none;
        d=google.com; s=arc-20240605;
        b=S7Je+3GXxrst8hmB034Q7DkpYuTxGrCRHksIJbFfs4ds5SSx9Wms+UacwMkNoBv4VB
         uqFazY3Le8YZQPgJHZGdWnY9ek/7dT3wQNKxtpZ4yHzzGK8CpgyyaqrhAGziNw5lpzjQ
         UhY+R2ZbFxMJZZwxESUo/cjqEPG3ggo48fuib81IPjwvcPYNoQaxlX+y2HjMRzVf+PsW
         W3kjRK0ehaKHGhkY5SvkG6wc5kaQ9HTz6tI8soQBVY5ZKa82aV28zd1xD+wkasEA3g81
         fGPYBDvAYtFquWOHrdesklyr9715U2J6y+JeFNCkXWD91AT0HWGNQrtEIewua6G9Ml5p
         h07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FrJ3od3X8M9bOPnstqA2Hb/cX/Yif+NbwT5ilPFnH3A=;
        fh=oGfN6HRI8tcrDNlCnFn7a2rh6Q7GpvZdIFG/NhuKbcI=;
        b=fPfLo7PNuGSPFUg9Xe6sx0U2DesaxxFHEcOQqlTR9ZtcvHCJoSGNjQ85Hoy3nSv4s+
         tv//qQfI+7ou5g7Yg/d9aet2wGMIXlqUa78E3/xYscfGo+ATyHTGf5k2vIpUcAJ81uK2
         waPGgbZlhwkm23q0REOtzRcpRXL8xh3G8AqR+qDCTlnOPFpiKgDarx9ftyYYhObb0gXp
         HBWj5cOYIaMUI1LrP6VVJfpISYh2iCiPtcYe3gFYlynbGQCTTzQPC4v6613nbwZHa9Us
         taJVM+UQ1KYNIYdfYXHOFlX8KMPUIfalOk9Y66pLrMBhCVan0vxQJ3imQ0EMJL/0Q3qj
         I5xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771705892; x=1772310692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrJ3od3X8M9bOPnstqA2Hb/cX/Yif+NbwT5ilPFnH3A=;
        b=k6AH5HFNGbr60z2XbCACCeQjrWalRYfvgDryc4Kjkox0RDdSPWdxvo3gO+OJSrdAxG
         Yqv81mTFOClKD6uRnUGNaz3pJMHL9Gt4DwNKJf16yQ4ayx6gRWq0GR6BtVY5MWRw+pUF
         1TrHp6zis+z5MaefMr6ckdNPjGTEMvSCCw+UnyyVg8Hg9swaU9cSjr8LNX559peXWV76
         aMImXoW7t3/O3JTVBP6wpgmu+0nYOoizzWaO88k0e8gIOy0JppGTsTCT/knhKmLroLOa
         93zQ6ehr1GIcpOtnAeraJSGhank+yAB+oSyPo0JdeAVL0k35R0akwI6bNLaPPtYLkHDX
         6DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771705892; x=1772310692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FrJ3od3X8M9bOPnstqA2Hb/cX/Yif+NbwT5ilPFnH3A=;
        b=rnoWYbqNbHafzM8dYWvKOaVg6E6wQjwX+FKs2120sGv/C+wFDsOZuB4/y0Vg6F2R5Z
         o2/37Bw5LoJj/ZUp3vCnS6EV58fQnvLlkQUy4JswjYN6rZA/3yr+rTLXeOSmPm5pH92L
         7veAo0j4aD2ZO30IizGZ2uTdL+cslmD8eauQnDED9Ccy4fddbcARNVQaWoLw9VmJv78K
         oaHaT7Im4RgCWuR7QOAMWJR4BS1gOqilP7vJHsJvl0b1qBAoVZyA/6vqAUdDqjYPjwyA
         8iLn2d0uqkPsHk4B2T5Rj9XBkrlTWvXAMgoQ9NooJYxeCG75FConuSosA+PYz/U9bs5L
         /OVw==
X-Forwarded-Encrypted: i=1; AJvYcCXlR0s05leff+Ad2Q1djvjZki+youhXoJwgcksfrAZ7SErV/xx8a6UnXHtCI8xRPPq9qzhbMf37Q2eKD3jkdmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpapITDPJK4w7NIkomveVS5R6MF1l6vNyHRvKFyTo+xZVFV/nd
	SxK/NEPVwfQsuCspmhLAvwIymW0a4AHGv6jc5oXNrwiw2C2JIKM9TkfQ9tYUuOk+dJyZy9ddzdd
	oMYTRFjG6s9CnbTEBQZEkpM9g1NZcR4s=
X-Gm-Gg: AZuq6aJcTg/VpKQCftMbinKXf3ku7dvM7TcCzvrHODFOtcvKgw+j/QvK+dyIlHS15FF
	yk5aCK4JJppHLfR9FDLHmHWHI8FDnsmC6q4nuLWq0+ZBZwnR3aPle1ugN029R63FMcRpCL0WuWq
	zxWvOT3IDU7r9Ef/Mr0mUKpapfYk/Q4iK/+zgi3mMnx7Y2BkRUlUGpfwfnby3CAxYIZenRMSdAY
	fWuNyxC0dtOalgkIpSBWH88kffrXehkCuTc2tOVaMJeOPD+G17Ah5bDan93GrncoajnODrNsShq
	HTs9Pbhj23Yz9xJyj0hVYoj5RkwZedjNofFvSginlw82Va+5R5Fze8O9rBwZG0YESFC336C5QG/
	gRN518QcpruOqhziQD83dNo/c
X-Received: by 2002:a05:693c:310b:b0:2ba:7783:d1d1 with SMTP id
 5a478bee46e88-2bd7bb62b24mr903258eec.2.1771705892150; Sat, 21 Feb 2026
 12:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221081659.1742800-1-stijn@linux-ipv6.be> <CANiq72nqwqTmCzKb=rhRhUDg8pju_RB2zzCKnJ5hDrVTUVnhPA@mail.gmail.com>
In-Reply-To: <CANiq72nqwqTmCzKb=rhRhUDg8pju_RB2zzCKnJ5hDrVTUVnhPA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Feb 2026 21:31:19 +0100
X-Gm-Features: AaiRm52aBfPYjtJMkeqYa1pVE2nBJzQoyEJKXJ-q7qII8d--4j4XXVFdcCdfMEk
Message-ID: <CANiq72kuP7P8NL51S2J48q=epqd+4F6iPXSPaVCF0ET7rAN9Og@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: disable GCC latent entropy plugin
To: stijn@linux-ipv6.be, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Emese Revfy <re.emese@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 11:46=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Cc'ing plugins and Kbuild.
>
> Kees, Emese: from a quick look at the plugin, it doesn't seem to
> change the signature of the functions (and even for variables it just
> initializes), so it seems OK to ignore it for `bindgen` purposes, at
> least naively. So I think this sounds fine.
>
> Thanks!

If nobody shouts, then I will pick this up soon.

Thanks!

Cheers,
Miguel
