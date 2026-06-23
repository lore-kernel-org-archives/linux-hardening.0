Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8B3C1406
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 22:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252411; cv=pass; b=NaAJeTstE6BCa0gBCOjzG4+TVhCoxIytVxI5ExS+ui2QP527q5Wb25S3Xsl2gN7uvwxge8NlAeLyp0uc4XbaYF5eeIOFJ4ly+XHf37ErHVKGMlNzHlfiQmpWg8vFZftj7KN+NrbExmd9rPNySS3Wn2uDvGeabpA+U6bLJBClOuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252411; c=relaxed/simple;
	bh=P4Bjcc2g90rCZwpLUPfcYDqywWWZ3CPJdaKkyPaUlPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkrk33mxIfk+dbmigGjpDfQUrOxtdhx2hNJwuTjhsF9ZbEJHmvLExv8zvQpHchEIe2r1jhA40JDDbtEMi8K0/f1lZNAEQgWgLgAtGdU+9L+YLnTTtni5cJrcIH02qIfDddzQMmu5RMhOQ9yyZZdO0LwOObKyMaJlqFrPBZ78ZIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nn0nxI0L; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn0nxI0L"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so501408a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jun 2026 15:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782252408; cv=none;
        d=google.com; s=arc-20240605;
        b=g/4k/vuecN1LqATblNM8+OG5vqvRl7ka26rYK5W4XkYeRNNNK2nXEkmpqeVSqjGNEF
         NjG0FWX79M4KT7h0opoTEOx9kMinG9VR6RYN+XU6K38ZlvOy/qssctF4o0M7bXXCDr1v
         Kfsf21w3QZaFYrpvSpYzQBcViZwPN2cKf66iYh+SU1jwWVoJRuFjNtqILfuO0hxVISkg
         fTmB006NEkwV7jx1R7jVMY0sP3PhT1xTZ9+X/LjW4/QdYcc4kBZ4vXqpEANg8bXNVxMR
         u4er08MDuMqXrSca8vowodG2Ww2wHOa/xaYJJIsjR24Nzbdtbb+/Y+TVFAfE3o8U0jex
         tNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        fh=wXyyb6ujM0BLV4hC63+bA1w5xsKbAxrC8G7IoaMkX+o=;
        b=SQBagOsuP9B9guCP67I0U59VhFr0eGpXb+MebVCUHGTXmHOHTvPmh5UEP+aZw8BBEV
         NSeMf31nHMasCyYQu0n5zp96pHX9XpHIRFVOewGYKvrlKAdvlFgTP0aZlMxH8zvDlYre
         qYLuAC1//uRdmlcDNt98P6FqN20T6ysM2poSNRN7yMU7emGwU92DAxYDAbPqDo08AmRs
         /yL6T9e7qVxEEuddaD5MOK/o3XnHeToaN1Lq8rg3iJhzVbDrb+Hsm5FBRz4xk0FJWVnX
         1U78HN77C+jlGldPF6ZKgEV6pey4uJLR7NVNT+25eriotM1eqvc71VawwuwVUIYvXJhd
         ZkLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782252408; x=1782857208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        b=nn0nxI0LL0ujyTcRYudT83wXs5YAnXQXPEvbSakGfIUPr7OauhwhUAVByUfyjQsE4G
         3VsbLDTuZfm9pKV/RMoJiNnQOQzLQc9H/0AewOryQVRgcxSvH5ztRM7Kj83wf25Mwcj9
         tT23LPx8w1vNREnckrRCKp4844JqBv3D9kF2pbiKV1kxe6KD637tqtGmMFlMlxqj9igW
         g+/eLdjtEpl2+oM1TQfM6LU04V51mvvZ2U3aGgGrbAb5sJtR/X0gnWQz+nvIMxXvQYgI
         6bF65nHrwFEpZvHRk89RCsMlJYYmm6sSo098xDc1b2Cd+3xphLPphdQhMceBP0zCVIU7
         uIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252408; x=1782857208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XoJED+TBqNpCfXx2/2rhI9BnHRUNSOFVPTrIiEf4/tE=;
        b=pG7tBXo3Mz0LVu3J6cbQucsihtCJerawjRwD07k15bc/h3neoJeAeeaoGqPUygkoER
         xs5ARvSa0SG67cVBhF5yFQ00KGu3PHiqduH69amu44MImladf4hC2zcR+3KFKwz0upzt
         nVN1qC2CN2fEddSWLaO7twPoGdk1Htl3VltnNiq1tOl1J0K46a/cwrEZdYp/5SmTsT8C
         FOZUfJC8C2bXwmdZqSJf52p5UZ2d2Z0HV+Q/rqT6H9IHrxFYu5s+LqLTEtRuROiM20e3
         e5y2i/fAV3BYlfw2KdB1NcfT/yrCs3EGE7chymMolXV7CD8yaNwDRw4YL/9k4Jyw24Kd
         W+mw==
X-Forwarded-Encrypted: i=1; AFNElJ9cBj0K8fIUfoDRb6cliFB7UE38Ufj+i220kpCbZZCaAOjAw5ukyZApHT7Qf27gM60RKs/jbHtnXxeUrFpWi4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASKjgvX8FhN9m2HvEAFube80FajYd1QHhp9j4V17HF3DDnBbl
	Vv67+pGRkHAneH2anI+3LCMGIQmrg4U8JNep6uJEzevBi/s5+NG1e3oT0/+3vGi7ke2gvMQ55P9
	voxzwKWZWQ6kTuJkx6A/CJmZkFEEGRJk=
X-Gm-Gg: AfdE7cmpo6rbQNCErIO3ARvOIqACcsl/ikAUUIPr6F+O33YPTLEWkRBAQDuvU4kdpZ/
	Kg5D8HC0WagCG0A/0X3mcBAlhNjCzt0bFESZCZqhtAozIqSYpjLSHmGZlU7BgQVy1lEjmY3HRSs
	FuE6kswcSFmQe4JKEoLvNQRZg+u8tkhYJR9OaWsHD+XiOBBRvoDhXJvoHYhjU8WpqOph555FvWF
	5w3EHbr1HrxR0wg7fgS9Fruy+kXlxBfB7K2TOkWJU6A7p6bBHo2sd09wIdG0asM1P9euIwojYS/
	CvFZeTdXjAXygVQTaA+pz0JiU6/I5KoKrxx0hVGkyKOrKkTtYjKrEalDeK6O46/9ynlYZi+nv2Q
	pI4JV+9ApNiAGjMdnUcts+702Hd+RiFQkTDk357bTK/1e9Q==
X-Received: by 2002:a05:6402:146e:b0:68d:235a:cdaf with SMTP id
 4fb4d7f45d1cf-697f377116bmr189804a12.5.1782252407504; Tue, 23 Jun 2026
 15:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622234803.6982-1-ebiggers@kernel.org> <CAKxU2N_EGTWkvtPOxQXBroxGVXDf1atPoFVyRRu0wHOtEXVWaA@mail.gmail.com>
 <20260623214730.GA3281861@google.com>
In-Reply-To: <20260623214730.GA3281861@google.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 23 Jun 2026 15:06:36 -0700
X-Gm-Features: AVVi8CeboaDakYuMckubiPixxEKhNCjPeUq6olU2uxCUHJDj2YuT_JoocSvKBZ8
Message-ID: <CAKxU2N_yu1LZeNxEUkhahx_5VYML7PZ0-EZfP94p7SmpWbO6qg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>, 
	Demi Marie Obenour <demiobenour@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:47=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jun 23, 2026 at 02:28:17PM -0700, Rosen Penev wrote:
> > > +static const struct af_alg_allowlist_entry hash_allowlist[] =3D {
> > > +       { "cmac(aes)", true }, /* iwd, bluez */
> > > +       { "hmac(md5)", true }, /* iwd */
> > > +       { "hmac(sha1)", true }, /* iwd */
> > > +       { "hmac(sha224)", true }, /* iwd */
> > > +       { "hmac(sha256)", true }, /* iwd */
> > > +       { "hmac(sha384)", true }, /* iwd */
> > > +       { "hmac(sha512)", true }, /* iwd, sha512hmac */
> > > +       { "md4", true }, /* iwd */
> > > +       { "md5", true }, /* iwd */
> > > +       { "sha1", false }, /* iwd, iproute2 < 7.0 */
> > > +       { "sha224", true }, /* iwd */
> > > +       { "sha256", true }, /* iwd */
> > > +       { "sha384", true }, /* iwd */
> > > +       { "sha512", true }, /* iwd */
> > > +       {},
> > In OpenWrt, https://gitlab.com/linux-afs/kafs-client and strongswan
> > seem to be the other users of the user API. I haven't looked into what
> > they need.
>
> [Please trim your replies, thanks!]
Not sure what you mean.
>
> https://gitlab.com/linux-afs/kafs-client uses AF_ALG only for
> "hmac(md5)", which I already put on the privileged allowlist due to iwd
> also using it.  So it would still work by default with the current
> patch, unless it needs to use it unprivileged.
>
> (FWIW, a use of a single obsolete algorithm like this is also a good
> candidate for just replacing with local code...)
>
> https://github.com/strongswan/strongswan already supports userspace
> crypto libraries.
Oh lovely. Looks like this needs fixing in OpenWrt.
>
> - Eric
