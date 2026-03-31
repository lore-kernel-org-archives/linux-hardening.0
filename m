Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDDD43E4AC
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979279; cv=pass; b=UqpKd8Iwyzqr+MymU9g+VZNmkDNapp5B034/K83WUiWFZZO9+fYyIXwHgCqLhHjcTC6xOAmwlHikC3JY5btBDu/K47qmrQpQAaDc5PudnqtigNqI6QLZMS3jo9SUh5Q0e9fWXKCXmbnh8gh/+tldrNvx5U1xshH0+ugYIEXasoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979279; c=relaxed/simple;
	bh=0gsHE02IRJdRhrhJLMxNqQrK8YKfaYio1tL3SdU4Cww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZkZLR7QtdCbu/Z4iKTfnMQwTCBIchFPegF/6bUzv/EkoH8N/8gJQLXQ5C3f21ip5X/9Rtt8XF1iECzI568CPZQo3U6xUHlN8bsbz2g+eARypWpW1RUZRw4cJjjiB0CujE3Np3bvr4Ehg8y6e8UcbDCdkIZ9NzcIxvKJCtfhUPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btmB3XFt; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btmB3XFt"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124713e4244so348174c88.2
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774979277; cv=none;
        d=google.com; s=arc-20240605;
        b=Kt3EoFfU1Aa1DVdQFKzg7bfPYxFqyd6wSmhj0Nu9sZj5y+c/Q2M+97Cs0VRIcL9C2T
         N1Df7O3DnckMMDAWwTYovSXPcNmVtx5XPDNW4HqOd+pQ3ePK41Zbkr+BbJQsNTA+7pgx
         XOp87zQQCGQmqeRONZaoJ6jlqAl674QAtU6b5hg2VLh/nsK+kyL7twm44bigiFIBy6Uf
         8o2kjvbn1T739NFd4oqEG7e3DUFHb+4V4qPQVOrmjIh3hMVsmlryn0iZGxviY9BF7Jf0
         ukeSY4NXWdSIZm1Y2LjixI3qJNkr7AGEf9sJM+nu9VAwqFbKytTRMKIqPSoSx636vB/0
         Whuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ysi2hafA+ptpgLLenBdk3UcWnvRmrwggzaNQGDWt5QA=;
        fh=SDeFeQinDBZGX7PdugP2MOo164nZVWlax400DuWjcwo=;
        b=a0/b1AHKfAcEqotQTHRt71MX8OC6n6Pfhf0OlmUlc4P5fZlbaMG+1LmiH0lZVsV7qb
         8lCjNmyCKDWHnl8DJdST5cn0UKJgtJ5MA/nefdKbG9J46dOlxWmxmdqXv2Cju8M2qE+U
         UAKqLwkKAm1g3WWLup7KddYo2RLpkfY4kf6ipneiZnOxNTTO2VfVzsmYc1giMqHHorCb
         gglvQNL5hdYew6sAiMoWi+xPrhVlHEFkFEHbPbHs0o4ALMD8QvRx6p4RLR76nDcD46QE
         4akZMUDefHtUNtUcVjDcQnwqThWd6U8/Jptzx8LlUDlkONWizX9dWwKbnBUrqKDKcWo5
         RzIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979277; x=1775584077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysi2hafA+ptpgLLenBdk3UcWnvRmrwggzaNQGDWt5QA=;
        b=btmB3XFtp4LixOK2c4UFCeR5b6tfKUvUYhR3vnU3nFxkJHl4SrrkPapy+cHtb30M/v
         k1eXNFxhdIPR86KCcF51ufDyUS//+/wo3RjBmQTQu6lejkedge4KdU3fsh+PzNJP/8OV
         PtxHW274Ra/LVp97xypVHozFahjLQ22/etehT5ibRL2HZIoent9W2lsWOK4IZNWWktfE
         rUAcPv824IJX8EgDkjViOgIdIyU6sIH84G3U6vMUyKalbRVvU2COz0dOzghIK4RSlk6T
         B4W83BsNLiVSK4Yu6Z3Ucb3EBOWLFwRQzLxOmUW+/WdwxBLZUufRDHbCQqSNIeb7xW/4
         39zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979277; x=1775584077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ysi2hafA+ptpgLLenBdk3UcWnvRmrwggzaNQGDWt5QA=;
        b=jUH6O/kan/HQe0r57i1K2b0N5LuhmSMupgqw9CDh7syegTM50+bQefoefmFSfayBZu
         WEJm+R5JE/OzATReT4xikWPkQDUZMB26ZGCN5l/zh3CCwyntkGH6fNN0zil+FNKXAN3H
         R1mIYCBJH16b2GsIuUrWWSLVtb0U0Lrt+n1tUJ2YGG9hTUi3IQUB3Yuj/noBC6SjcP1C
         xj/ttfZWUQBBebDvuyJEwkbcivs4dPB4JSoIuGpcf8dyTx/EARnPf3PFCncZloTXFV4A
         avoxjjjsXS2hYJTGqdHZuHVwCo1DrriRVTkIerhjZvEsSm+EL0t3LET6IvTVDHOhwyIb
         IMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUXcOWNfBMqRnpFMiS6d0ZPk8Z620jhvE5PlFxaZ1f6uQyIfQUvqM9a26/vfZBWDHEVDcAFQwFb5Z0X8yzlAug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXvzu9I0C/+/1XPDupMlYj2db7bXnzGBHRovktEA8VheTSdrr
	w4yUX5kVX0Z1PdzMssh4UdPjvA4TztsHdEZSbiWTUKdUKV1ISaodYoxYe1pr5FaCSbT9nBvafMW
	l1CK0KU9YUEBGyxwzCffcuN9HOcVg8FA=
X-Gm-Gg: ATEYQzzO7iNO6QMM4oIGs5LtxXRfaGGRbXDe2dMnT4mleiCUn1GleXoLqsLQOlUKuy6
	vNdCGfJAWMyiYH5uCw6BrQLsOtZcYOFyq7Tc/Aaei/s0bAhGXkDsAGWDdzQ7WYVd/w/xFznhIt6
	+LqvMQyaozwxfnjl1c2jW1MfR/Tr+0dUuNnGFc6eZq8fs7YUrEd5vdYNDf+tsdyGz1TQmK5Xk+u
	YMVutFPKDJcLsNyu0N0FLY4vv5rGVzJK7M8iAei59ZmKKzg3erbiTDPvrV3fs9vDPovesywIxa+
	ZYG98yHjySNz58S4R5UctL0VFggfNqqSRHzfwLjgjiDEafdFW+eGbSt7yA7FsAPh29WQ2gpUkav
	VjZ0NXZXtPV3/I934SL+Hw8U=
X-Received: by 2002:a05:693c:3013:b0:2be:1f56:ed0d with SMTP id
 5a478bee46e88-2c9333b1713mr40887eec.6.1774979276969; Tue, 31 Mar 2026
 10:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-5-kees@kernel.org>
 <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
In-Reply-To: <CAHk-=wiJ6Q_qMHSe-hs+QvqKVZphvDZjvFP_gQLw1eaWimv8+w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 31 Mar 2026 19:47:44 +0200
X-Gm-Features: AQROBzCQ6Wo3TBLhc4gV7S4by1XCetN63ihcS6-yEhM3XyLxgnvaM_4biv0PCmo
Message-ID: <CANiq72kL3rTKyDNYmD7wXiKCVJSfa1bnp2L8NShXU7OPmWjJ4w@mail.gmail.com>
Subject: Re: [PATCH 5/5] types: Add standard __ob_trap and __ob_wrap scalar types
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Mark Rutland <mark.rutland@arm.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, Finn Thain <fthain@linux-m68k.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	llvm@lists.linux.dev, Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nsc@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 7:11=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> No stupid one-character things. If we go down this path it would need
> to be "wrapping_u32" or whatever.

That sounds close to similar types provided by Rust, i.e. if something
like these types are used, then it would be nice to match names if
possible (assuming they are similar enough, i.e. no surprises).

e.g. with generics they do `Wrapping<u32>` or, in other cases, without
generics they name them something like e.g. `NonZeroU32`.

Having said that...

> This needs to look _very_different_.

I think there is an actual risk of someone e.g. copying an expression
from one place to another, with the operators behaving differently,
yeah.

In the Rust side, even if those "explicit" types like the
`wrapping_u32` you suggest exist, we generally use the methods on the
normal integers instead, e.g.

    i.wrapping_add(1)

    micros.saturating_mul(NSEC_PER_USEC)

    self.index.checked_mul(page::PAGE_SIZE)?

etc.

The advantage is precisely that it is more explicit and avoids
confusing the operators when copy-pasting code and so on.

So that could perhaps be an option? Kees et al. have been thinking
about this for a long time as far as I recall.

[ And for the usual operators on integer primitives, we panic by
default (configurable via Kconfig), but at least that applies to all
Rust code, which is all new, and kernel developers get accustomed to
think about what they actually want for a particular operation and
whether they need one of the explicit behaviors above, so it has been
good so far, but it remains to be seen what happens when we have way
more code around etc. It does mean someone copying a simple math
expression from C to Rust could forget about it, though... ]

Cheers,
Miguel
