Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679FD331221
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464912; cv=none; b=JFaueqqXPAhea35fD2KWfuHEttv7eQYTjHs5lEwgOo2k2M1qjq6paWviXPB3AdW6o/FzX79hqEv/NtVwYpw93QyEZmVj/a2Y+883IA5+LZ2QcLMCPwnldkFxLJjfWCMG9XsPzdwxbg8hZsJhuvM0rIvL0xg1ah6q5uPQgZ+f30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464912; c=relaxed/simple;
	bh=B1FsBCLZ1091fdu3CKfazhUK9tOtY4FVr3EaczDF5Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZh5pAWnIYHz+y0wWSfStNUnN02UEWAXZf9s5DqCN+Iwi3NjjH1NFHPIzhmiQcJOdDKepBDoMTreJbUrUWu8yKG1GF91/y7EvLUpKSNK9CXHW0E1/ggCx5VS6BoyVnp0w0Lad+Wp9ZbnR8mbNB2dnxyOcCZMPshNcU5P7UcdQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-559836d04f6so3388822e0c.0
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 03:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763464909; x=1764069709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prvcS1Nj5HxJbRS6Jy4uHehWZnJysfpIngTPCq04YCY=;
        b=w4RbDwK4d5UBcrfeHDnMd+E0gnVU39HG2of0AJTHr3qfZ+zqIDIyvDJmGplEiGbT2y
         +Y8TiJH9IkCVpX3tE3DrrVtDlW4MyaRSD1QnLLaenTOr/2QFOsFI3VwKJTD4ikfNN5mD
         yUbuMjbOXxitQQmgqe5iOws8Ws5GpXc6LaFUJEVQ/SovD3bWJKIqpyiH4OogxVTgqBJz
         TZWrqNLp6wfn9NZqKq9BqagoIMPiV/VMVrtHvk5jiWON+QFu6RGYWgGZyvaq5ArZj+Lh
         3k6a/VQ/jF92xelcZzJsSQvbQFvrg4hL8Dnh4Jn8Qt6GCwMs88bFAoCw6RbvhsLmaE11
         2P1g==
X-Forwarded-Encrypted: i=1; AJvYcCVtt1ty6cE9ljkj412Ws7GJUV6/6mwj20c0bu22PknPWOyQfw8U2OAoe+5hqxDBenzpSo67V3EdKc8oV0zvyPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTA4xlJJ2EFOPAtIcLmDj0GZPwy6JD7ruEMvlkfnbmBUfrdNSP
	R8Egk8Q/otelGu69LproN7znSILDz6Y3uIsHzpMJds7ZqAufAw9VhvYKW9jOJw2PzQk=
X-Gm-Gg: ASbGncsoRWOLahwmbnWea5DkTRXr33gV1aaQymql36kx9lx+1BzV09RhppDxWe5p+CI
	JN7wlE2e4lbAI48y3T+jWya/fLKJybAWJyd09trcSBz78j8latnaO7NSKkdyhAl26ntG1MdgVqr
	tIKOm04nDvXbk3rTkR4C19Yk3+OqTe5DFLX/0uNPcyriFYbLlg8KWaKmlHC1ZbmTnvBQnhn1Q1D
	pkFw3jkC4xClKGEdqcCVSrmyjbNkLgJWsD2f4Q8wy14YdKfOnp8baZwnpXGXXC3zFEAqEwTdZs2
	8gjoxyOAekHHCXzON3SnHgcxx3K3KLPZAXar22Yfb0/iR6mS1M3LjQF0bGISxazFz2xZ4E+zeF0
	YR8pP2pDwe7HzTyMZj47r/zHNCnM9m/42xcvhNKWvxq7E13SdDlxhzOjFgUEVcywGzdiQlGT6QH
	TZh46GUZ35ARdWc8sTYeRkXwracI/qxfm2fYS9QwLxm6AFmTwBTGOzaOJhUkA=
X-Google-Smtp-Source: AGHT+IH/i8ErAJLO9N01HaTYWEbVb+GEHM8EMAknDOtq9CHALfRWR+obfRXpcvKYtF6150m6iUiZKw==
X-Received: by 2002:a05:6122:370d:b0:559:6092:936c with SMTP id 71dfb90a1353d-55b1be0404fmr5214482e0c.12.1763464908903;
        Tue, 18 Nov 2025 03:21:48 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f32f178sm5137914e0c.5.2025.11.18.03.21.48
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 03:21:48 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-932e6d498b2so3267521241.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 03:21:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhPkkryzaSXJcwGAP2xpYqP43/VX7SvLRKt958hJOYys3cdEA2CIR7oQi8cQEV6hJflls+y/HU1IXLmab7rlA=@vger.kernel.org
X-Received: by 2002:a05:6102:4189:b0:5dc:7fe3:1d0 with SMTP id
 ada2fe7eead31-5dfc5586babmr5642681137.19.1763464547898; Tue, 18 Nov 2025
 03:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
In-Reply-To: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Nov 2025 12:15:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnG1e_JZjF_t0LAgzvKf5wM6L4cWt2t2bx5VV8t6YS3prQ_Mx2gaFVEov0
Message-ID: <CAMuHMdVR9Z70+M-SqHYrHiC6H_yw=VRuDOOg=YnXSNKjPnx3WQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] gpio: improve support for shared GPIOs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Wed, 12 Nov 2025 at 15:05, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Bjorn, Konrad: I should have Cc'ed you on v1 but I just went with what
> came out of b4 --auto-to-cc. It only gave me arm-msm. :( Patch 7 from
> this series however impacts Qualcomm platforms. It's a runtime dependency
> of patches 8 and 9. Would you mind Acking it so that I can take it into
> an immutable branch that I'll make available to Mark Brown for him to
> take patches 8-10 through the ASoC and regulator trees for v6.19?
>
> Problem statement: GPIOs are implemented as a strictly exclusive
> resource in the kernel but there are lots of platforms on which single
> pin is shared by multiple devices which don't communicate so need some
> way of properly sharing access to a GPIO. What we have now is the
> GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> doesn't do any locking or arbitration of access - it literally just hand
> the same GPIO descriptor to all interested users.
>
> The proposed solution is composed of three major parts: the high-level,
> shared GPIO proxy driver that arbitrates access to the shared pin and
> exposes a regular GPIO chip interface to consumers, a low-level shared
> GPIOLIB module that scans firmware nodes and creates auxiliary devices
> that attach to the proxy driver and finally a set of core GPIOLIB
> changes that plug the former into the GPIO lookup path.
>
> The changes are implemented in a way that allows to seamlessly compile
> out any code related to sharing GPIOs for systems that don't need it.
>
> The practical use-case for this are the powerdown GPIOs shared by
> speakers on Qualcomm db845c platform, however I have also extensively
> tested it using gpio-virtuser on arm64 qemu with various DT
> configurations.

Thanks for your series, part of which is now present linux-next.
IIUIC, this requires the direction of the GPIO to be fixed?

We have a long-standing use-case on various Renesas R-Car Gen3 boards
(e.g. Salvator-X(S) and ULCB[1]), where GPIOs are shared by LEDs and
key switches.  Basically, the GPIO is connected to:
  1. A key switch connecting to GND when closed, with pull-up.
  2. The gate of an N-channel MOSFET, turning on an LED when driven
     high.

Hence:
  - In output mode, the LED can be controlled freely,
  - In input mode, the LED is on, unless the key is pressed,
  - Hence the switch state can only be read when the LED is turned on.
If you have any idea how to handle this, feel free to reply ;-)

Thanks!

[1] https://www.renesas.com/en/document/sch/r-car-starterkit-schematic
    (needs a (free) account) Page 15 aka schematic 12.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
