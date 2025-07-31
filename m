Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A32C08DF
	for <linux-hardening@vger.kernel.org>; Thu, 31 Jul 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968754; cv=none; b=VS5skt56/Px0/UsModw5hP9hur1wea8+ztYf/02570UjcHUppeMYVyo1RaIDAnBeP/fg8okjxGbOAdO9VCuqX7g7nHfYO3uyuVt9vkZI6qZJ2xSDf5+HchnpERTwcU7a7pug1Z2bMP9x0ZsWzt5wewgKoYjip1bsxr5oLlIHp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968754; c=relaxed/simple;
	bh=DwLv3NVgK+NLuVZxUkGdJBfD5FPTwniAQK5bZRxIfmU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a+y27PTtyb/rXDzJEyG0wG3RLTi29eV99Xowft1gejg3lCAAkIpN3/6afwiZ17L/bimCIgCUJZQnXDOvHw/zBSJIDyS/68CFm/MpqGbNJw29+byEtt4BC7j2L+kzLPn87E3/ByW5KAzl+h2szPr130w9smSTq3lSigi2HQeZrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGc86efY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGc86efY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76858e9e48aso329354b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 31 Jul 2025 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753968752; x=1754573552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmXYzT6zJ9rS420ixrln5bVB+UwoUFt5tecWAfMb5OA=;
        b=gGc86efYP2En6YuMKLUdrZOq0nhhITXlO5//ZBQ11e3Q0NPHvOnY4sbUr/XtJ4BHJL
         Gx+PPlUqXPznxtXp9jQiKZQO/+2NwosveIjW5qmuOOd+cEcqAd111WYWVL2zx9MpPbXI
         5hrtUXGqi5O4yilelYqyRFUrz3fszr8AxcIn5UAeZqeHCb4YENlTi3eE3+XR5ndyfFD8
         iz7t5mKmVnydNrl8IgHwrbkqN949PS0necqiRPHrbJMwE/c1cPoHO3AM7xG8PRsm6rXv
         rt4rXFH0wC8tIlFRCIVuDyF7Us1haFRookHHGy8W8yoMIuwb/8Nnf8E6uXnFixEsKEOo
         ES/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968752; x=1754573552;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmXYzT6zJ9rS420ixrln5bVB+UwoUFt5tecWAfMb5OA=;
        b=En9DF2Prh02fQDNiDuYYTfV7be/3rI4ZnFRd+bSSjWnsC2MOhqJwnT43SlnW8dDOJD
         xWZn2GPcG3PeDa+allBpdFvGRYb42R2Dv5IiqD+biQsMH+f8ubyJDrvknb/ESe79gCvJ
         VT3rtNMK2o0N+fOk1CfIDmXAJB3L8cr0n9ivVpnJyLNt+JT4ofka9WdE9Pp76pTigdcU
         MYqvdXozrwLeqdLaE3A2mk5GPTklp5xtjWiK5XdSm0VZNO8NCOne5ps6FaJ4oC4zDJb3
         FsoooW8f1bVFNNWKaN6pRrWt++tncsDy2ibA5qO3TeUNedev6J5mAjPlMIOWqIln1XRp
         rd7g==
X-Forwarded-Encrypted: i=1; AJvYcCW3+8zwI+IegYQdBJBdNHjqKULbqQ+6CJGKPcYZi3yarkc29VtYVo153xGvC36WJL3dDvLyqzrLeRMFgUcychA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3TKfGHa5IVuU7OIiGKe8rO1mdbYZv7UlT/49/a7jD39WD89T
	ECcbLPRx2fjHMfBCsgqc2NLJ7lrmc2EfGG3LBmXN2Rs3Hzy455HI7K1M1C0rHlY0Iu9ZnyqtI7T
	CTYfi7ZUrmDVWO580DsJVNmVh3pHkkzhoau5LArxbfaiCiFxGbUdRJnU=
X-Gm-Gg: ASbGncvYzNurUeI6oFULtv7J42gzxR24ojwu1LqEIX1X31qcHGvb/013uIbqZDuMuxl
	6zDeFGU/ZLC69RK3a+MZuLHGVPXMS27udT7xa3zM0DCIeW2JaWdHST82kmy+rWDfdOd+dOht7UJ
	oF1BYg1FotAPnPu99alE8zO8zbJ4uRuYYFtipjQ8/uPvoW+UwTEThNyAo1BVPiB4bznxaA6zTcJ
	jHKl9Q1/G/lOGQnqdfOXnRYDONrMH4Jcb+vuZ/P
X-Google-Smtp-Source: AGHT+IHMOlGLBVMZYIfdD8TgOlG751bAmep6oG9qqVy6znDcDyIXiYVE8rT/XtpzFlKEZWKLciEH9UdIeYkn8YVABic=
X-Received: by 2002:a17:902:ef11:b0:240:725d:c396 with SMTP id
 d9443c01a7336-24096b17fb3mr112149505ad.34.1753968752058; Thu, 31 Jul 2025
 06:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 31 Jul 2025 19:02:20 +0530
X-Gm-Features: Ac12FXz5D2sJ8CLUiMTBbTCix6pCoDq6lk-VMWBeOCc2LNXohdtN5ecn-7jz4iY
Message-ID: <CA+G9fYv-c6D6tJKw9x05+U_VxrpTAQCKADTeYg4jsjaJkX+isw@mail.gmail.com>
Subject: next-20250730 x86, s390, riscv gcc-8 hardening.config vmlinux symbol
 `.modinfo' required but not present
To: open list <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: kees@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Regressions while building x86, S390 and riscv64 with hardening.config on the
Linux next-20250730 and next-20250731.

Build pass with gcc-13 with hardening.config fails with gcc-8

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

First seen on the next-20250730
Good: next-20250729
Bad: next-20250730

Build regression: next-20250730 x86 gcc-8 hardening.config vmlinux
symbol `.modinfo' required but not present
Build regression: next-20250730 S390 gcc-8 hardening.config vmlinux
symbol `.modinfo' required but not present
Build regression: next-20250730 riscv64 gcc-8 hardening.config vmlinux
symbol `__rela_dyn_end' required but not present

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log x86
x86_64-linux-gnu-objcopy: vmlinux: symbol `.modinfo' required but not present
x86_64-linux-gnu-objcopy:vmlinux: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1
make[3]: Target '__default' not remade because of errors.

## Build log S390
s390x-linux-gnu-ld: .tmp_vmlinux1: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: .tmp_vmlinux2: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-ld: vmlinux.unstripped: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: vmlinux: warning: allocated section
`.got.plt' not in segment
s390x-linux-gnu-objcopy: vmlinux: symbol `.modinfo' required but not present
s390x-linux-gnu-objcopy:vmlinux: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error

## Build log riscv64
riscv64-linux-gnu-objcopy: vmlinux.unstripped: warning: empty loadable
segment detected at vaddr=0xffffffff81e5b000, is this intentional?
riscv64-linux-gnu-objcopy: vmlinux: symbol `__rela_dyn_end' required
but not present
riscv64-linux-gnu-objcopy:vmlinux: no symbols
make[3]: *** [scripts/Makefile.vmlinux:97: vmlinux] Error 1

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 84b92a499e7eca54ba1df6f6c6e01766025943f1
* Git describe: next-20250731
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731
* Architectures: x86, s390, riscv
* Toolchains: gcc-8
* Kconfigs: hardening.config

## Build
* Build details 1:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29316787/suite/build/test/gcc-8-lkftconfig-hardening/details/
* Build details 2:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29317240/suite/build/test/gcc-8-lkftconfig-hardening/details/
* Build details 3:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29317236/suite/build/test/gcc-8-lkftconfig-hardening/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250731/testrun/29316787/suite/build/test/gcc-8-lkftconfig-hardening/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmb9OdgONks9mQHuMJ5hkW09f/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30cmb9OdgONks9mQHuMJ5hkW09f/config

## Steps to reproduce
 * tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-8
--kconfig defconfig \
           --kconfig-add CONFIG_DEBUG_INFO_REDUCED=y \
           --kconfig-add CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y \
           --kconfig-add CONFIG_IGB=y \
           --kconfig-add hardening.config

--
Linaro LKFT
https://lkft.linaro.org
