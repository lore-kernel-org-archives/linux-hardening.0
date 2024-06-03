Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7F57C9A;
	Mon,  3 Jun 2024 07:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401194; cv=none; b=cL9VXZeL3/ZI7WdpRYKnyuUO0WN9cy1bcRUuVu/0yjeOvTt1/5ExZAK0b39x8IBa4wUSPcEIO0l/80td3masGTHPoYziVN7rJR6LZ4Pu8MJJz/t4fOiaMP2WW5IyxOf28FnkkpZbgibTcoDA6I3iXwnmEZnfgpvRoaGAiveoGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401194; c=relaxed/simple;
	bh=mclJXgOQjhez+p33D0A652N1g3VdqkIxJIxJkj78IXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RarrHzi4or5RjEadUHGVUac/UN4JGBEBtA3yHkquk64H3bhCRX7sA8bbjZPTARat0J199cRA3JyZS6Ts1sDK7zK3faBWLgtiBD3TSFThrQjv+Xv2i1rnsXCcj9wZJeBPlsmYbVSsmnCgSS4u1Ij3fOZnjS0NdFGTvqCnakw/Jpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a2424ec50so41578697b3.3;
        Mon, 03 Jun 2024 00:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717401190; x=1718005990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXTaEr+raexc9QEG/NealCw1eG9smW9RzL5Ji2YA4JQ=;
        b=s6+byiYsum2Jy07uwQo74GVirhNoIzSZ534ZKcfXoZOUHCa8jkbdRjAcpg7um9FnOw
         +bjSq9FL+w/jSc9lN8LW7I2knsBAWPrIwRzZah6SHxQ0owTnv7TmLEvZLqyugeShqZyJ
         nX6n4JvcRljqBF6zAaaZm6Edg3HtkMTIkoMNLtamjglkCFI7PP9FiN9Vxd3wkMUFl/bX
         bSrz51TprnLqvYTf69VYp3Rov8Aw3i2WutuxokrCYhmkxsCevZ13gyinWTswlAnywklu
         TNAjXZ/gjwaIpKAwLGcHureYYaOI7UTPvM/NCBpMhQQn26KgLx+dGWp6WUi2+5taa9Tn
         o7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCW8xqjBYqe2il6PlW1PIaYs963z9TWAML6ilNnRQYAWdxjIMbt4Vu7Paq2BdvaLJWF7lZbE7cOSRiZpMvvhLV3WAuQZFVszexGNdOhUVileIwW8A5DttrpMf/tApm1hJSGV/aT/U+E9P6qel2Ef
X-Gm-Message-State: AOJu0YwdGIOxbjLl9RKnCRZ4UGOPCktLj4U15s/Yzsy5g/QZGmGYQSS1
	s83ZxIa5VgG4HlK5xO3dpwoDMba44suQZCnNJovWlQ1Y/Z/+PEj1kgGDIsAC
X-Google-Smtp-Source: AGHT+IFlgyx4QxbpCfrX+q/FoKonrinSiWGgiPaiHnn+g+lE8KxT2T56IMzaeiF2mbbhd3XMuXuQ7Q==
X-Received: by 2002:a0d:e2c5:0:b0:627:df3b:74b7 with SMTP id 00721157ae682-62c79494b10mr81543947b3.0.1717401190214;
        Mon, 03 Jun 2024 00:53:10 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c765b924bsm12393037b3.11.2024.06.03.00.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 00:53:09 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfa7873bab2so2204727276.1;
        Mon, 03 Jun 2024 00:53:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDz0TD+4A6QFtdJ/tbwsAfHaqAVA3SjvoFjbMuSWR5wBeclylaQcTBpjy/+EHsmErYLc5DlMRpya6J/XOfvN2iRVh25EusNmkrv5yJQtI5Qhhbgj2ff7tyxgrMAaQBxhCv+vkbKtH0ncX5PorI
X-Received: by 2002:a25:ab4d:0:b0:deb:5f9b:76fc with SMTP id
 3f1490d57ef6-dfa73c3863amr8567553276.38.1717401189552; Mon, 03 Jun 2024
 00:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR02MB7237B94B9A9F4580E79BAC0C8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB7237B94B9A9F4580E79BAC0C8BFE2@AS8PR02MB7237.eurprd02.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Jun 2024 09:52:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWnbAPN4rSsquF4GA=i1anay2+y5y46of255a5Y9O1qnw@mail.gmail.com>
Message-ID: <CAMuHMdWnbAPN4rSsquF4GA=i1anay2+y5y46of255a5Y9O1qnw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Use sizeof(*pointer) instead of sizeof(type)
To: Erick Archer <erick.archer@outlook.com>
Cc: Andy Shevchenko <andy@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 10:49=E2=80=AFAM Erick Archer <erick.archer@outlook.=
com> wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type)
> due to the type of the variable can change and one needs not
> change the former (unlike the latter). This patch has no effect
> on runtime behavior.
>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
