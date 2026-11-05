Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793915641;
	b=BGcDSs+y88c4Ir/tZeGybx8WSYwfuajUh6jvtHC9Ar90RX/OqbvDJ35zi0ouAYc9yvFZ
	 X6Odu1Fl/1ICY0UH5Sg6a9kuR29Y9Z4uiX5zYaZ6JbJ1M0abAUQxtB5RBUbaO8ZrP0rMY
	 gWPGvnjF4DIYpBg8LAPX/uRxJgqJeY788GupmuL6cNZ19t0axpVrf93Sp96E0K29xbZ2N
	 5eNpqa0UB+uP9yhGutpb8d//WNqi+9aavOFkZJB7mXmovqKFD5uiKQad5twO5wtn4jdj/
	 Rwf0G/R0q2pf16EfUw9OItS7c0Ges9S4I2Ns4JrTjLetikcO39P5HjVSfbSfNBuv/nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=l8n+OopgLwypxqFGetb5HIgCgsMRDuPspITkC+2T1Gk=;
	b=gf6r6QRFFMDaGIthZ9PE9FCWrUONFCassFu16L7gQfQRbvCIBjPPZ07w5KJqNmJnSzu1
	 NtCQ168ooH+bU0RaMTAUpsnLVepfuMKHCkcOQGnUn4iZdja0N/VkWF5nJJ6VaBQdMwv+O
	 thSO9c8rMTKwhf0oisnaT7ipkJPgxdGO8Go24v+05mxwusnGqjFKoonpAIesI3wTypWvk
	 /lXpnWXZfm/bbKMpUpIRH2FxJCISvC7ktB6mrEUKTZBGvt6pK7DWddpZyZifP1zsIJVzC
	 Cou7c5+j9YJr/w5WrtIwMM3dw2JZAZdsJooJxrl9IEKzzKVIGrvcdh5r/fSJ2YjamkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=MfV9AI4+;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2223606A31B
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 21:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2223606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=MfV9AI4+
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b57182c4c6so2459611a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 13:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793915638; x=1794520438; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l8n+OopgLwypxqFGetb5HIgCgsMRDuPspITkC+2T1Gk=;
        b=MfV9AI4+9+3yFfAFj+fC5uXrdcRWgE3qdD4NzBpHI1Z2pg1cNnvt7bUpgsJH3G1sZu
         /G/pxpD+tCMIurmKYElpvWah3L7k/sFx5bCDoBTLSZGj6h/6Ls+t5PrYifrNFCBJQ8mb
         hl+TVoAJeSfc5VH4kVzvvaIK3nmqv2A8Hp0u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915638; x=1794520438;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l8n+OopgLwypxqFGetb5HIgCgsMRDuPspITkC+2T1Gk=;
        b=KNwWELpYNRHmd2aRzmtWy/oaWM3CWcyFxWbWz8D+0/4NQItayZkH8TdmGa4B8Gru8l
         2S5/6+pIQxvhzFihM+9HfcQtcJnHWFkButlYi7pEXarWXoAa1EuFdEeE+LzLHbr0igUe
         iV1tmDIYP/bLNCIgcDh8S/X3Fk5Xl2kTntCu68brHzPGcq2A4aatGbwRJDs2D/fORgrV
         vCqGx85ury5S8FSEyra1uVoid7kGGA/ktBvpj8DZJrbPkwlYRg8sgTqOIvmC4o39QnVd
         2B/x/r7hBDYZplUys2KnkDsBRJ0XroZFFXm46IR3BC9My8tPCiWZ+XM2kOzdmYiB/u9v
         mcLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxV7j2iSfkOwGLJj71CF/2V11/ksdn6QDM85YdeWTKSLFFUizW2/sDDwsSb2dcXHlSXhRCGDWY1oFQS+hKJeE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KFSTXqJKp1/kQ1ES7Ol7L0kbb/Pb2/S0dmRB6cak+5iPeDlow
	g6lFjwyAnphcVsEQlSNBWhAyCZPz5oJVW22sxw9tfHvvTil6yUn/4ZAJvbIoTDBYWLYnGjmkgUy
	FZuOZY9mkuA==
X-Gm-Gg: AYBFou3UNRLxNPTMVAL0D27lfBv5QdciWG50zKn67CG64Da+JjgQc98BDTuyOVY8TjB
	iEW9eP6HlbwVsFI2Bqt+6H+sZohohglTluYnbwhQftS1oDiFXBFTVgH2OUKeuE6AG6lEMvSZzXz
	Rlp6Z5IJJ9dGPBVcwKnYDssAvEJlieQ7w7BjIsc7AaqnD6Yeq9OW5xw0Z8LHlo760uHW49lMoXO
	+McpVSsFknLFXMdwq1mQihLmsir1s4rUM8B1drBvZtEReNlZs9aYKxiMZsIiNFJToFhQWtCs57F
	FkoL0CT9BvYeU3IJnfIlvkD429KKeEpCPQBfMzDPxxoHQFeVuofFuT9ubuVV648bBEXP2qlV3PG
	k9lZ59dtjbSU1eaSChkrgEznTN5Bk37ZqWiKQ7HKUEc4Fq9NZoPm2AebF1B4Qcnq0XTrc3C77Qg
	Tb9nFQohswJSDt2Tsc2D5kZmDaf7wJzz5FzSmeIP1WB9tKXdPwR5mxPpud0aT0LAa6zgF6ISWZo
	WtJPJemv6O1LwcYxUAYLlA99wJt3vDsPN2/ElVhzhYqOInVK6XCjcSz7ZM9P35BJfXooycIxHzt
	ZFAmEqYi+OLxjT2+C70woWmvzUbpIeAfPQRmwbpN/GxkAhKf6TJWhRr71AEmk/0x4BQF4ETwfO+
	bCg==
X-Received: by 2002:a05:6402:428e:b0:6b1:ef16:1855 with SMTP id 4fb4d7f45d1cf-6b5977d14b0mr338014a12.18.1793915638010;
        Thu, 05 Nov 2026 13:53:58 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b577ed823asm1106587a12.21.2026.11.05.13.53.57
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:53:57 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so2573331a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 13:53:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBypHPJqSTzuOIprjdRP2t/4kAqEAwF96XeG9HybbP1cMOfJAeWXwV3FovU41AA27+3KcYf71B/qKmociuEvinA=@vger.kernel.org
X-Received: by 2002:a17:907:2da2:b0:c40:b59:1b with SMTP id
 a640c23a62f3a-c4d34d39a58mr58567866b.44.1793915314942; Thu, 05 Nov 2026
 13:48:34 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org> <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
 <20261105111423.360f4ba8@gandalf.local.home> <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home> <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local> <auzHFRzd86iV4-RA@ashevche-desk.local> <auzxXyAU6zyHtMtn@devuan>
In-Reply-To: <auzxXyAU6zyHtMtn@devuan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2026 13:48:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
X-Gm-Features: AclHuK9v-o21t8pmiI4INk2NQJoSrOcmPCpk8IDpuzUs81f6KLpwaM7gxXogW80
Message-ID: <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate str_has_prefix()
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alejandro Colomar <alx@kernel.org>, linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 13:24, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
>
> I think it might indeed be that find(1) is slow at filtering, because
> using git-ls-files(1) is faster without piping to grep(1):

No. Your find | grep" speedup is because you use two cores for this.
So it's slower, but does it in parallel, which is faster on a machine
with idle cores.

The reason git ls-files is faster is different: it's because git
ls-files is just that fast.

And it's so fast that now the pipe overhead is much much more
expensive than git itself, and so doing "git ls-files | grep" is
slower and only adds overhead even if you have idle cores.

And the reason git ls-files is so fast is because it doesn't do any
directory searches. It just looks at the git index file.

So git ls-files really does something very different from 'find'. It
just looks at the files that git already knows about, and it basically
only opens '.git/index' and parses it.

You can *make* git ls-files do a directory read: if you ask for "other
files" (with the -o option) then git ls-files will basically do that
whole directory traversal that 'find' does.

Anyway, if you search sources and don't want to care about object
files or other generated files etc, I'd heavily suggest using "git
ls-files" and "git grep" exactly because it's much faster.

(Ok, "git grep" isn't always faster, the whole regex algorithm issue
can go both ways, but 'git grep' does do the same "just look at files
that are actually known to git" thing, and obviously it can look at
different revisions etc too, so it's really *good* at greapping the
actual committed history, although if you go back in history you'll
obviously be paying a much higher price because now the cost is often
not the regex, but the unpacking of the objects etc)

            Linus
