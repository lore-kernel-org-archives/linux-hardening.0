Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCF3D6461
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363249; cv=pass; b=ehWhsynMSM2OEttANyR2bmU9AcyEBewylZmDFMQmioNAgYBqQPd9OaZ4u2Wa6HbWymEk3AnRfoJJwVxUobtu8N8YPfou8sxItzfH/M98nKq6WwkkUZWIR6fyd+URlnbCLQbGQFEKhAFgIayVLZTIUtIDG5X5Q4rjJSeH0r6ZZnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363249; c=relaxed/simple;
	bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDTAKswBfdmGc91Mexw90TcuHDH/R94U9cMQ9bybGxta4hVABPTsTykIiJWo7sA7f2dXxqmnoCT7GE3Vv4eL3gXtLIgjpdNNccAWIdbgaxi+IabrcOF+tki8ta4e8UFbB2VCTrSXbOsUzToXmeGKye7mlsfFhHJDdNBaIbzTa48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5QR1fr5; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5QR1fr5"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79801df3e42so70486837b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 07:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363247; cv=none;
        d=google.com; s=arc-20240605;
        b=le6Eq3FYynfl46JgdbnMTVpwFpwcMEqoDC9a9mr+YAg6XJHHhXa8eJetHlykfZANF4
         wfB9N1Xy8UItzSTFo/1Tzej62oOqVpkqD3u3z46imHjHFwJlykfa9BkpxGfE95nIEBcM
         +hWCpsOnRQ17p4yqoscAsuOVh+KLOT2utFzYEeO5MRTSF5lZBJgL3i5tl+eBFPP2vED+
         SC3kXnvPalZ7+CGw4bfIAjxJQHgGHTegH+T+6JNJtZGdiV6m4gWemvX60fpiPCnkvp+D
         9i2juB3As72A6sz21JZcztefKgdwChrK/kTizQ0Z9j9tdmsFZLUvCQ+cucYlH6MSdFSQ
         xYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
        fh=fBXN+3XoSrmwC04D3paHJxCuM4s/bbMlpm8QFLpR5J4=;
        b=WJdxSkUI0wNHgtj9AEdHja3yFYOL+xAEFklp10AvhZp9UPVf7d5e4YrzTSxCqPxafl
         j8oaFGypJQOCgYX0MxzFpYnEnzByX9yjVRwZqQYn0xoSy8/YuEZdb7lg1HESpF2NR2tm
         JfChuBsuwpnDuKdlVomk/W+7J7IDYu/GFFCpyZGRRTBOSB+lxj8iRotx5IZiAcrWeIos
         bjmxSMz8RJjSAJgqTxBHfYamz2MJJYohafC7DFnf/LibZ9H++3Lgk/vJG4vEUALh1bfD
         BMUN5wpkF4d0WzPFX5wpncHcr9gQbEPUQynzV383IlGI8nLJQouiTuxngGDN0IhF4Oib
         XcrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363247; x=1774968047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
        b=T5QR1fr5LsUidi/oSaEMN/akhtx3oH2F3/ILSN4y9ePBxOpKFNONsW2SFRhPoNG0b7
         cjVJE9iDIiqGxwzkhcM5OFxxilJUSUcwFyZjI6TiFubm/DdiqcJuYZdTlqZ8xj5LppZj
         yG9owVHUYaZq1Nc+Ia9LrvLS9EIrTQY1tdQ8/+lut+OityHzoxWQbCKAL/cgiD8O4Mr2
         tL6Qljdt2VN/sKufJ6JHwNZVdzo5Y3TCoHMChazIVGyB07xFag3JxH3+GQz0KsK6JxnC
         F+lmdomEjA+RbcU2pKGgEhhKRHgl5qDQEVWguzmaUPDDMRW7SXbcoDrTdpKXx7sYqtbf
         tAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363247; x=1774968047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIOTQppSONw9z50oLZexhAWHsb4Q3HZrSfu8BpJO/QA=;
        b=ks9zFlAVRT1Bm71L20bB7RcNs0Zal+ma47tDIfifMJB5RHKZJzWJxhLQMhYpSf2wSh
         EDBaTGSwghQFqHkIRAE7q+Ed6YR+3vGGikVJgxxKGFPFt2nZICd1dxM+BHvfX/yByS1M
         ZP8J7rLrDqauAen2FQgR5Qe/QDty9/NX/+L/+4y6omOIO8EmZ9B8Mw23QGFCDIVVFxWn
         S4HAzjjKbOI0QvjafPedNhP3yOfwmJDcmZCRfj2BJTYmIJgqZfr/rrkW0xef9JX/UuOA
         RwyGFCcHp3QWfrlylhd5rIv0t8yGeiXJuDYI+FVhvV1/C+pI9anHkSmlW0JnhQpoIK+g
         /DGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuA7vTIlEA+955v9i/seBwpGPPHybc5T7/iKgEUg5AGwUBVBHKrcv4CE4muhT2FLsWcaZU5HUer2mfMixYdyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuPkGXPck0OLa/a9G+0WNx2MpRVhM0Of3UnYfwjq4vH+XrwCI
	zEvDyfgCW2VhXXCuuxlTy4T9z9BK65Z1hqv/m3EMQf72leVuhVvgGVkB7Cpv+5/hjpoUoZ/mmsG
	KOqW0QWisfDKEmnHnYmN5Jz7b6QW1/Nw=
X-Gm-Gg: ATEYQzzDkSE1e7K+8IJ2jNwsIsQxs5F9SyrOXbcf6sB8k6yDmFy8JICSqchXHcBjHGq
	A4ehD+P9gwIInC5FAwS1lign/omzxvQR5aK1k4fRNOmhVRZ2ZImOR0W8jjV+62kzYzRk7sB59UR
	ySYMUWaz/WtCGxillTtqQ9n0G8jOr3ofdLqK+AEyr+lnPtT0OVYIRmqJfQNwC4Rym4eY8icKQ2G
	tBEweYIQ2biygDqRpbSdnP7z3fpXbat1eSS9Yt1qgEWcEH1RSmOplXuHpVY14BRn/5v1n0Z4d6+
	cvrH0ouxE5gv+hKiJ3f4FKvQrUWrCZd5mH8fJmQqF0MY7psNexA=
X-Received: by 2002:a05:690c:386:b0:794:c283:5fb8 with SMTP id
 00721157ae682-79ac2f69d32mr32318717b3.25.1774363247300; Tue, 24 Mar 2026
 07:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
In-Reply-To: <202603232224.C1555BF@keescook>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 24 Mar 2026 22:40:36 +0800
X-Gm-Features: AQROBzDuylfJpvIzbHVr5tertRSIgq0oIglskAWDMfwVyWLSS3eK64LQ-Sk2jqM
Message-ID: <CABFUUZGYfw7=yHu8p7CW_JC6FSNSrT8jg1pAPqBK6nj_Br0iNw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > While the original strncpy() would have copied a full 16 bytes from an
> > overlong name (producing an unterminated field that the syscall rejects=
),
> > but this wasn't a reachable state. This replacement will instead always
> > truncate to 15 bytes and keeps the NUL terminator, which should have no
> > behavioral changes with the present code and avoids potential issues
> > with future over-long string literals.
>
> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> fails that way recently, so I will try a v2 with the "unterminated at 16
> bytes" behavior restored and see if it passes...
>
> test_progs_no_alu32-x86_64-llvm-21:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683004=
40546
IMHO, it's a flaky test failure, likely caused by timer-related
activity when selftests/bpf
are running concurrently.

As for your patch, replacing strncpy() makes sense, but this also
changes semantics
for overlong map names: they are silently truncated to 15 bytes.
I'd prefer an explicit length check and rejecting the overlong names,
instead of normalizing
them by truncation.

Sun Jian
