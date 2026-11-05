Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793920915;
	b=AHdcLkkSvOYmjRh38dUCQbX9v2aUc9jw+G7tfTELdCepmiRAgO5UTx4t5OhlEJHJ9mzW
	 DCu0vL4ST9ndfilpxi0nmYJOQ2TT8tVUiT11aozu43HYjMJaPQhKOeqPxogbCsfippu4a
	 0HHD/zNEjAAu3AWk0CGDyAlj9R3LpwJRo7ygv2OxdxVPvtzIiODLRDtNegzjJqYXnR6hM
	 m4NeLJr/lVT0URkkCmpG3QZ1/BSgJ5RLvxAzx3OHELKVXQsZ/CPv5V81ZVbGTYfMDlulZ
	 4D8xvcyknHpgfZAORiqLVBuCWUg+ng7YBVnm/VlbidmSytPLVUD0/p7BeLeNrwA7nKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4CY6kteulYS6YGOwsvXKGn1qUkLcgM9XJ2I0e0tk+JA=;
	b=SBRSWJe2FVj7NJVbCe/IzS385IDaqoJacTyRZAiKHKvNFrAw9FAfpVfzhz8a8VTbWp6M
	 cBScMyVZk4ThKc8jpsrsWOgn5TNGAOH9G6hO5uYARzie1HUpAgHu5u9L6ilY2ahNWTNG/
	 jM9DHrupqc2+gcZNPpFdoEOUmaqBbCTc0LAJXE/QFvdgcXdWbmjL5gteulaNAjYVKKMUE
	 ITzqAPIKgKmebduotd0bN43jEI4SmN3Oj8F7eGyxfC1+mlKV4THu9NjLM7nmq5YrfmWgO
	 9S0g4zsay/sf0ZqlZzT0JE0o1J1EAX13n/mh7ePoT0cuN40E8HHwX7h3bvEiShH+0pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gPo9SPxF;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756B606A31B
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 23:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A756B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=gPo9SPxF
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso14882a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793920913; x=1794525713; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CY6kteulYS6YGOwsvXKGn1qUkLcgM9XJ2I0e0tk+JA=;
        b=gPo9SPxFi2rVLsKhGrCqqE5hE92NbFoq1Zi2JOci1ChfKUbD/F6dG9k1a30KNoO4ZF
         wClRGp+wp2ZjBS96hWxBSQamrLKtcD7VPC+k7NnmR7j7oQdpAKf8jlOaJBX3V5M92Mfj
         b85PiFEwv9zEk1nfcT8S76Bsz/+2lc4z+sJno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920913; x=1794525713;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4CY6kteulYS6YGOwsvXKGn1qUkLcgM9XJ2I0e0tk+JA=;
        b=kW1KNdXrPGDu9IJIALlRO9uD6QV8xlLpcyxfBjZLM1o5iXfGqfX9jpSdiAYcEHiAC3
         kTXuqku9OEvObJ3GCB8Z7TUHVmrIPxg0RcVkObtGXPR1XlC+GvHZ7GBXewoztwQ43oLJ
         fzsDdpXoyg7sVowG+BxloBTCmkX01KCxzabllcKAKPd59KzgqzVtpSxO1EqafBIv2owj
         NhfbwietDYPkfBwumq1CKPCP1cKL9EIcFeD1Y6n02ZCNUrk1rK5/4k35opOoS04bOZJS
         gRIMdSMTbWlteuxf4jNuRy+kOJRZjHBJSTz1iUzlcp4PrX0/gciJ5Jw8FU24g6fCq5lG
         7WEg==
X-Forwarded-Encrypted: i=1; AKwUvBxGCuOpCVD1PMw/0gy1oVCQWP1HhOE930yudir1/8qJKpUO6j8rjXW+Gw771VzJDDOArclFTMrnC9I19MPCfOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B9uIx2sHnyU2jYp12IB6C/XiRbdATzKEANQMt6nwy5Xx56Uy2
	b4ENDq5EA3K1141rqlPKFmLdSLpj89ZQbG9NliLKvv/UxoeenTz544/u6Bntf9xiFo2dkJCa6Ua
	cP1ZTeucO3w==
X-Gm-Gg: AYBFou3JGUxviFPEZkiCc7etKyFyhokVW4x8ns84zMu6SHgfxllMX0dDsHBZnvQUMqw
	VsmbMpv6SBNEaStUxF5Vb5kHMfDzMI0dW9PCLRIB3YU3dGt6KOfrdCmxK67c+cxee7MSESABrhb
	L4KZsUbrATgBKggzkAEjxm346PHdE4pYjsJbNmT8Q+r7Hb3iz6hIwPitN/1OxcXaLpUQONfRiwz
	zc8TTQZKUl1eNjA8XkQ82NgemdGaAa1YF/FZ7luKRgLEC1owkf5JpKoLXx6PhGOd3wbCTVJIanM
	XyE/pQwrTXkLeHCSxClDrbW1wWGsyC9ENV6N8+dyz0lxaSMOMMrBTZeMjbdriAAXua8nfJv9y8r
	gdiT8i1LxR1G0UG9bIsQ/+piNwTdaro1Ot9jNbx2SIXBp11yLTApvmRaKSEn5N5dHSlq+0mncY/
	6J49IcKReBeqivRVxFWDYUzNFEGyko1lIq6dZWMMBPXlTn45uTag31hCzyAC4qn5kjU14ReWb8D
	32Rn3zaq8rzQ+kye7T2C+MoUGBTLccwcrx1yu/xA2uLg5rf2srU2K8YBdPF8bK6q0BrRMCVMJ+v
	N1DL9CrHkpviSXT7KHCfLLUSextexnKoU4KAI6BHOHFacargrSACHUcTVjHrVN1qPezsA1ewVg3
	/lQ==
X-Received: by 2002:aa7:da4e:0:b0:6b5:7fe8:5275 with SMTP id 4fb4d7f45d1cf-6b59782684bmr331835a12.38.1793920912952;
        Thu, 05 Nov 2026 15:21:52 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ff8a6asm2652a12.32.2026.11.05.15.21.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 15:21:52 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c423b145922so5866366b.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Nov 2026 15:21:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzs7X5WSUCNcOSo7JbmqAWGb4WO5OHI2zS81Q9cRV4tJ+nkBzKqFNWsgvA5ohXTQNNhZOskIxkoJFmdmNeCrX8=@vger.kernel.org
X-Received: by 2002:a17:907:9c05:b0:c41:cf68:bbcf with SMTP id
 a640c23a62f3a-c4d34c42700mr81823766b.32.1793920911855; Thu, 05 Nov 2026
 15:21:51 -0800 (PST)
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
 <auzGMV1YbO9DodBq@ashevche-desk.local> <auzHFRzd86iV4-RA@ashevche-desk.local>
 <auzxXyAU6zyHtMtn@devuan> <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
 <auz79Izf6Q5qOQPi@devuan>
In-Reply-To: <auz79Izf6Q5qOQPi@devuan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2026 15:21:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>
X-Gm-Features: AclHuK-tRyoIoIlVqV1ObINoCwGUeXX8nUrj1waZW-FHLSpz23irfQuKt09nDLk
Message-ID: <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate str_has_prefix()
To: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-hardening@vger.kernel.org, 
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

On Thu, 5 Nov 2026 at 14:25, Alejandro Colomar <alx@kernel.org> wrote:
>
> I'm not a fan of git-grep(1), because it's easier to remember grep(1),
> as I already need to remember it for other stuff.

Why?

"git grep" is *literally* the exact same thing as "git ls-files |
xargs grep" that you apparently find so natural. It takes all the same
arguments as "grep" does.

Except "git grep" is way more capable if you ever go "Oh, but I'd like
to go back to an older version".

That makes no sense.

> I'm finding some issues with git-ls-files(1), though: it's listing
> symlinks, which grep(1) complains about.  I wish I could discard those
> with something like '-type f'.

Christ.

"Doctor, doctor, it hurts when I hit myself in the face with a spiky object".

Stop doing that. You're just being silly for no reason.

>         $ time git ls-files | xargs grep ARRAY_SIZE | wc -l

Just do the sane thing. Look:

   git grep ARRAY_SIZE | wc -l

Trust me. Just learn to write "git grep". After five minutes of doing
that, you'll realize that you should always have done it, and you were
silly thinking anything else.

And it's faster too:

  $ time git ls-files | xargs grep ARRAY_SIZE 2&>1 > /dev/null

  real 0m0.636s
  user 0m0.367s
  sys 0m0.307s

  $ time git grep ARRAY_SIZE > /dev/null

  real 0m0.519s
  user 0m1.837s
  sys 0m1.719s

(I used that "2&>1" to obviously remove the errors from the stupid
mis-used of xargs).

And it's *safer* too, because if you have filenames with spaces, "git
grep" does the right thing. Your xargs thing now needs to start using
"-z" to git ls-files and "-0" to grep to actually be safe.

So just embrace "git grep". I can pretty much guarantee that if you
use it a while you'll never go back.

            Linus
