Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9F1DA5E
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240238; cv=none; b=KD1oSQRkZ/lOQ5U3xjXIQHgXWt8PP8ztvkbqfeRgzF+667Z1xH5IjL+8Vxzma/+FMo/34nvcuBRqb9qXhRAwd58burUU+hm60uBam2In1QqTTu2A/OrPFJf7hqKX9ZS/A2PLCnSJnfXbPJZnqeFuFOdM9Sv7O5DXUz8SBwUWSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240238; c=relaxed/simple;
	bh=plI9VQ8PNkZ0Z7s2DW8Xc/jOMVJgY+/ameGpL8Yn5Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWc19JPUVmdm8/EAbDkkkiYwFCmDZRZpWGif8pvjfjevGn4lfUOHMF6z9SjqMxXQkGVLIPH9IIf2HH+wEeHy0A4qMNg10ByOX9663p+ogfZ/kRs9qGe2LHppxjXjysZXUKwopbM1lsX8jnqa9H+I7nXjhFlJmnB7bWj4tJMTchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E3o+CiEZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E3o+CiEZ"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea5dc3c79so10069065e87.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721240234; x=1721845034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgdx7vvSTCDmReVymeTt0yzw+JJTtSiE4bn5RhejZQg=;
        b=E3o+CiEZoLi7JCeAKmJQj9uC7Ws40jxFyfUx7SyQY6wBWmT78xoygh+51UEKOqL/fE
         JYA82iJ1Bj+Gp3IG31OVY/Y5TsL6gg550Q5iMckl1oaCYTUNcdjORSFFu60x8XXXb9EC
         TjudTpYazFppQHYH6IbYZD82BPsaa5xaabLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240234; x=1721845034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgdx7vvSTCDmReVymeTt0yzw+JJTtSiE4bn5RhejZQg=;
        b=eTvlexpX7abVdVv5GIBHxLFo9Tm0YxC7IgibMop7hFXxOyt1m2Y0ow2EIqhhHO227C
         IMjt+awPiFYgPbo+HP04ik5HmkE2CcB3j1q6bnVIBl/Aw4cb1z0DmZczLC0MBMziIveI
         o40bT59OucPy+L/urfpgjvOOx1WNz48VnEmqLcapCIDECcD1O9BSutcF0LMPFxB3MaAZ
         WjA5ikaRd3AanulqRcRGRJTymR1dlowM8uJhEQlPTiKfgL+KD8AuX5cYIcMJ8drqWmwg
         TbJsxGTqfZx83KSBy3GyybZLKGCctdDHWsO07IXLE/8bE3PmJiBwUOzx4Uq6gIX4P85a
         j2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUeZM1gmaE2ELoD0Xg8XlwncdVMHXAuKCCRPlxNTwBQ61hoHha+70/8tD0SkMGIwrRboDbFE0AVzRU1s5QEX3zHhPPeG3eG80BUd5Oej+N
X-Gm-Message-State: AOJu0Yy3kyNlXbYd7wtMUC0O7/D9HNxMYc+fd/jZnr8/1GG+hn8b0doF
	2bjlGePR66myv+DeB4Ux82baXQXOqIJHZ9TdvPibsGjOtOypsAuXYGHzdZFMKBp1qlQI38TmTCF
	OoIPqpw==
X-Google-Smtp-Source: AGHT+IFdOZnk5ZydjRLypEmRq7gvDuPHS6MufoJ07HTa1TXS0Bjt5ITyrY12nky1O1JFoDg+oLoH3Q==
X-Received: by 2002:a05:6512:4025:b0:52c:cc46:d59 with SMTP id 2adb3069b0e04-52ee53b6803mr1893106e87.18.1721240234070;
        Wed, 17 Jul 2024 11:17:14 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eeacdbdb0sm35051e87.248.2024.07.17.11.17.13
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 11:17:13 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eec7e43229so47341fa.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jul 2024 11:17:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlPez5AJTO+374DYm9BkL41HbJtoWzNvdWcOc1giiXhC6E5pzZE5IgMpupaNtyTt2dbGnVb+l55uzcivd0FeLz2vyecYC2oXvZNerdQ8Fg
X-Received: by 2002:a2e:9b12:0:b0:2ee:7b7d:66ed with SMTP id
 38308e7fff4ca-2ef05c52bbamr1815371fa.10.1721240232921; Wed, 17 Jul 2024
 11:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717111358.415712-1-adrian.ratiu@collabora.com> <202407171017.A0930117@keescook>
In-Reply-To: <202407171017.A0930117@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jul 2024 11:16:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
Message-ID: <CAHk-=wi3m98GCv-kXJqRvsjOa+DCFqQux7pcmJW9WR8_n=QPqg@mail.gmail.com>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
To: Kees Cook <kees@kernel.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@collabora.com, gbiv@google.com, 
	inglorion@google.com, ajordanr@google.com, 
	Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a8f0be061d757832"

--000000000000a8f0be061d757832
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 10:23, Kees Cook <kees@kernel.org> wrote:
>
> For this to be available for general distros, I still want to have a
> bootparam to control this, otherwise this mitigation will never see much
> testing as most kernel deployments don't build their own kernels. A
> simple __ro_after_init variable can be used.

Oh, btw, I looked at the FOLL_FORCE back in 2017 when we did this:

    8ee74a91ac30 ("proc: try to remove use of FOLL_FORCE entirely")

and then we had to undo that with

    f511c0b17b08 (""Yes, people use FOLL_FORCE ;)"")

but at the time I also had an experimental patch that worked for me,
but I seem to have only sent that out in private to the people
involved with the original issue.

And then that whole discussion petered out, and nothing happened.

But maybe we can try again.

In particular, while people piped up about other uses (see the quotes
in that commit f511c0b17b08) they were fairly rare and specialized.

The one *common* use was gdb.

But my old diff from years ago mostly still applies, so I resurrected it.

It basically restricts FOLL_FORCE to just ptracers.

That's *not* good for some of the people that piped up back when (eg
Julia JIT), but it might be a more palatable halfway state.

In particular, this patch would make it easy to make that
SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE config option be a "choice"
where you pick "never, ptrace, always" by just changing the rules in
proc_is_ptracing().

I guess that function should be renamed too, I only did a minimal
"forward-port an old patch" thing.

               Linus

--000000000000a8f0be061d757832
Content-Type: text/x-patch; charset="US-ASCII"; name="foll_force.patch"
Content-Disposition: attachment; filename="foll_force.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyq5yyfz0>
X-Attachment-Id: f_lyq5yyfz0

IGZzL3Byb2MvYmFzZS5jIHwgMTYgKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9wcm9jL2Jhc2Uu
YyBiL2ZzL3Byb2MvYmFzZS5jCmluZGV4IDcyYTFhY2QwMzY3NS4uMWI2NDZjYjk2NTA5IDEwMDY0
NAotLS0gYS9mcy9wcm9jL2Jhc2UuYworKysgYi9mcy9wcm9jL2Jhc2UuYwpAQCAtODM1LDYgKzgz
NSwxOCBAQCBzdGF0aWMgaW50IG1lbV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBm
aWxlICpmaWxlKQogCXJldHVybiByZXQ7CiB9CiAKK3N0YXRpYyBib29sIHByb2NfaXNfcHRyYWNp
bmcoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQoreworCWJvb2wgcHRy
YWNlX2FjdGl2ZSA9IGZhbHNlOworCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzayA9IGdldF9wcm9j
X3Rhc2soZmlsZV9pbm9kZShmaWxlKSk7CisKKwlpZiAodGFzaykgeworCQlwdHJhY2VfYWN0aXZl
ID0gdGFzay0+cHRyYWNlICYmIHRhc2stPm1tID09IG1tICYmIHRhc2stPnBhcmVudCA9PSBjdXJy
ZW50OworCQlwdXRfdGFza19zdHJ1Y3QodGFzayk7CisJfQorCXJldHVybiBwdHJhY2VfYWN0aXZl
OworfQorCiBzdGF0aWMgc3NpemVfdCBtZW1fcncoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191
c2VyICpidWYsCiAJCQlzaXplX3QgY291bnQsIGxvZmZfdCAqcHBvcywgaW50IHdyaXRlKQogewpA
QCAtODU1LDcgKzg2Nyw5IEBAIHN0YXRpYyBzc2l6ZV90IG1lbV9ydyhzdHJ1Y3QgZmlsZSAqZmls
ZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAlpZiAoIW1tZ2V0X25vdF96ZXJvKG1tKSkKIAkJZ290byBm
cmVlOwogCi0JZmxhZ3MgPSBGT0xMX0ZPUkNFIHwgKHdyaXRlID8gRk9MTF9XUklURSA6IDApOwor
CWZsYWdzID0gd3JpdGUgPyBGT0xMX1dSSVRFIDogMDsKKwlpZiAocHJvY19pc19wdHJhY2luZyhm
aWxlLCBtbSkpCisJCWZsYWdzIHw9IEZPTExfRk9SQ0U7CiAKIAl3aGlsZSAoY291bnQgPiAwKSB7
CiAJCXNpemVfdCB0aGlzX2xlbiA9IG1pbl90KHNpemVfdCwgY291bnQsIFBBR0VfU0laRSk7Cg==
--000000000000a8f0be061d757832--
