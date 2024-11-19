Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209D19CD17;
	Tue, 19 Nov 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005360; cv=none; b=bouvEuO2o9xIjeIEyPbucyatCRZCXpoOYR7iHi4CD9VIFrABtwMlsd5QOyAkty+3bx2YVC0NoN8Hxbtjf3YTFUMpcLWVJqb0pGjW4s74CSpqqFp7aPJaU7G8/+yqv8+DW8NhMhBJgKgh4UltADN9nMQ//0Zy+BI+Aa9mKAa5gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005360; c=relaxed/simple;
	bh=XH01imPv0mUK7wiVASyHVNO8L5toIV4S09y+kyvkR/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dm9UmLZfOl9JIxPlYzViaO6qZ9bF1MaANRkTbKu1Jv5mj8jRn/dfmPyJksvDmauHJ2ihT04iTcItbsprjfoWQA9lUSpE6/ldM+ULT80vGKPdjIC0wKqFMpYLj4DjQG58Dr82GU8NvOQR2HfhI3T8nkDLHXDmGZ8zP9aQmdD7+84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tmk+CAE5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tmk+CAE5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so872085066b.0;
        Tue, 19 Nov 2024 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732005357; x=1732610157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH01imPv0mUK7wiVASyHVNO8L5toIV4S09y+kyvkR/8=;
        b=Tmk+CAE5WoxihEt8VHsKP0LpgtNessUTXtLQqDuyTaOGDXn5dHaesxvm+QyMjvVhgO
         AoS8Y7MELO698AceocSUYvFT3rI/vdAcwJ5/u89k4QtVWM7kakE/OxlLbQns8Na5s/1J
         tmDndVahEuhqq6Ft2/QvIRe4dTBKPQ3LWBHBAbUhStMGJkTHXnQ3TDwsoFgmZ2IX/Zi0
         qw8XGVLUfYtZYGp5BFJYXK+0nL9ScboVewbCjgYYZA/bYFxXOIcmVAuer9rvQG+v6uA8
         Zgxf/x/FXumfzV3+lDUGAWk+3PsYXtaljb8++9k8HMo2h50l4xTc91KyXHOxCj9502D7
         //8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732005357; x=1732610157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH01imPv0mUK7wiVASyHVNO8L5toIV4S09y+kyvkR/8=;
        b=aqgWvfPID7JfVIurb5usrcb/d+wlnnOTqzieJ1arNBqGqOoPhLSHoD35QQC16I8fqy
         ug8MX84a6FpmkfDSrYoT6fPH7Jh7hMI0p8yTPqDeVSVLmuFB7ryo5eLFvM2d1wVfqlhR
         jsxJAChlxeNG5YVQI64s7ZTgcYSplolGlYw3W5IJCb3+L7XdRVbYO+k0R7+cvbLVca3g
         tFWHU0AKN63CY4K5QfuIChXoZVF+Y8LWyILc7W8XUo25DueT+mg+YtxfgpbgYvbDNTIz
         xbPZATBKSgUPDHebcNuTj+9Or9k1G4LopYQecHg5q4J9p1uAIT6SDBrwS5oqlJ/mg7/p
         lyXg==
X-Forwarded-Encrypted: i=1; AJvYcCUX2DWuRVL44faZjgK/IPfGdK/7rvxK9uMXOkzlS7oP9azOoFX1g5h33WNbO8m2xknYUtw4DzILIZEjaT47Fgc=@vger.kernel.org, AJvYcCVvTioI5tiKxstiAN7sNPr2EyXFiTBj/8ROp8qEn3EIaZvM/DCjr0ecunNuT+cCM+yUJYdjJg2dILorYXCs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52bOICirlb8tQQEMRWeLS2WxQcsAi/0YdAyYhfc2YWxvfb57P
	ljXczyo1VHvO0bSvIecp4MBtlgOZ7iJH9gP+ufJ987ZBF1rNbwcwNVyeNQq/fw3EGbmO0rFiUQO
	VpCgh8IYQu4376J+qR8hIm6WtznU=
X-Google-Smtp-Source: AGHT+IFYaZeyEuXhJPY6zvB7VMX0yvUH3CyiNLAiSAU82nWk3gj2d9UXTDD/vlL//n+632YG26ttYZR2+UQ0UozMokc=
X-Received: by 2002:a17:906:eb52:b0:aa4:a814:3f78 with SMTP id
 a640c23a62f3a-aa4a814447amr664100266b.1.1732005357219; Tue, 19 Nov 2024
 00:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119021719.7659-1-prosunofficial@gmail.com>
In-Reply-To: <20241119021719.7659-1-prosunofficial@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Nov 2024 10:35:21 +0200
Message-ID: <CAHp75Vf_2+0wCsQWCUojzE_WQ4KfE6DCGKxURZ=s+Lsh4TdTfQ@mail.gmail.com>
Subject: Re: [PATCH v2 linux-next 0/2] lib/string_choices: Sorting function order
To: R Sundar <prosunofficial@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:17=E2=80=AFAM R Sundar <prosunofficial@gmail.com>=
 wrote:
>
> This patch series rearrange misplaced functions in sorted order and add
> str_locked_unlocked() helper.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
