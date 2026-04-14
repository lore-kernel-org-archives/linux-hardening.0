Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E430CD85
	for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154005; cv=pass; b=SDhrIhYIHYgaRUB4Zz4WU6pEWYgUXFyDZ+jKZFN+BQoiELJniVxuwe9x0eHgC2cHotl3O9nIqEMtAy/s0HWRuFkPbLj+4NURYmFb3fKY9xJ1kAYkCKjAk+FG1IlW6CWbuUwcFuQ+5ZDy83/hyR5Hhs78b9c+/lSlXA7C1jAUEHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154005; c=relaxed/simple;
	bh=fmGVbtsBI1VoOe9OcSZWHLOEsNoUrYJLI1DgVfRukRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHB0c9c+ZOOn+fFBUveSvjE0KiSl3tv6UZRviY1nGkCmoHM5M0hmvoghPYokvDUq1j0p0mrxrJRrRslEV7lNuVbpKSnWMtn31sTIxg30LXRwJXGIJRFYwQ+1K0zgELb28yQRK0Cg4GN6SKzOHmrcFxNEkWNwyQSNu1w9hR/eSV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi+jQTj4; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi+jQTj4"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-607f1fac33cso1764314137.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 Apr 2026 01:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776154003; cv=none;
        d=google.com; s=arc-20240605;
        b=VXI3aTYwIyvSgvsRi6yKt/2/ecM8VbNtXGG2RN/AjHRi+ZMJLUhulMs6vNKggvYny2
         j/1uAKjkOft3idekbYzIfJDSHj0WHxuz8hwUwYBQXFLSb8qbDNVTOopSvsNanMd8ciJp
         eJnAj+qxdOQPEIR8tKcY3nBgYTxUK6PXU3VvH3iQZix2grRWnfZuNTmNAv66SvWssEnk
         2qPoLLwjs6wEmgeTKFhpvPl9PbXq1VJxkxusXSkwweQMn0/Rw/eKOcugMQqhG8Biq2YN
         w0nmou4kBha6BMNJRg04jKUsfPhueS3WHN5yd6kHl7jqV+7LMCqB9eQmgXgnIOtSwz/3
         mKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uc24Ki9VYMqHvv8n6woz43UOOq8epixfEuksTZtbwnI=;
        fh=evfFoudx3jsm0TEUazmDVEzGA0c0jzMYpuOr4YvO45Y=;
        b=UxI9zV54IZBOZyD/6DlF3Td7dq9wrzn1peqBa3nhCwRzBgmIoOPoyVS3nTBW/8l2WE
         yMflUhngjWxVDynJiQihCIxoRgoi8FUE5Orm2PeJhuvYFzGBEtDhq0w7KEmwyNKOF6jo
         hwX3TE9ClqCUP7eBagpy8JWlDO3aISlM8b7UV4h+lQ5CSXX3UCp7MdrAfJUMFtd3RyKP
         1DzsX9aAMDGcmT0+ZvgM8TK6bZbRF2ydxQ4UAgSlH0nwb/r2QWihqCq3VHSr3E+PHJ/w
         j3JCp4isI0AvXTOTnmNEMfa9KBkuqun3pV0YO3Fl0IPE0WyW2IzTdSxnrEUWWVMgtHsk
         wPEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776154003; x=1776758803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uc24Ki9VYMqHvv8n6woz43UOOq8epixfEuksTZtbwnI=;
        b=bi+jQTj4hNN5zJw60heIboixFqA+PCmjkIB5EFC7Coh3NYcrGcFPllLd1gnILaXtAY
         wVnCLqhl4SrRbI3w/cSeAa81W063X8eF00AW2kJQKBSj02f1A9KPz0wwzzKuxWU0xGN1
         zpf3HDE63q7z31Wfd10n1XbKW+RQL+JOlQAWVoZ/KusazmLmwGeRi/CjQK6hHJUdtoU0
         wz1MVwuH2t2PcZ/OhooymHuXjWufK0fZ59D74ngyLVB1MNkwxjDoIqduECZgKRjiMNJ3
         8UUrGHqt9UIxyUde9Ga1T5IS+KbTaY8EWgZtqcgImdbi0VQrbjtAkz4Ft6/uDnEbm3Jl
         5OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776154003; x=1776758803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc24Ki9VYMqHvv8n6woz43UOOq8epixfEuksTZtbwnI=;
        b=iTnjeJQhI+hJRMxK8wlGUfDaBw7z7tJfNSR46J7AzCn6PVulMv20tBKqHfdt6jpPfa
         SwyeugQ76a4kfXv/8OM49cJDmvFEUh0eFPcEHQIgxhO5dvQ+bGeIg8wniS9nKRk462IR
         2A29KeDrzwdWpy7vCWai7lFagDoiFfsZiSFXLdr8o1IVGHdarw/phQazU8qU0Gmgfa53
         kBX89IkX9yW2L2lB6YOL8XMuSvvCPq5daGNjmhTf/YUjIk5EoznYVhj1OW6haypMP9Hf
         V7sdC1VbTGaYdqNwixUUxT+8xdVBNWXVz5qO5zkzanj/DY30YL/hTrvXdjjWHycQKF1e
         LxOg==
X-Forwarded-Encrypted: i=1; AFNElJ/WFFF7WG7T+oH3/535LgcPRHG39dlevhzZb5lF5p5vuwgLSdE2Qe5x5tDZywqBiUkjiKMpDCtWLAnW/pZzibs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl0oQw0iy3oM+uJsdIvlPZH2s7Kn5uVMJK/nrCRVnnHL1M6UV8
	uHPcEpvp0iE+rNL+IwcM04dHgihCS/L96Te0XiwX3uHG5Kc3/VSY69JbkCAYE80gqIk14LEwdCN
	I7VrjtYn/mGM2zJ5IxTHW2Cff8Qh2I/A=
X-Gm-Gg: AeBDieuI+HGJ6sHIeOUFYt/S/2ukEfEK5kN7G4lDxFX3pvywZHWIOVZiue03mRhdyX+
	fWy5G6vF3aAwCkPnbySAxrxYx+2QlLxollKgUATWUQkO+aeD7mrgHFK8so46GLlGjqsaBwMa9ts
	IqDi7bSadePhgzczmgUa7Sh2rMHyoKWn2UKBSVXBTM7UvgdH8HgJtPPKuYWCxFcL7hFQiugIoIk
	+5/muFANaUkIkbdr1sSijCPw/U5gYPk8ML44YChDRA89207EDhNF7fpiQBIPN3TwJIMIChTixsD
	Yx+O18/LENqdIN1OQmZX3CyQyEca5Q8EmUX4xQH3
X-Received: by 2002:a05:6102:4a94:b0:60f:f4e0:f139 with SMTP id
 ada2fe7eead31-60ff4e0f446mr2279103137.9.1776154003394; Tue, 14 Apr 2026
 01:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
 <adUaTrU_DZuK1Kd8@ashevche-desk.local> <CANAAWH+ihOpBVB5_Q4gxLs0_zO=pHb-kF53UXE-pqg1U9E9OKw@mail.gmail.com>
 <adayT_7xAtOLiVlq@ashevche-desk.local> <CANAAWHKDBoi1x=MpAyU5bQ88=ZOOrkaJNziyhcK9Ei7c8oNSHg@mail.gmail.com>
 <CANAAWHKZXbFAr7=DRCrS46GDsWi88Q=v883RQrgF4+EScksP=w@mail.gmail.com> <ad3qeKiW1jIKHOMi@ashevche-desk.local>
In-Reply-To: <ad3qeKiW1jIKHOMi@ashevche-desk.local>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Tue, 14 Apr 2026 13:51:31 +0545
X-Gm-Features: AQROBzBvD_axoHP3mQnIJNooQzq5tbx-MevM5aj4WTh2jGEfTqz7nqEgGcG6T0Y
Message-ID: <CANAAWHKLxpWOE1E5smBicb6bz6H5JdQndhbL434vsa6z+4K9ug@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: fix string_get_size() unit promotion
 after rounding
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Sorry, I should have kept the discussion on-list.

This is about the string_get_size() patch for outputs like "1000 kB" and
"1024 KiB", i.e. cases where the current code has already rounded to the
unit divisor but still prints the old unit.

> I'm trying to understand the current behaviour better and the logic of your
> change. But looking at the above I think your patch doesn't improve the case.
> And might even be another bug in the current code. I mean, do we have to round
> the numbers? 1048575 and lower are not equal 1.00 MiB strictly speaking.
> It's rather 0.999 MiB.

I took another look at the code and the old versions. I think the issue
here is narrower than whether values should cross the boundary at all.

For the base-10 values you asked about earlier, and for the binary
boundary case, the current code already rounds across the boundary.
With blk_size = 1, it prints:

  999999   -> 1000 kB
  1000000  -> 1.00 MB
  1000001  -> 1.00 MB

and

  1048575  -> 1024 KiB
  1048576  -> 1.00 MiB
  1048577  -> 1.00 MiB

So the patch does not introduce new cross-boundary rounding. It only changes
how those already-rounded results are displayed: it renormalizes 1000 kB to
1.00 MB and 1024 KiB to 1.00 MiB.

Around the first MB/MiB boundary with blk_size = 1, the display changes for:

  STRING_UNITS_10: 999500 .. 999999
  STRING_UNITS_2:  1048064 .. 1048575

with the adjacent values staying unchanged, e.g.:

  999499   -> 999 kB
  1000000  -> 1.00 MB
  1048063  -> 1023 KiB
  1048576  -> 1.00 MiB

That behavior comes from the arithmetic-rounding logic added by
564b026fbd0d ("string_helpers: fix precision loss for some inputs").
Before that change, 999999 printed 999 kB and 1048575 printed 1023 KiB,
so my original Fixes tag was wrong.

The v2 will carry:

  Fixes: 564b026fbd0d ("string_helpers: fix precision loss for some inputs")

If the intended policy is instead that values below 1.00 MB / MiB must
never round across the unit boundary, then I agree this is broader than a
renormalization bug and the rounding policy itself would need changing.

But with the current documented 3 significant figures behavior, leaving
the result as 1000 kB / 1024 KiB is inconsistent with that formatting,
because the existing rounding has already carried the value to the next
unit boundary.

Unless there is a reason to take a different approach, I'll send a v2 with
the corrected Fixes tag, an updated changelog framing this as post-rounding
renormalization, and threshold tests around the affected ranges.

Thanks,
Shuvam
