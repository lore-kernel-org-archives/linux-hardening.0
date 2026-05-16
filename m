Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3C9361DDC
	for <linux-hardening@vger.kernel.org>; Sat, 16 May 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778975492; cv=pass; b=ODMMP6S8GWCKY4AazcCMG5788zAFfzto+xctChaMNpuKWXvHBqR4x8L21pH9kztxoO+HDDs1wcBdcjo7bW4cv2fp7tObi/2qmOPBZ55z++tlAx69K5oj/lnqjtJZdtmBYyQeILaHSP/aJWQZPt/LTyaurNhH8PYhd6C1l3WukFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778975492; c=relaxed/simple;
	bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNn+dIoutB0IRrAHCFwBYIKI0tcEMYTdBX25ALtX+XBx3C07CL+f7C8LCWueDhLh1fGzNrvsVlzcO1dyzZZUs1iqPXd8Dkfy0YOlO9OqNTDd0h2z9eeCgooanzwhQnOdelDGLax1+yi3nK6p/Uz2BGO/XApTXPtEBKUiMR4Bins=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehaejxoU; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehaejxoU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso2650843a12.0
        for <linux-hardening@vger.kernel.org>; Sat, 16 May 2026 16:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778975490; cv=none;
        d=google.com; s=arc-20240605;
        b=iku9Uh3cNkyJpy6EnvONlOPwUGNNKTQcPJRwiFf+kLQflneBm8GpOyTPjCXf6l/1wQ
         KZhqKKrWLJkKeHgoNSUxhqro75EcS3sAkpUW2T5FrNxKD7jU5pXz9OD7Pg+UsAf1wrBn
         EkdLkfVFHy66SkVdVky+N8EWVBuDGpwKWWZQzDQwaIon4HOL4bMGmdit6/Sf84f6cglq
         ck5LITwjUIPgfO8N5bu4JzSWLwIg8WkRoxI9ETVjmnp9Z5IPVhBNTUfuXrGkify3gBvr
         JXCB8GHsFJKiI7GGvElTClN4POduUVvZbE9kV3tE3N+W+MSPqvAvWH29Vqa+eapI5Dmj
         xJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
        fh=0vfOidHy33YrKx1JqoWIOtHQR1CUVKg5OSOPQhNUI0c=;
        b=iG1PUxSiAORlfBWu17CBlCm9rymqEDpET6Gx1xeXiyYr7bMUJBaPcfRmitnSAkKxDE
         BAAQIcgiqu7NeE2voeAZW06wyvZ/Iq0Ig2U40BL5jfc2n4GfDEG107bTrWBKPr2v9zrv
         3nCrLSunMVkMzzksCH6CJsZXAPlPfL7LSQH1oHimDVzD323zd7wUyZnJ2gwgcbF0xLQF
         I2UtxYLK0Nz/KMR3huMzl522vBDxTNWHyYE28vwBoQY+r3gVA7SOieZ2Wm+mSpfsEug7
         JxPHoI3pTEh+dvIjBITwsw97uIH13TYMx8K/0ij19YtNQrJokDITfNfvvHl1NSkEJ1jG
         MO3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778975490; x=1779580290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
        b=ehaejxoUwoQpqkf8aiu3PrPncrm3qXhiFGHq5PhObggOH7ycQsIOkmbfYRACfQ47Is
         hV8IJ9iXBy7FE3LqaHrqx6dkZMOm+2kYAjPB0h5ea4RNgCrqim8d9IGnzQC/U/w6kWkd
         hsDho73Skviqukg3/xqweB6E+Wz/ejsZ0Ai8ocMnb0HUBhNjgP6QN1QHfulNqeQhYTff
         ttxI5jPi0kBPaGuDdSw8yK4ETaN0DS10+OnzBCVXFQMEvd3uNp4371U+gPvVU/cPUmEE
         eWNuOPeUdTL41PoqosvRm8jhZJkqlj7fszXkSliavZZ/AFrEjDzC33XLxZ8qfCe0YvC3
         /8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778975490; x=1779580290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEuDl9BbGL0tz01PdR2cvYCLLSzpkzQiU2vp6zLIhhY=;
        b=QZ1//4dsLb59jS3Wq4Op3vwR+WkdQD39yR/yWnjIO3ygMi7iVlMeJTz+zinmf0S0Py
         Ur+4aca6bX7vFQdzVSbHZiHyVRSEmN/gTBAp/dKQuVI8R8i6elbFaG/Gkh3NmQH2W7fs
         6tu9QQd7kO5DZR2DYayBNPbcGkK5E7ZU/LxCOTrNDnzHCia6YBxjO4SktBa8hQ9iCYeC
         zNEB5tFIfDs+GEJ4pB5kbc1uIimEG74CS+lkTEUZAkOTgg++X332ttTBrsRA5bcgNU3P
         6CSgnNVY2erhgKmIrtj3GZyfLhZVHHrXRvj3rAReRvxf96rhhcApyAhLEIuhq9DZuIwy
         AwEA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ne+s41TsuzcMVJxr9doiOKl4oZml0UFXJFPeimk4oqO0W2OD9SZ6oZIrSoHh8+vYJt7eKeUHRSZTASaTu4lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAyy1o2B9/fnkr6or3QwF5yMGXXKj3/doRWiMPCV3EYiF30y6
	SCVJJtemTwnf3EME5OorhGt4+D+sgURoCLPL9OL0zzgI6b9bM9kZLcgrL5iZplyzfi/ddDpl06P
	Z+ryP8Q/wJrbYp5Z7VzPSKj275l0a5xU=
X-Gm-Gg: Acq92OHH9dlkQe4td07tEKODlPhT8zyXIDWwU1ZdoEY5L5xOusEx3MsrIKaveR8cpHc
	uNMzW7VW8qlPWJ4TpgCqtBf/zalE37UGbGVQUXfivqX1Ty/TYsf6aIBKELMT1VQuNoUikXGRYZ0
	X7W+nbwai7EHJ51eWAdSDmsCKuE3R9P4ezaPR65V9tr1zytpPcPywywmILTLJ4sioKi6KU2H10f
	3ieeL6Td18KI69NbedvPbNyuIXoh0gKrfn1VtAXrYvYAZvcfZ2QEKqTDcRFTpc3ElJbzEbzsJmQ
	50fhditgPRqOMBnkHiqTQCZ9jlccRq+vS4FJF+aMHTTUQGzzsQ==
X-Received: by 2002:a05:6402:11d1:b0:676:67ec:a2cf with SMTP id
 4fb4d7f45d1cf-683bd08fad0mr4189598a12.20.1778975489646; Sat, 16 May 2026
 16:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516182126.530498-1-pfalcato@suse.de>
In-Reply-To: <20260516182126.530498-1-pfalcato@suse.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 17 May 2026 01:51:16 +0200
X-Gm-Features: AVHnY4LQyyzXjVtPQhJb8qVVp3yQjS1Vt78uw12X8MN5Nrm3AJq0RnjAefRlP1U
Message-ID: <CAGudoHHeYbPWQbz+vXoS-Oi4PhxX6rh5XsMUkZetyfdnJHNj=g@mail.gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
To: Pedro Falcato <pfalcato@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 8:21=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> and Fragnasia, splicing a read-only file is fundamentally unsafe.
>
> As such, as a mitigation, add a way for users to block splice() for
> files they cannot write to. This eliminates this whole class of exploits
> that use splice()+confusion in pipe/net/etc code to gain write-access to
> files they can only read.
>

The patch touches stuff I'm not familiar with, so no comments on that front=
.

The core idea is a half-measure which will at best buy few weeks until
splice bugs dry out and there will be a new attack vector du jour
which people point their LLMs at. Perhaps it is worth it as a bandaid
until a more complete solution shows up.

A full-measure solution would git rm these modules to
fuck^W^W^W^W^W^Wprevent suspicious modules from being usable by
unprivileged users to begin with, at least by default. Of the cases I
had seen so far, your typical machine either does not have the thing
loaded or in the worst case does not have a legitimate reason to
expose them. Someone(tm) would have to figure out a sensible setup
where stuff stops autoloading and there is a whitelist of modules
allowed on the box, and even then the functionality provided is only
usable by select people.

Back in the day I wrote a LSM which learned what kind of socket
options etc. are being used in a given workload and afterwards only
allowed that. The code never escaped $workplace, but the idea might be
a starting point.

All that aside, is someone with access to many tokens(tm) racing the
bad guys vs splice bugs? Realistically one has to assume there are
some more waiting (as suggested by the patch) and chances are decent
nobody has to be caught with their pants down even without the
aforementioned mitigation.
