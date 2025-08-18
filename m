Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061727603C
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549754; cv=none; b=PGpJCej+zvgU53myoN7E3ekV9rjgofFjmwQzufvXUKcY/uHCZOq4cVcbIifsajnzF01UEAf3luoVlWtegReDsg03X5Y4E5zAQTaKjRlCJ9+fZwY8LAvgBX02Juy6wif3NvbgvMzFwO9KLvCPac7petl1vXjKWIpv3y5P9U9ob8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549754; c=relaxed/simple;
	bh=NmR2/IL5WTkW71fZow9sS8wK7G2c13V/YGNMLRRHbV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsBPO3/dN/8YyuDrizQ+PqMs83iKPgWOhr/RKpdVH9wl1GygpGz0OucroBiAbMkAvEBS5uUmZ8kKSuy0qZXQfSmhC6/LhPjhRqU+pvVgoDylRruAHIwEtYlAZg5j5KPw3qIZwbC53VYDsZsl1QyKXIfl5kbga5IXePVQ935rAHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YHLP25TC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHLP25TC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so5759539a91.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755549750; x=1756154550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a5SHWZT5ObhjuEG18Uce/tsKkrsIEanMlhP2HGBzsE=;
        b=YHLP25TCV2wDFcvliv9QbfyCd3g4edLLBcyYys8bEsm5tABhbrB8snBB81t/8j5D7/
         8tFg8+CoHVRotCQmm/RwUExOz33ZdWNZDpe+3fpXiGjvavZDhIUeNhZaXWD63Tz1t448
         pzSbPBEQ4YwsW41n+rh0Y0oKaMMWLNgy79bSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755549750; x=1756154550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a5SHWZT5ObhjuEG18Uce/tsKkrsIEanMlhP2HGBzsE=;
        b=xPv8iXIBCP8mkAmMNlm1L+PJ/0JHW3GxW3aLvmzr626ZloX5kpjDHCynUf4U/B/wa6
         ZYGEjfjB8ctSkbP1vsZXXdwRKOgpv6GyxRF7seJgRKcLgUtNSxP2L8Ug7icIyD7baBoy
         3jbbFUJRZFhGIJTAh4gLl4H3advH92p1gBKk0dxHYLj1Rhx6pizGIO08yZeJO+BFSlEf
         XB0TCAuLTsTbKdCFmfWS6jGN1iizrFxMtp3uzV0TRr7hoUv5JonbfRZZhpCu2ShuwQYS
         ezrxIxbZnnkhx+o38MfDwhg52VaeETU2NXTCuhdf3q1alUh3p8/bNsGtXNZhp1ZgPJ64
         qCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjRjqymdQLMeOiZbXKZGahvlSELGz81IG6gy8pgfUvbM+2uqkbkAqjHSbc+U3KAwYGV1W1t7b8nZFQDzV8WVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPTtnEjMYaDmQkNbG7onFvClTFe+TGRqDSAj/u+n4dhrNMy9k
	AjImWr5u0HVooTL+kUR3y0Z2mbhxYG0JgXqe9CSm2jhz571XqQRIrwgAmXPqZNZrmZ89kiyGZvR
	IyriynFCS
X-Gm-Gg: ASbGncuvV+3OljLJuKz71qNtNAOhrg+U2dz25Tm//vhB32ornEzA+gr8GdbhT4QnmF/
	RlsLWZYhqu1clX9iBnSJeMOZWP294bJqYik02FlAK4f6+S9aui+kTUDIWnI5llg9xYpdFkvV3P7
	Ar/dIueK2QpdDIlQwhMSCjrx673Z5iTLtsRW4SDE2WvKYUMBEeJld55VqjbfJy1XKCOrX2sgl6O
	rQBirQRlW/rDztcubsmrQoSkm/AyHNDus140NNmKpwGTeEK/Akjq8s6Xrbgi4YQXB7VBgisJThn
	uIUrKKxIgyDbupZVOxQ8w+B9gL5SIf9/EhlgDmw22c+g0gdgcMKUGp4saG9x6SZ5TXBAMjavAbc
	QzSrK1BZYnOH9uYp8OSPL1asga4B6qOygPGS8OsKdZzxFYMDdAZLjgq8xaVGJBAB/fw==
X-Google-Smtp-Source: AGHT+IFXmwV7xIvbcqwneNAvkixpTOMO3c+7p4BrthILcqA04Nh1LxmG/NrVdiFpX0GTkU6cne+3xA==
X-Received: by 2002:a17:90b:58ec:b0:321:9549:66cf with SMTP id 98e67ed59e1d1-32476a2edadmr397956a91.12.1755549749673;
        Mon, 18 Aug 2025 13:42:29 -0700 (PDT)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com. [209.85.215.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3237e3c31cdsm784176a91.3.2025.08.18.13.42.28
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 13:42:28 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b471740e488so4442439a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 13:42:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuMnzsP3jk4IN9tEQzgSWQKsrfhnwoDDVdmaJOynWGRiDM0vJBTlvvVqAqiA+U5yK4bT0oamLsMoA3ZC6BMgQ=@vger.kernel.org
X-Received: by 2002:a17:903:28e:b0:243:926:b1f3 with SMTP id
 d9443c01a7336-245e030c986mr619005ad.24.1755549747360; Mon, 18 Aug 2025
 13:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818181153.661431-1-thorsten.blum@linux.dev> <20250818181153.661431-4-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-4-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Aug 2025 13:42:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhEeZdCwL0kVmDHZF03q+Jp5iOiUvbNNoCDuBr3os9qQ@mail.gmail.com>
X-Gm-Features: Ac12FXy3Z47CKyrKqijfaotNViVGOwKbhTPJHzFwx9GEuH8Qe5j9BxC7wx8gFu8
Message-ID: <CAD=FV=UhEeZdCwL0kVmDHZF03q+Jp5iOiUvbNNoCDuBr3os9qQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kdb: Replace deprecated strcpy() with helper function
 in kdb_defcmd()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Nir Lichtman <nir@lichtman.org>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Heng <zhangheng@kylinos.cn>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 18, 2025 at 11:13=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> +/*
> + * kdb_strdup_dequote - same as kdb_strdup(), but trims surrounding quot=
es from
> + *                     the input string if present.
> + * Remarks:
> + *     Quotes are only removed if there is both a leading and a trailing=
 quote.
> + */
> +char *kdb_strdup_dequote(const char *str, gfp_t type)
> +{
> +       size_t len =3D strlen(str);
> +       char *s;
> +
> +       if (str[0] =3D=3D '"' && len > 1 && str[len - 1] =3D=3D '"') {
> +               /* trim both leading and trailing quotes */
> +               str++;
> +               len -=3D 2;
> +       }
> +
> +       len++; /* add space for NUL terminator */
> +
> +       s =3D kmalloc(len, type);
> +       if (!s)
> +               return NULL;
> +
> +       memcpy(s, str, len);
> +       s[len - 1] =3D '\0';

Very nitty, but technically the above memcpy() could pass "len - 1", right?

It doesn't really matter other than the wasteful copy of 1-byte, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
