Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DD322768
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209277; cv=pass; b=Mz2mGMFThDAsxcGQHmWNsEgM77AjlUGWLwe4wE1rYB19FeY7/CRH8i5dA0z7+hM7sm9Eeeq3spBbPGrXl972drBj1/1kMxOp3mq8ZJpsoEu/DWnjs/m2K6RmAEWUNDC92PAyegtD3fD8OpeIItv/Bk/lkqXCd9lvfW78bq1FMws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209277; c=relaxed/simple;
	bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJyiLPC7xbGlC40k4ca29zz3awDSYyq4dK8XgzHKtI0zNOCfqWePmHWVRHZ6/wZbfMPbhFNHpkzFiZYArORMmZl/uaY0BNjyKso3q8yr1btyTbE7xYJyPFzqJOz2zvWkwH4GdOLjFqztvijoxxgjITH13dYFLU1daGZYqpJEMtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCDj36xB; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCDj36xB"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c8d0945b3so99c88.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 09:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209275; cv=none;
        d=google.com; s=arc-20240605;
        b=C26hCapTM7cNsZsM+GVntp6d0YCjzRZ7J8iZWbFvohY37/yhVrB7VlftPQfzMOmbqd
         /9voj322JPUoY86u8Vg9/LrwMCtqSVssyYqWcYOMqAdYuGBIrcXGH3HjLWmumdndVnk4
         kn+WIlkCJsoHIU01nYzbnUgJ6RhaRAAW+UIKBqp6/UK3qQlCqdUnXXsorRjmkBGI70Qb
         9iPWZ4FXdbFNxvCNBwaBTRE6TmPMDMCrvy6rucBKHPPDZyCl/YGXNtr++XJz+7uX0ZxF
         LUX2XmaPW6sxNaPodZ0rxwQTPLORFTsKheZWnyqqk2kZm3N9ZoNBbwCS+BEqNBKrcrji
         Lqbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        fh=qewiEHBfjqvCnU9kLMlxwtL7YjWY0KHt0k2cH655yTU=;
        b=Kj0gjyVUR36ofHeEyR9t94/Vn6mhqJE6Fl8/zhOv1FZrUWz8nhrMMZhLSGLvrY4IdQ
         vL9zbhqEAVvgZ1sQ+rD8BSolLzyILbGHdaZwo4XdQB1Fs6Wc0NtHV5DYK0h5C8DAqcrR
         jBh9C5GSWZh1dVbrBOfcTq9NHJEigpWq8vXux77ooMQfwyDoHtwhcVt/brxlZubGqKEP
         v1ort20is/An27gtPFK9/Fno3ZvwetfvyUirBqdIpFbmG81xMP82QSNMtHRFB9j9GjD1
         CwsonULG8JJx2wAOeUftJeVHR4QKrjbwzP5+4qxlbw+ZU462Kgnh50w8LDCJ3CBGqFlJ
         31nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779209275; x=1779814075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        b=qCDj36xB+gWsx5I++4gl23aTy/IsknfkUlDdViRQo5wucJqQ8XdghhD+kLpe7INyJX
         D5hDNw4zhXmqyvnDQ+SLTsfjy3d+aAzPtHK4Hf/yZvzw4vcTdOfCgbx45BElKmR12hfX
         pu5c2HaqaT73C2IpAxqMFMcZNTBN0dPwrTcBUBQ9H3m6bZt6mx/YJhlrLDFNw5Cvbfji
         jvAUMXhEKAap1D9lrGHZsUO74k7gq02nBUlPXXnPBlgSayaJKDgXw3EWOzWfApAElNs6
         BfzZRPCYgAd0MgV4u2ao7+QnmxOz2O+5xUIt6DXaGaTbjbG45iFgS0OcpDl/H5i84vQ9
         f0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209275; x=1779814075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViKPE/zs4gsJozSFsoDM9rzZ64VredtJAzBJtyzJDD8=;
        b=QCeF0UtR/VzMLYT6maFG1hKJsLII2lPmFz9Px8w2o3j2vY6zdVN0NTioblC/OxQSyo
         DXiTJP7t3Vyyntqcls0S/gqOpYxffxgaPzlP5/tBoz65nQnf8PcW9Lhby/cyY7KlCnRG
         oWyXOCCV7x8GLFpz02Sxghx7ynuJfz2xeO1MfRp7bkg8hVp+/CC5iIUj//j/fxcvdYg9
         MHfbg/qdFTzo+AGInSa9AHa26Eg+uyhrFXFxbevjblx9BMaI4VpXSE2y1a9ub35W27a4
         6B4guFgyzcp3w/ILjxc5wjek/8ok9j4UjEAeW5N5e1VNWLSnwIxmaCvaZLVu4SlD6nJa
         xY2g==
X-Forwarded-Encrypted: i=1; AFNElJ/Qvu/um0KkKP3znnYXf1e+XOoPdRJa5k4um1AIv4NYnv6YN7wkvUX78NptiQvaNnIHbAW7d3Bwx2idPpCsO+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMYAwUIy0z0qgSAxKtUMOlP8J9xT1r6dGttUG99hZTrppG3xX/
	QxolYBkT+DS8S96m990yNqebGZse8Ni4ybFGBjdHvdFK40vfeFNUBdVYKpK+PwO39rVgZFW/1BK
	p56bzZ7hSZzjlc/NlmEalxK/mFjIpw/u7z5CyNsTw
X-Gm-Gg: Acq92OGCp7QHIo5YiKv/U2KZbpe/m3Vrn6kJODb9W9c3SAn/yZgwf4DDmN5TC/JwjT5
	Q1jIK0F3yZcM7mKTA6BhuRrsQw4qyesqNKpI8+VDPTWm1Si1RIBqobiphmvOaX+cTLfwmzkPkcc
	iYl1yeiEsInqq+7KyqMpaND6TharPH+NnZ3/zoWR2UyXtzojU+5ai66wCxw+h201mXS+MN28NCG
	4sXh2Q07RRYgFi2UFtUSWo9faV1PdKkMfyg21lnwoLcwQFiNwGkAfNLBfBKk9eC3B6wXHoe6Osp
	BBB+934bWznIPhbstQpLOZgAoowrL91AhGaOGG3mJeHe2Knz
X-Received: by 2002:a05:7022:41a3:b0:12c:2ed4:6314 with SMTP id
 a92af1059eb24-13557dcef85mr326451c88.1.1779209273823; Tue, 19 May 2026
 09:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
In-Reply-To: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 18:47:15 +0200
X-Gm-Features: AVHnY4LvG4Du5d39_T67NOwKnozMptM-y7xFRUTkKn7VXkYMQfWRo6DTkXiA7Lg
Message-ID: <CAG48ez0KsuR5z4RDgxWPUoS8e_MJzF74RgFDJayohG48A_N0PQ@mail.gmail.com>
Subject: Re: [RFC] TID v2.0: kernel module for cache-line zeroization against
 Flush+Reload (CLFLUSHOPT + LFENCE + REP STOSQ)
To: Ahmed Hassan <ahmaaaaadbntaaaaa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:47=E2=80=AFPM Ahmed Hassan
<ahmaaaaadbntaaaaa@gmail.com> wrote:
>
> Hi kernel developers,
>
> I am sharing TID (The Instant Destroyer) v2.0, a Linux kernel module
> written in C that addresses a specific gap in existing security
> libraries: none of them (libsodium, OpenSSL, glibc memzero_explicit)
> flush CPU cache lines after memory zeroization.
>
>
> =3D=3D Problem =3D=3D
>
> Standard zeroization functions (explicit_bzero, sodium_memzero,
> OPENSSL_cleanse) prevent the compiler from eliding the wipe, but do
> not evict CPU cache lines (L1/L2/L3). This leaves residual key
> material measurable via Flush+Reload (Yarom & Falkner, 2014) after
> data use ends.

The thing you're talking about isn't really related to the
Flush+Reload side channel attack, right? You're just talking about
flushing cache lines.

In what threat model would this be an issue? Normally, the goal of
memory zeroing is to ensure that sensitive data is wiped before an
attacker has a chance to physically pull out the RAM from a machine
and plug it into another device that can reveal RAM contents, or
before an attacker gains physical control of a locked device and can
connect malicious peripherals to it, or such.

So for this to be an actual security problem, the device would have to
keep running in a sufficiently high power state that data caches are
not discarded, and at the same time not perform enough memory accesses
to cause this memory to be discarded...

Assuming that this is an actual problem, why are you using a kernel
module for this? At least on x86, CLFLUSH is unprivileged, so crypto
libraries should be able to just use that directly. (There is the
caveat of what happens when the kernel migrates pages or kills a
process, but that's a larger problem.)
