Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587162C1594
	for <linux-hardening@vger.kernel.org>; Thu, 31 Jul 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971125; cv=none; b=WXu73AYcdXXUc+t2BCSJZMm2+3Cu1SZWiAX9Pqb2dIj2TPjb4Bp/TvilP6cLdNbApeCFEC+m1qWqQn96jBHnMgl0wcHxMlIQv5TBBQIBwknKP4Irg6oYM0v4k38swsws2rUZNcb939+3NtTlO59R8J0Kl/5RQYIC+5z4Ovpez/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971125; c=relaxed/simple;
	bh=TH3fCZPCy4YyphExJVOAQdZ8iXnIWWWw+CoAeuxr3Ps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TUHlcCMOCipNFslJOBMSF+yetJ1cEr9sFWOwjl06yQtwwn3nlDgF/uCTxtMcsvdSPaYERQLe85Fz2rV6Ge9hwdBZMiLMwHnAyEyI4vX+BTGagpLHrBrnoSvmJ0njJRtfGvHXRRq5iYct+9z62jEgL6eL66+jLdAvT8atx5I9qMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mqnRJmtW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqnRJmtW"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24031a3e05cso7518005ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 31 Jul 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753971122; x=1754575922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=REQVjpTsrsLvJl/SEHd88cRQSz2tJb2a7A9OwH842ak=;
        b=mqnRJmtWDjBsAGcBqJXhXYzi7AZmpoFVWtVQjbMn1KTC8PpaOCCrrfhekvL9TPbOA5
         1hUKp7KKEdY7Bj7J3KlxuaOZC1xbll1lL7YqGnEJ21GE7HOJyeS4NtN9fvbOfivKAXme
         i4FOW2VLsW4kH75FMKrSq2k8oPRJ7d9Pk6G0ggYhIAqTvxQUv/waiUSRc2kzWG3mhw/b
         /2oKbE7P5WwI7AJY7uXeFqPnuHr62JK9V90W+E3o8+cJqad4zs+7+6F6pxCbH8bffoZV
         Nc0XLzfvQtKQ8Qvzyh6o+7m9BEZ2lwjqwVWF2BEEzI0P2gt5YIm0mcH33FaOMFqqczVk
         cWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971123; x=1754575923;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REQVjpTsrsLvJl/SEHd88cRQSz2tJb2a7A9OwH842ak=;
        b=PakX5ljPa58E+Cqb3KdtiGqppzXgGOXVvogsXpEurdZChWvpYjX953Q4zxDRuSZw/g
         S+7Y+mwf3zyppVU0o6kI79pXN2/iZbv9MNQ+/N8IDFKKGGQX6vvSUuzgJyoQTqoHMRPF
         4fAkkoSws1pknn4CVXTuP6R+YXmfTvoA+Vw5kSKJTfQMGt64jKZmMAq/rIG7KZNeMs/3
         rGc+Cm/0Ns6uMN4wIAkL6X8Gr3QVOcQLxeadtHpbG2s0SKgKsQ1NJ09EEKEX/oMSx7vW
         MVAsyVR/1WMvrzggVZqwQPgz72uhSzDuPLmjbunld3b8vwN+WNaWpQ6IOwAgz3qc7wCo
         SjAg==
X-Forwarded-Encrypted: i=1; AJvYcCUYSm8nh4gu/TZlYGqCZ54rJWegbH3OfEwIKjvNweX9bZACjDjj1aDJJo15/eUeU1vylB97BsntsvmTOn/tohw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/n2wKWDOb00du+RfpfgBN5MjPIOu1sRHXc9M6BmQTqEmVJv17
	FNAmmNwrCIHoa3PlODlSmIrmjbuA1TGHum93l8tMXaSHgYd2i/jv1gkTT3Lo4iKh/FYQWIq6QzB
	ghFx4TZCxwnilO+q26IQsTDFp8Q9dTl4LVXKHbp3KJg==
X-Gm-Gg: ASbGncuO13F/StSdZ4Q0BC2bjQ0h7RZfGcGYbR6XmcIaPbWEtY0N5nV8W95I51ZTh9c
	peYdENxvLT7Zp2N5Z3peJ1kq8UrV1kQZNpvJnKyEuzA0qigW4zr8fbsrBXpKSHPg2yzzdx6HTOU
	a6nfTcrNRp0/NWp0Fdk+2VqBC01PwNXfK5Hwxi2kxh0UKt70N6LcjCqXhQ3jF9+ji39OghPosns
	y8yCsEl6+DuJKupNVULJCohp5x23jmD/qR6M4x+
X-Google-Smtp-Source: AGHT+IHFfipkwRQ+1K4xVlGJXDzqCVyVvmjQjtepMnIjmmMksReYrNJ2xhZLKNYVlub943plRlIYBtrdspjKLTHKge4=
X-Received: by 2002:a17:902:ce8e:b0:234:24a8:bee9 with SMTP id
 d9443c01a7336-24200a0a192mr33923355ad.4.1753971122562; Thu, 31 Jul 2025
 07:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 19:41:50 +0530
X-Gm-Features: Ac12FXxL-rGTjN1fNAMIPyVHVoE05EOo4i2s7AKGH0E5aPdsscvXESoyUk_z0Hc
Message-ID: <CA+G9fYvMS94GL5kMmHKSGSQqTS0XgwiYnETf_bLYYu6nTRNP-A@mail.gmail.com>
Subject: next-20250731: arm64 arc riscv64 parisc vmlinux.unstripped warning
 empty loadable segment detected at vaddr is this intentional?
To: open list <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Masahiro Yamada <masahiroy@kernel.org>, kees@kernel.org, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions while building arm64 arc riscv64 parisc with defconfig
on the Linux next-20250730 and next-20250731 with gcc-13 and gcc-8
the following build warnings noticed.

Build warnings with gcc-13, gcc-12, gcc-11 and gcc-8 defconfig

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

First seen on the next-20250730
Good: next-20250729
Bad: next-20250730

Build regression: arm64  arc riscv64 parisc vmlinux.unstripped warning
empty loadable segment detected at vaddr is this intentional?

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
aarch64-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0xffff800082720000, is this intentional?
arc-elf32-objcopy: vmlinux.unstripped: warning: empty loadable segment
detected at vaddr=0x80306000, is this intentional?
riscv64-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0xffffffff8202d000, is this intentional?
hppa-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0x11400000, is this intentional?


## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 84b92a499e7eca54ba1df6f6c6e01766025943f1
* Git describe: next-20250731
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731
* Architectures: arm64 arc riscv64 parisc
* Toolchains: gcc-8 gcc-13
* Kconfigs: defconfig

## Build
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250731/log-parser-build-gcc/general-objcopy-warning-empty-loadable-segment-detected-at-vaddr-is-this-intentional/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/30cmZFV63SOEwwWoGiSHEsDR63Q
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmZFV63SOEwwWoGiSHEsDR63Q/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmZFV63SOEwwWoGiSHEsDR63Q/config

## Steps to reproduce
 * tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org
