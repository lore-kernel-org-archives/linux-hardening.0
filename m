Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F586344
	for <linux-hardening@vger.kernel.org>; Fri, 20 Jun 2025 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387862; cv=none; b=QX8AFPKgYdb3dETydcaE3JvbiCgZVkVuRBqZuRSWTby6zW0iP3dCvyr291ZZvGT73JTOWvFCk6sczfsp6XyPXDxDhEOahBsk/veEdS75O4nX+KdUn6q8czeXT638TsYLw5mzVU7vOkcJfkxfMaBWIxmYBiRl/kZ2tsvcnw02HR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387862; c=relaxed/simple;
	bh=/QKDlRcwhqIDqN1ZyOADY7Kn32bkkQMXiTnisdbzINo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtNDyk8w3Fe15Os32yNupXbv7LPW5uA9ptRfeL9+QTtMgzWgUsMThD9/lgPyp9sqjtv7PGnlovy1C0/dW5e9ih8DZVXRK4pvzTjj8cp4p+66+hnq8nmLpp/WBFRNM9UlKqUhAr0QmrLq+4eDodRZqrok32VLg283rzxK8dcNPYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a69Il1lX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a69Il1lX"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso13662781fa.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 19:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750387858; x=1750992658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tx2CbH4A/3SzNrGWHEPoaDpuPtPaErEYy8KTPvOJ9E=;
        b=a69Il1lXynoX9hlTwfZFz3xpXNoUER1T+d+lc+rBQa8xQJKtzEVVDqlwiGHHMBhCWX
         fOeRAJjtKhSQnjk6/vg0dZKj25Dl8j8ipHl1CojUzvbblmnXTGNORjKrK4JkuwgrcPgp
         EObWpgSNWQyRRjOlZNUjl5g3dE18AR+8CBKiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750387858; x=1750992658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Tx2CbH4A/3SzNrGWHEPoaDpuPtPaErEYy8KTPvOJ9E=;
        b=dzdomHJM/enqbvra3eOAYOOpPO/Y39X+84/XISNbS/FKU5ev9/dtGEdKxbnJqLn/3j
         xufUop2QNo5QWWMXcfEUOB2j/P8EjU22RAjVtAmKCSeIJshbNaDBpqesan/9ShngNTCE
         H/p7mtgiGQn/BS3+edspAAYrLpmsEPjxKuX6N9Mpl+xarAIPbHZET94mhxMkyGAZRduw
         F8M7iMSGpBVpbjQra11g1qRWoFG+VdgMRs8bfAMmfbXxH+iWpL7haiyivKm/lFhowVee
         NRpaxVociwvPglwYtacPhknHYKBMBZsENTyJmOohz5pt4jS8GtP+sGqnIJxod6f2RKRC
         3R+A==
X-Forwarded-Encrypted: i=1; AJvYcCVY9+G3dMMFNmyVmZmI7oTLJNKsyfcMdMfcwKYwPLxViDz4dzSgqiCGGWjNR+ms07jHUy8mqGxFCp9sy9p2s+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJFCY7OCzXWUh8c4BtXw2/HPHWTLu5+6zyeSJf6L1BIEbg56Y
	/dBs02N0oXahrq0vlAf7HEByl/S9NDFgAmXxhaw5aNyQX7I4Jhmbz0Goi11Mixj02U/jO4rShqd
	dweL6PdwX2aEKucdYOPYtFANwElsRhwN67s1et90V
X-Gm-Gg: ASbGncvYt7R6I+MGuhCqlZUmJehJ1lQFGfvIfqdtIfQrurll4fb8bahLe7K3k3nMPFJ
	eYgmtAp3YdInxKvFF4MizPsnsX0+LTdlN6LbYxMoBkxh7gEYIwlGt3fKhAC5YH9yuR5C58aDjIR
	tRgLtutczYu7bGSVJyg44civ0T6jJ81qWQfZIC/C5reYTDcWPhMaXcQpV9+6Rl0AUPZ74O1W+vA
	A==
X-Google-Smtp-Source: AGHT+IEpFd0jknn6dJ7uHw9T9Pf5V4mOpm5v3zlNZwNkWSElZnOusIQCIAw38tA7L/6endmHtCrfM0YwX0tD4KBIaVU=
X-Received: by 2002:a2e:bc05:0:b0:32b:9c54:4ca1 with SMTP id
 38308e7fff4ca-32b9c544dfcmr1378961fa.39.1750387858055; Thu, 19 Jun 2025
 19:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610050458.4014083-1-naoyatezuka@chromium.org> <aEhK9knE1Fu_e_Sv@tzungbi-laptop>
In-Reply-To: <aEhK9knE1Fu_e_Sv@tzungbi-laptop>
From: Naoya Tezuka <naoyatezuka@chromium.org>
Date: Fri, 20 Jun 2025 11:50:46 +0900
X-Gm-Features: AX0GCFvTeEJqMqZJLqsl51gLxelWMSzurbKwmLCMjIMUg2mxZgtwpD35rT1g5Ho
Message-ID: <CAFe8q1Xp3c-o7DdNcmdwRDcntnEjD5sqVQEj06ouugLK6KO66A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: chromeos_pstore: Add ecc_size module parameter
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tzung-Bi and others,

Thank you so much for taking time and valuable feedback on my patch.

On Wed, Jun 11, 2025 at 12:10=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
> The doc [1] suggests to describe changes in imperative mood. If you have
> chance to send next version, please fix it.  Otherwise, it doesn't really
> bother me.

Thank you for pointing out the convention. I'll fix the commit message to f=
ollow
this in the next version (v3).

> > @@ -9,6 +9,10 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pstore_ram.h>
> >
> > +static int ecc_size;
> > +module_param(ecc_size, int, 0444);
>
> Does it need to be world-readable? How about 0400?

Good point, there is no need for it to be world-readable. I'll change
the permission
to 0400 as you suggested in the next version.


> > @@ -117,6 +121,9 @@ static int __init chromeos_pstore_init(void)
> >  {
> >       bool acpi_dev_found;
> >
> > +     if (ecc_size > 0)
> > +             chromeos_ramoops_data.ecc_info.ecc_size =3D ecc_size;
>
> It seems `ecc_size` doesn't have an upper bound.  Wondering what would
> be happened if it is a somehow large value.

I have investigated this, and you are right to be concerned. Providing a la=
rge
value for `ecc_size` can indeed lead to a kernel panic.
The panic occurs within the Reed-Solomon library, specifically from a BUG_O=
N
check in `decode_rs()` [1] when the ECC parameters are invalid. Here
is the crash
log I observed (edited for simplicity):

[    2.395351] kernel BUG at lib/reed_solomon/decode_rs.c:43!
[    2.395355] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[    2.395358] CPU: 3 PID: 1 Comm: swapper/0 Tainted: G        W
  5.15.178-24446-gf4364e2b1c85-dirty #1
f18df54893409d10705efc03f3f58f5431f53e8b
[    2.395361] Hardware name: Google Kindred/Kindred, BIOS
Google_Kindred.12672.534.0 01/19/2023
[    2.395362] RIP: 0010:decode_rs8+0xee0/0xef0
[    2.395378] Call Trace:
[    2.395379]  <TASK>
[    2.395380]  ? __die_body+0xac/0xb0
[    2.395383]  ? die+0x2f/0x50
[    2.395385]  ? do_trap+0x9e/0x170
[    2.395386]  ? decode_rs8+0xee0/0xef0
[    2.395388]  ? decode_rs8+0xee0/0xef0
[    2.395390]  ? handle_invalid_op+0x69/0x80
[    2.395391]  ? decode_rs8+0xee0/0xef0
[    2.395392]  ? exc_invalid_op+0x3b/0x50
[    2.395395]  ? asm_exc_invalid_op+0x16/0x20
[    2.395397]  ? decode_rs8+0xee0/0xef0
[    2.395399]  ? down_trylock+0x27/0x40
[    2.395401]  ? console_trylock+0x46/0xd0
[    2.395404]  persistent_ram_save_old+0xfd/0x1b0
[    2.395407]  persistent_ram_new+0x385/0x720
[    2.395410]  ramoops_init_prz+0x8e/0x120
[    2.395412]  ramoops_probe+0x25e/0x460
[    2.395414]  ? acpi_dev_pm_attach+0x27/0x110
[    2.395416]  platform_probe+0x6b/0xa0
[    2.395419]  really_probe+0xd5/0x340
[    2.395421]  __driver_probe_device+0x78/0xc0
[    2.395423]  driver_probe_device+0x28/0x180
[    2.395425]  __device_attach_driver+0x11b/0x130
[    2.395427]  ? deferred_probe_work_func+0xc0/0xc0
[    2.395429]  bus_for_each_drv+0x9d/0xe0
[    2.395430]  __device_attach+0xec/0x1a0
[    2.395432]  bus_probe_device+0x32/0xa0
[    2.395434]  device_add+0x281/0x3b0
[    2.395436]  platform_device_add+0x15e/0x200
[    2.395438]  ? chromeos_privacy_screen_driver_init+0x20/0x20
[    2.395441]  do_one_initcall+0x10e/0x2d0
[    2.395445]  ? strlen+0x10/0x20
[    2.395447]  ? parse_args+0x11f/0x3a0
[    2.395450]  do_initcall_level+0x80/0xe0
[    2.395453]  do_initcalls+0x50/0x80
[    2.395455]  kernel_init_freeable+0xee/0x160
[    2.395456]  ? rest_init+0xd0/0xd0
[    2.395458]  kernel_init+0x1a/0x110
[    2.395460]  ret_from_fork+0x1f/0x30
[    2.395463]  </TASK>
[    2.395463] Modules linked in:
[    2.396278] gsmi: Log Shutdown Reason 0x03
[    2.397390] ---[ end trace 52a9249d98b7a130 ]---

Since this validation issue exists in the pstore/ram core rather than
being specific to this driver, I believe the best approach is to address
it in a separate, new patch. My proposed fix is to add a check in
`ram_set_ecc_info()` [2] to validate the ECC parameters against the
requirements of the Reed-Solomon library, and return -EINVAL if the check
fails.
I will prepare and send this new patch for review, and add you to CC.

Thank you again for your guidance.

Best,
Naoya Tezuka


[1] https://elixir.bootlin.com/linux/v6.15.1/source/lib/reed_solomon/decode=
_rs.c#L43
[2] https://elixir.bootlin.com/linux/v6.15/source/fs/pstore/ram_core.c#L188
