Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACE1F61C
	for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 22:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493061; cv=none; b=O/J8cG/iTG9F1YQZyNog+RM+BUCoqnzjB/noyWqjGhflLYZpgVV/KcrChMpl+gFKgiKxYZKi43xT0xdyWfHrImNwL+9+E4F20H8omdPggTgXQqips9pXcW94fhWSyJSMNM/8dhzeWzYdH1ohJ9AN/dYXij7nyVDXYCLuW+M2Ofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493061; c=relaxed/simple;
	bh=DmzPSzaPgO5ZdYrZP/V5WrYINYntX9rvKUOE24fNeNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F73ivZVwLwkatTvObdX53ltyHyKoLU1Y5W2s2gHDWiLv7uv6997Pp16EsDrZAmmvWQ7NiwwfTkJMJlsh2/f5mWQUCBgbt2ffqt3MKC/RHg6TX9F7l1zIaw7m8SU/KxLD0slKII4jRJnX9CCfnr7nRK5wPhAAB+lTGl80v58kQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W+Vmormj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W+Vmormj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ea838bf357so3429819b3a.0
        for <linux-hardening@vger.kernel.org>; Tue, 26 Mar 2024 15:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711493059; x=1712097859; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXI5ZdGfMORIPiIcqImDe2wXt3ueShbSXK4sRTx/QcM=;
        b=W+Vmormjn9EU5780R1Fax53N0KdU+9zbOYFEFW/CcBsS6FaDchRjAvZhUqjZea4RfO
         NrWHg3DqEkG8smFoAApc2NpVJicTfIzKJIhchEVtpCwm3PMg2aJUXqT3Jrh2hJIKA36D
         U0tbOjsTlWCHN/Yysfp5msqnVdWSewEVgZJMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711493059; x=1712097859;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VXI5ZdGfMORIPiIcqImDe2wXt3ueShbSXK4sRTx/QcM=;
        b=bMiTQHJQi284BQ9mRhQkvMf40U7UwpVIxJo37HYPdkiGo06PKQTErwdXKb/aGepHBa
         TyitaLEfeaNNJ5efVvJl2VOc7krbFM5GkccEriXnt8KiojtYNZKkL01QPQhWzCpxwncZ
         /4BFmz/3Z4UCz6OuM55ncL2tcnDBCVg7qFccPyyDYlgtU5ODIJPHz8jz/SfrM1F0gLy0
         kcbRDfdTrmpxd6TA3KH560aMHi+djSSKjFCXZMvUTwqsC9iLwGACczlEzZCs9FlnUfv9
         lfmFC5FbM3oCAjavaNZku+MbJfr6Kb11jw+/QJOUyV/RIVCVGzdfRa/qA+pZYy8EuoCm
         4AlA==
X-Forwarded-Encrypted: i=1; AJvYcCWHJff3f+RmPjs1rB0fRZ1I3iw5D+/+pWvzNcNtknEBcPd9aJYzTKcrWwzxiLCUnaK0KTszQKdu1o5U0UMgHGLeHtx7KUkUhSJZHmTmdAw2
X-Gm-Message-State: AOJu0Yx2Xb7S1ippUQqwhBeaDayWr98w9LqERP83dH5yezSRfGt9iHEA
	0ARPTCpODqG/ePn2gd2W7KxOXxOGnVL0ywoWciqJKwondXWxEWl5szXCXfAsnA==
X-Google-Smtp-Source: AGHT+IFYNEPpAhAP0GckgmftIJyxv28Z7U0cdsSZCG176h42q0yhHHC6B5JG435IRLzrseqndsRg+A==
X-Received: by 2002:a05:6a00:1896:b0:6e6:9f03:6a6d with SMTP id x22-20020a056a00189600b006e69f036a6dmr1317580pfh.3.1711493059527;
        Tue, 26 Mar 2024 15:44:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hy4-20020a056a006a0400b006e6a16acf85sm6550957pfb.87.2024.03.26.15.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:44:19 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:44:18 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [GIT PULL] execve fixes for v6.9-rc2
Message-ID: <202403261544.E7B2404@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve fixes for v6.9-rc2.

Thanks!

-Kees

The following changes since commit 725d50261285ccf02501f2a1a6d10b31ce014597:

  exec: Simplify remove_arg_zero() error path (2024-03-09 13:46:30 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.9-rc2

for you to fetch changes up to 5248f4097308c1cdcf163314a6ea3c8c88c98cd9:

  binfmt: replace deprecated strncpy (2024-03-21 20:20:52 -0700)

----------------------------------------------------------------
execve fixes for v6.9-rc2

- Fix selftests to conform to the TAP output format (Muhammad Usama Anjum)

- Fix NOMMU linux_binprm::exec pointer in auxv (Max Filippov)

- Replace deprecated strncpy usage (Justin Stitt)

- Replace another /bin/sh instance in selftests

----------------------------------------------------------------
Justin Stitt (1):
      binfmt: replace deprecated strncpy

Kees Cook (2):
      selftests/exec: execveat: Improve debug reporting
      selftests/exec: Convert remaining /bin/sh to /bin/bash

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Muhammad Usama Anjum (3):
      selftests/exec: binfmt_script: Add the overall result line according to TAP
      selftests/exec: load_address: conform test to TAP format output
      selftests/exec: recursion-depth: conform test to TAP format output

 fs/binfmt_elf_fdpic.c                          |  2 +-
 fs/exec.c                                      |  1 +
 tools/testing/selftests/exec/Makefile          |  4 +-
 tools/testing/selftests/exec/binfmt_script.py  | 10 ++++-
 tools/testing/selftests/exec/execveat.c        | 12 +++---
 tools/testing/selftests/exec/load_address.c    | 34 ++++++++---------
 tools/testing/selftests/exec/recursion-depth.c | 53 +++++++++++++-------------
 7 files changed, 61 insertions(+), 55 deletions(-)

-- 
Kees Cook
