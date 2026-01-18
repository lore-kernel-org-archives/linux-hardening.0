Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9F23B63F
	for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768776400; cv=pass; b=lSj+0BwXBlSWXKg5MEon7QTxprWBQkfjKBiKDHZV6iXzwfvmKoirZgpr8qYmozoSYoQOK7LLkehI0V+RQQcX2Zv2ISuPr+pQO7B6vThGx+wAokzIey+EqEODmF3idIbQifXaWD2Hqz0T1OqxqN2ksrKMQ2sfS51b/g1i9HO3vBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768776400; c=relaxed/simple;
	bh=2g/7cFlPY2ZAdPsMyWoE68vAlVX/dSFDy6oQHwex+sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+EmLovnpgekWOtST2K1u3zIqhU5+zCFgAMUZEdt/cw2xZGztFDH/BdiWHucRnR1Iqk0MnLxnYWsSo/GRrI8sqXzp/V3eRwW15ETfGC3RKkf2iS8FQ/JkDoERhNFiBdSboKRc4z6j6tL1rkhG+MpC4/e04+EEOHmMJWmt8oaouU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiNKT7sU; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiNKT7sU"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6c1ec0dd6so186788eec.1
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 14:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768776398; cv=none;
        d=google.com; s=arc-20240605;
        b=Hhb6nV2KuIFJyKUdjPsaRZ4Iw2tOuhO2a7jN2B8mq+aZnSG5YEbJpiwDecSkw26K4J
         0C6Y7kSKgsN3nfIi1AIL4bx8qt0i+NKeSLNkwzX6BoaEmmGfLWZZSKn71Wyu1cT+OWn0
         z4RQ2kCgC4Oz8Bei8d+HSN7McEUq0Csn/gzE/AuWyIHTN3a30J1KKwVyLprY2IyngpQ2
         6IS43O7LKrU6xK7kqV07sMxoCbq2KF3p6O0w3Kn37g3Q/LGR/gnOHSjhGA1EpDqgw1jD
         1VgGqDQ1T+yAbjSvptuW8UWWc470fUQdCxp4Tptyk2MojJ/kwmFSA7x6U771b55caVCG
         qrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HtVEsLC63/IRG9ePaQ4Wz532UEWlaB8YwqF2YosYYDk=;
        fh=64y5h7EjpUQ6q/te/f3H0g18aFWD8RmD2beJSu5yJfQ=;
        b=fgztMN4EsI84dQdXehk2g58qKjCgP2uD9DvfMwgGLpjqKjHeRymBcHj+fl8YOs//RU
         KqB7i4qetfMXRYhSykq3wClrleczi4Vpgy1S6CpN7YW2Ew8Rr2VIs6nFdaLEu+fq5Gq1
         dcAoog8kuv5Ij86hv7RsKFQ6lLfPij2/LbF/ukGQWPWD13qD9YW42pdhgBeS6BGtqpEm
         LdOHh5+gPJbRvvOevJ13pRhIRkbsEPbI6NvYz8/cYTc8IR+iXKpRFBHZS+NUdiEtB+BP
         fEoUIGNYO2nwkfr879cBCrMX5Q8iTYnhRdKzaQ0G+PJ8qMrWushN9Ds4DLd0JhZ53QZ6
         MZ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768776398; x=1769381198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtVEsLC63/IRG9ePaQ4Wz532UEWlaB8YwqF2YosYYDk=;
        b=RiNKT7sUt0UeJxtr9eAMht9VCrKQxQwvjkYqg+Nh+EbYjqdbFXEy5RFdOZLtYlL7P3
         tXtCh949D7x6+iVHHwyHcEczfLbRkvZtV0NAKl5Zj7TRa76H/4xfpm1SYn1lZMb6mx/1
         qMI3KdykDFWJdkkZyKN1BoeutmHCs3yInnJG0ieWD9cVmooCLIgU5A3SeGJhzay2jaru
         g6tkBAiZ4pA54ZnCrjBv2m3ZPGAgLMbYIWUISmhV+Rq+QJVl1BpPJp8k/kXSW5swbiuQ
         yufYPKVNBXGCSzWfIxIYSo58LXSpzBaDc1LVwzNj80Uop/iL/jnArEjMlP1r9z2WujU1
         nBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768776398; x=1769381198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtVEsLC63/IRG9ePaQ4Wz532UEWlaB8YwqF2YosYYDk=;
        b=YhW+EcOhRgvghPFK4EA0rs5i+VIQZ8ls1Zsc9FAmHIXkVBk0xfQ2EgVXCzJPlEElME
         r5hAWnCsh/sEHo8V3Q+PhIIPtYuLQ5eojMFXzk+QnB7UMy1/pLQekP/9H3f/5x0z+oi2
         UK0IkHbrrbRADlBqIWTlAS0fzPjf6xrgvEhe7h33iz2P68IDfS90/xzTM4AJqZtLwcdk
         c9ElyAQqcC5RYyGRXk80EtHRblxPL1Xw88Q1+uFmj2bZGnGxCD0ncELGZmwH1jXm33rq
         bXQGSjeqzb3VD+suMX7KRrjh964p55ajKcoZTzEzh/t3I0HvUt2+jKG5ENt7BqiwdAJ9
         NaCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW65P45ge7m3b22HDCq8+SyeZGX0InDgabTAb0IttFp2kMqtgXrrxS2xUksq8M3aTcTzAWEtHd68O2HwrkAHms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qd2b5cJrZwYaHux/yss6xcfFHCpYuNeM1giTjuy/efd2qwHQ
	6kbtRTM8EM+GOmapWtJkS+t5SCW6FZhcMfPyl+2fX2wuRLra7nJ7kpwgEbnN0Q5ofHfMrxcXF6y
	PQF28nPLxC777v2M8GRyiLmFu3MheMR8=
X-Gm-Gg: AY/fxX78Q12ibrpo8tNqAacktuh4tuR5afR2wXg1LWr6AHVLDjQxUbu6WEcyMn6Bu6o
	Sx0q6JOLiENCMkGiVTj8+bvTmr2bUaIV/pofQPBsotXtKrZun/9396d4b11ySYZM3LAUlgyrc+l
	LZrFnkZNkWSGr8z8/6FCaE1pKto44/7hEpEY5QsSDrTSKKm39TcwesmaJ7gj6e06HRcLK/rp6mk
	gALrye4xCIzgF2mbmZsZys8BhUNIscCeSkiioh7dl/6iI9/6nubDfiAsot1Gz0IE/UyoUQwBsYf
	w3FbvEGMZZNHk9pny8W6ooz4N4ocgsHr2EXX6FPDIhQ1TMhTj406XAqp0b3Cs/z6FHiH4IJSmM8
	ZecENrDyQpOiiHDqQVAzPTKk=
X-Received: by 2002:a05:7300:f18f:b0:2a6:cb65:1974 with SMTP id
 5a478bee46e88-2b6b3ecafe4mr3840431eec.1.1768776398161; Sun, 18 Jan 2026
 14:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221081659.1742800-1-stijn@linux-ipv6.be>
In-Reply-To: <20251221081659.1742800-1-stijn@linux-ipv6.be>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Jan 2026 23:46:25 +0100
X-Gm-Features: AZwV_QgLttooLq08ae1MGIYSqi9xhNf1UwvXHTfzNO4Jj3FY48KQmYnqWrzcVhA
Message-ID: <CANiq72nqwqTmCzKb=rhRhUDg8pju_RB2zzCKnJ5hDrVTUVnhPA@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: disable GCC latent entropy plugin
To: stijn@linux-ipv6.be, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Emese Revfy <re.emese@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 9:17=E2=80=AFAM <stijn@linux-ipv6.be> wrote:
>
> When CONFIG_GCC_PLUGIN_LATENT_ENTROPY and CONFIG_RUST are enabled, rust
> bindgen fails due to latent_entropy being undeclared:
>
>   BINDGEN rust/bindings/bindings_generated.rs
> ./include/linux/random.h:24:39: error: use of undeclared identifier 'late=
nt_entropy'
> ./include/linux/random.h:24:62: error: use of undeclared identifier 'late=
nt_entropy'
> Unable to generate bindings: clang diagnosed error: ./include/linux/rando=
m.h:24:39: error: use of undeclared identifier 'latent_entropy'
> ./include/linux/random.h:24:62: error: use of undeclared identifier 'late=
nt_entropy'
>
> Fix this by adding DISABLE_LATENT_ENTROPY_PLUGIN to
> bindgen_extra_c_flags.
>
> Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> Signed-off-by: Stijn Tintel <stijn@linux-ipv6.be>

Cc'ing plugins and Kbuild.

Kees, Emese: from a quick look at the plugin, it doesn't seem to
change the signature of the functions (and even for variables it just
initializes), so it seems OK to ignore it for `bindgen` purposes, at
least naively. So I think this sounds fine.

Thanks!

Cheers,
Miguel
