Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593125949A
	for <linux-hardening@vger.kernel.org>; Fri,  5 Sep 2025 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060208; cv=none; b=g/YuLqNDvMTCP2OKG8t6BVE4l5T8+hyXM1uHn+C0TQwMXx3On685BalpvheWmUgCXd/YZz2yu7zkm4EoUTqIvhEX8gZpzLEEBbECRbX00MceQ7PoW7CySVLKlqQMkR1/1fFLIh79IgS3HkI5d2Uo5urX6aYp3AE0PcOMfoHfjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060208; c=relaxed/simple;
	bh=r34BaPjjnAxEk0pYZF1gJK7z2l/adNB3vzB+6aApLLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CABf7Ongzlz6YI7NsVehajKrxkoZu6upriwCpzRIc/n/odnuymEpP6RpFO0Q1z7Ybi0XjA/eufxWlo0gY/tMlTIW1t5Knykg9zFNkEsLHV0aFNqspA6wnx/QMrfJm0W5u8KAsI4ruCx0ii/y1AME+/tyPzbIi/AzqxrdOgSQOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VqH1H+KC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqH1H+KC"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70fa1287cffso707396d6.0
        for <linux-hardening@vger.kernel.org>; Fri, 05 Sep 2025 01:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757060205; x=1757665005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pmRMEuNmJqUQDrfbifQMhcZYMdkhFlWyXwwtuzWLPlM=;
        b=VqH1H+KCUWU4657PsFvLhiEzB1qE8Kz5Dc0tHJuwxVRlG3AKc1tco7REkHb2AllmsU
         GDaOX8YedV7ETQmapML4qR5fmjrv5FkeodrmTA5FLt7PGQArdFI+howebmZIuatxcZQt
         4IoRmgG0D8pubpRF69bml6Rs6kyk8KDREK9GerWjncrSWLJwfm6RHvXpdNLeFQoMJWUL
         nKqOwQoaBII1A0r2HBlr6MwrIfZnxs+jtTXz+x/HLdnTA2GvAo25Ucao+iDqA0XDTYtH
         FHU/8A9qbWGX2nWFUNeBeeYYk3FAMaaRQbmfF+D5pQbsYq5BkN7bAQV66orOPlVadfSF
         RFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060205; x=1757665005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmRMEuNmJqUQDrfbifQMhcZYMdkhFlWyXwwtuzWLPlM=;
        b=EDHQIekwCprE/77JMXigAmqWiHcPIcSgqAJ1EjK0eYOCfY8EEMPy08blkPwlGikiFc
         5NWQIHUg5p4IuABrMFch/cN+ocHp2IzgkNpas1+C3MKINz1mZ50ap1ZO/jl6XY+B9oNa
         0PXO+Sw7ezw5+H4jq5Yd4CvETUMg75UiQ6WvfNJItSuruiUzgbt909E28bp68M/hzMXJ
         AyS9B7L9KpbSWcJXL9FryaXKBPtgh+IZp3Zd5Q0jveizW4/n10glvRxWtpPRmPKdF8g1
         xH0i7sycy+QqVF5HYYYLr4HDXdHRg+BqV84L9tXtz40MnEP6cX6NDaQUPvLHq2+qZCgD
         8tgg==
X-Forwarded-Encrypted: i=1; AJvYcCXDLSoHlb+oTBITyD/3Th3KVt6NQyiUuoXbg+ejEgFtQ42kD+mhuw4y652/dF642HCj5PUMEeaYdpN793TMaQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pa30GvPmgQQ1MO5l9vNQIJFEcu5QETp1PagbODy6JPubMWNY
	FLn7mgpPdWfHHTVYF5opSJVrIcNpmPzEw6GAG9a4PVJpbd1Jajay8Moq5VswUSCWO+ifJU4ssOC
	EnR1RuU0wVQ9Jy0F2ljbXy5I17ik8gjoKtP85QHltuQ==
X-Gm-Gg: ASbGncsmXvR95IaP75YkqdQM53pz5mt9k6PwbOqExPeMJEYWnvYB1Rh/xEnL1cETeDB
	bran65ag4lIbTLCqs3HjgylTos1ZuJ6Cbt/JotigiaUI0TXQTu7Yu++CP2TmrgcVkJfAOSWOX2e
	Mt2yeWUoWQN8LPAmdIKhFmV64Ciff2sINhw0tquMx0IrzeHep0TlWrFP+/5SIgO1+rFbEuAqTgH
	830cSfOAwUG14uGNprV2o+AmtQ8a7EXavbl/Q==
X-Google-Smtp-Source: AGHT+IG1/H0XgF1Z0mVwgA+Hm/3Z8WnWU7aR5gwqaxhSAw9EmueUjpEcG/rJ6rBmj73ByYwqulnJNifibNyClBj0MK0=
X-Received: by 2002:a05:6214:4405:b0:72f:27de:9443 with SMTP id
 6a1803df08f44-72f27deb20bmr6495506d6.0.1757060205056; Fri, 05 Sep 2025
 01:16:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905052836.work.425-kees@kernel.org>
In-Reply-To: <20250905052836.work.425-kees@kernel.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 5 Sep 2025 10:16:33 +0200
X-Gm-Features: Ac12FXxXBCiJZ6j6Q-_OR5jc0zqm4NYxAPnOlmCg3M0Qu-SVhJpAaiy5I8LGFng
Message-ID: <CADYN=9Kd9w0pAMJJD1jq4RSum5+Xzk04yPZiQxi9tmEBtHPEMA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Test for bit underflow in pcie_set_readrq()
To: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linux Kernel Functional Testing <lkft@linaro.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Sept 2025 at 07:28, Kees Cook <kees@kernel.org> wrote:
>
> After commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations"), which allows GCC's value range tracker
> to see past ffs(), GCC 8 on ARM thinks that it might be possible that
> "ffs(rq) - 8" used here:
>
>         v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>
> could wrap below 0, leading to a very large value, which would be out of
> range for the FIELD_PREP() usage:
>
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to '__compiletime_assert_471' declared with attribute error: FIELD_PREP: value too large for the field
> ...
> drivers/pci/pci.c:5896:6: note: in expansion of macro 'FIELD_PREP'
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
>       ^~~~~~~~~~
>
> If the result of the ffs() is bounds checked before being used in
> FIELD_PREP(), the value tracker seems happy again. :)
>
> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: lkft-triage@lists.linaro.org
> Cc: Linux Regressions <regressions@lists.linux.dev>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Ben Copeland <benjamin.copeland@linaro.org>
> Cc: <lkft-triage@lists.linaro.org>
> Cc: <linux-pci@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> ---
>  drivers/pci/pci.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..005b92e6585e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5932,6 +5932,7 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  {
>         u16 v;
>         int ret;
> +       unsigned int firstbit;
>         struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>
>         if (rq < 128 || rq > 4096 || !is_power_of_2(rq))
> @@ -5949,7 +5950,10 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>                         rq = mps;
>         }
>
> -       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> +       firstbit = ffs(rq);
> +       if (firstbit < 8)
> +               return -EINVAL;
> +       v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, firstbit - 8);

Hi Kees,

Thank you for looking into this.

These warnings are not a one time thing.  the later versions of gcc
can figure it
out that firstbit is at least 8 based on the "rq < 128" (i guess), so
we're adding
bogus code.  maybe we should just disable the check for gcc-8.

Maybe something like this:

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 5355f8f806a9..4716025c98c7 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -65,9 +65,20 @@
                BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
                                 _pfx "mask is not constant");          \
                BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
-               BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
-                                ~((_mask) >> __bf_shf(_mask)) &        \
-                                       (0 + (_val)) : 0,               \
+               /* Value validation disabled for gcc < 9 due to
__attribute_const__ issues.
+                */ \
+               BUILD_BUG_ON_MSG(__GNUC__ >= 9 &&
__builtin_constant_p(_val) ?  \
+                                ~((_mask) >> __bf_shf(_mask)) &
         \
+                                       (0 + (_val)) : 0,
         \
                                 _pfx "value too large for the field"); \
                BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
                                 __bf_cast_unsigned(_reg, ~0ull),       \

I found similar patterns with ffs and FIELD_PREP here
drivers/dma/uniphier-xdmac.c row 156 and 165
drivers/gpu/drm/i915/display/intel_cursor_regs.h row 17

Cheers,
Anders
